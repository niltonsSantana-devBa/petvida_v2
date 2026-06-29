const router = require('express').Router();
const db = require('../config/database');

// POST /api/consultas — Agendar nova consulta
router.post('/', async (req, res) => {
  try {
    const { animal_id, veterinario_id, data_hora, valor } = req.body;
    await db.execute(
      'CALL sp_agendar_consulta(?, ?, ?, ?)',
      [animal_id, veterinario_id, data_hora, valor]
    );
    res.status(201).json({ message: 'Consulta agendada com sucesso!' });
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
});

// PUT /api/consultas/:id/concluir — Concluir consulta
router.put('/:id/concluir', async (req, res) => {
  try {
    const { diagnostico } = req.body;
    await db.execute(
      'CALL sp_concluir_consulta(?, ?)',
      [req.params.id, diagnostico]
    );
    res.json({ message: 'Consulta concluída com sucesso!' });
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
});

// GET /api/agenda/:data — Agenda do dia
router.get('/agenda/:data', async (req, res) => {
  try {
    const [rows] = await db.execute(
      'SELECT * FROM vw_consultas_completas WHERE DATE(data_hora) = ?',
      [req.params.data]
    );
    res.json(rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;
