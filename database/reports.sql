USE petvida_v2;

-- =============================================
-- 1) Ranking de tutores que mais gastam
-- =============================================
SET @posicao = 0;
SELECT
    @posicao := @posicao + 1 AS posicao,
    t.nome AS tutor,
    COALESCE(SUM(c.valor), 0) AS total_gasto,
    COUNT(c.id) AS qtd_consultas
FROM tutores t
LEFT JOIN animais a ON a.tutor_id = t.id
LEFT JOIN consultas c ON c.animal_id = a.id AND c.status != 'cancelada'
GROUP BY t.id, t.nome
ORDER BY total_gasto DESC;

-- =============================================
-- 2) Faturamento mensal
-- =============================================
SELECT
    YEAR(c.data_hora) AS ano,
    MONTH(c.data_hora) AS mes,
    COUNT(c.id) AS total_consultas,
    SUM(c.valor) AS faturamento_bruto,
    COALESCE(SUM(CASE WHEN p.status = 'pago' THEN p.valor_pago END), 0) AS recebido,
    COALESCE(SUM(CASE WHEN p.status = 'pendente' THEN c.valor END), 0) AS pendente
FROM consultas c
LEFT JOIN pagamentos p ON p.consulta_id = c.id
GROUP BY YEAR(c.data_hora), MONTH(c.data_hora)
ORDER BY ano DESC, mes DESC;

-- =============================================
-- 3) Animais sem consulta há 6+ meses
-- =============================================
SELECT
    a.id,
    a.nome AS animal,
    e.nome AS especie,
    t.nome AS tutor,
    MAX(c.data_hora) AS ultima_consulta,
    DATEDIFF(CURDATE(), COALESCE(MAX(c.data_hora), '0001-01-01')) AS dias_sem_consulta
FROM animais a
JOIN especies e ON e.id = a.especie_id
JOIN tutores t ON t.id = a.tutor_id
LEFT JOIN consultas c ON c.animal_id = a.id
GROUP BY a.id, a.nome, e.nome, t.nome
HAVING ultima_consulta IS NULL
    OR MAX(c.data_hora) < DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
ORDER BY dias_sem_consulta DESC;

-- =============================================
-- 4) Dashboard financeiro (1 query)
-- =============================================
SELECT
    COUNT(DISTINCT c.id) AS total_consultas,
    SUM(c.valor) AS faturamento_bruto,
    COALESCE(SUM(CASE WHEN p.status = 'pago' THEN p.valor_pago END), 0) AS total_recebido,
    COALESCE(SUM(CASE WHEN p.status = 'pendente' THEN c.valor END), 0) AS total_pendente,
    CONCAT(
        ROUND(
            COALESCE(SUM(CASE WHEN p.status = 'pendente' THEN c.valor END), 0)
            / NULLIF(SUM(c.valor), 0) * 100,
            2
        ),
        '%'
    ) AS inadimplencia
FROM consultas c
LEFT JOIN pagamentos p ON p.consulta_id = c.id;

-- =============================================
-- 5) Veterinário do mês
-- =============================================
SELECT
    v.nome AS veterinario,
    COUNT(c.id) AS total_consultas,
    SUM(c.valor) AS total_faturado
FROM veterinarios v
JOIN consultas c ON c.veterinario_id = v.id
WHERE MONTH(c.data_hora) = MONTH(CURDATE())
  AND YEAR(c.data_hora) = YEAR(CURDATE())
GROUP BY v.id, v.nome
ORDER BY total_faturado DESC
LIMIT 1;

-- =============================================
-- 6) Distribuição por espécie
-- =============================================
SELECT
    e.nome AS especie,
    COUNT(a.id) AS total_animais,
    CONCAT(ROUND(COUNT(a.id) / (SELECT COUNT(*) FROM animais) * 100, 2), '%') AS percentual
FROM especies e
LEFT JOIN animais a ON a.especie_id = e.id
GROUP BY e.id, e.nome
ORDER BY total_animais DESC;
