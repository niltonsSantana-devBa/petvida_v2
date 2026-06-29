const router = require('express').Router();
const db = require('../db');

router.get('/dashboard', async (req, res) => {
  try {
    const [rows] = await db.execute(`
      SELECT
        COUNT(*) AS total_consultas,
        SUM(c.valor) AS faturamento_bruto,
        COALESCE(SUM(CASE WHEN p.status = 'pago' THEN p.valor_pago END), 0) AS recebido,
        COALESCE(SUM(CASE WHEN p.status = 'pendente' THEN c.valor END), 0) AS pendente,
        ROUND(
          COALESCE(SUM(CASE WHEN p.status = 'pendente' THEN 1 ELSE 0 END), 0)
          / NULLIF(COUNT(*), 0) * 100, 1
        ) AS pct_inadimplencia
      FROM consultas c
      LEFT JOIN pagamentos p ON c.id = p.consulta_id
      WHERE c.status != 'cancelada'
    `);
    res.json(rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

router.get('/inadimplentes', async (req, res) => {
  try {
    const [rows] = await db.execute('SELECT * FROM vw_inadimplentes');
    res.json(rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;
