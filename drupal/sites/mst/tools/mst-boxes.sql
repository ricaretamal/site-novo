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
-- Table structure for table `boxes`
--

DROP TABLE IF EXISTS `boxes`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `boxes` (
  `bid` int(10) unsigned NOT NULL auto_increment,
  `body` longtext,
  `info` varchar(128) NOT NULL default '',
  `format` smallint(6) NOT NULL default '0',
  PRIMARY KEY  (`bid`),
  UNIQUE KEY `info` (`info`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `boxes`
--

LOCK TABLES `boxes` WRITE;
/*!40000 ALTER TABLE `boxes` DISABLE KEYS */;
INSERT INTO `boxes` VALUES (2,'<h2 class=\"title\">Seções</h2>','Navegação de jornal',2),(5,'<?php\r\n\r\n$galeria = db_fetch_array(db_query(\" SELECT td.description, tn.nid,td.tid,td.name,f.filepath FROM term_data td, term_node tn, image i, files f WHERE td.tid = tn.tid AND tn.nid = i.nid AND i.fid = f.fid  AND i.image_size = \'thumbnail\' order by tid desc limit 1\"));\r\n\r\n$tituloGaleria = $galeria[\'name\'];\r\n$urlGaleria = url(\"image/tid/\" . $galeria[\'tid\']);\r\n$imagemGaleria = url($galeria[\'filepath\']);\r\n$textoGaleria = $galeria[\'description\'];\r\n\r\n?>\r\n<h2><?php print $tituloGaleria ?></h2>\r\n<span>\r\n  <a href=\'<?php print $urlGaleria ?>\'><img border=\'0\' src=\'<?php print $imagemGaleria; ?>\'></a>\r\n</span>\r\n<?php print $textoGaleria; ?>','Última galeria de imagens',3),(6,'<?php\r\n\r\n$resGaleria = db_query(\"SELECT DISTINCT tn.tid, tn.nid,td.name,f.filepath from node n, term_data td, term_node tn, image i, files f WHERE n.nid = tn.nid AND td.tid = tn.tid AND tn.nid = i.nid AND i.fid = f.fid  AND image_size = \'mini\' group by tid desc limit 2,12\");\r\n\r\n$strGaleria = \"<ul\'>\";\r\nwhile($galeria = db_fetch_array($resGaleria)) {\r\n  $urlGaleria = url(\"image/tid/\" . $galeria[\'tid\']);\r\n  $imagemGaleria = url($galeria[\'filepath\']);\r\n  \r\n  $strGaleria .= \"<li style=\'display: inline\'><a href=\'$urlGaleria\'><img border=\'0\' src=\'$imagemGaleria\'></a></li>\";\r\n}\r\n\r\n$strGaleria .= \"</ul>\";\r\n\r\nprint $strGaleria;\r\n?>','Listagem de galerias de imagem',3),(8,'<?php\r\nrequire_once drupal_get_path(\'module\', \'contact\') .\'/contact.pages.inc\';\r\n\r\nfunction local_contact_page(){\r\n    $form = contact_mail_page();\r\n    $form[\'name\'][\'#default_value\'] = \'Seu nome aqui\';\r\n    $form[\'name\'][\'#size\'] = 15;\r\n    $form[\'mail\'][\'#size\'] = 15;\r\n    $form[\'mail\'][\'#default_value\'] = \'\';\r\n    $form[\'subject\'][\'#size\'] = 15;\r\n    $form[\'subject\'][\'#default_value\'] = \'subscribe\';\r\n    $form[\'subject\'][\'#type\'] = \'hidden\';\r\n    $form[\'message\'][\'#size\'] = 1;\r\n    $form[\'message\'][\'#rows\'] = 2;\r\n    $form[\'message\'][\'#default_value\'] = \'subscribe\';\r\n    $form[\'message\'][\'#type\'] = \'hidden\';\r\n    $form[\'contact_information\'][\'#value\'] = \'\';\r\n    $form[\'cid\'][\'#type\']=\'hidden\';\r\n    $form[\'cid\'][\'#default_value\']= \'2\';\r\n\r\n    return($form);\r\n}\r\n\r\nfunction local_contact_page_submit($form_id, $form_values){\r\n    return(contact_mail_page_submit($form_id, $form_values));\r\n}\r\n\r\nfunction local_contact_page_validate($form, $form_state){\r\n    return(contact_mail_page_validate($form, $form_state));\r\n}\r\n\r\nprint drupal_get_form(\'local_contact_page\');  \r\n?>  ','Informativo Letraviva',3);
/*!40000 ALTER TABLE `boxes` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2009-06-21 21:23:25
