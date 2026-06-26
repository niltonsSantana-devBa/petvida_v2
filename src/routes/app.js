



app.get('/api', (req, res)) => {
    res.json({message: 'Pet Vida API',status:'Online' })
};

app.use('/api')

app.use('/api/verinarios')
