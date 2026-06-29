USE petvida_v2;

-- =============================================
-- CRIAÇÃO DOS USUÁRIOS
-- =============================================
CREATE USER IF NOT EXISTS 'recepcionista'@'localhost' IDENTIFIED BY 'petvida2024';
CREATE USER IF NOT EXISTS 'veterinario'@'localhost' IDENTIFIED BY 'petvida2024';
CREATE USER IF NOT EXISTS 'gerente'@'localhost' IDENTIFIED BY 'petvida2024';
CREATE USER IF NOT EXISTS 'admin'@'localhost' IDENTIFIED BY 'petvida2024';

-- =============================================
-- 1) RECEPCIONISTA
-- SELECT/INSERT em tutores, animais, consultas, especies
-- EXECUTE em sp_agendar_consulta e sp_cadastrar_animal
-- SEM DELETE, SEM pagamentos
-- =============================================
GRANT SELECT, INSERT ON petvida_v2.tutores TO 'recepcionista'@'localhost';
GRANT SELECT, INSERT ON petvida_v2.animais TO 'recepcionista'@'localhost';
GRANT SELECT, INSERT ON petvida_v2.consultas TO 'recepcionista'@'localhost';
GRANT SELECT, INSERT ON petvida_v2.especies TO 'recepcionista'@'localhost';
GRANT EXECUTE ON PROCEDURE petvida_v2.sp_agendar_consulta TO 'recepcionista'@'localhost';
GRANT EXECUTE ON PROCEDURE petvida_v2.sp_cadastrar_animal TO 'recepcionista'@'localhost';

-- =============================================
-- 2) VETERINARIO
-- SELECT em tudo
-- UPDATE(diagnostico, status) em consultas
-- EXECUTE em sp_concluir_consulta
-- SEM INSERT/DELETE
-- =============================================
GRANT SELECT ON petvida_v2.* TO 'veterinario'@'localhost';
GRANT UPDATE (diagnostico, status) ON petvida_v2.consultas TO 'veterinario'@'localhost';
GRANT EXECUTE ON PROCEDURE petvida_v2.sp_concluir_consulta TO 'veterinario'@'localhost';

-- =============================================
-- 3) GERENTE
-- SELECT/INSERT/UPDATE em tudo
-- DELETE apenas em consultas canceladas
-- EXECUTE em todas as procedures
-- =============================================
GRANT SELECT, INSERT, UPDATE ON petvida_v2.* TO 'gerente'@'localhost';
GRANT DELETE ON petvida_v2.consultas TO 'gerente'@'localhost';
GRANT EXECUTE ON PROCEDURE petvida_v2.sp_agendar_consulta TO 'gerente'@'localhost';
GRANT EXECUTE ON PROCEDURE petvida_v2.sp_concluir_consulta TO 'gerente'@'localhost';
GRANT EXECUTE ON PROCEDURE petvida_v2.sp_registrar_pagamento TO 'gerente'@'localhost';
GRANT EXECUTE ON PROCEDURE petvida_v2.sp_cancelar_consulta TO 'gerente'@'localhost';
GRANT EXECUTE ON PROCEDURE petvida_v2.sp_cadastrar_animal TO 'gerente'@'localhost';

-- =============================================
-- 4) ADMIN — ALL PRIVILEGES
-- =============================================
GRANT ALL PRIVILEGES ON petvida_v2.* TO 'admin'@'localhost';

-- =============================================
-- REVOKE — Remover acesso da recepcionista
-- =============================================
REVOKE INSERT ON petvida_v2.tutores FROM 'recepcionista'@'localhost';
REVOKE INSERT ON petvida_v2.animais FROM 'recepcionista'@'localhost';
REVOKE INSERT ON petvida_v2.consultas FROM 'recepcionista'@'localhost';
REVOKE INSERT ON petvida_v2.especies FROM 'recepcionista'@'localhost';

FLUSH PRIVILEGES;
