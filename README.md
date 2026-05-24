# PetVida V2 - Expansão do Schema

Este repositório contém a versão 2.0 do banco de dados da clínica veterinária **PetVida**.

## 🚀 Novidades na V2
- **Normalização (2NF):** Criação da tabela `especies` e substituição da coluna de texto em `animais` por uma chave estrangeira (`especie_id`).
- **Controle Financeiro:** Criação da tabela `pagamentos`, permitindo registrar a forma de pagamento (PIX, Cartão, Dinheiro, Convênio) e o status do pagamento.
- **Status de Consultas:** Adicionado o controle de estado da consulta (Agendada, Em Atendimento, Concluída, Cancelada).
- **Otimização de Performance:** Adição de `INDEX` em campos muito utilizados em filtros e buscas (`data_hora` nas consultas, `tutor_id` nos animais, e `consulta_id` nos pagamentos).

## 🗂 Estrutura de Arquivos
- `schema.sql`: Contém a definição atualizada de todas as tabelas (DDL) e índices.
- `seed.sql`: Contém a carga inicial de dados (DML) para testes (5 espécies, 3 veterinários, 8 tutores, 15 animais, 20 consultas e 20 pagamentos).

## 🔧 Como Executar
1. Abra o arquivo `schema.sql` no MySQL Workbench e execute-o para criar o banco de dados `petvida_v2` e as tabelas.
2. Abra o arquivo `seed.sql` e execute-o para popular o banco de dados com os dados fictícios (Seed) solicitados.
