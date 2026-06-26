const app = require('./scr/app');
require('dotenv').config();

const PORT = process.env.PORT || 3001;

app.listen(PORT, () => {

    console.log (`PetVida API rodando na porta ${PORT}`)
    console.log (`Teste: http://localhost:${PORT}/api`)
});