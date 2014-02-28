-- MySQL dump 10.11
--
-- Host: localhost    Database: mst_novo
-- ------------------------------------------------------
-- Server version	5.0.51a-24+lenny1-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `blocks`
--

DROP TABLE IF EXISTS `blocks`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `blocks` (
  `bid` int(11) NOT NULL auto_increment,
  `module` varchar(64) NOT NULL default '',
  `delta` varchar(32) NOT NULL default '0',
  `theme` varchar(64) NOT NULL default '',
  `status` tinyint(4) NOT NULL default '0',
  `weight` tinyint(4) NOT NULL default '0',
  `region` varchar(64) NOT NULL default '',
  `custom` tinyint(4) NOT NULL default '0',
  `throttle` tinyint(4) NOT NULL default '0',
  `visibility` tinyint(4) NOT NULL default '0',
  `pages` text NOT NULL,
  `title` varchar(64) NOT NULL default '',
  `cache` tinyint(4) NOT NULL default '1',
  PRIMARY KEY  (`bid`),
  UNIQUE KEY `tmd` (`theme`,`module`,`delta`),
  KEY `list` (`theme`,`status`,`region`,`weight`,`module`)
) ENGINE=MyISAM AUTO_INCREMENT=116 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `blocks`
--

LOCK TABLES `blocks` WRITE;
/*!40000 ALTER TABLE `blocks` DISABLE KEYS */;
INSERT INTO `blocks` VALUES (1,'user','0','garland',1,0,'left',0,0,0,'','',-1),(2,'user','1','garland',1,0,'left',0,0,0,'','',-1),(3,'system','0','garland',1,10,'footer',0,0,0,'','',-1),(4,'system','0','mst',0,-10,'',0,0,0,'','',-1),(5,'user','0','mst',1,-4,'right',0,0,0,'','',-1),(6,'user','1','mst',1,-5,'right',0,0,0,'','',-1),(7,'comment','0','mst',0,-8,'',0,0,0,'','',1),(8,'locale','0','mst',0,9,'',0,0,0,'','',-1),(9,'menu','primary-links','mst',1,-10,'header',0,0,0,'','<none>',-1),(10,'menu','secondary-links','mst',0,3,'',0,0,0,'','',-1),(11,'node','0','mst',0,-7,'',0,0,0,'','',-1),(12,'user','2','mst',0,-2,'',0,0,0,'','',1),(13,'user','3','mst',0,2,'',0,0,0,'','',-1),(14,'book','0','mst',0,-4,'',0,0,0,'','',5),(15,'search','0','mst',0,-10,'',0,0,1,'<front>','<none>',-1),(17,'image','0','mst',0,10,'',0,0,1,'multimidia','',1),(18,'image','1','mst',0,-5,'',0,0,0,'','',1),(19,'img_assist','0','mst',0,-6,'',0,0,0,'','',1),(89,'block','1','mst',0,1,'',0,0,0,'','',-1),(90,'views','ultima_atualizacao-block_1','mst',0,0,'',0,0,0,'','',-1),(28,'views','comments_recent-block','mst',0,8,'',0,0,0,'','',-1),(29,'views','archive-block','mst',0,4,'',0,0,0,'','',-1),(30,'views','backlinks-block','mst',0,10,'',0,0,0,'','',-1),(34,'statistics','0','mst',0,6,'',0,0,0,'','',-1),(35,'audio','2','mst',0,5,'',0,0,1,'multimidia','',1),(36,'views','destaque_revista-block_1','mst',0,10,'',0,0,0,'','',-1),(37,'views','destaque_especial-block_1','mst',0,10,'',0,0,0,'','',-1),(39,'views','audio_last-block_1','mst',0,10,'',0,0,0,'','',-1),(40,'views','entrevista_destaque-block_1','mst',0,10,'',0,0,0,'','',-1),(41,'views','artigo_destaque-block_1','mst',0,10,'',0,0,0,'','',-1),(42,'views','popular-block','mst',0,7,'',0,0,0,'','',-1),(43,'views','popular-block_1','mst',0,10,'',0,0,0,'','',-1),(44,'views','audio-block_1','mst',0,10,'',0,0,0,'','',-1),(45,'views','audio_random-block_1','mst',0,10,'',0,0,0,'','',-1),(46,'system','0','mst2',0,-21,'',0,0,0,'','',-1),(47,'user','0','mst2',0,-20,'',0,0,0,'','',-1),(48,'user','1','mst2',1,-21,'right',0,0,0,'','',-1),(49,'comment','0','mst2',0,-18,'',0,0,0,'','',1),(50,'locale','0','mst2',0,-7,'',0,0,0,'','',-1),(51,'menu','primary-links','mst2',0,-22,'',0,0,0,'','',-1),(52,'menu','secondary-links','mst2',1,-21,'header',0,0,0,'','',-1),(53,'node','0','mst2',0,-17,'',0,0,0,'','',-1),(54,'user','2','mst2',0,-12,'',0,0,0,'','',1),(55,'user','3','mst2',0,-11,'',0,0,0,'','',-1),(56,'book','0','mst2',0,-13,'',0,0,0,'','',5),(57,'search','0','mst2',1,-20,'right',0,0,1,'<front>','<none>',-1),(58,'image','0','mst2',0,-16,'',0,0,1,'multimidia','',1),(59,'image','1','mst2',0,-14,'',0,0,0,'','',1),(60,'img_assist','0','mst2',0,-15,'',0,0,0,'','',1),(87,'block','2','mst',0,-3,'',0,0,0,'','',-1),(68,'block','5','mst2',1,-17,'content_bottom',0,0,1,'multimidia','',-1),(75,'statistics','0','mst2',0,-8,'',0,0,0,'','',-1),(76,'audio','2','mst2',0,-22,'',0,0,1,'multimidia','',1),(85,'views','audio-block_1','mst2',0,-6,'',0,0,0,'','',-1),(86,'views','audio_random-block_1','mst2',0,-5,'',0,0,0,'','',-1),(91,'block','6','mst2',0,-10,'',0,0,0,'','',-1),(92,'block','2','mst2',0,-9,'',0,0,0,'','',-1),(94,'gallery_navigation','0','mst2',1,-16,'content_bottom',0,0,1,'','',1),(95,'nav_estruturada','0','mst2',1,-7,'left',0,0,1,'revista/*\r\njornal/*','',1),(96,'relevance','0','mst2',1,-16,'right',0,0,0,'<front>\r\nmultimidia\r\nbook/*\r\nrevista/*\r\njornal/*\r\nespeciais/*','',1),(97,'views','ultimo_jornal-block_1','mst2',1,-13,'right',0,0,1,'<front>','',-1),(98,'views','ultima_revista-block_1','mst2',1,-14,'right',0,0,1,'<front>','',-1),(99,'views','ultimo_audio-block_1','mst2',1,-15,'content_bottom',0,0,1,'multimidia','',-1),(100,'views','ultimo_artigo-block_1','mst2',1,-15,'right',0,0,1,'<front>','',-1),(101,'views','ultima_entrevista-block_1','mst2',1,-18,'right',0,0,1,'<front>','',-1),(102,'views','listagem_artigos-block_1','mst2',0,-4,'',0,0,0,'','',-1),(103,'views','listagem_entrevistas-block_1','mst2',0,-3,'',0,0,0,'','',-1),(104,'views','ultimo_especial-block_1','mst2',1,-17,'right',0,0,1,'<front>','',-1),(105,'views','ultimo_video-block_1','mst2',1,-18,'content_bottom',0,0,1,'multimidia','',-1),(106,'views','ulltimas_noticias-block_1','mst2',1,-17,'content_bottom',0,0,1,'<front>','',-1),(107,'views','taxonomia_destaque-block_1','mst2',1,-19,'content_bottom',0,0,1,'<front>','',-1),(108,'views','frontpage_sticky-block_1','mst2',1,0,'content_top',0,0,1,'<front>','',-1),(109,'block','8','mst2',1,-12,'right',0,0,1,'<front>','Informativo Letraviva',-1),(110,'views','listagem_amigos-block_1','mst2',1,-11,'right',0,0,1,'<front>','',-1),(111,'views','listagem_selos-block_1','mst2',1,0,'footer',0,0,0,'','',-1),(112,'views','destaque_video-block_1','mst2',0,-19,'',0,0,1,'<front>','',-1),(113,'uc_cart','0','mst2',0,-1,'',0,0,0,'','',-1),(114,'nice_menus','1','mst2',1,0,'header',0,0,0,'','',-1),(115,'nice_menus','2','mst2',0,-2,'',0,0,0,'','',-1);
/*!40000 ALTER TABLE `blocks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blocks_roles`
--

DROP TABLE IF EXISTS `blocks_roles`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `blocks_roles` (
  `module` varchar(64) NOT NULL,
  `delta` varchar(32) NOT NULL,
  `rid` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`module`,`delta`,`rid`),
  KEY `rid` (`rid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `blocks_roles`
--

LOCK TABLES `blocks_roles` WRITE;
/*!40000 ALTER TABLE `blocks_roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `blocks_roles` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2009-06-21 21:23:22
