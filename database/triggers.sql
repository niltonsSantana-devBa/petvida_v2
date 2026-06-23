USE petvida_v2;

-- 1) Tabela de log para auditoria
CREATE TABLE IF NOT EXISTS log_auditoria (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tabela_afetada VARCHAR(50) NOT NULL,
    acao VARCHAR(20) NOT NULL,
    registro_id INT NOT NULL,
    detalhes VARCHAR(255),
    data_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$

-- 2a) trg_after_insert_consulta — AFTER INSERT em consultas
CREATE TRIGGER trg_after_insert_consulta
AFTER INSERT ON consultas
FOR EACH ROW
BEGIN
    INSERT INTO log_auditoria (tabela_afetada, acao, registro_id, detalhes)
    VALUES ('consultas', 'INSERT', NEW.id, CONCAT('Nova consulta do animal ', NEW.animal_id, ' com o veterinário ', NEW.veterinario_id));
END$$

-- 2b) trg_after_update_consulta_status — AFTER UPDATE se status mudou
CREATE TRIGGER trg_after_update_consulta_status
AFTER UPDATE ON consultas
FOR EACH ROW
BEGIN
    IF OLD.status != NEW.status THEN
        INSERT INTO log_auditoria (tabela_afetada, acao, registro_id, detalhes)
        VALUES ('consultas', 'UPDATE', NEW.id, CONCAT('Status alterado de ', OLD.status, ' para ', NEW.status));
    END IF;
END$$

-- 2c) trg_before_delete_consulta — BEFORE DELETE bloqueia se pago
CREATE TRIGGER trg_before_delete_consulta
BEFORE DELETE ON consultas
FOR EACH ROW
BEGIN
    DECLARE v_status_pagamento VARCHAR(20);
    SELECT status INTO v_status_pagamento FROM pagamentos WHERE consulta_id = OLD.id;
    IF v_status_pagamento = 'pago' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Não é possível excluir consulta com pagamento já realizado';
    END IF;
END$$

-- 2d) trg_after_insert_animal — AFTER INSERT em animais
CREATE TRIGGER trg_after_insert_animal
AFTER INSERT ON animais
FOR EACH ROW
BEGIN
    INSERT INTO log_auditoria (tabela_afetada, acao, registro_id, detalhes)
    VALUES ('animais', 'INSERT', NEW.id, CONCAT('Novo animal cadastrado: ', NEW.nome));
END$$

-- 2e) trg_before_update_pagamento — BEFORE UPDATE preenche data automaticamente
CREATE TRIGGER trg_before_update_pagamento
BEFORE UPDATE ON pagamentos
FOR EACH ROW
BEGIN
    IF OLD.status != 'pago' AND NEW.status = 'pago' THEN
        SET NEW.data_pagamento = CURDATE();
    END IF;
END$$

DELIMITER ;
