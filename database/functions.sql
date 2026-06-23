USE petvida_v2;

DELIMITER $$

-- 1) fn_idade_animal — Retorna "X anos e Y meses"
CREATE FUNCTION fn_idade_animal(p_data_nascimento DATE)
RETURNS VARCHAR(30)
DETERMINISTIC
BEGIN
    DECLARE v_anos INT;
    DECLARE v_meses INT;
    SET v_anos = TIMESTAMPDIFF(YEAR, p_data_nascimento, CURDATE());
    SET v_meses = TIMESTAMPDIFF(MONTH, p_data_nascimento, CURDATE()) - (v_anos * 12);
    RETURN CONCAT(v_anos, ' anos e ', v_meses, ' meses');
END$$

-- 2) fn_total_gasto_tutor — Soma consultas (exceto canceladas) dos animais do tutor
CREATE FUNCTION fn_total_gasto_tutor(p_tutor_id INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_total DECIMAL(10,2);
    SELECT COALESCE(SUM(c.valor), 0) INTO v_total
    FROM consultas c
    JOIN animais a ON c.animal_id = a.id
    WHERE a.tutor_id = p_tutor_id AND c.status != 'cancelada';
    RETURN v_total;
END$$

-- 3) fn_qtd_consultas_animal — Conta consultas do animal
CREATE FUNCTION fn_qtd_consultas_animal(p_animal_id INT)
RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_qtd INT;
    SELECT COUNT(*) INTO v_qtd FROM consultas WHERE animal_id = p_animal_id;
    RETURN v_qtd;
END$$

-- 4) fn_status_emoji — Retorna emoji + texto do status
CREATE FUNCTION fn_status_emoji(p_status VARCHAR(20))
RETURNS VARCHAR(30)
DETERMINISTIC
BEGIN
    DECLARE v_resultado VARCHAR(30);
    CASE p_status
        WHEN 'agendada' THEN SET v_resultado = '📅 Agendada';
        WHEN 'concluida' THEN SET v_resultado = '✅ Concluída';
        WHEN 'cancelada' THEN SET v_resultado = '❌ Cancelada';
        WHEN 'em_atendimento' THEN SET v_resultado = '🏥 Em Atendimento';
        ELSE SET v_resultado = p_status;
    END CASE;
    RETURN v_resultado;
END$$

-- 5) fn_classificar_valor — Classifica valor da consulta
CREATE FUNCTION fn_classificar_valor(p_valor DECIMAL(10,2))
RETURNS VARCHAR(30)
DETERMINISTIC
BEGIN
    DECLARE v_classificacao VARCHAR(30);
    IF p_valor < 100 THEN
        SET v_classificacao = 'Consulta Simples';
    ELSEIF p_valor <= 300 THEN
        SET v_classificacao = 'Consulta Padrão';
    ELSE
        SET v_classificacao = 'Procedimento Especial';
    END IF;
    RETURN v_classificacao;
END$$

DELIMITER ;
