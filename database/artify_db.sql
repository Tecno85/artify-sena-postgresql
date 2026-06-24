CREATE DATABASE  IF NOT EXISTS `artify_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `artify_db`;
-- MySQL dump 10.13  Distrib 8.0.43, for macos15 (arm64)
--
-- Host: localhost    Database: artify_db
-- ------------------------------------------------------
-- Server version	8.4.7

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `CONFIGURACION`
--

DROP TABLE IF EXISTS `CONFIGURACION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CONFIGURACION` (
  `cfg_id_configuracion` int NOT NULL AUTO_INCREMENT,
  `cfg_usr_id_usuario` int NOT NULL,
  `cfg_tema` enum('claro','oscuro','auto') DEFAULT 'oscuro',
  `cfg_idioma` varchar(10) DEFAULT 'es',
  `cfg_atajos_teclado` json DEFAULT NULL,
  `cfg_mostrar_ayudas` tinyint(1) DEFAULT '1',
  `cfg_calidad_exportacion` enum('baja','media','alta','maxima') DEFAULT 'alta',
  `cfg_configuracion_avanzada` json DEFAULT NULL,
  `cfg_fecha_actualizacion` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`cfg_id_configuracion`),
  UNIQUE KEY `cfg_usr_id_usuario` (`cfg_usr_id_usuario`),
  CONSTRAINT `configuracion_ibfk_1` FOREIGN KEY (`cfg_usr_id_usuario`) REFERENCES `USUARIO` (`usr_id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CONFIGURACION`
--

LOCK TABLES `CONFIGURACION` WRITE;
/*!40000 ALTER TABLE `CONFIGURACION` DISABLE KEYS */;
/*!40000 ALTER TABLE `CONFIGURACION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `IMAGEN`
--

DROP TABLE IF EXISTS `IMAGEN`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `IMAGEN` (
  `img_id_imagen` int NOT NULL AUTO_INCREMENT,
  `img_usr_id_usuario` int NOT NULL,
  `img_nombre_original` varchar(255) NOT NULL,
  `img_nombre_archivo` varchar(255) NOT NULL,
  `img_formato` varchar(50) NOT NULL,
  `img_ancho_original` int NOT NULL,
  `img_alto_original` int NOT NULL,
  `img_tamano_bytes` bigint NOT NULL,
  `img_hash_archivo` varchar(255) DEFAULT NULL,
  `img_fecha_subida` datetime DEFAULT CURRENT_TIMESTAMP,
  `img_fecha_modificacion` datetime DEFAULT NULL,
  `img_estado_imagen` enum('activa','archivada','eliminada') DEFAULT 'activa',
  PRIMARY KEY (`img_id_imagen`),
  KEY `img_usr_id_usuario` (`img_usr_id_usuario`),
  CONSTRAINT `imagen_ibfk_1` FOREIGN KEY (`img_usr_id_usuario`) REFERENCES `USUARIO` (`usr_id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `IMAGEN`
--

LOCK TABLES `IMAGEN` WRITE;
/*!40000 ALTER TABLE `IMAGEN` DISABLE KEYS */;
/*!40000 ALTER TABLE `IMAGEN` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OPERACION`
--

DROP TABLE IF EXISTS `OPERACION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `OPERACION` (
  `opr_id_operacion` int NOT NULL AUTO_INCREMENT,
  `opr_ses_id_sesion` int NOT NULL,
  `opr_usr_id_usuario` int NOT NULL,
  `opr_tipo_operacion` varchar(100) NOT NULL,
  `opr_parametros` json DEFAULT NULL,
  `opr_fecha_hora` datetime DEFAULT CURRENT_TIMESTAMP,
  `opr_orden_secuencial` int NOT NULL,
  `opr_estado_operacion` enum('completada','revertida','error') DEFAULT 'completada',
  `opr_tiempo_ejecucion_ms` int DEFAULT NULL,
  PRIMARY KEY (`opr_id_operacion`),
  KEY `opr_ses_id_sesion` (`opr_ses_id_sesion`),
  KEY `opr_usr_id_usuario` (`opr_usr_id_usuario`),
  CONSTRAINT `operacion_ibfk_1` FOREIGN KEY (`opr_ses_id_sesion`) REFERENCES `SESION_EDICION` (`ses_id_sesion`),
  CONSTRAINT `operacion_ibfk_2` FOREIGN KEY (`opr_usr_id_usuario`) REFERENCES `USUARIO` (`usr_id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OPERACION`
--

LOCK TABLES `OPERACION` WRITE;
/*!40000 ALTER TABLE `OPERACION` DISABLE KEYS */;
/*!40000 ALTER TABLE `OPERACION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SESION_EDICION`
--

DROP TABLE IF EXISTS `SESION_EDICION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SESION_EDICION` (
  `ses_id_sesion` int NOT NULL AUTO_INCREMENT,
  `ses_usr_id_usuario` int NOT NULL,
  `ses_img_id_imagen` int DEFAULT NULL,
  `ses_fecha_inicio` datetime DEFAULT CURRENT_TIMESTAMP,
  `ses_fecha_fin` datetime DEFAULT NULL,
  `ses_duracion_minutos` int DEFAULT NULL,
  `ses_estado_sesion` enum('activa','pausada','finalizada','cancelada') DEFAULT 'activa',
  `ses_cambios_guardados` tinyint(1) DEFAULT '0',
  `ses_numero_operaciones` int DEFAULT '0',
  PRIMARY KEY (`ses_id_sesion`),
  KEY `ses_usr_id_usuario` (`ses_usr_id_usuario`),
  KEY `ses_img_id_imagen` (`ses_img_id_imagen`),
  CONSTRAINT `sesion_edicion_ibfk_1` FOREIGN KEY (`ses_usr_id_usuario`) REFERENCES `USUARIO` (`usr_id_usuario`),
  CONSTRAINT `sesion_edicion_ibfk_2` FOREIGN KEY (`ses_img_id_imagen`) REFERENCES `IMAGEN` (`img_id_imagen`)
) ENGINE=InnoDB AUTO_INCREMENT=243 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SESION_EDICION`
--

LOCK TABLES `SESION_EDICION` WRITE;
/*!40000 ALTER TABLE `SESION_EDICION` DISABLE KEYS */;
/*!40000 ALTER TABLE `SESION_EDICION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USUARIO`
--

DROP TABLE IF EXISTS `USUARIO`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `USUARIO` (
  `usr_id_usuario` int NOT NULL AUTO_INCREMENT,
  `usr_nombres` varchar(100) NOT NULL,
  `usr_apellidos` varchar(100) NOT NULL,
  `usr_cedula` varchar(20) NOT NULL,
  `usr_fecha_nacimiento` date NOT NULL,
  `usr_correo` varchar(150) NOT NULL,
  `usr_contrasena` varchar(255) NOT NULL,
  `usr_fecha_registro` datetime DEFAULT CURRENT_TIMESTAMP,
  `usr_ultimo_acceso` datetime DEFAULT NULL,
  `usr_sesion_activa` tinyint(1) DEFAULT '0',
  `usr_estado_usuario` enum('activo','inactivo','suspendido') DEFAULT 'activo',
  `usr_rol` enum('usuario','admin') NOT NULL DEFAULT 'usuario',
  PRIMARY KEY (`usr_id_usuario`),
  UNIQUE KEY `usr_cedula` (`usr_cedula`),
  UNIQUE KEY `usr_correo` (`usr_correo`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USUARIO`
--

LOCK TABLES `USUARIO` WRITE;
/*!40000 ALTER TABLE `USUARIO` DISABLE KEYS */;
INSERT INTO `USUARIO` VALUES 
(1,'Admin','Artify','0000000000','1990-01-01',
'admin@artify.com','$2b$10$hash_de_ejemplo_no_valido',
NOW(),NULL,0,'activo','admin');
/*!40000 ALTER TABLE `USUARIO` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `v_usuarios_activos`
--

DROP TABLE IF EXISTS `v_usuarios_activos`;
/*!50001 DROP VIEW IF EXISTS `v_usuarios_activos`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_usuarios_activos` AS SELECT 
 1 AS `usr_id_usuario`,
 1 AS `nombre_completo`,
 1 AS `usr_correo`,
 1 AS `usr_fecha_registro`,
 1 AS `usr_ultimo_acceso`,
 1 AS `usr_sesion_activa`,
 1 AS `total_imagenes`,
 1 AS `total_sesiones`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `v_usuarios_activos`
--

/*!50001 DROP VIEW IF EXISTS `v_usuarios_activos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_usuarios_activos` AS select `u`.`usr_id_usuario` AS `usr_id_usuario`,concat(`u`.`usr_nombres`,' ',`u`.`usr_apellidos`) AS `nombre_completo`,`u`.`usr_correo` AS `usr_correo`,`u`.`usr_fecha_registro` AS `usr_fecha_registro`,`u`.`usr_ultimo_acceso` AS `usr_ultimo_acceso`,`u`.`usr_sesion_activa` AS `usr_sesion_activa`,count(distinct `i`.`img_id_imagen`) AS `total_imagenes`,count(distinct `s`.`ses_id_sesion`) AS `total_sesiones` from ((`usuario` `u` left join `imagen` `i` on((`u`.`usr_id_usuario` = `i`.`img_usr_id_usuario`))) left join `sesion_edicion` `s` on((`u`.`usr_id_usuario` = `s`.`ses_usr_id_usuario`))) where (`u`.`usr_estado_usuario` = 'activo') group by `u`.`usr_id_usuario` */;
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

-- Dump completed on 2026-03-21  8:39:03
