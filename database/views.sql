USE petvida_v2;

-- 1) vw_consultas_completas — JOIN de TODAS as 6 tabelas
CREATE OR REPLACE VIEW vw_consultas_completas AS
SELECT
    c.data_hora,
    c.status AS status_consulta,
    c.diagnostico,
    c.valor,
    a.nome AS animal,
    e.nome AS especie,
    t.nome AS tutor,
    t.telefone AS telefone_tutor,
    v.nome AS veterinario,
    v.especialidade,
    p.forma_pagamento,
    p.status AS status_pagamento
FROM consultas c
JOIN animais a ON c.animal_id = a.id
JOIN especies e ON a.especie_id = e.id
JOIN tutores t ON a.tutor_id = t.id
JOIN veterinarios v ON c.veterinario_id = v.id
LEFT JOIN pagamentos p ON c.id = p.consulta_id;

-- 2) vw_agenda_hoje — consultas de hoje
CREATE OR REPLACE VIEW vw_agenda_hoje AS
SELECT *
FROM vw_consultas_completas
WHERE DATE(data_hora) = CURDATE()
ORDER BY TIME(data_hora);

-- 3) vw_faturamento_mensal — GROUP BY ano/mês/veterinário
CREATE OR REPLACE VIEW vw_faturamento_mensal AS
SELECT
    YEAR(c.data_hora) AS ano,
    MONTH(c.data_hora) AS mes,
    v.nome AS veterinario,
    COUNT(c.id) AS total_consultas,
    SUM(c.valor) AS faturamento_total
FROM consultas c
JOIN veterinarios v ON c.veterinario_id = v.id
GROUP BY YEAR(c.data_hora), MONTH(c.data_hora), v.id, v.nome;

-- 4) vw_animais_detalhados — animais com tutor, espécie e total de consultas
CREATE OR REPLACE VIEW vw_animais_detalhados AS
SELECT
    a.id AS id_animal,
    a.nome AS animal,
    t.nome AS tutor,
    e.nome AS especie,
    COUNT(c.id) AS total_consultas
FROM animais a
JOIN tutores t ON a.tutor_id = t.id
JOIN especies e ON a.especie_id = e.id
LEFT JOIN consultas c ON a.id = c.animal_id
GROUP BY a.id, a.nome, t.nome, e.nome;

-- 5) vw_inadimplentes — consultas concluídas sem pagamento ou pendente
CREATE OR REPLACE VIEW vw_inadimplentes AS
SELECT
    data_hora,
    animal,
    tutor,
    telefone_tutor,
    valor,
    status_pagamento
FROM vw_consultas_completas
WHERE status_consulta = 'concluida'
  AND (status_pagamento IS NULL OR status_pagamento = 'pendente');
