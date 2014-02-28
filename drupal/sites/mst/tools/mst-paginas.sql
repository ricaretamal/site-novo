-- MySQL dump 10.11
--
-- Host: localhost    Database: mst_novo
-- ------------------------------------------------------
-- Server version	5.0.60-log

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
-- Table structure for table `node`
--

DROP TABLE IF EXISTS `node`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `node` (
  `nid` int(10) unsigned NOT NULL auto_increment,
  `vid` int(10) unsigned NOT NULL default '0',
  `type` varchar(32) NOT NULL default '',
  `language` varchar(12) NOT NULL default '',
  `title` varchar(255) NOT NULL default '',
  `uid` int(11) NOT NULL default '0',
  `status` int(11) NOT NULL default '1',
  `created` int(11) NOT NULL default '0',
  `changed` int(11) NOT NULL default '0',
  `comment` int(11) NOT NULL default '0',
  `promote` int(11) NOT NULL default '0',
  `moderate` int(11) NOT NULL default '0',
  `sticky` int(11) NOT NULL default '0',
  `tnid` int(10) unsigned NOT NULL default '0',
  `translate` int(11) NOT NULL default '0',
  PRIMARY KEY  (`nid`),
  UNIQUE KEY `vid` (`vid`),
  KEY `node_changed` (`changed`),
  KEY `node_created` (`created`),
  KEY `node_moderate` (`moderate`),
  KEY `node_promote_status` (`promote`,`status`),
  KEY `node_status_type` (`status`,`type`,`nid`),
  KEY `node_title_type` (`title`,`type`(4)),
  KEY `node_type` (`type`(4)),
  KEY `uid` (`uid`),
  KEY `tnid` (`tnid`),
  KEY `translate` (`translate`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `node`
--

LOCK TABLES `node` WRITE;
/*!40000 ALTER TABLE `node` DISABLE KEYS */;
INSERT INTO `node` VALUES (1,1,'book','pt-br','Jornal Sem Terra',1,1,1220286103,1220286103,2,0,0,0,0,0),(2,2,'book','pt-br','Revista Sem Terra',1,1,1220286121,1220286121,2,0,0,0,0,0),(3,3,'book','pt-br','Especiais',1,1,1220286136,1220286136,2,0,0,0,0,0),(5,5,'page','pt-br','Redirecionando...',1,1,1221870260,1221871051,2,0,0,0,0,0),(6,6,'page','pt-br','Redirecionando...',1,1,1222104876,1222104972,0,0,0,0,0,0),(7,7,'page','pt-br','Redirecionando...',1,1,1222104876,1222104972,0,0,0,0,0,0),(8,8,'page','pt-br','Página inicial',1,1,1223924458,1223924564,0,0,0,0,0,0),(9,9,'image','pt-br','',1,1,1226461528,1226461528,2,0,0,0,0,0),(10,10,'page','pt-br','Multimídia',1,1,1226461528,1229010480,2,0,0,0,0,0),(11,11,'page','pt-br','Sobre o MST',1,1,1229010790,1229010790,0,0,0,0,0,0),(12,12,'page','pt-br','Mural do MST',1,1,1229011070,1229011070,2,0,0,0,0,0),(14,14,'page','pt-br','Nossa Produção',1,1,1229011507,1229011507,0,0,0,0,0,0);
/*!40000 ALTER TABLE `node` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `node_revisions`
--

DROP TABLE IF EXISTS `node_revisions`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `node_revisions` (
  `nid` int(10) unsigned NOT NULL default '0',
  `vid` int(10) unsigned NOT NULL auto_increment,
  `uid` int(11) NOT NULL default '0',
  `title` varchar(255) NOT NULL default '',
  `body` longtext NOT NULL,
  `teaser` longtext NOT NULL,
  `log` longtext NOT NULL,
  `timestamp` int(11) NOT NULL default '0',
  `format` int(11) NOT NULL default '0',
  PRIMARY KEY  (`vid`),
  KEY `nid` (`nid`),
  KEY `uid` (`uid`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `node_revisions`
--

LOCK TABLES `node_revisions` WRITE;
/*!40000 ALTER TABLE `node_revisions` DISABLE KEYS */;
INSERT INTO `node_revisions` VALUES (1,1,1,'Jornal Sem Terra','Jornal Sem Terra','Jornal Sem Terra','',1220286103,1),(2,2,1,'Revista Sem Terra','Revista Sem Terra','Revista Sem Terra','',1220286121,1),(3,3,1,'Especiais','Especiais','Especiais','',1220286136,1),(5,5,1,'Redirecionando...','<?php\r\n\r\nglobal $base_url;\r\n$url = $base_url;\r\n\r\n// pega id antigo\r\n$cd = $_REQUEST[\"cd\"];\r\n\r\n// se for um id valido\r\nif (is_numeric($cd)) {\r\n    \r\n    $result = db_query(\"SELECT nid FROM legacy WHERE old_id = $cd\");\r\n    \r\n    $item = db_fetch_array($result);\r\n    $nid = $item[\'nid\'];\r\n    \r\n    $url .= \"/node/$nid\";\r\n}\r\n\r\nheader(\"Location: $url\");\r\n\r\n?>','<?php\r\n\r\nglobal $base_url;\r\n$url = $base_url;\r\n\r\n// pega id antigo\r\n$cd = $_REQUEST[\"cd\"];\r\n\r\n// se for um id valido\r\nif (is_numeric($cd)) {\r\n    \r\n    $result = db_query(\"SELECT nid FROM legacy WHERE old_id = $cd\");\r\n    \r\n    $item = db_fetch_array($result);\r\n    $nid = $item[\'nid\'];\r\n    \r\n    $url .= \"/node/$nid\";\r\n}\r\n\r\nheader(\"Location: $url\");\r\n\r\n?>','',1221871051,3),(6,6,1,'Redirecionando...','<?php\r\n\r\nglobal $base_url;\r\n$url = $base_url;\r\n\r\n// pega id antigo\r\n$cd = $_REQUEST[\"cd\"];\r\n\r\n// se for um id valido\r\nif (is_numeric($cd)) {\r\n    \r\n    $result = db_query(\"SELECT nid FROM legacy WHERE old_id = $cd AND type in (\'Jornal Sem Terra\', \'Revista Sem Terra\')\");\r\n    \r\n    $item = db_fetch_array($result);\r\n    $nid = $item[\'nid\'];\r\n    \r\n    $url .= \"/node/$nid\";\r\n}\r\n\r\nheader(\"Location: $url\");\r\n\r\n?>','<?php\r\n\r\nglobal $base_url;\r\n$url = $base_url;\r\n\r\n// pega id antigo\r\n$cd = $_REQUEST[\"cd\"];\r\n\r\n// se for um id valido\r\nif (is_numeric($cd)) {\r\n    \r\n    $result = db_query(\"SELECT nid FROM legacy WHERE old_id = $cd AND type in (\'Jornal Sem Terra\', \'Revista Sem Terra\')\");\r\n    \r\n    $item = db_fetch_array($result);\r\n    $nid = $item[\'nid\'];\r\n    \r\n    $url .= \"/node/$nid\";\r\n}\r\n\r\nheader(\"Location: $url\");\r\n\r\n?>','',1222104972,3),(7,7,1,'Redirecionando...','<?php\r\n\r\nglobal $base_url;\r\n$url = $base_url;\r\n\r\n// pega id antigo\r\n$ed = $_REQUEST[\"ed\"];\r\n\r\n// se for um id valido\r\nif (is_numeric($ed)) {\r\n    \r\n    $result = db_query(\"SELECT nid FROM legacy WHERE old_id = $ed AND type in (\'Especiais\')\");\r\n    \r\n    $item = db_fetch_array($result);\r\n    $nid = $item[\'nid\'];\r\n    \r\n    $url .= \"/node/$nid\";\r\n}\r\n\r\nheader(\"Location: $url\");\r\n\r\n?>','<?php\r\n\r\nglobal $base_url;\r\n$url = $base_url;\r\n\r\n// pega id antigo\r\n$ed = $_REQUEST[\"ed\"];\r\n\r\n// se for um id valido\r\nif (is_numeric($ed)) {\r\n    \r\n    $result = db_query(\"SELECT nid FROM legacy WHERE old_id = $ed AND type in (\'Especiais\')\");\r\n    \r\n    $item = db_fetch_array($result);\r\n    $nid = $item[\'nid\'];\r\n    \r\n    $url .= \"/node/$nid\";\r\n}\r\n\r\nheader(\"Location: $url\");\r\n\r\n?>','',1224243546,3),(8,8,1,'Página Inicial','<?php\r\n\r\n  /* customizacao para MST\r\n   * - pode pegar de de 0 a 1 materias sticky\r\n   * - exclui materias sticky da listagem, fixa\r\n   * - tirei a paginacao\r\n   */\r\n  $resultSticky = pager_query(db_rewrite_sql(\'SELECT n.nid, n.sticky, n.created FROM {node} n WHERE n.promote = 1 AND n.status = 1 and sticky = 1 ORDER BY n.created DESC\'),\n 1);\r\n				\r\n  $output = \'\';\r\n  while ($nodeSticky = db_fetch_object($resultSticky)) {\r\n      $output .= node_view(node_load($nodeSticky->nid),\n 1);\r\n  }\r\n\r\n  // essa lista tambem exclui os termos de posicionamento nos boxes (hardcoded 86 e 87)\r\n  $result = pager_query(db_rewrite_sql(\'SELECT DISTINCT n.nid, n.created FROM {node} n WHERE n.promote = 1 AND n.status = 1 AND sticky = 0 AND n.nid NOT IN ( SELECT n.nid FROM node n, term_node tn WHERE tn.nid=n.nid AND (tn.tid = 86 OR tn.tid = 87)) ORDER BY n.created DESC\'),\n 3);\r\n  \r\n  $num_rows = FALSE;\r\n  while ($node = db_fetch_object($result)) {\r\n    $output .= node_view(node_load($node->nid),\n 1);\r\n    $num_rows = TRUE;\r\n  }\r\n\r\n  if ($num_rows) {\r\n    $feed_url = url(\'rss.xml\', array(\'absolute\' => TRUE));\r\n    drupal_add_feed($feed_url, variable_get(\'site_name\', \'Drupal\') .\' \'. t(\'RSS\'));\r\n    //    $output .= theme(\'pager\', NULL, variable_get(\'default_nodes_main\', 10)); // paginacao comentada\r\n  }\r\n  else {\r\n      $output = \'\';\r\n  }\r\n  drupal_set_title(\'\');\r\n\r\nprint $output;\r\n\r\n?>','<?php\r\n\r\n  /* customizacao para MST\r\n   * - pode pegar de de 0 a 1 materias sticky\r\n   * - exclui materias sticky da listagem, fixa\r\n   * - tirei a paginacao\r\n   */\r\n  $resultSticky = pager_query(db_rewrite_sql(\'SELECT n.nid, n.sticky, n.created FROM {node} n WHERE n.promote = 1 AND n.status = 1 and sticky = 1 ORDER BY n.created DESC\'),\n 1);\r\n				\r\n  $output = \'\';\r\n  while ($nodeSticky = db_fetch_object($resultSticky)) {\r\n      $output .= node_view(node_load($nodeSticky->nid),\n 1);\r\n  }\r\n\r\n  // essa lista tambem exclui os termos de posicionamento nos boxes (hardcoded 86 e 87)\r\n  $result = pager_query(db_rewrite_sql(\'SELECT DISTINCT n.nid, n.created FROM {node} n WHERE n.promote = 1 AND n.status = 1 AND sticky = 0 AND n.nid NOT IN ( SELECT n.nid FROM node n, term_node tn WHERE tn.nid=n.nid AND (tn.tid = 86 OR tn.tid = 87)) ORDER BY n.created DESC\'),\n 3);\r\n  \r\n  $num_rows = FALSE;\r\n  while ($node = db_fetch_object($result)) {\r\n    $output .= node_view(node_load($node->nid),\n 1);\r\n    $num_rows = TRUE;\r\n  }\r\n\r\n  if ($num_rows) {\r\n    $feed_url = url(\'rss.xml\', array(\'absolute\' => TRUE));\r\n    drupal_add_feed($feed_url, variable_get(\'site_name\', \'Drupal\') .\' \'. t(\'RSS\'));\r\n    //    $output .= theme(\'pager\', NULL, variable_get(\'default_nodes_main\', 10)); // paginacao comentada\r\n  }\r\n  else {\r\n      $output = \'\';\r\n  }\r\n  drupal_set_title(\'\');\r\n\r\nprint $output;\r\n\r\n?>','',1223924564,3),(9,9,1,'','','','',1226461528,1),(10,10,1,'Multimídia','Página de multimídia do MST\r\n\r\nAudio - Video - Galerias de imagens','Página de multimídia do MST\r\n\r\nAudio - Video - Galerias de imagens','',1229010480,1),(11,11,1,'Sobre o MST','Sobre o MST','Sobre o MST','',1229010790,1),(12,12,1,'Mural do MST','Mural do MST','Mural do MST','',1229011070,1),(14,14,1,'Nossa Produção','Nossa Produção','Nossa Produção','',1229011507,1);
/*!40000 ALTER TABLE `node_revisions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `node_comment_statistics`
--

DROP TABLE IF EXISTS `node_comment_statistics`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `node_comment_statistics` (
  `nid` int(10) unsigned NOT NULL default '0',
  `last_comment_timestamp` int(11) NOT NULL default '0',
  `last_comment_name` varchar(60) default NULL,
  `last_comment_uid` int(11) NOT NULL default '0',
  `comment_count` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`nid`),
  KEY `node_comment_timestamp` (`last_comment_timestamp`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `node_comment_statistics`
--

LOCK TABLES `node_comment_statistics` WRITE;
/*!40000 ALTER TABLE `node_comment_statistics` DISABLE KEYS */;
INSERT INTO `node_comment_statistics` VALUES (1,1220286103,NULL,1,0),(2,1220286121,NULL,1,0),(3,1220286136,NULL,1,0),(4,1220286136,NULL,1,0),(5,1221870260,NULL,1,0),(6,1221870260,NULL,1,0),(7,1221870260,NULL,1,0),(8,1223924458,NULL,1,0),(9,1223924458,NULL,1,0),(10,1223924458,NULL,1,0),(11,1229010790,NULL,1,0),(12,1229011070,NULL,1,0),(14,1229011507,NULL,1,0);
/*!40000 ALTER TABLE `node_comment_statistics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `url_alias`
--

DROP TABLE IF EXISTS `url_alias`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `url_alias` (
  `pid` int(10) unsigned NOT NULL auto_increment,
  `src` varchar(128) NOT NULL default '',
  `dst` varchar(128) NOT NULL default '',
  `language` varchar(12) NOT NULL default '',
  PRIMARY KEY  (`pid`),
  UNIQUE KEY `dst_language` (`dst`,`language`),
  KEY `src` (`src`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `url_alias`
--

LOCK TABLES `url_alias` WRITE;
/*!40000 ALTER TABLE `url_alias` DISABLE KEYS */;
INSERT INTO `url_alias` VALUES (1,'node/5','mst/pagina.php','pt-br'),(2,'node/6','mst/edicoes.php','pt-br'),(3,'node/7','mst/especiais.php','pt-br'),(4,'node/8','inicial','pt-br'),(5,'node/1599','assinaturas/jornal','pt-br'),(6,'node/1528','assinaturas/revista','pt-br'),(7,'node/1561','onde_comprar','pt-br'),(8,'node/10','multimidia','pt-br'),(9,'node/11','sobre','pt-br'),(10,'node/12','mural','pt-br'),(12,'node/14','nossaproducao','pt-br'),(13,'contact','fale_conosco','pt-br');
/*!40000 ALTER TABLE `url_alias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `files`
--

DROP TABLE IF EXISTS `files`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `files` (
  `fid` int(10) unsigned NOT NULL auto_increment,
  `uid` int(10) unsigned NOT NULL default '0',
  `filename` varchar(255) NOT NULL default '',
  `filepath` varchar(255) NOT NULL default '',
  `filemime` varchar(255) NOT NULL default '',
  `filesize` int(10) unsigned NOT NULL default '0',
  `status` int(11) NOT NULL default '0',
  `timestamp` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`fid`),
  KEY `uid` (`uid`),
  KEY `status` (`status`),
  KEY `timestamp` (`timestamp`)
) ENGINE=MyISAM AUTO_INCREMENT=931 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `files`
--

LOCK TABLES `files` WRITE;
/*!40000 ALTER TABLE `files` DISABLE KEYS */;
INSERT INTO `files` VALUES (930,1,'_original','sites/default/files/images/selo10dhnet.gif','image/gif',10873,1,1226499591);
/*!40000 ALTER TABLE `files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `image`
--

DROP TABLE IF EXISTS `image`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `image` (
  `nid` int(11) NOT NULL default '0',
  `fid` int(11) NOT NULL default '0',
  `image_size` varchar(32) NOT NULL default ''
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `image`
--

LOCK TABLES `image` WRITE;
/*!40000 ALTER TABLE `image` DISABLE KEYS */;
INSERT INTO `image` VALUES (9,930,'_original');
/*!40000 ALTER TABLE `image` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2008-12-11 16:06:07
