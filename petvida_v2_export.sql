-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: petvida_v2
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `animais`
--

DROP TABLE IF EXISTS `animais`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `animais` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `especie_id` int(11) NOT NULL,
  `raca` varchar(50) DEFAULT NULL,
  `data_nascimento` date DEFAULT NULL,
  `tutor_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `especie_id` (`especie_id`),
  KEY `idx_animais_tutor_id` (`tutor_id`),
  CONSTRAINT `animais_ibfk_1` FOREIGN KEY (`especie_id`) REFERENCES `especies` (`id`),
  CONSTRAINT `animais_ibfk_2` FOREIGN KEY (`tutor_id`) REFERENCES `tutores` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `animais`
--

LOCK TABLES `animais` WRITE;
/*!40000 ALTER TABLE `animais` DISABLE KEYS */;
INSERT INTO `animais` VALUES (1,'Rex',1,'Labrador','2019-05-10',1),(2,'Mimi',2,'Siamês','2020-08-15',1),(3,'Bolinha',1,'Poodle','2018-12-01',2),(4,'Thor',1,'Bulldog','2021-03-20',3),(5,'Luna',2,'Persa','2019-11-05',3),(6,'Piu',3,'Calopsita','2022-01-10',4),(7,'Nina',1,'Vira-lata','2020-07-22',5),(8,'Nemo',4,'Palhaço','2023-01-01',6),(9,'Dory',4,'Cirurgião','2023-02-01',6),(10,'Spyro',5,'Iguana','2021-09-12',7),(11,'Mel',1,'Golden Retriever','2022-04-10',8),(12,'Simba',2,'Maine Coon','2020-12-25',1),(13,'Max',1,'Beagle','2019-07-14',2),(14,'Lola',1,'Pug','2021-08-30',4),(15,'Zazu',3,'Papagaio','2015-05-05',8);
/*!40000 ALTER TABLE `animais` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consultas`
--

DROP TABLE IF EXISTS `consultas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `consultas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `animal_id` int(11) NOT NULL,
  `veterinario_id` int(11) NOT NULL,
  `data_hora` datetime NOT NULL,
  `diagnostico` text DEFAULT NULL,
  `valor` decimal(10,2) NOT NULL,
  `status` enum('agendada','em_atendimento','concluida','cancelada') DEFAULT 'agendada',
  PRIMARY KEY (`id`),
  KEY `animal_id` (`animal_id`),
  KEY `veterinario_id` (`veterinario_id`),
  KEY `idx_consultas_data_hora` (`data_hora`),
  CONSTRAINT `consultas_ibfk_1` FOREIGN KEY (`animal_id`) REFERENCES `animais` (`id`),
  CONSTRAINT `consultas_ibfk_2` FOREIGN KEY (`veterinario_id`) REFERENCES `veterinarios` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consultas`
--

LOCK TABLES `consultas` WRITE;
/*!40000 ALTER TABLE `consultas` DISABLE KEYS */;
INSERT INTO `consultas` VALUES (1,1,1,'2023-10-01 10:00:00','Exame de rotina',150.00,'concluida'),(2,2,2,'2023-10-02 14:30:00','Castração',400.00,'concluida'),(3,3,3,'2023-10-05 09:00:00','Alergia na pele',200.00,'concluida'),(4,4,1,'2023-10-10 11:15:00','Vacina anual',120.00,'concluida'),(5,5,1,'2023-10-12 16:00:00','Problema respiratório',180.00,'concluida'),(6,6,2,'2023-10-15 10:00:00','Asa machucada',150.00,'concluida'),(7,7,3,'2023-10-20 08:30:00','Dermatite',220.00,'concluida'),(8,8,1,'2023-10-25 13:45:00','Análise de água',80.00,'concluida'),(9,9,1,'2023-11-02 09:00:00','Check-up',80.00,'concluida'),(10,10,2,'2023-11-05 15:00:00','Avaliação geral',120.00,'concluida'),(11,11,1,'2023-11-10 10:00:00','Vacina anual',120.00,'concluida'),(12,12,3,'2023-11-12 14:00:00','Problema de pele',200.00,'concluida'),(13,13,1,'2023-11-15 09:00:00','Exame de sangue',150.00,'concluida'),(14,14,2,'2023-11-18 11:00:00','Limpeza de tártaro',350.00,'concluida'),(15,15,1,'2023-11-20 16:00:00','Check-up',150.00,'concluida'),(16,1,1,'2023-12-01 10:00:00',NULL,150.00,'agendada'),(17,2,2,'2023-12-02 14:30:00',NULL,150.00,'cancelada'),(18,3,3,'2023-12-05 09:00:00',NULL,200.00,'agendada'),(19,4,1,'2023-12-10 11:15:00','Avaliação inicial',150.00,'em_atendimento'),(20,5,1,'2023-12-12 16:00:00',NULL,180.00,'agendada');
/*!40000 ALTER TABLE `consultas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `especies`
--

DROP TABLE IF EXISTS `especies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `especies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `especies`
--

LOCK TABLES `especies` WRITE;
/*!40000 ALTER TABLE `especies` DISABLE KEYS */;
INSERT INTO `especies` VALUES (1,'Cachorro'),(2,'Gato'),(3,'Pássaro'),(4,'Peixe'),(5,'Réptil');
/*!40000 ALTER TABLE `especies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pagamentos`
--

DROP TABLE IF EXISTS `pagamentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pagamentos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `consulta_id` int(11) NOT NULL,
  `valor_pago` decimal(10,2) NOT NULL,
  `forma_pagamento` enum('pix','cartao','dinheiro','convenio') NOT NULL,
  `data_pagamento` datetime DEFAULT NULL,
  `status` enum('pago','pendente','cancelado') DEFAULT 'pendente',
  PRIMARY KEY (`id`),
  KEY `idx_pagamentos_consulta_id` (`consulta_id`),
  CONSTRAINT `pagamentos_ibfk_1` FOREIGN KEY (`consulta_id`) REFERENCES `consultas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pagamentos`
--

LOCK TABLES `pagamentos` WRITE;
/*!40000 ALTER TABLE `pagamentos` DISABLE KEYS */;
INSERT INTO `pagamentos` VALUES (1,1,150.00,'pix','2023-10-01 10:30:00','pago'),(2,2,400.00,'cartao','2023-10-02 15:30:00','pago'),(3,3,200.00,'dinheiro','2023-10-05 09:30:00','pago'),(4,4,120.00,'pix','2023-10-10 11:30:00','pago'),(5,5,180.00,'cartao','2023-10-12 16:30:00','pago'),(6,6,150.00,'dinheiro','2023-10-15 10:30:00','pago'),(7,7,220.00,'pix','2023-10-20 09:00:00','pago'),(8,8,80.00,'cartao','2023-10-25 14:15:00','pago'),(9,9,80.00,'convenio','2023-11-02 09:30:00','pago'),(10,10,120.00,'pix','2023-11-05 15:30:00','pago'),(11,11,120.00,'cartao','2023-11-10 10:30:00','pago'),(12,12,200.00,'dinheiro','2023-11-12 14:30:00','pago'),(13,13,150.00,'pix','2023-11-15 09:30:00','pago'),(14,14,350.00,'cartao','2023-11-18 12:00:00','pago'),(15,15,150.00,'convenio','2023-11-20 16:30:00','pago'),(16,16,150.00,'pix',NULL,'pendente'),(17,17,0.00,'cartao',NULL,'cancelado'),(18,18,200.00,'dinheiro',NULL,'pendente'),(19,19,150.00,'pix','2023-12-10 11:15:00','pago'),(20,20,180.00,'cartao',NULL,'pendente');
/*!40000 ALTER TABLE `pagamentos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tutores`
--

DROP TABLE IF EXISTS `tutores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tutores` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `cpf` varchar(14) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cpf` (`cpf`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tutores`
--

LOCK TABLES `tutores` WRITE;
/*!40000 ALTER TABLE `tutores` DISABLE KEYS */;
INSERT INTO `tutores` VALUES (1,'Maria Silva','111.111.111-11','maria@email.com','11988888881'),(2,'João Souza','222.222.222-22','joao@email.com','11988888882'),(3,'Fernanda Lima','333.333.333-33','fernanda@email.com','11988888883'),(4,'Pedro Costa','444.444.444-44','pedro@email.com','11988888884'),(5,'Luciana Dias','555.555.555-55','luciana@email.com','11988888885'),(6,'Marcos Alves','666.666.666-66','marcos@email.com','11988888886'),(7,'Beatriz Nunes','777.777.777-77','beatriz@email.com','11988888887'),(8,'Ricardo Gomes','888.888.888-88','ricardo@email.com','11988888888');
/*!40000 ALTER TABLE `tutores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `veterinarios`
--

DROP TABLE IF EXISTS `veterinarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `veterinarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `crmv` varchar(20) NOT NULL,
  `especialidade` varchar(50) DEFAULT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `crmv` (`crmv`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `veterinarios`
--

LOCK TABLES `veterinarios` WRITE;
/*!40000 ALTER TABLE `veterinarios` DISABLE KEYS */;
INSERT INTO `veterinarios` VALUES (1,'Dr. Roberto','12345/SP','Clínica Geral','11999999991'),(2,'Dra. Ana','54321/SP','Cirurgia','11999999992'),(3,'Dr. Carlos','98765/SP','Dermatologia','11999999993');
/*!40000 ALTER TABLE `veterinarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `vw_agenda_hoje`
--

DROP TABLE IF EXISTS `vw_agenda_hoje`;
/*!50001 DROP VIEW IF EXISTS `vw_agenda_hoje`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vw_agenda_hoje` AS SELECT
 1 AS `data_hora`,
  1 AS `status_consulta`,
  1 AS `diagnostico`,
  1 AS `valor`,
  1 AS `animal`,
  1 AS `especie`,
  1 AS `tutor`,
  1 AS `telefone_tutor`,
  1 AS `veterinario`,
  1 AS `especialidade`,
  1 AS `forma_pagamento`,
  1 AS `status_pagamento` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_animais_detalhados`
--

DROP TABLE IF EXISTS `vw_animais_detalhados`;
/*!50001 DROP VIEW IF EXISTS `vw_animais_detalhados`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vw_animais_detalhados` AS SELECT
 1 AS `id_animal`,
  1 AS `animal`,
  1 AS `tutor`,
  1 AS `especie`,
  1 AS `total_consultas` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_consultas_completas`
--

DROP TABLE IF EXISTS `vw_consultas_completas`;
/*!50001 DROP VIEW IF EXISTS `vw_consultas_completas`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vw_consultas_completas` AS SELECT
 1 AS `data_hora`,
  1 AS `status_consulta`,
  1 AS `diagnostico`,
  1 AS `valor`,
  1 AS `animal`,
  1 AS `especie`,
  1 AS `tutor`,
  1 AS `telefone_tutor`,
  1 AS `veterinario`,
  1 AS `especialidade`,
  1 AS `forma_pagamento`,
  1 AS `status_pagamento` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_faturamento_mensal`
--

DROP TABLE IF EXISTS `vw_faturamento_mensal`;
/*!50001 DROP VIEW IF EXISTS `vw_faturamento_mensal`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vw_faturamento_mensal` AS SELECT
 1 AS `ano`,
  1 AS `mes`,
  1 AS `veterinario`,
  1 AS `total_consultas`,
  1 AS `faturamento_total` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_inadimplentes`
--

DROP TABLE IF EXISTS `vw_inadimplentes`;
/*!50001 DROP VIEW IF EXISTS `vw_inadimplentes`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vw_inadimplentes` AS SELECT
 1 AS `data_hora`,
  1 AS `animal`,
  1 AS `tutor`,
  1 AS `telefone_tutor`,
  1 AS `valor`,
  1 AS `status_pagamento` */;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `vw_agenda_hoje`
--

/*!50001 DROP VIEW IF EXISTS `vw_agenda_hoje`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_agenda_hoje` AS select `vw_consultas_completas`.`data_hora` AS `data_hora`,`vw_consultas_completas`.`status_consulta` AS `status_consulta`,`vw_consultas_completas`.`diagnostico` AS `diagnostico`,`vw_consultas_completas`.`valor` AS `valor`,`vw_consultas_completas`.`animal` AS `animal`,`vw_consultas_completas`.`especie` AS `especie`,`vw_consultas_completas`.`tutor` AS `tutor`,`vw_consultas_completas`.`telefone_tutor` AS `telefone_tutor`,`vw_consultas_completas`.`veterinario` AS `veterinario`,`vw_consultas_completas`.`especialidade` AS `especialidade`,`vw_consultas_completas`.`forma_pagamento` AS `forma_pagamento`,`vw_consultas_completas`.`status_pagamento` AS `status_pagamento` from `vw_consultas_completas` where cast(`vw_consultas_completas`.`data_hora` as date) = curdate() order by cast(`vw_consultas_completas`.`data_hora` as time) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_animais_detalhados`
--

/*!50001 DROP VIEW IF EXISTS `vw_animais_detalhados`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_animais_detalhados` AS select `a`.`id` AS `id_animal`,`a`.`nome` AS `animal`,`t`.`nome` AS `tutor`,`e`.`nome` AS `especie`,count(`c`.`id`) AS `total_consultas` from (((`animais` `a` join `tutores` `t` on(`a`.`tutor_id` = `t`.`id`)) join `especies` `e` on(`a`.`especie_id` = `e`.`id`)) left join `consultas` `c` on(`a`.`id` = `c`.`animal_id`)) group by `a`.`id`,`a`.`nome`,`t`.`nome`,`e`.`nome` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_consultas_completas`
--

/*!50001 DROP VIEW IF EXISTS `vw_consultas_completas`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_consultas_completas` AS select `c`.`data_hora` AS `data_hora`,`c`.`status` AS `status_consulta`,`c`.`diagnostico` AS `diagnostico`,`c`.`valor` AS `valor`,`a`.`nome` AS `animal`,`e`.`nome` AS `especie`,`t`.`nome` AS `tutor`,`t`.`telefone` AS `telefone_tutor`,`v`.`nome` AS `veterinario`,`v`.`especialidade` AS `especialidade`,`p`.`forma_pagamento` AS `forma_pagamento`,`p`.`status` AS `status_pagamento` from (((((`consultas` `c` join `animais` `a` on(`c`.`animal_id` = `a`.`id`)) join `especies` `e` on(`a`.`especie_id` = `e`.`id`)) join `tutores` `t` on(`a`.`tutor_id` = `t`.`id`)) join `veterinarios` `v` on(`c`.`veterinario_id` = `v`.`id`)) left join `pagamentos` `p` on(`c`.`id` = `p`.`consulta_id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_faturamento_mensal`
--

/*!50001 DROP VIEW IF EXISTS `vw_faturamento_mensal`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_faturamento_mensal` AS select year(`c`.`data_hora`) AS `ano`,month(`c`.`data_hora`) AS `mes`,`v`.`nome` AS `veterinario`,count(`c`.`id`) AS `total_consultas`,sum(`c`.`valor`) AS `faturamento_total` from (`consultas` `c` join `veterinarios` `v` on(`c`.`veterinario_id` = `v`.`id`)) group by year(`c`.`data_hora`),month(`c`.`data_hora`),`v`.`id`,`v`.`nome` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_inadimplentes`
--

/*!50001 DROP VIEW IF EXISTS `vw_inadimplentes`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_inadimplentes` AS select `vw_consultas_completas`.`data_hora` AS `data_hora`,`vw_consultas_completas`.`animal` AS `animal`,`vw_consultas_completas`.`tutor` AS `tutor`,`vw_consultas_completas`.`telefone_tutor` AS `telefone_tutor`,`vw_consultas_completas`.`valor` AS `valor`,`vw_consultas_completas`.`status_pagamento` AS `status_pagamento` from `vw_consultas_completas` where `vw_consultas_completas`.`status_consulta` = 'concluida' and (`vw_consultas_completas`.`status_pagamento` is null or `vw_consultas_completas`.`status_pagamento` = 'pendente') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-01 19:59:21
