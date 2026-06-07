USE petvida_v2;

DELIMITER $$

-- 1) sp_agendar_consulta — Valida existências e horário. TRANSAÇÃO: consulta + pagamento.
CREATE PROCEDURE sp_agendar_consulta(
    p_animal_id INT,
    p_vet_id INT,
    p_data_hora DATETIME,
    p_valor DECIMAL(10,2)
)
BEGIN
    DECLARE v_animal_count INT;
    DECLARE v_vet_count INT;
    DECLARE v_horario_count INT;

    START TRANSACTION;

    SELECT COUNT(*) INTO v_animal_count FROM animais WHERE id = p_animal_id;
    IF v_animal_count = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Animal não encontrado';
    END IF;

    SELECT COUNT(*) INTO v_vet_count FROM veterinarios WHERE id = p_vet_id;
    IF v_vet_count = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Veterinário não encontrado';
    END IF;

    SELECT COUNT(*) INTO v_horario_count
    FROM consultas
    WHERE veterinario_id = p_vet_id
      AND data_hora = p_data_hora
      AND status IN ('agendada', 'em_atendimento');

    IF v_horario_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Horário já ocupado para este veterinário';
    END IF;

    INSERT INTO consultas (animal_id, veterinario_id, data_hora, valor, status)
    VALUES (p_animal_id, p_vet_id, p_data_hora, p_valor, 'agendada');

    INSERT INTO pagamentos (consulta_id, valor_pago, forma_pagamento, data_pagamento, status)
    VALUES (LAST_INSERT_ID(), p_valor, 'pix', NULL, 'pendente');

    COMMIT;
END$$

-- 2) sp_concluir_consulta — Finaliza consulta com diagnóstico
CREATE PROCEDURE sp_concluir_consulta(
    p_consulta_id INT,
    p_diagnostico TEXT
)
BEGIN
    DECLARE v_count INT;
    DECLARE v_status VARCHAR(20);

    SELECT COUNT(*) INTO v_count FROM consultas WHERE id = p_consulta_id;
    IF v_count = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Consulta não encontrada';
    END IF;

    SELECT status INTO v_status FROM consultas WHERE id = p_consulta_id;

    IF v_status NOT IN ('agendada', 'em_atendimento') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Consulta não pode ser concluída no status atual';
    END IF;

    UPDATE consultas
    SET status = 'concluida', diagnostico = p_diagnostico
    WHERE id = p_consulta_id;
END$$

-- 3) sp_registrar_pagamento — Confirma pagamento
CREATE PROCEDURE sp_registrar_pagamento(
    p_consulta_id INT,
    p_forma ENUM('pix', 'cartao', 'dinheiro', 'convenio')
)
BEGIN
    DECLARE v_count INT;
    DECLARE v_status VARCHAR(20);

    SELECT COUNT(*) INTO v_count FROM pagamentos WHERE consulta_id = p_consulta_id;
    IF v_count = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Pagamento não encontrado para esta consulta';
    END IF;

    SELECT status INTO v_status FROM pagamentos WHERE consulta_id = p_consulta_id;

    IF v_status = 'pago' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Pagamento já foi realizado';
    END IF;

    UPDATE pagamentos
    SET status = 'pago', forma_pagamento = p_forma, data_pagamento = NOW()
    WHERE consulta_id = p_consulta_id;
END$$

-- 4) sp_cancelar_consulta — TRANSAÇÃO: cancela consulta e pagamento
CREATE PROCEDURE sp_cancelar_consulta(
    p_consulta_id INT
)
BEGIN
    DECLARE v_count INT;
    DECLARE v_status VARCHAR(20);

    START TRANSACTION;

    SELECT COUNT(*) INTO v_count FROM consultas WHERE id = p_consulta_id;
    IF v_count = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Consulta não encontrada';
    END IF;

    SELECT status INTO v_status FROM consultas WHERE id = p_consulta_id;

    IF v_status = 'cancelada' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Consulta já está cancelada';
    END IF;

    IF v_status = 'concluida' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Consulta concluída não pode ser cancelada';
    END IF;

    UPDATE consultas SET status = 'cancelada' WHERE id = p_consulta_id;

    UPDATE pagamentos
    SET status = 'cancelado', valor_pago = 0.00
    WHERE consulta_id = p_consulta_id AND status != 'cancelado';

    COMMIT;
END$$

-- 5) sp_cadastrar_animal — Cadastra e retorna o ID criado
CREATE PROCEDURE sp_cadastrar_animal(
    p_nome VARCHAR(100),
    p_especie_id INT,
    p_raca VARCHAR(50),
    p_data_nascimento DATE,
    p_tutor_id INT,
    OUT p_animal_id INT
)
BEGIN
    DECLARE v_especie_count INT;
    DECLARE v_tutor_count INT;

    SELECT COUNT(*) INTO v_especie_count FROM especies WHERE id = p_especie_id;
    IF v_especie_count = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Espécie não encontrada';
    END IF;

    SELECT COUNT(*) INTO v_tutor_count FROM tutores WHERE id = p_tutor_id;
    IF v_tutor_count = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tutor não encontrado';
    END IF;

    INSERT INTO animais (nome, especie_id, raca, data_nascimento, tutor_id)
    VALUES (p_nome, p_especie_id, p_raca, p_data_nascimento, p_tutor_id);

    SET p_animal_id = LAST_INSERT_ID();
END$$

DELIMITER ;
