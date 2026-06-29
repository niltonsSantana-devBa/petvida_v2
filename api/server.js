const express = require('express');
const cors = require('cors');
require('dotenv').config();

const app = express();
app.use(cors());
app.use(express.json());

// Rotas
app.use('/api/veterinarios', require('./routes/veterinarios'));
app.use('/api/animais', require('./routes/animais'));
app.use('/api/consultas', require('./routes/consultas'));
app.use('/api/agenda', require('./routes/consultas'));
app.use('/api/pagamentos', require('./routes/pagamentos'));
app.use('/api/relatorios', require('./routes/relatorios'));

// Status da API
app.get('/', (req, res) => {
  res.json({ message: 'PetVida API rodando!' });
});

const PORT = process.env.PORT || 3001;
app.listen(PORT, () => {
  console.log(`PetVida API rodando na porta ${PORT}`);
});
