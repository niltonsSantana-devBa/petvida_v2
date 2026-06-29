const router = require('express').Router();
const db = require('../db');

router.post('/:consulta_id', async (req, res) => {
  try {
    const { forma_pagamento } = req.body;
    await db.execute(
      'CALL sp_registrar_pagamento(?, ?)',
      [req.params.consulta_id, forma_pagamento]
    );
    res.json({ message: 'Pagamento registrado com sucesso!' });
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
});

module.exports = router;
