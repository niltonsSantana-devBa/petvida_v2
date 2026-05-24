USE petvida_v2;

-- 5 espécies
INSERT INTO especies (nome) VALUES 
('Cachorro'), 
('Gato'), 
('Pássaro'), 
('Peixe'), 
('Réptil');

-- 3 veterinários
INSERT INTO veterinarios (nome, crmv, especialidade, telefone) VALUES
('Dr. Roberto', '12345/SP', 'Clínica Geral', '11999999991'),
('Dra. Ana', '54321/SP', 'Cirurgia', '11999999992'),
('Dr. Carlos', '98765/SP', 'Dermatologia', '11999999993');

-- 8 tutores
INSERT INTO tutores (nome, cpf, email, telefone) VALUES
('Maria Silva', '111.111.111-11', 'maria@email.com', '11988888881'),
('João Souza', '222.222.222-22', 'joao@email.com', '11988888882'),
('Fernanda Lima', '333.333.333-33', 'fernanda@email.com', '11988888883'),
('Pedro Costa', '444.444.444-44', 'pedro@email.com', '11988888884'),
('Luciana Dias', '555.555.555-55', 'luciana@email.com', '11988888885'),
('Marcos Alves', '666.666.666-66', 'marcos@email.com', '11988888886'),
('Beatriz Nunes', '777.777.777-77', 'beatriz@email.com', '11988888887'),
('Ricardo Gomes', '888.888.888-88', 'ricardo@email.com', '11988888888');

-- 15 animais
INSERT INTO animais (nome, especie_id, raca, data_nascimento, tutor_id) VALUES
('Rex', 1, 'Labrador', '2019-05-10', 1),
('Mimi', 2, 'Siamês', '2020-08-15', 1),
('Bolinha', 1, 'Poodle', '2018-12-01', 2),
('Thor', 1, 'Bulldog', '2021-03-20', 3),
('Luna', 2, 'Persa', '2019-11-05', 3),
('Piu', 3, 'Calopsita', '2022-01-10', 4),
('Nina', 1, 'Vira-lata', '2020-07-22', 5),
('Nemo', 4, 'Palhaço', '2023-01-01', 6),
('Dory', 4, 'Cirurgião', '2023-02-01', 6),
('Spyro', 5, 'Iguana', '2021-09-12', 7),
('Mel', 1, 'Golden Retriever', '2022-04-10', 8),
('Simba', 2, 'Maine Coon', '2020-12-25', 1),
('Max', 1, 'Beagle', '2019-07-14', 2),
('Lola', 1, 'Pug', '2021-08-30', 4),
('Zazu', 3, 'Papagaio', '2015-05-05', 8);

-- 20 consultas
INSERT INTO consultas (animal_id, veterinario_id, data_hora, diagnostico, valor, status) VALUES
(1, 1, '2023-10-01 10:00:00', 'Exame de rotina', 150.00, 'concluida'),
(2, 2, '2023-10-02 14:30:00', 'Castração', 400.00, 'concluida'),
(3, 3, '2023-10-05 09:00:00', 'Alergia na pele', 200.00, 'concluida'),
(4, 1, '2023-10-10 11:15:00', 'Vacina anual', 120.00, 'concluida'),
(5, 1, '2023-10-12 16:00:00', 'Problema respiratório', 180.00, 'concluida'),
(6, 2, '2023-10-15 10:00:00', 'Asa machucada', 150.00, 'concluida'),
(7, 3, '2023-10-20 08:30:00', 'Dermatite', 220.00, 'concluida'),
(8, 1, '2023-10-25 13:45:00', 'Análise de água', 80.00, 'concluida'),
(9, 1, '2023-11-02 09:00:00', 'Check-up', 80.00, 'concluida'),
(10, 2, '2023-11-05 15:00:00', 'Avaliação geral', 120.00, 'concluida'),
(11, 1, '2023-11-10 10:00:00', 'Vacina anual', 120.00, 'concluida'),
(12, 3, '2023-11-12 14:00:00', 'Problema de pele', 200.00, 'concluida'),
(13, 1, '2023-11-15 09:00:00', 'Exame de sangue', 150.00, 'concluida'),
(14, 2, '2023-11-18 11:00:00', 'Limpeza de tártaro', 350.00, 'concluida'),
(15, 1, '2023-11-20 16:00:00', 'Check-up', 150.00, 'concluida'),
(1, 1, '2023-12-01 10:00:00', NULL, 150.00, 'agendada'),
(2, 2, '2023-12-02 14:30:00', NULL, 150.00, 'cancelada'),
(3, 3, '2023-12-05 09:00:00', NULL, 200.00, 'agendada'),
(4, 1, '2023-12-10 11:15:00', 'Avaliação inicial', 150.00, 'em_atendimento'),
(5, 1, '2023-12-12 16:00:00', NULL, 180.00, 'agendada');

-- 20 pagamentos
INSERT INTO pagamentos (consulta_id, valor_pago, forma_pagamento, data_pagamento, status) VALUES
(1, 150.00, 'pix', '2023-10-01 10:30:00', 'pago'),
(2, 400.00, 'cartao', '2023-10-02 15:30:00', 'pago'),
(3, 200.00, 'dinheiro', '2023-10-05 09:30:00', 'pago'),
(4, 120.00, 'pix', '2023-10-10 11:30:00', 'pago'),
(5, 180.00, 'cartao', '2023-10-12 16:30:00', 'pago'),
(6, 150.00, 'dinheiro', '2023-10-15 10:30:00', 'pago'),
(7, 220.00, 'pix', '2023-10-20 09:00:00', 'pago'),
(8, 80.00, 'cartao', '2023-10-25 14:15:00', 'pago'),
(9, 80.00, 'convenio', '2023-11-02 09:30:00', 'pago'),
(10, 120.00, 'pix', '2023-11-05 15:30:00', 'pago'),
(11, 120.00, 'cartao', '2023-11-10 10:30:00', 'pago'),
(12, 200.00, 'dinheiro', '2023-11-12 14:30:00', 'pago'),
(13, 150.00, 'pix', '2023-11-15 09:30:00', 'pago'),
(14, 350.00, 'cartao', '2023-11-18 12:00:00', 'pago'),
(15, 150.00, 'convenio', '2023-11-20 16:30:00', 'pago'),
(16, 150.00, 'pix', NULL, 'pendente'),
(17, 0.00, 'cartao', NULL, 'cancelado'),
(18, 200.00, 'dinheiro', NULL, 'pendente'),
(19, 150.00, 'pix', '2023-12-10 11:15:00', 'pago'),
(20, 180.00, 'cartao', NULL, 'pendente');
