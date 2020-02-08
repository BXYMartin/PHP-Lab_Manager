-- MySQL dump 10.13  Distrib 5.7.27, for Linux (x86_64)
--
-- Host: localhost    Database: auditing
-- ------------------------------------------------------
-- Server version	5.7.27

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
-- Table structure for table `agile_board`
--

DROP TABLE IF EXISTS `agile_board`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `agile_board` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `project_id` int(11) unsigned NOT NULL,
  `type` enum('status','issue_type','label','module','resolve','priority','assignee') DEFAULT NULL,
  `is_filter_backlog` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `is_filter_closed` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `weight` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `project_id` (`project_id`),
  KEY `weight` (`weight`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `agile_board`
--

LOCK TABLES `agile_board` WRITE;
/*!40000 ALTER TABLE `agile_board` DISABLE KEYS */;
INSERT INTO `agile_board` VALUES (1,'Active Sprint',0,NULL,1,1,99999),(2,'LabelS',10003,'label',1,1,0);
/*!40000 ALTER TABLE `agile_board` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `agile_board_column`
--

DROP TABLE IF EXISTS `agile_board_column`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `agile_board_column` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `board_id` int(11) unsigned NOT NULL,
  `data` varchar(1000) NOT NULL,
  `weight` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `board_id` (`board_id`),
  KEY `id_and_weight` (`id`,`weight`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `agile_board_column`
--

LOCK TABLES `agile_board_column` WRITE;
/*!40000 ALTER TABLE `agile_board_column` DISABLE KEYS */;
INSERT INTO `agile_board_column` VALUES (1,'Preparing',1,'[\"open\",\"reopen\",\"todo\",\"delay\"]',3),(2,'In Progress',1,'[\"in_progress\",\"in_review\"]',2),(3,'Finished',1,'[\"resolved\",\"closed\",\"done\"]',1),(4,'Simple',2,'[\"1\",\"2\"]',0),(5,'Normal',2,'[\"3\"]',0);
/*!40000 ALTER TABLE `agile_board_column` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `agile_sprint`
--

DROP TABLE IF EXISTS `agile_sprint`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `agile_sprint` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` int(11) unsigned NOT NULL,
  `name` varchar(128) NOT NULL,
  `description` varchar(256) DEFAULT NULL,
  `active` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `order_weight` int(10) unsigned NOT NULL DEFAULT '0',
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `agile_sprint`
--

LOCK TABLES `agile_sprint` WRITE;
/*!40000 ALTER TABLE `agile_sprint` DISABLE KEYS */;
/*!40000 ALTER TABLE `agile_sprint` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `agile_sprint_issue_report`
--

DROP TABLE IF EXISTS `agile_sprint_issue_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `agile_sprint_issue_report` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sprint_id` int(11) unsigned NOT NULL,
  `date` date NOT NULL,
  `week` tinyint(2) unsigned DEFAULT NULL,
  `month` varchar(20) DEFAULT NULL,
  `done_count` int(11) unsigned DEFAULT '0' COMMENT 'Total Tasks Done Today',
  `no_done_count` int(11) unsigned DEFAULT '0' COMMENT 'Total Tasks Undone Today, Summarized By Status',
  `done_count_by_resolve` int(11) unsigned DEFAULT '0' COMMENT 'Total Tasks Done Today, Summarized By Evaluation Result',
  `no_done_count_by_resolve` int(11) unsigned DEFAULT '0' COMMENT 'Total Tasks Undone Today, Summarized By Evaluation Result',
  `today_done_points` int(11) unsigned DEFAULT '0' COMMENT 'Total Points for Tasks Done Today',
  `today_done_number` int(11) unsigned DEFAULT '0' COMMENT 'Total Number for Tasks Done Today',
  PRIMARY KEY (`id`),
  KEY `sprint_id` (`sprint_id`),
  KEY `sprintIdAndDate` (`sprint_id`,`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `agile_sprint_issue_report`
--

LOCK TABLES `agile_sprint_issue_report` WRITE;
/*!40000 ALTER TABLE `agile_sprint_issue_report` DISABLE KEYS */;
/*!40000 ALTER TABLE `agile_sprint_issue_report` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_custom_value`
--

DROP TABLE IF EXISTS `field_custom_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_custom_value` (
  `id` decimal(18,0) NOT NULL,
  `issue_id` decimal(18,0) DEFAULT NULL,
  `project_id` int(11) unsigned DEFAULT NULL,
  `custom_field_id` decimal(18,0) DEFAULT NULL,
  `parent_key` varchar(255) DEFAULT NULL,
  `string_value` varchar(255) DEFAULT NULL,
  `number_value` decimal(18,6) DEFAULT NULL,
  `text_value` longtext,
  `date_value` datetime DEFAULT NULL,
  `valuet_ype` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cfvalue_issue` (`issue_id`,`custom_field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_custom_value`
--

LOCK TABLES `field_custom_value` WRITE;
/*!40000 ALTER TABLE `field_custom_value` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_custom_value` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_layout_default`
--

DROP TABLE IF EXISTS `field_layout_default`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_layout_default` (
  `id` int(11) unsigned NOT NULL,
  `issue_type` int(11) unsigned DEFAULT NULL,
  `issue_ui_type` tinyint(1) unsigned DEFAULT '1',
  `field_id` int(11) unsigned DEFAULT '0',
  `verticalposition` decimal(18,0) DEFAULT NULL,
  `ishidden` varchar(60) DEFAULT NULL,
  `isrequired` varchar(60) DEFAULT NULL,
  `sequence` int(11) unsigned DEFAULT NULL,
  `tab` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_layout_default`
--

LOCK TABLES `field_layout_default` WRITE;
/*!40000 ALTER TABLE `field_layout_default` DISABLE KEYS */;
INSERT INTO `field_layout_default` VALUES (11192,NULL,NULL,11192,NULL,'false','true',NULL,NULL),(11193,NULL,NULL,11193,NULL,'false','true',NULL,NULL),(11194,NULL,NULL,11194,NULL,'false','false',NULL,NULL),(11195,NULL,NULL,11195,NULL,'false','true',NULL,NULL),(11196,NULL,NULL,11196,NULL,'false','false',NULL,NULL),(11197,NULL,NULL,11197,NULL,'false','true',NULL,NULL),(11198,NULL,NULL,11198,NULL,'false','true',NULL,NULL),(11199,NULL,NULL,11199,NULL,'false','false',NULL,NULL),(11200,NULL,NULL,11200,NULL,'false','false',NULL,NULL),(11201,NULL,NULL,11201,NULL,'false','true',NULL,NULL),(11202,NULL,NULL,11202,NULL,'false','false',NULL,NULL),(11203,NULL,NULL,11203,NULL,'false','false',NULL,NULL),(11204,NULL,NULL,11204,NULL,'false','false',NULL,NULL),(11205,NULL,NULL,11205,NULL,'false','false',NULL,NULL),(11206,NULL,NULL,11206,NULL,'false','false',NULL,NULL),(11207,NULL,NULL,11207,NULL,'false','false',NULL,NULL),(11208,NULL,NULL,11208,NULL,'false','false',NULL,NULL),(11209,NULL,NULL,11209,NULL,'false','false',NULL,NULL),(11210,NULL,NULL,11210,NULL,'false','false',NULL,NULL),(11211,NULL,NULL,11211,NULL,'false','false',NULL,NULL),(11212,NULL,NULL,11212,NULL,'false','false',NULL,NULL),(11213,NULL,NULL,11213,NULL,'false','false',NULL,NULL),(11214,NULL,NULL,11214,NULL,'false','false',NULL,NULL),(11215,NULL,NULL,11215,NULL,'false','true',NULL,NULL),(11216,NULL,NULL,11216,NULL,'false','false',NULL,NULL),(11217,NULL,NULL,11217,NULL,'false','false',NULL,NULL),(11218,NULL,NULL,11218,NULL,'false','false',NULL,NULL),(11219,NULL,NULL,11219,NULL,'false','false',NULL,NULL),(11220,NULL,NULL,11220,NULL,'false','false',NULL,NULL),(11221,NULL,NULL,11221,NULL,'false','false',NULL,NULL),(11222,NULL,NULL,11222,NULL,'false','false',NULL,NULL),(11223,NULL,NULL,11223,NULL,'false','false',NULL,NULL),(11224,NULL,NULL,11224,NULL,'false','false',NULL,NULL),(11225,NULL,NULL,11225,NULL,'false','false',NULL,NULL),(11226,NULL,NULL,11226,NULL,'false','false',NULL,NULL),(11227,NULL,NULL,11227,NULL,'false','false',NULL,NULL),(11228,NULL,NULL,11228,NULL,'false','false',NULL,NULL),(11229,NULL,NULL,11229,NULL,'false','false',NULL,NULL),(11230,NULL,NULL,11230,NULL,'false','false',NULL,NULL),(11231,NULL,NULL,11231,NULL,'false','false',NULL,NULL),(11232,NULL,NULL,11232,NULL,'false','false',NULL,NULL),(11233,NULL,NULL,11233,NULL,'false','false',NULL,NULL),(11234,NULL,NULL,11234,NULL,'false','false',NULL,NULL),(11235,NULL,NULL,11235,NULL,'false','false',NULL,NULL),(11236,NULL,NULL,11236,NULL,'false','false',NULL,NULL),(11237,NULL,NULL,11237,NULL,'false','false',NULL,NULL),(11238,NULL,NULL,11238,NULL,'false','false',NULL,NULL),(11239,NULL,NULL,11239,NULL,'false','false',NULL,NULL);
/*!40000 ALTER TABLE `field_layout_default` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_layout_project_custom`
--

DROP TABLE IF EXISTS `field_layout_project_custom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_layout_project_custom` (
  `id` int(11) unsigned NOT NULL,
  `project_id` int(11) unsigned DEFAULT NULL,
  `issue_type` int(11) unsigned DEFAULT NULL,
  `issue_ui_type` tinyint(2) unsigned DEFAULT NULL,
  `field_id` int(11) unsigned DEFAULT '0',
  `verticalposition` decimal(18,0) DEFAULT NULL,
  `ishidden` varchar(60) DEFAULT NULL,
  `isrequired` varchar(60) DEFAULT NULL,
  `sequence` int(11) unsigned DEFAULT NULL,
  `tab` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `project_id` (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_layout_project_custom`
--

LOCK TABLES `field_layout_project_custom` WRITE;
/*!40000 ALTER TABLE `field_layout_project_custom` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_layout_project_custom` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_main`
--

DROP TABLE IF EXISTS `field_main`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_main` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `title` varchar(64) NOT NULL DEFAULT '',
  `description` varchar(512) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `default_value` varchar(255) DEFAULT NULL,
  `is_system` tinyint(1) unsigned DEFAULT '0',
  `options` varchar(5000) DEFAULT '' COMMENT '{}',
  `order_weight` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_fli_fieldidentifier` (`name`),
  KEY `order_weight` (`order_weight`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_main`
--

LOCK TABLES `field_main` WRITE;
/*!40000 ALTER TABLE `field_main` DISABLE KEYS */;
INSERT INTO `field_main` VALUES (1,'summary','Title',NULL,'TEXT',NULL,1,NULL,0),(2,'priority','Priority',NULL,'PRIORITY',NULL,1,NULL,0),(3,'fix_version','Fix Version',NULL,'VERSION',NULL,1,NULL,0),(4,'assignee','Assignee',NULL,'USER',NULL,1,NULL,0),(5,'reporter','Reporter',NULL,'USER',NULL,1,NULL,0),(6,'description','Description',NULL,'MARKDOWN',NULL,1,NULL,0),(7,'module','Module',NULL,'MODULE',NULL,1,NULL,0),(8,'labels','Label',NULL,'LABELS',NULL,1,NULL,0),(9,'environment','Environment','Applicable Environment','TEXT',NULL,1,NULL,0),(10,'resolve','Evaluation','Evaluation Result Used For Audit','RESOLUTION',NULL,1,NULL,0),(11,'attachment','Attachment',NULL,'UPLOAD_FILE',NULL,1,NULL,0),(12,'start_date','Start Date',NULL,'DATE',NULL,1,'',0),(13,'due_date','Due Date',NULL,'DATE',NULL,1,NULL,0),(14,'milestone','Milestone',NULL,'MILESTONE',NULL,1,'',0),(15,'sprint','Sprint',NULL,'SPRINT',NULL,1,'',0),(17,'parent_issue','Parent Task',NULL,'ISSUES',NULL,1,'',0),(18,'effect_version','Effect Version',NULL,'VERSION',NULL,1,'',0),(19,'status','Status',NULL,'STATUS','1',1,'',950),(20,'assistants','Assistant','Assistant','USER_MULTI',NULL,1,'',900),(21,'weight','Weight','The Weight for the Task','TEXT','0',1,'',0),(23,'source','Source','','TEXT',NULL,1,'',0),(24,'standard','Standard','','STANDARD',NULL,1,'',0);
/*!40000 ALTER TABLE `field_main` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_type`
--

DROP TABLE IF EXISTS `field_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_type` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `type` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `type` (`type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_type`
--

LOCK TABLES `field_type` WRITE;
/*!40000 ALTER TABLE `field_type` DISABLE KEYS */;
INSERT INTO `field_type` VALUES (1,'TEXT',NULL,'TEXT'),(2,'TEXT_MULTI_LINE',NULL,'TEXT_MULTI_LINE'),(3,'TEXTAREA',NULL,'TEXTAREA'),(4,'RADIO',NULL,'RADIO'),(5,'CHECKBOX',NULL,'CHECKBOX'),(6,'SELECT',NULL,'SELECT'),(7,'SELECT_MULTI',NULL,'SELECT_MULTI'),(8,'DATE',NULL,'DATE'),(9,'LABEL',NULL,'LABELS'),(10,'UPLOAD_IMG',NULL,'UPLOAD_IMG'),(11,'UPLOAD_FILE',NULL,'UPLOAD_FILE'),(12,'VERSION',NULL,'VERSION'),(16,'USER',NULL,'USER'),(18,'GROUP',NULL,'GROUP'),(19,'GROUP_MULTI',NULL,'GROUP_MULTI'),(20,'MODULE',NULL,'MODULE'),(21,'Milestone',NULL,'MILESTONE'),(22,'Sprint',NULL,'SPRINT'),(25,'Reslution',NULL,'RESOLUTION'),(26,'Issues',NULL,'ISSUES'),(27,'Markdown',NULL,'MARKDOWN'),(28,'USER_MULTI',NULL,'USER_MULTI'),(29,'STANDARD',NULL,'STANDARD');
/*!40000 ALTER TABLE `field_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hornet_cache_key`
--

DROP TABLE IF EXISTS `hornet_cache_key`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hornet_cache_key` (
  `key` varchar(100) NOT NULL,
  `module` varchar(64) DEFAULT NULL,
  `datetime` datetime DEFAULT NULL,
  `expire` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`key`),
  UNIQUE KEY `module_key` (`key`,`module`) USING BTREE,
  KEY `module` (`module`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hornet_cache_key`
--

LOCK TABLES `hornet_cache_key` WRITE;
/*!40000 ALTER TABLE `hornet_cache_key` DISABLE KEYS */;
/*!40000 ALTER TABLE `hornet_cache_key` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hornet_user`
--

DROP TABLE IF EXISTS `hornet_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hornet_user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL DEFAULT '',
  `phone` varchar(20) NOT NULL,
  `password` varchar(32) NOT NULL DEFAULT '',
  `email` varchar(50) NOT NULL DEFAULT '',
  `status` tinyint(2) unsigned NOT NULL DEFAULT '1' COMMENT 'User Status: 1 Normal,2 Disabled',
  `reg_time` int(11) unsigned NOT NULL DEFAULT '0',
  `last_login_time` int(11) unsigned NOT NULL DEFAULT '0',
  `company_id` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `phone_unique` (`phone`) USING BTREE,
  KEY `phone` (`phone`,`password`),
  KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='User Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hornet_user`
--

LOCK TABLES `hornet_user` WRITE;
/*!40000 ALTER TABLE `hornet_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `hornet_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issue_assistant`
--

DROP TABLE IF EXISTS `issue_assistant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `issue_assistant` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `issue_id` int(11) unsigned DEFAULT NULL,
  `user_id` int(11) unsigned DEFAULT NULL,
  `join_time` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `issue_id` (`issue_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue_assistant`
--

LOCK TABLES `issue_assistant` WRITE;
/*!40000 ALTER TABLE `issue_assistant` DISABLE KEYS */;
/*!40000 ALTER TABLE `issue_assistant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issue_description_template`
--

DROP TABLE IF EXISTS `issue_description_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `issue_description_template` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `content` text NOT NULL,
  `created` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'Created Time',
  `updated` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'Updated Time',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='Task Description Template';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue_description_template`
--

LOCK TABLES `issue_description_template` WRITE;
/*!40000 ALTER TABLE `issue_description_template` DISABLE KEYS */;
INSERT INTO `issue_description_template` VALUES (5,'Audit Site Description Template','# Site Name\r\nThis is the audit site description template!',1572178085,1581137134);
/*!40000 ALTER TABLE `issue_description_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issue_effect_version`
--

DROP TABLE IF EXISTS `issue_effect_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `issue_effect_version` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `issue_id` int(11) unsigned DEFAULT NULL,
  `version_id` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue_effect_version`
--

LOCK TABLES `issue_effect_version` WRITE;
/*!40000 ALTER TABLE `issue_effect_version` DISABLE KEYS */;
/*!40000 ALTER TABLE `issue_effect_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issue_field_layout_project`
--

DROP TABLE IF EXISTS `issue_field_layout_project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `issue_field_layout_project` (
  `id` decimal(18,0) NOT NULL,
  `fieldlayout` decimal(18,0) DEFAULT NULL,
  `fieldidentifier` varchar(255) DEFAULT NULL,
  `description` text,
  `verticalposition` decimal(18,0) DEFAULT NULL,
  `ishidden` varchar(60) DEFAULT NULL,
  `isrequired` varchar(60) DEFAULT NULL,
  `renderertype` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_fli_fieldidentifier` (`fieldidentifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue_field_layout_project`
--

LOCK TABLES `issue_field_layout_project` WRITE;
/*!40000 ALTER TABLE `issue_field_layout_project` DISABLE KEYS */;
/*!40000 ALTER TABLE `issue_field_layout_project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issue_file_attachment`
--

DROP TABLE IF EXISTS `issue_file_attachment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `issue_file_attachment` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(64) NOT NULL DEFAULT '',
  `issue_id` int(11) DEFAULT '0',
  `tmp_issue_id` varchar(32) NOT NULL,
  `mime_type` varchar(64) DEFAULT '',
  `origin_name` varchar(128) NOT NULL DEFAULT '',
  `file_name` varchar(255) DEFAULT '',
  `created` int(11) DEFAULT '0',
  `file_size` int(11) DEFAULT '0',
  `author` int(11) DEFAULT '0',
  `file_ext` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `attach_issue` (`issue_id`),
  KEY `uuid` (`uuid`),
  KEY `tmp_issue_id` (`tmp_issue_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue_file_attachment`
--

LOCK TABLES `issue_file_attachment` WRITE;
/*!40000 ALTER TABLE `issue_file_attachment` DISABLE KEYS */;
/*!40000 ALTER TABLE `issue_file_attachment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issue_filter`
--

DROP TABLE IF EXISTS `issue_filter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `issue_filter` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `author` int(11) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `share_obj` varchar(255) DEFAULT NULL,
  `share_scope` varchar(20) DEFAULT NULL COMMENT 'all,group,uid,project,origin',
  `projectid` decimal(18,0) DEFAULT NULL,
  `filter` longtext,
  `fav_count` decimal(18,0) DEFAULT NULL,
  `name_lower` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sr_author` (`author`),
  KEY `searchrequest_filternameLower` (`name_lower`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue_filter`
--

LOCK TABLES `issue_filter` WRITE;
/*!40000 ALTER TABLE `issue_filter` DISABLE KEYS */;
/*!40000 ALTER TABLE `issue_filter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issue_fix_version`
--

DROP TABLE IF EXISTS `issue_fix_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `issue_fix_version` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `issue_id` int(11) unsigned DEFAULT NULL,
  `version_id` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue_fix_version`
--

LOCK TABLES `issue_fix_version` WRITE;
/*!40000 ALTER TABLE `issue_fix_version` DISABLE KEYS */;
/*!40000 ALTER TABLE `issue_fix_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issue_follow`
--

DROP TABLE IF EXISTS `issue_follow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `issue_follow` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `issue_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `issue_id` (`issue_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue_follow`
--

LOCK TABLES `issue_follow` WRITE;
/*!40000 ALTER TABLE `issue_follow` DISABLE KEYS */;
/*!40000 ALTER TABLE `issue_follow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issue_label`
--

DROP TABLE IF EXISTS `issue_label`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `issue_label` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` int(11) unsigned NOT NULL,
  `title` varchar(64) NOT NULL,
  `color` varchar(20) NOT NULL,
  `bg_color` varchar(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `project_id` (`project_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue_label`
--

LOCK TABLES `issue_label` WRITE;
/*!40000 ALTER TABLE `issue_label` DISABLE KEYS */;
INSERT INTO `issue_label` VALUES (1,0,'Error','#FFFFFF','#FF0000'),(2,0,'Success','#FFFFFF','#69D100'),(3,0,'Warning','#FFFFFF','#F0AD4E');
/*!40000 ALTER TABLE `issue_label` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issue_label_data`
--

DROP TABLE IF EXISTS `issue_label_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `issue_label_data` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `issue_id` int(11) unsigned DEFAULT NULL,
  `label_id` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue_label_data`
--

LOCK TABLES `issue_label_data` WRITE;
/*!40000 ALTER TABLE `issue_label_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `issue_label_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issue_main`
--

DROP TABLE IF EXISTS `issue_main`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `issue_main` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pkey` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `issue_num` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `project_id` int(11) DEFAULT '0',
  `issue_type` int(11) unsigned NOT NULL DEFAULT '0',
  `creator` int(11) unsigned DEFAULT '0',
  `modifier` int(11) unsigned NOT NULL DEFAULT '0',
  `reporter` int(11) DEFAULT '0',
  `assignee` int(11) DEFAULT '0',
  `summary` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `environment` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '',
  `priority` int(11) DEFAULT '0',
  `resolve` int(11) DEFAULT '0',
  `status` int(11) DEFAULT '0',
  `created` int(11) DEFAULT '0',
  `updated` int(11) DEFAULT '0',
  `start_date` date DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `resolve_date` date DEFAULT NULL,
  `module` int(11) DEFAULT '0',
  `milestone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sprint` int(11) NOT NULL DEFAULT '0',
  `weight` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '优先级权重值',
  `backlog_weight` int(11) NOT NULL DEFAULT '0' COMMENT 'backlog排序权重',
  `sprint_weight` int(11) NOT NULL DEFAULT '0' COMMENT 'sprint排序权重',
  `assistants` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `master_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '父任务的id,非0表示子任务',
  `have_children` tinyint(1) unsigned DEFAULT '0' COMMENT '是否拥有子任务',
  `followed_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '被关注人数',
  `comment_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '评论数',
  `standard_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `standard_id` (`standard_id`),
  KEY `issue_created` (`created`),
  KEY `issue_updated` (`updated`),
  KEY `issue_duedate` (`due_date`),
  KEY `issue_assignee` (`assignee`),
  KEY `issue_reporter` (`reporter`),
  KEY `pkey` (`pkey`),
  KEY `summary` (`summary`(191)),
  KEY `backlog_weight` (`backlog_weight`),
  KEY `sprint_weight` (`sprint_weight`),
  FULLTEXT KEY `fulltext_summary` (`summary`) /*!50100 WITH PARSER `ngram` */ ,
  FULLTEXT KEY `fulltext_summary_description` (`summary`,`description`) /*!50100 WITH PARSER `ngram` */ ,
  CONSTRAINT `issue_main_ibfk_1` FOREIGN KEY (`standard_id`) REFERENCES `standard_main` (`sid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue_main`
--

LOCK TABLES `issue_main` WRITE;
/*!40000 ALTER TABLE `issue_main` DISABLE KEYS */;
/*!40000 ALTER TABLE `issue_main` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issue_moved_issue_key`
--

DROP TABLE IF EXISTS `issue_moved_issue_key`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `issue_moved_issue_key` (
  `id` decimal(18,0) NOT NULL,
  `old_issue_key` varchar(255) DEFAULT NULL,
  `issue_id` decimal(18,0) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_old_issue_key` (`old_issue_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue_moved_issue_key`
--

LOCK TABLES `issue_moved_issue_key` WRITE;
/*!40000 ALTER TABLE `issue_moved_issue_key` DISABLE KEYS */;
/*!40000 ALTER TABLE `issue_moved_issue_key` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issue_priority`
--

DROP TABLE IF EXISTS `issue_priority`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `issue_priority` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `sequence` int(11) unsigned DEFAULT '0',
  `name` varchar(60) DEFAULT NULL,
  `_key` varchar(128) NOT NULL,
  `description` text,
  `iconurl` varchar(255) DEFAULT NULL,
  `status_color` varchar(60) DEFAULT NULL,
  `font_awesome` varchar(40) DEFAULT NULL,
  `is_system` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `_key` (`_key`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue_priority`
--

LOCK TABLES `issue_priority` WRITE;
/*!40000 ALTER TABLE `issue_priority` DISABLE KEYS */;
INSERT INTO `issue_priority` VALUES (1,1,'Urgent','very_import','Very Important Task','/images/icons/priorities/blocker.png','red',NULL,1),(2,2,'Important','import','Important Task','/images/icons/priorities/critical.png','#cc0000',NULL,1),(3,3,'High','high','Task With High Priority','/images/icons/priorities/major.png','#ff0000',NULL,1),(4,4,'Normal','normal','Normal Task','/images/icons/priorities/minor.png','#006600',NULL,1),(5,5,'Low','low','Task With Low Priority','/images/icons/priorities/trivial.png','#003300',NULL,1);
/*!40000 ALTER TABLE `issue_priority` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issue_recycle`
--

DROP TABLE IF EXISTS `issue_recycle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `issue_recycle` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `delete_user_id` int(11) unsigned NOT NULL,
  `issue_id` int(11) unsigned DEFAULT NULL,
  `pkey` varchar(32) DEFAULT NULL,
  `issue_num` decimal(18,0) DEFAULT NULL,
  `project_id` int(11) DEFAULT '0',
  `issue_type` int(11) unsigned NOT NULL DEFAULT '0',
  `creator` int(11) unsigned DEFAULT '0',
  `modifier` int(11) unsigned NOT NULL DEFAULT '0',
  `reporter` int(11) DEFAULT '0',
  `assignee` int(11) DEFAULT '0',
  `summary` varchar(255) DEFAULT '',
  `description` text,
  `environment` varchar(128) DEFAULT '',
  `priority` int(11) DEFAULT '0',
  `resolve` int(11) DEFAULT '0',
  `status` int(11) DEFAULT '0',
  `created` int(11) DEFAULT '0',
  `updated` int(11) DEFAULT '0',
  `start_date` date DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `resolve_date` datetime DEFAULT NULL,
  `workflow_id` int(11) DEFAULT '0',
  `module` int(11) DEFAULT '0',
  `milestone` varchar(20) DEFAULT NULL,
  `sprint` int(11) NOT NULL DEFAULT '0',
  `assistants` varchar(256) NOT NULL DEFAULT '',
  `master_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '父任务的id,非0表示子任务',
  `data` text,
  `time` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `issue_assignee` (`assignee`),
  KEY `summary` (`summary`),
  KEY `project_id` (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue_recycle`
--

LOCK TABLES `issue_recycle` WRITE;
/*!40000 ALTER TABLE `issue_recycle` DISABLE KEYS */;
/*!40000 ALTER TABLE `issue_recycle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issue_resolve`
--

DROP TABLE IF EXISTS `issue_resolve`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `issue_resolve` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `sequence` int(11) unsigned DEFAULT '0',
  `name` varchar(60) DEFAULT NULL,
  `_key` varchar(128) NOT NULL,
  `description` text,
  `font_awesome` varchar(32) DEFAULT NULL,
  `color` varchar(20) DEFAULT NULL,
  `is_system` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `_key` (`_key`)
) ENGINE=InnoDB AUTO_INCREMENT=10102 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue_resolve`
--

LOCK TABLES `issue_resolve` WRITE;
/*!40000 ALTER TABLE `issue_resolve` DISABLE KEYS */;
INSERT INTO `issue_resolve` VALUES (1,1,'Resolved','fixed','The requirements are deemed to be met',NULL,'#1aaa55',1),(2,2,'Excluded','excluded','This process is excluded / not applied. The justification was deemed acceptable',NULL,'#1aaa55',1),(3,3,'Passed','not_formal','The requirements are deemed to be met with the exception of the established nonconformity(ies)',NULL,'#ffd700',1),(4,4,'Not Applicable','not_applicable','Evaluation not applicable',NULL,'#db3b21',1),(5,5,'Not In Scope','not_exists','This task was not in the scope of the audit',NULL,'#db3b21',1),(6,6,'Unable To Resolve','not_fix','This task was planned to be audited. Due to the recorded obstacle(s), it was not audited',NULL,'#db3b21',1),(7,7,'Error','error','The requirements are not met, Major nonconformity has been established',NULL,'#db3b21',1);
/*!40000 ALTER TABLE `issue_resolve` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issue_standard_desc`
--

DROP TABLE IF EXISTS `issue_standard_desc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `issue_standard_desc` (
  `sid` int(11) NOT NULL AUTO_INCREMENT,
  `issue_id` int(11) unsigned NOT NULL,
  `auditor_desc` varchar(128) DEFAULT NULL,
  `publish_desc` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`sid`),
  KEY `issue_id` (`issue_id`),
  CONSTRAINT `issue_standard_desc_ibfk_1` FOREIGN KEY (`issue_id`) REFERENCES `issue_main` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue_standard_desc`
--

LOCK TABLES `issue_standard_desc` WRITE;
/*!40000 ALTER TABLE `issue_standard_desc` DISABLE KEYS */;
/*!40000 ALTER TABLE `issue_standard_desc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issue_standard_doc`
--

DROP TABLE IF EXISTS `issue_standard_doc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `issue_standard_doc` (
  `sid` int(11) NOT NULL AUTO_INCREMENT,
  `issue_id` int(11) unsigned NOT NULL,
  `status` varchar(128) NOT NULL,
  `name` varchar(128) NOT NULL,
  `rev` varchar(128) DEFAULT NULL,
  `description` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`sid`),
  KEY `issue_id` (`issue_id`),
  CONSTRAINT `issue_standard_doc_ibfk_1` FOREIGN KEY (`issue_id`) REFERENCES `issue_main` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue_standard_doc`
--

LOCK TABLES `issue_standard_doc` WRITE;
/*!40000 ALTER TABLE `issue_standard_doc` DISABLE KEYS */;
/*!40000 ALTER TABLE `issue_standard_doc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issue_standard_person`
--

DROP TABLE IF EXISTS `issue_standard_person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `issue_standard_person` (
  `sid` int(11) NOT NULL AUTO_INCREMENT,
  `issue_id` int(11) unsigned NOT NULL,
  `name` varchar(128) NOT NULL,
  `position` varchar(128) DEFAULT NULL,
  `description` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`sid`),
  KEY `issue_id` (`issue_id`),
  CONSTRAINT `issue_standard_person_ibfk_1` FOREIGN KEY (`issue_id`) REFERENCES `issue_main` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue_standard_person`
--

LOCK TABLES `issue_standard_person` WRITE;
/*!40000 ALTER TABLE `issue_standard_person` DISABLE KEYS */;
/*!40000 ALTER TABLE `issue_standard_person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issue_standard_record`
--

DROP TABLE IF EXISTS `issue_standard_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `issue_standard_record` (
  `sid` int(11) NOT NULL AUTO_INCREMENT,
  `issue_id` int(11) unsigned NOT NULL,
  `status` varchar(128) NOT NULL,
  `type` varchar(128) DEFAULT NULL,
  `description` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`sid`),
  KEY `issue_id` (`issue_id`),
  CONSTRAINT `issue_standard_record_ibfk_1` FOREIGN KEY (`issue_id`) REFERENCES `issue_main` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue_standard_record`
--

LOCK TABLES `issue_standard_record` WRITE;
/*!40000 ALTER TABLE `issue_standard_record` DISABLE KEYS */;
/*!40000 ALTER TABLE `issue_standard_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issue_status`
--

DROP TABLE IF EXISTS `issue_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `issue_status` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `sequence` int(11) unsigned DEFAULT '0',
  `name` varchar(60) DEFAULT NULL,
  `_key` varchar(20) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  `font_awesome` varchar(255) DEFAULT NULL,
  `is_system` tinyint(1) unsigned DEFAULT '0',
  `color` varchar(20) DEFAULT NULL COMMENT 'Default Primary Success Info Warning Danger可选',
  PRIMARY KEY (`id`),
  UNIQUE KEY `key` (`_key`)
) ENGINE=InnoDB AUTO_INCREMENT=10101 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue_status`
--

LOCK TABLES `issue_status` WRITE;
/*!40000 ALTER TABLE `issue_status` DISABLE KEYS */;
INSERT INTO `issue_status` VALUES (1,1,'Open','open','Task Waiting to be Processed','/images/icons/statuses/open.png',1,'info'),(3,3,'In Progress','in_progress','Task Solving In Progress','/images/icons/statuses/inprogress.png',1,'primary'),(4,4,'Reopen','reopen','Task Reopened and Waiting to be Solved','/images/icons/statuses/reopened.png',1,'warning'),(5,5,'Solved','resolved','Task Solved','/images/icons/statuses/resolved.png',1,'success'),(6,6,'Closed','closed','Task Closed','/images/icons/statuses/closed.png',1,'success'),(7,0,'Finished','done','Task Finished','',1,'success'),(8,9,'Reviewing','in_review','Task Being Reviewed','/images/icons/statuses/information.png',1,'info'),(9,10,'Delayed','delay','Task Being Delayed','/images/icons/statuses/generic.png',1,'info');
/*!40000 ALTER TABLE `issue_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issue_type`
--

DROP TABLE IF EXISTS `issue_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `issue_type` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `sequence` decimal(18,0) DEFAULT NULL,
  `name` varchar(60) DEFAULT NULL,
  `_key` varchar(64) NOT NULL,
  `catalog` enum('Custom','Kanban','Scrum','Standard') DEFAULT 'Standard' COMMENT '类型',
  `description` text,
  `font_awesome` varchar(20) DEFAULT NULL,
  `custom_icon_url` varchar(128) DEFAULT NULL,
  `is_system` tinyint(1) unsigned DEFAULT '0',
  `form_desc_tpl_id` int(11) unsigned DEFAULT '0' COMMENT '创建事项时,描述字段对应的模板id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `_key` (`_key`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue_type`
--

LOCK TABLES `issue_type` WRITE;
/*!40000 ALTER TABLE `issue_type` DISABLE KEYS */;
INSERT INTO `issue_type` VALUES (1,1,'Test Instance','bug','Standard','System Flaws Detected','fa-bug',NULL,1,1),(2,2,'New Feature','new_feature','Standard','New Feature Request For System','fa-plus',NULL,1,2),(3,3,'Task','task','Standard','Task Needs to be Done','fa-tasks',NULL,1,0),(4,4,'Improvement','improve','Standard','Functional Improvement to Current System','fa-arrow-circle-o-up',NULL,1,1),(5,0,'Audit Plan','audit','Standard','Audit Plan (May Contain Multiple Audit Sites)','fa-subscript',NULL,1,1),(6,2,'User Story','user_story','Scrum','Describe the Function that User Wants','fa-users',NULL,1,2),(7,3,'Tech Mission','tech_task','Scrum','Technical Challenges','fa-cogs',NULL,1,2),(8,5,'Audit Site','site','Scrum','Massive Auditing Task Per Site','fa-address-book-o',NULL,1,5);
/*!40000 ALTER TABLE `issue_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issue_type_scheme`
--

DROP TABLE IF EXISTS `issue_type_scheme`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `issue_type_scheme` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `is_default` tinyint(1) unsigned DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='问题方案表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue_type_scheme`
--

LOCK TABLES `issue_type_scheme` WRITE;
/*!40000 ALTER TABLE `issue_type_scheme` DISABLE KEYS */;
INSERT INTO `issue_type_scheme` VALUES (1,'Default Issue Type','System Used By Default',1),(2,'Agile Development','Scheme Used For Development',1),(3,'Dropdown Management','Normal Software Development',1),(4,'Visiting Management','Scheme Used For Visiting Protocal',0),(5,'Audit Management','Scheme Used For Auditing',0);
/*!40000 ALTER TABLE `issue_type_scheme` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issue_type_scheme_data`
--

DROP TABLE IF EXISTS `issue_type_scheme_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `issue_type_scheme_data` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `scheme_id` int(11) unsigned DEFAULT NULL,
  `type_id` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `scheme_id` (`scheme_id`) USING HASH
) ENGINE=InnoDB AUTO_INCREMENT=469 DEFAULT CHARSET=utf8 COMMENT='问题方案字表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue_type_scheme_data`
--

LOCK TABLES `issue_type_scheme_data` WRITE;
/*!40000 ALTER TABLE `issue_type_scheme_data` DISABLE KEYS */;
INSERT INTO `issue_type_scheme_data` VALUES (458,1,1),(459,1,2),(460,1,3),(461,1,4),(462,2,1),(463,2,2),(464,2,4),(465,2,6),(466,2,7),(467,5,5),(468,5,8);
/*!40000 ALTER TABLE `issue_type_scheme_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issue_ui`
--

DROP TABLE IF EXISTS `issue_ui`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `issue_ui` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `issue_type_id` int(10) unsigned DEFAULT NULL,
  `ui_type` varchar(10) DEFAULT '',
  `field_id` int(10) unsigned DEFAULT NULL,
  `order_weight` int(10) unsigned DEFAULT NULL,
  `tab_id` int(11) unsigned DEFAULT '0',
  `required` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否必填项',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1482 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue_ui`
--

LOCK TABLES `issue_ui` WRITE;
/*!40000 ALTER TABLE `issue_ui` DISABLE KEYS */;
INSERT INTO `issue_ui` VALUES (422,4,'create',1,14,0,1),(423,4,'create',6,13,0,0),(424,4,'create',2,12,0,0),(425,4,'create',3,11,0,0),(426,4,'create',7,10,0,0),(427,4,'create',9,9,0,0),(428,4,'create',8,8,0,0),(429,4,'create',4,7,0,0),(430,4,'create',19,6,0,0),(431,4,'create',10,5,0,0),(432,4,'create',11,4,0,0),(433,4,'create',12,3,0,0),(434,4,'create',13,2,0,0),(435,4,'create',15,1,0,0),(436,4,'create',20,0,0,0),(452,5,'create',1,14,0,1),(453,5,'create',6,13,0,0),(454,5,'create',2,12,0,0),(455,5,'create',7,11,0,0),(456,5,'create',9,10,0,0),(457,5,'create',8,9,0,0),(458,5,'create',3,8,0,0),(459,5,'create',4,7,0,0),(460,5,'create',19,6,0,0),(461,5,'create',10,5,0,0),(462,5,'create',11,4,0,0),(463,5,'create',12,3,0,0),(464,5,'create',13,2,0,0),(465,5,'create',15,1,0,0),(466,5,'create',20,0,0,0),(467,5,'edit',1,14,0,1),(468,5,'edit',6,13,0,0),(469,5,'edit',2,12,0,0),(470,5,'edit',7,11,0,0),(471,5,'edit',9,10,0,0),(472,5,'edit',8,9,0,0),(473,5,'edit',3,8,0,0),(474,5,'edit',4,7,0,0),(475,5,'edit',19,6,0,0),(476,5,'edit',10,5,0,0),(477,5,'edit',11,4,0,0),(478,5,'edit',12,3,0,0),(479,5,'edit',13,2,0,0),(480,5,'edit',15,1,0,0),(481,5,'edit',20,0,0,0),(587,6,'create',1,7,0,1),(588,6,'create',6,6,0,0),(589,6,'create',2,5,0,0),(590,6,'create',8,4,0,0),(591,6,'create',11,3,0,0),(592,6,'create',4,2,0,0),(593,6,'create',21,1,0,0),(594,6,'create',15,0,0,0),(595,6,'create',19,6,33,0),(596,6,'create',10,5,33,0),(597,6,'create',7,4,33,0),(598,6,'create',20,3,33,0),(599,6,'create',9,2,33,0),(600,6,'create',13,1,33,0),(601,6,'create',12,0,33,0),(602,6,'edit',1,7,0,1),(603,6,'edit',6,6,0,0),(604,6,'edit',2,5,0,0),(605,6,'edit',8,4,0,0),(606,6,'edit',4,3,0,0),(607,6,'edit',11,2,0,0),(608,6,'edit',15,1,0,0),(609,6,'edit',21,0,0,0),(610,6,'edit',19,6,34,0),(611,6,'edit',10,5,34,0),(612,6,'edit',7,4,34,0),(613,6,'edit',20,3,34,0),(614,6,'edit',9,2,34,0),(615,6,'edit',12,1,34,0),(616,6,'edit',13,0,34,0),(646,7,'create',1,7,0,1),(647,7,'create',6,6,0,0),(648,7,'create',2,5,0,0),(649,7,'create',8,4,0,0),(650,7,'create',4,3,0,0),(651,7,'create',11,2,0,0),(652,7,'create',15,1,0,0),(653,7,'create',21,0,0,0),(654,7,'create',19,6,37,0),(655,7,'create',10,5,37,0),(656,7,'create',7,4,37,0),(657,7,'create',20,3,37,0),(658,7,'create',9,2,37,0),(659,7,'create',13,1,37,0),(660,7,'create',12,0,37,0),(834,3,'create',1,13,0,1),(835,3,'create',6,12,0,0),(836,3,'create',2,11,0,0),(837,3,'create',7,10,0,0),(838,3,'create',9,9,0,0),(839,3,'create',8,8,0,0),(840,3,'create',3,7,0,0),(841,3,'create',4,6,0,0),(842,3,'create',19,5,0,0),(843,3,'create',10,4,0,0),(844,3,'create',11,3,0,0),(845,3,'create',12,2,0,0),(846,3,'create',13,1,0,0),(847,3,'create',20,0,0,0),(848,3,'edit',1,13,0,1),(849,3,'edit',6,12,0,0),(850,3,'edit',2,11,0,0),(851,3,'edit',7,10,0,0),(852,3,'edit',9,9,0,0),(853,3,'edit',8,8,0,0),(854,3,'edit',3,7,0,0),(855,3,'edit',4,6,0,0),(856,3,'edit',19,5,0,0),(857,3,'edit',10,4,0,0),(858,3,'edit',11,3,0,0),(859,3,'edit',12,2,0,0),(860,3,'edit',13,1,0,0),(861,3,'edit',20,0,0,0),(862,3,'edit',20,2,49,0),(863,3,'edit',9,1,49,0),(864,3,'edit',3,0,49,0),(958,2,'create',1,10,0,1),(959,2,'create',6,9,0,0),(960,2,'create',19,8,0,0),(961,2,'create',2,7,0,0),(962,2,'create',7,6,0,0),(963,2,'create',4,5,0,0),(964,2,'create',11,4,0,0),(965,2,'create',12,3,0,0),(966,2,'create',13,2,0,0),(967,2,'create',15,1,0,0),(968,2,'create',21,0,0,0),(969,2,'create',10,3,56,0),(970,2,'create',20,2,56,0),(971,2,'create',9,1,56,0),(972,2,'create',3,0,56,0),(1060,9,'create',1,4,0,1),(1061,9,'create',19,3,0,0),(1062,9,'create',3,2,0,0),(1063,9,'create',6,1,0,0),(1064,9,'create',4,0,0,0),(1080,7,'edit',1,7,0,0),(1081,7,'edit',6,6,0,0),(1082,7,'edit',2,5,0,0),(1083,7,'edit',8,4,0,0),(1084,7,'edit',4,3,0,0),(1085,7,'edit',11,2,0,0),(1086,7,'edit',15,1,0,0),(1087,7,'edit',21,0,0,0),(1088,7,'edit',19,6,63,0),(1089,7,'edit',10,5,63,0),(1090,7,'edit',7,4,63,0),(1091,7,'edit',9,3,63,0),(1092,7,'edit',20,2,63,0),(1093,7,'edit',12,1,63,0),(1094,7,'edit',13,0,63,0),(1095,4,'edit',1,11,0,0),(1096,4,'edit',6,10,0,0),(1097,4,'edit',2,9,0,0),(1098,4,'edit',7,8,0,0),(1099,4,'edit',4,7,0,0),(1100,4,'edit',19,6,0,0),(1101,4,'edit',11,5,0,0),(1102,4,'edit',12,4,0,0),(1103,4,'edit',13,3,0,0),(1104,4,'edit',15,2,0,0),(1105,4,'edit',20,1,0,0),(1106,4,'edit',21,0,0,0),(1107,4,'edit',8,3,64,0),(1108,4,'edit',9,2,64,0),(1109,4,'edit',3,1,64,0),(1110,4,'edit',10,0,64,0),(1215,2,'edit',1,11,0,1),(1216,2,'edit',19,10,0,0),(1217,2,'edit',10,9,0,0),(1218,2,'edit',6,8,0,0),(1219,2,'edit',2,7,0,0),(1220,2,'edit',7,6,0,0),(1221,2,'edit',4,5,0,0),(1222,2,'edit',11,4,0,0),(1223,2,'edit',12,3,0,0),(1224,2,'edit',13,2,0,0),(1225,2,'edit',15,1,0,1),(1226,2,'edit',21,0,0,0),(1227,2,'edit',20,2,71,0),(1228,2,'edit',9,1,71,0),(1229,2,'edit',3,0,71,0),(1355,1,'create',1,9,0,1),(1356,1,'create',6,8,0,0),(1357,1,'create',2,7,0,1),(1358,1,'create',7,6,0,0),(1359,1,'create',4,5,0,1),(1360,1,'create',11,4,0,0),(1361,1,'create',12,3,0,0),(1362,1,'create',13,2,0,0),(1363,1,'create',15,1,0,0),(1364,1,'create',23,0,0,0),(1365,1,'create',19,7,79,0),(1366,1,'create',20,6,79,0),(1367,1,'create',18,5,79,0),(1368,1,'create',3,4,79,0),(1369,1,'create',10,3,79,0),(1370,1,'create',21,2,79,0),(1371,1,'create',8,1,79,0),(1372,1,'create',9,0,79,0),(1373,1,'edit',1,9,0,1),(1374,1,'edit',6,8,0,0),(1375,1,'edit',2,7,0,1),(1376,1,'edit',7,6,0,0),(1377,1,'edit',4,5,0,1),(1378,1,'edit',19,4,0,0),(1379,1,'edit',11,3,0,0),(1380,1,'edit',12,2,0,0),(1381,1,'edit',13,1,0,0),(1382,1,'edit',15,0,0,0),(1383,1,'edit',3,6,80,0),(1384,1,'edit',18,5,80,0),(1385,1,'edit',20,4,80,0),(1386,1,'edit',10,3,80,0),(1387,1,'edit',21,2,80,0),(1388,1,'edit',8,1,80,0),(1389,1,'edit',9,0,80,0),(1390,9,'edit',11,1,0,1),(1391,9,'edit',24,0,0,1),(1415,12,'edit',25,0,0,1),(1431,14,'edit',28,0,0,1),(1432,13,'edit',27,0,0,1),(1433,11,'edit',24,0,0,1),(1434,11,'create',1,6,0,1),(1435,11,'create',2,5,0,1),(1436,11,'create',12,4,0,1),(1437,11,'create',4,3,0,1),(1438,11,'create',20,2,0,0),(1439,11,'create',6,1,0,1),(1440,11,'create',24,0,0,0),(1441,12,'create',1,6,0,1),(1442,12,'create',2,5,0,1),(1443,12,'create',12,4,0,1),(1444,12,'create',4,3,0,1),(1445,12,'create',20,2,0,0),(1446,12,'create',6,1,0,1),(1447,12,'create',25,0,0,0),(1448,13,'create',1,6,0,1),(1449,13,'create',4,5,0,1),(1450,13,'create',20,4,0,0),(1451,13,'create',6,3,0,1),(1452,13,'create',26,2,0,1),(1453,13,'create',12,1,0,1),(1454,13,'create',13,0,0,1),(1455,14,'create',1,6,0,1),(1456,14,'create',4,5,0,1),(1457,14,'create',20,4,0,0),(1458,14,'create',6,3,0,1),(1459,14,'create',2,2,0,1),(1460,14,'create',12,1,0,1),(1461,14,'create',13,0,0,1),(1464,8,'create',1,8,0,1),(1465,8,'create',6,7,0,1),(1466,8,'create',24,6,0,1),(1467,8,'create',2,5,0,1),(1468,8,'create',4,4,0,1),(1469,8,'create',10,3,0,0),(1470,8,'create',12,2,0,0),(1471,8,'create',13,1,0,0),(1472,8,'create',11,0,0,0),(1473,8,'edit',1,8,0,1),(1474,8,'edit',6,7,0,1),(1475,8,'edit',24,6,0,1),(1476,8,'edit',2,5,0,1),(1477,8,'edit',4,4,0,1),(1478,8,'edit',10,3,0,0),(1479,8,'edit',11,2,0,0),(1480,8,'edit',12,1,0,0),(1481,8,'edit',13,0,0,0);
/*!40000 ALTER TABLE `issue_ui` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issue_ui_tab`
--

DROP TABLE IF EXISTS `issue_ui_tab`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `issue_ui_tab` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `issue_type_id` int(11) unsigned DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `order_weight` int(11) DEFAULT NULL,
  `ui_type` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `issue_id` (`issue_type_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue_ui_tab`
--

LOCK TABLES `issue_ui_tab` WRITE;
/*!40000 ALTER TABLE `issue_ui_tab` DISABLE KEYS */;
INSERT INTO `issue_ui_tab` VALUES (33,6,'更多',0,'create'),(34,6,'\n            \n            更多\n             \n            \n        \n             \n            \n        ',0,'edit'),(37,7,'更 多',0,'create'),(49,3,'\n            \n            \n            其他\n             \n            \n        \n             \n            \n        \n             \n            \n        ',0,'edit'),(56,2,'更 多',0,'create'),(63,7,'\n            \n            \n            \n            更 多\n             \n            \n        \n             \n            \n        \n             \n            \n        \n             \n            \n        ',0,'edit'),(64,4,'\n            \n            \n            更多\n             \n            \n        \n             \n            \n        \n             \n            \n        ',0,'edit'),(71,2,'\n            \n            \n            \n            \n            \n            \n            \n            \n            更 多\n             \n            \n        \n             \n            \n        \n             \n            \n        \n             \n            ',0,'edit'),(79,1,'更 多',0,'create'),(80,1,'\n            \n            \n            \n            \n            \n            \n            \n            更 多\n             \n            \n        \n             \n            \n        \n             \n            \n        \n             \n            \n        \n   ',0,'edit');
/*!40000 ALTER TABLE `issue_ui_tab` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `log_base`
--

DROP TABLE IF EXISTS `log_base`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_base` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company_id` int(11) unsigned NOT NULL DEFAULT '0',
  `module` varchar(20) DEFAULT NULL COMMENT '所属模块',
  `obj_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '操作记录所关联的对象id,如现货id 订单id',
  `uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '操作者id,0为系统操作',
  `user_name` varchar(32) DEFAULT '' COMMENT '操作者用户名',
  `real_name` varchar(255) DEFAULT NULL,
  `page` varchar(100) DEFAULT '' COMMENT '页面',
  `pre_status` tinyint(3) unsigned DEFAULT NULL,
  `cur_status` tinyint(3) unsigned DEFAULT NULL,
  `action` varchar(20) DEFAULT NULL COMMENT '操作动作',
  `remark` varchar(100) DEFAULT '' COMMENT '动作',
  `pre_data` varchar(1000) DEFAULT '{}' COMMENT '操作记录前的数据,json格式',
  `cur_data` varchar(1000) DEFAULT '{}' COMMENT '操作记录前的数据,json格式',
  `ip` varchar(15) DEFAULT '' COMMENT '操作者ip地址 ',
  `time` int(11) unsigned DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`) USING HASH,
  KEY `obj_id` (`obj_id`) USING BTREE,
  KEY `like_query` (`uid`,`action`,`remark`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='组合模糊查询索引';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log_base`
--

LOCK TABLES `log_base` WRITE;
/*!40000 ALTER TABLE `log_base` DISABLE KEYS */;
/*!40000 ALTER TABLE `log_base` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `log_operating`
--

DROP TABLE IF EXISTS `log_operating`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_operating` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) unsigned NOT NULL DEFAULT '0',
  `module` varchar(20) DEFAULT NULL COMMENT '所属模块',
  `obj_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '操作记录所关联的对象id,如现货id 订单id',
  `uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '操作者id,0为系统操作',
  `user_name` varchar(32) DEFAULT '' COMMENT '操作者用户名',
  `real_name` varchar(255) DEFAULT NULL,
  `page` varchar(100) DEFAULT '' COMMENT '页面',
  `pre_status` tinyint(3) unsigned DEFAULT NULL,
  `cur_status` tinyint(3) unsigned DEFAULT NULL,
  `action` varchar(20) DEFAULT NULL COMMENT '操作动作',
  `remark` varchar(100) DEFAULT '' COMMENT '动作',
  `pre_data` varchar(1000) DEFAULT '{}' COMMENT '操作记录前的数据,json格式',
  `cur_data` varchar(1000) DEFAULT '{}' COMMENT '操作记录前的数据,json格式',
  `ip` varchar(15) DEFAULT '' COMMENT '操作者ip地址 ',
  `time` int(11) unsigned DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`) USING HASH,
  KEY `obj_id` (`obj_id`) USING BTREE,
  KEY `like_query` (`uid`,`action`,`remark`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='组合模糊查询索引';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log_operating`
--

LOCK TABLES `log_operating` WRITE;
/*!40000 ALTER TABLE `log_operating` DISABLE KEYS */;
/*!40000 ALTER TABLE `log_operating` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `log_runtime_error`
--

DROP TABLE IF EXISTS `log_runtime_error`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_runtime_error` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `md5` varchar(32) NOT NULL,
  `file` varchar(255) NOT NULL,
  `line` smallint(6) unsigned NOT NULL,
  `time` int(10) unsigned NOT NULL,
  `date` date NOT NULL,
  `err` varchar(32) NOT NULL DEFAULT '',
  `errstr` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `file_line_unique` (`md5`),
  KEY `date` (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log_runtime_error`
--

LOCK TABLES `log_runtime_error` WRITE;
/*!40000 ALTER TABLE `log_runtime_error` DISABLE KEYS */;
/*!40000 ALTER TABLE `log_runtime_error` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `main_action`
--

DROP TABLE IF EXISTS `main_action`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `main_action` (
  `id` decimal(18,0) NOT NULL,
  `issueid` decimal(18,0) DEFAULT NULL,
  `author` varchar(255) DEFAULT NULL,
  `actiontype` varchar(255) DEFAULT NULL,
  `actionlevel` varchar(255) DEFAULT NULL,
  `rolelevel` decimal(18,0) DEFAULT NULL,
  `actionbody` longtext,
  `created` datetime DEFAULT NULL,
  `updateauthor` varchar(255) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `actionnum` decimal(18,0) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `action_author_created` (`author`,`created`),
  KEY `action_issue` (`issueid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `main_action`
--

LOCK TABLES `main_action` WRITE;
/*!40000 ALTER TABLE `main_action` DISABLE KEYS */;
/*!40000 ALTER TABLE `main_action` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `main_activity`
--

DROP TABLE IF EXISTS `main_activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `main_activity` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned DEFAULT NULL,
  `project_id` int(11) unsigned DEFAULT NULL,
  `action` varchar(32) DEFAULT NULL COMMENT '动作说明,如 关闭了，创建了，修复了',
  `type` enum('agile','user','issue','issue_comment','org','project') DEFAULT 'issue' COMMENT 'project,issue,user,agile,issue_comment',
  `obj_id` int(11) unsigned DEFAULT NULL,
  `title` varchar(128) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `time` int(11) unsigned DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `project_id` (`project_id`),
  KEY `date` (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `main_activity`
--

LOCK TABLES `main_activity` WRITE;
/*!40000 ALTER TABLE `main_activity` DISABLE KEYS */;
/*!40000 ALTER TABLE `main_activity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `main_announcement`
--

DROP TABLE IF EXISTS `main_announcement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `main_announcement` (
  `id` int(10) unsigned NOT NULL,
  `content` varchar(255) DEFAULT NULL,
  `status` tinyint(1) unsigned DEFAULT '0' COMMENT '0为禁用,1为发布中',
  `flag` int(11) DEFAULT '0' COMMENT '每次发布将自增该字段',
  `expire_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `main_announcement`
--

LOCK TABLES `main_announcement` WRITE;
/*!40000 ALTER TABLE `main_announcement` DISABLE KEYS */;
/*!40000 ALTER TABLE `main_announcement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `main_cache_key`
--

DROP TABLE IF EXISTS `main_cache_key`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `main_cache_key` (
  `key` varchar(100) NOT NULL,
  `module` varchar(64) DEFAULT NULL,
  `datetime` datetime DEFAULT NULL,
  `expire` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`key`),
  UNIQUE KEY `module_key` (`key`,`module`) USING BTREE,
  KEY `module` (`module`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `main_cache_key`
--

LOCK TABLES `main_cache_key` WRITE;
/*!40000 ALTER TABLE `main_cache_key` DISABLE KEYS */;
INSERT INTO `main_cache_key` VALUES ('dict/description_template/getAll/0,*','dict/description_template','2020-02-15 12:45:35',1581741935),('dict/type/getAll/1,*','dict/type','2020-02-15 12:44:14',1581741854),('setting/getSettingByKey/date_timezone','setting','2020-02-15 12:45:49',1581741949),('setting/getSettingByKey/full_datetime_format','setting','2020-02-15 12:44:17',1581741857),('setting/getSettingByKey/title','setting','2020-02-15 12:44:09',1581741849);
/*!40000 ALTER TABLE `main_cache_key` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `main_eventtype`
--

DROP TABLE IF EXISTS `main_eventtype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `main_eventtype` (
  `id` decimal(18,0) NOT NULL,
  `template_id` decimal(18,0) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  `event_type` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `main_eventtype`
--

LOCK TABLES `main_eventtype` WRITE;
/*!40000 ALTER TABLE `main_eventtype` DISABLE KEYS */;
INSERT INTO `main_eventtype` VALUES (1,NULL,'Issue Created','This is the \'issue created\' event.','jira.system.event.type'),(2,NULL,'Issue Updated','This is the \'issue updated\' event.','jira.system.event.type'),(3,NULL,'Issue Assigned','This is the \'issue assigned\' event.','jira.system.event.type'),(4,NULL,'Issue Resolved','This is the \'issue resolved\' event.','jira.system.event.type'),(5,NULL,'Issue Closed','This is the \'issue closed\' event.','jira.system.event.type'),(6,NULL,'Issue Commented','This is the \'issue commented\' event.','jira.system.event.type'),(7,NULL,'Issue Reopened','This is the \'issue reopened\' event.','jira.system.event.type'),(8,NULL,'Issue Deleted','This is the \'issue deleted\' event.','jira.system.event.type'),(9,NULL,'Issue Moved','This is the \'issue moved\' event.','jira.system.event.type'),(10,NULL,'Work Logged On Issue','This is the \'work logged on issue\' event.','jira.system.event.type'),(11,NULL,'Work Started On Issue','This is the \'work started on issue\' event.','jira.system.event.type'),(12,NULL,'Work Stopped On Issue','This is the \'work stopped on issue\' event.','jira.system.event.type'),(13,NULL,'Generic Event','This is the \'generic event\' event.','jira.system.event.type'),(14,NULL,'Issue Comment Edited','This is the \'issue comment edited\' event.','jira.system.event.type'),(15,NULL,'Issue Worklog Updated','This is the \'issue worklog updated\' event.','jira.system.event.type'),(16,NULL,'Issue Worklog Deleted','This is the \'issue worklog deleted\' event.','jira.system.event.type'),(17,NULL,'Issue Comment Deleted','This is the \'issue comment deleted\' event.','jira.system.event.type');
/*!40000 ALTER TABLE `main_eventtype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `main_group`
--

DROP TABLE IF EXISTS `main_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `main_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `active` int(11) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `group_type` varchar(60) DEFAULT NULL,
  `directory_id` decimal(18,0) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `main_group`
--

LOCK TABLES `main_group` WRITE;
/*!40000 ALTER TABLE `main_group` DISABLE KEYS */;
INSERT INTO `main_group` VALUES (1,'administrators',1,NULL,NULL,NULL,'1',NULL),(2,'developers',1,NULL,NULL,NULL,'1',NULL),(3,'users',1,NULL,NULL,NULL,'1',NULL),(4,'qas',1,NULL,NULL,NULL,'1',NULL),(5,'ui-designers',1,NULL,NULL,NULL,'1',NULL);
/*!40000 ALTER TABLE `main_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `main_mail_queue`
--

DROP TABLE IF EXISTS `main_mail_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `main_mail_queue` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `seq` varchar(32) DEFAULT NULL,
  `title` varchar(100) DEFAULT NULL,
  `address` varchar(200) DEFAULT NULL,
  `status` varchar(10) DEFAULT NULL,
  `create_time` int(11) unsigned DEFAULT NULL,
  `error` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `seq` (`seq`) USING BTREE,
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `main_mail_queue`
--

LOCK TABLES `main_mail_queue` WRITE;
/*!40000 ALTER TABLE `main_mail_queue` DISABLE KEYS */;
/*!40000 ALTER TABLE `main_mail_queue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `main_notify_scheme`
--

DROP TABLE IF EXISTS `main_notify_scheme`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `main_notify_scheme` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_system` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `main_notify_scheme`
--

LOCK TABLES `main_notify_scheme` WRITE;
/*!40000 ALTER TABLE `main_notify_scheme` DISABLE KEYS */;
INSERT INTO `main_notify_scheme` VALUES (1,'默认通知方案',1);
/*!40000 ALTER TABLE `main_notify_scheme` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `main_notify_scheme_data`
--

DROP TABLE IF EXISTS `main_notify_scheme_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `main_notify_scheme_data` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `scheme_id` int(11) unsigned NOT NULL,
  `name` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `flag` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '[]' COMMENT '项目成员,经办人,报告人,关注人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `main_notify_scheme_data`
--

LOCK TABLES `main_notify_scheme_data` WRITE;
/*!40000 ALTER TABLE `main_notify_scheme_data` DISABLE KEYS */;
INSERT INTO `main_notify_scheme_data` VALUES (1,1,'Create Task','issue@create','[\"assigee\",\"reporter\",\"follow\"]'),(2,1,'Update Task','issue@update','[\"assigee\",\"reporter\",\"follow\"]'),(3,1,'Assign Task','issue@assign','[\"assigee\",\"reporter\",\"follow\"]'),(4,1,'Resolve Task','issue@resolve@complete','[\"assigee\",\"reporter\",\"follow\"]'),(5,1,'Close Task','issue@close','[\"assigee\",\"reporter\",\"follow\"]'),(6,1,'Comment on Task','issue@comment@create','[\"assigee\",\"reporter\",\"follow\"]'),(7,1,'Delete Comment on Ta','issue@comment@remove','[\"assigee\",\"reporter\",\"follow\"]'),(8,1,'Start to Solve Task','issue@resolve@start','[\"assigee\",\"reporter\",\"follow\"]'),(9,1,'Stop to Solve Task','issue@resolve@stop','[\"assigee\",\"reporter\",\"follow\"]'),(10,1,'Add Sprint','sprint@create','[\"project\"]'),(11,1,'Set Sprint Start','sprint@start','[\"project\"]'),(12,1,'Delete Sprint','sprint@remove','[\"project\"]');
/*!40000 ALTER TABLE `main_notify_scheme_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `main_org`
--

DROP TABLE IF EXISTS `main_org`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `main_org` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `path` varchar(64) NOT NULL DEFAULT '',
  `name` varchar(64) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `avatar` varchar(256) NOT NULL DEFAULT '',
  `create_uid` int(11) NOT NULL DEFAULT '0',
  `created` int(11) unsigned NOT NULL DEFAULT '0',
  `updated` int(11) unsigned NOT NULL DEFAULT '0',
  `scope` tinyint(2) NOT NULL DEFAULT '1' COMMENT '1 private, 2 internal , 3 public',
  PRIMARY KEY (`id`),
  KEY `path` (`path`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `main_org`
--

LOCK TABLES `main_org` WRITE;
/*!40000 ALTER TABLE `main_org` DISABLE KEYS */;
INSERT INTO `main_org` VALUES (1,'default','Default','Default organization','org/default.jpg',0,0,1535263464,3);
/*!40000 ALTER TABLE `main_org` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `main_setting`
--

DROP TABLE IF EXISTS `main_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `main_setting` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `_key` varchar(50) NOT NULL COMMENT '关键字',
  `title` varchar(20) NOT NULL COMMENT '标题',
  `module` varchar(20) NOT NULL DEFAULT '' COMMENT '所属模块,basic,advance,ui,datetime,languge,attachment可选',
  `order_weight` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '排序权重',
  `_value` varchar(100) NOT NULL,
  `default_value` varchar(100) DEFAULT '' COMMENT '默认值',
  `format` enum('string','int','float','json') NOT NULL DEFAULT 'string' COMMENT '数据类型',
  `form_input_type` enum('datetime','date','textarea','select','checkbox','radio','img','color','file','int','number','text') DEFAULT 'text' COMMENT '表单项类型',
  `form_optional_value` varchar(5000) DEFAULT NULL COMMENT '待选的值定义,为json格式',
  `description` varchar(200) DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `_key` (`_key`),
  KEY `module` (`module`) USING BTREE,
  KEY `module_2` (`module`,`order_weight`)
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8 COMMENT='系统配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `main_setting`
--

LOCK TABLES `main_setting` WRITE;
/*!40000 ALTER TABLE `main_setting` DISABLE KEYS */;
INSERT INTO `main_setting` VALUES (1,'title','网站的页面标题','basic',0,'Audit Manager','MasterLab','string','text',NULL,''),(2,'open_status','启用状态','basic',0,'1','1','int','radio','{\"1\":\"开启\",\"0\":\"关闭\"}',''),(3,'max_login_error','最大尝试验证登录次数','basic',0,'4','4','int','text',NULL,''),(4,'login_require_captcha','登录时需要验证码','basic',0,'0','0','int','radio','{\"1\":\"开启\",\"0\":\"关闭\"}',''),(5,'reg_require_captcha','注册时需要验证码','basic',0,'0','0','int','radio','{\"1\":\"开启\",\"0\":\"关闭\"}',''),(6,'sender_format','邮件发件人显示格式','basic',0,'${fullname} (Masterlab)','${fullname} (Hornet)','string','text',NULL,''),(7,'description','说明','basic',0,'','','string','text',NULL,''),(8,'date_timezone','默认用户时区','basic',0,'Asia/Shanghai','Asia/Shanghai','string','text','[\"Asia/Shanghai\":\"\"]',''),(11,'allow_share_public','允许用户分享过滤器或面部','basic',0,'1','1','int','radio','{\"1\":\"开启\",\"0\":\"关闭\"}',''),(12,'max_project_name','项目名称最大长度','basic',0,'80','80','int','text',NULL,''),(13,'max_project_key','项目键值最大长度','basic',0,'20','20','int','text',NULL,''),(15,'email_public','邮件地址可见性','basic',0,'1','1','int','radio','{\"1\":\"开启\",\"0\":\"关闭\"}',''),(20,'allow_gravatars','允许使用Gravatars用户头像','basic',0,'1','1','int','radio','{\"1\":\"开启\",\"0\":\"关闭\"}',''),(21,'gravatar_server','Gravatar服务器','basic',0,'','','string','text',NULL,''),(24,'send_mail_format','默认发送个邮件的格式','user_default',0,'html','text','string','radio','{\"text\":\"text\",\"html\":\"html\"}',''),(25,'issue_page_size','问题导航每页显示的问题数量','user_default',0,'100','100','int','text',NULL,''),(39,'time_format','时间格式','datetime',0,'H:i:s','HH:mm:ss','string','text',NULL,'例如 11:55:47'),(40,'week_format','星期格式','datetime',0,'l H:i:s','EEEE HH:mm:ss','string','text',NULL,'例如 Wednesday 11:55:47'),(41,'full_datetime_format','完整日期/时间格式','datetime',0,'Y-m-d H:i:s','yyyy-MM-dd  HH:mm:ss','string','text',NULL,'例如 2007-05-23  11:55:47'),(42,'datetime_format','日期格式(年月日)','datetime',0,'Y-m-d','yyyy-MM-dd','string','text',NULL,'例如 2007-05-23'),(43,'use_iso','在日期选择器中使用 ISO8601 标准','datetime',0,'1','1','int','radio','{\"1\":\"开启\",\"0\":\"关闭\"}','打开这个选项，在日期选择器中，以星期一作为每周的开始第一天'),(45,'attachment_dir','附件路径','attachment',0,'{{STORAGE_PATH}}attachment','{{STORAGE_PATH}}attachment','string','text',NULL,'附件存放的绝对或相对路径, 一旦被修改, 你需要手工拷贝原来目录下所有的附件到新的目录下'),(46,'attachment_size','附件大小(单位M)','attachment',0,'10.0','10.0','float','text',NULL,'超过大小，无法上传'),(47,'enbale_thum','启用缩略图','attachment',0,'1','1','int','radio','{\"1\":\"开启\",\"0\":\"关闭\"}','允许创建图像附件的缩略图'),(48,'enable_zip','启用ZIP支持','attachment',0,'1','1','int','radio','{\"1\":\"开启\",\"0\":\"关闭\"}','允许用户将一个问题的所有附件打包成一个ZIP文件下载'),(49,'password_strategy','密码策略','password_strategy',0,'1','2','int','radio','{\"1\":\"禁用\",\"2\":\"简单\",\"3\":\"安全\"}',''),(50,'send_mailer','发信人','mail',0,'send_mailer@xxx.com','','string','text',NULL,''),(51,'mail_prefix','前缀','mail',0,'Masterlab','','string','text',NULL,''),(52,'mail_host','主机','mail',0,'smtpdm.aliyun.com','','string','text',NULL,''),(53,'mail_port','SMTP端口','mail',0,'465','','string','text',NULL,''),(54,'mail_account','账号','mail',0,'send_mailer@xxx.com','','string','text',NULL,''),(55,'mail_password','密码','mail',0,'xxxx','','string','text',NULL,''),(56,'mail_timeout','发送超时','mail',0,'20','','int','text',NULL,''),(57,'page_layout','页面布局','user_default',0,'float','fixed','string','radio','{\"fixed\":\"固定\",\"float\":\"自适应\"}',''),(58,'project_view','项目首页','user_default',0,'sprints','issues','string','radio','{\"issues\":\"事项列表\",\"summary\":\"项目摘要\",\"backlog\":\"待办事项\",\"sprints\":\"迭代列表\",\"board\":\"迭代看板\"}',''),(59,'company','公司名称','basic',0,'Audit Manager','','string','text',NULL,''),(60,'company_logo','公司logo','basic',0,'logo','','string','text',NULL,''),(61,'company_linkman','联系人','basic',0,'Xinyu Bai','','string','text',NULL,''),(62,'company_phone','联系电话','basic',0,'15652579676','','string','text',NULL,''),(63,'enable_async_mail','是否使用异步方式发送邮件','mail',0,'1','1','int','radio','{\"1\":\"开启\",\"0\":\"关闭\"}',''),(64,'enable_mail','是否开启邮件推送','mail',0,'1','1','int','radio','{\"1\":\"开启\",\"0\":\"关闭\"}',''),(70,'socket_server_host','MasterlabSocket服务器地址','mail',0,'127.0.0.1','127.0.0.1','string','text',NULL,''),(71,'socket_server_port','MasterlabSocket服务器端口','mail',0,'9002','9002','int','text',NULL,'');
/*!40000 ALTER TABLE `main_setting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `main_timeline`
--

DROP TABLE IF EXISTS `main_timeline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `main_timeline` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) unsigned NOT NULL DEFAULT '0',
  `type` varchar(12) NOT NULL DEFAULT '',
  `origin_id` int(11) unsigned NOT NULL DEFAULT '0',
  `project_id` int(11) unsigned NOT NULL DEFAULT '0',
  `issue_id` int(11) unsigned NOT NULL DEFAULT '0',
  `action` varchar(32) NOT NULL DEFAULT '',
  `action_icon` varchar(64) NOT NULL DEFAULT '',
  `content` text NOT NULL,
  `content_html` text NOT NULL,
  `time` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `main_timeline`
--

LOCK TABLES `main_timeline` WRITE;
/*!40000 ALTER TABLE `main_timeline` DISABLE KEYS */;
/*!40000 ALTER TABLE `main_timeline` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `main_widget`
--

DROP TABLE IF EXISTS `main_widget`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `main_widget` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '工具名称',
  `_key` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `method` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `module` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pic` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` enum('list','chart_line','chart_pie','chart_bar','text') COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '工具类型',
  `status` tinyint(2) DEFAULT '1' COMMENT '状态（1可用，0不可用）',
  `is_default` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `required_param` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否需要参数才能获取数据',
  `description` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '描述',
  `parameter` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '{}' COMMENT '支持的参数说明',
  `order_weight` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `_key` (`_key`) USING BTREE,
  KEY `order_weight` (`order_weight`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `main_widget`
--

LOCK TABLES `main_widget` WRITE;
/*!40000 ALTER TABLE `main_widget` DISABLE KEYS */;
INSERT INTO `main_widget` VALUES (1,'My Projects','my_projects','fetchUserHaveJoinProjects','通用','my_projects.png','list',1,1,0,'','[]',0),(2,'My Tasks','assignee_my','fetchAssigneeIssues','通用','assignee_my.png','list',1,1,0,'','[]',0),(3,'Activity Log','activity','fetchActivity','通用','activity.png','list',1,1,0,'','[]',0),(4,'Quick Navigator','nav','fetchNav','通用','nav.png','list',1,1,0,'','[]',0),(5,'Organizations','org','fetchOrgs','通用','org.png','list',1,1,0,'','[]',0),(6,'Project Stats','project_stat','fetchProjectStat','项目','project_stat.png','list',1,0,1,'','[{\"name\":\"项目\",\"field\":\"project_id\",\"type\":\"my_projects_select\",\"value\":[]}]',0),(7,'Project Resolves','project_abs','fetchProjectAbs','项目','abs.png','chart_bar',1,0,1,'','\r\n[{\"name\":\"项目\",\"field\":\"project_id\",\"type\":\"my_projects_select\",\"value\":[]},{\"name\":\"时间\",\"field\":\"by_time\",\"type\":\"select\",\"value\":[{\"title\":\"天\",\"value\":\"date\"},{\"title\":\"周\",\"value\":\"week\"},{\"title\":\"月\",\"value\":\"month\"}]},{\"name\":\"几日之内\",\"field\":\"within_date\",\"type\":\"text\",\"value\":\"\"}]',0),(8,'Project Priorities','project_priority_stat','fetchProjectPriorityStat','项目','priority_stat.png','list',1,0,1,'','[{\"name\":\"项目\",\"field\":\"project_id\",\"type\":\"my_projects_select\",\"value\":[]},{\"name\":\"状态\",\"field\":\"status\",\"type\":\"select\",\"value\":[{\"title\":\"全部\",\"value\":\"all\"},{\"title\":\"未解决\",\"value\":\"unfix\"}]}]\r\n',0),(9,'Project Status Stats','project_status_stat','fetchProjectStatusStat','项目','status_stat.png','list',1,0,1,'','[{\"name\":\"项目\",\"field\":\"project_id\",\"type\":\"my_projects_select\",\"value\":[]}]',0),(10,'Project Developer Stats','project_developer_stat','fetchProjectDeveloperStat','项目','developer_stat.png','list',1,0,1,'','[{\"name\":\"项目\",\"field\":\"project_id\",\"type\":\"my_projects_select\",\"value\":[]},{\"name\":\"状态\",\"field\":\"status\",\"type\":\"select\",\"value\":[{\"title\":\"全部\",\"value\":\"all\"},{\"title\":\"未解决\",\"value\":\"unfix\"}]}]',0),(11,'Project Task Stats','project_issue_type_stat','fetchProjectIssueTypeStat','项目','issue_type_stat.png','list',1,0,1,'','[{\"name\":\"项目\",\"field\":\"project_id\",\"type\":\"my_projects_select\",\"value\":[]}]',0),(12,'Project Pie Stats','project_pie','fetchProjectPie','项目','chart_pie.png','chart_pie',1,0,1,'','[{\"name\":\"项目\",\"field\":\"project_id\",\"type\":\"my_projects_select\",\"value\":[]},{\"name\":\"数据源\",\"field\":\"data_field\",\"type\":\"select\",\"value\":[{\"title\":\"经办人\",\"value\":\"assignee\"},{\"title\":\"优先级\",\"value\":\"priority\"},{\"title\":\"事项类型\",\"value\":\"issue_type\"},{\"title\":\"状态\",\"value\":\"status\"}]},{\"name\":\"开始时间\",\"field\":\"start_date\",\"type\":\"date\",\"value\":\"\"},{\"name\":\"结束时间\",\"field\":\"end_date\",\"type\":\"date\",\"value\":\"\"}]',0),(13,'Sprint Stats','sprint_stat','fetchSprintStat','迭代','sprint_stat.png','list',1,0,1,'','[{\"name\":\"迭代\",\"field\":\"sprint_id\",\"type\":\"my_projects_sprint_select\",\"value\":[]}]',0),(14,'Sprint Countdown','sprint_countdown','fetchSprintCountdown','项目','countdown.png','text',1,0,1,'','[{\"name\":\"迭代\",\"field\":\"sprint_id\",\"type\":\"my_projects_sprint_select\",\"value\":[]}]',0),(15,'Sprint Burndown','sprint_burndown','fetchSprintBurndown','迭代','burndown.png','text',1,0,1,'','[{\"name\":\"迭代\",\"field\":\"sprint_id\",\"type\":\"my_projects_sprint_select\",\"value\":[]}]',0),(16,'Sprint Speed','sprint_speed','fetchSprintSpeedRate','迭代','sprint_speed.png','text',1,0,1,'','[{\"name\":\"迭代\",\"field\":\"sprint_id\",\"type\":\"my_projects_sprint_select\",\"value\":[]}]',0),(17,'Sprint Pie Stats','sprint_pie','fetchSprintPie','迭代','chart_pie.png','chart_pie',1,0,1,'','[{\"name\":\"迭代\",\"field\":\"sprint_id\",\"type\":\"my_projects_sprint_select\",\"value\":[]},{\"name\":\"数据源\",\"field\":\"data_field\",\"type\":\"select\",\"value\":[{\"title\":\"经办人\",\"value\":\"assignee\"},{\"title\":\"优先级\",\"value\":\"priority\"},{\"title\":\"事项类型\",\"value\":\"issue_type\"},{\"title\":\"状态\",\"value\":\"status\"}]}]',0),(18,'Sprint Recolve Stats','sprint_abs','fetchSprintAbs','迭代','abs.png','chart_bar',1,0,1,'','[{\"name\":\"迭代\",\"field\":\"sprint_id\",\"type\":\"my_projects_sprint_select\",\"value\":[]}]',0),(19,'Sprint Priority Stats','sprint_priority_stat','fetchSprintPriorityStat','迭代','priority_stat.png','list',1,0,1,'','[{\"name\":\"迭代\",\"field\":\"sprint_id\",\"type\":\"my_projects_sprint_select\",\"value\":[]},{\"name\":\"状态\",\"field\":\"status\",\"type\":\"select\",\"value\":[{\"title\":\"全部\",\"value\":\"all\"},{\"title\":\"未解决\",\"value\":\"unfix\"}]}]',0),(20,'Sprint Status Stats','sprint_status_stat','fetchSprintStatusStat','迭代','status_stat.png','list',1,0,1,'','[{\"name\":\"迭代\",\"field\":\"sprint_id\",\"type\":\"my_projects_sprint_select\",\"value\":[]}]',0),(21,'Sprint Developer Stats','sprint_developer_stat','fetchSprintDeveloperStat','迭代','developer_stat.png','list',1,0,1,'','[{\"name\":\"迭代\",\"field\":\"sprint_id\",\"type\":\"my_projects_sprint_select\",\"value\":[]},{\"name\":\"迭代\",\"field\":\"status\",\"type\":\"select\",\"value\":[{\"title\":\"全部\",\"value\":\"all\"},{\"title\":\"未解决\",\"value\":\"unfix\"}]}]',0),(22,'Sprint Task Stats','sprint_issue_type_stat','fetchSprintIssueTypeStat','迭代','issue_type_stat.png','list',1,0,1,'','[{\"name\":\"迭代\",\"field\":\"sprint_id\",\"type\":\"my_projects_sprint_select\",\"value\":[]}]',0),(23,'My Unresolved Tasks','unresolve_assignee_my','fetchUnResolveAssigneeIssues','通用','assignee_my.png','list',1,1,0,'','[]',0),(24,'Calender','calender','fetchCalender','通用','calender.png','text',1,1,0,'','[]',0);
/*!40000 ALTER TABLE `main_widget` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permission`
--

DROP TABLE IF EXISTS `permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permission` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) unsigned DEFAULT '0',
  `name` varchar(64) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `_key` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `permission_key_idx` (`_key`)
) ENGINE=InnoDB AUTO_INCREMENT=10907 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permission`
--

LOCK TABLES `permission` WRITE;
/*!40000 ALTER TABLE `permission` DISABLE KEYS */;
INSERT INTO `permission` VALUES (10004,0,'管理项目','可以对项目进行设置','ADMINISTER_PROJECTS'),(10005,0,'访问事项列表(已废弃)','','BROWSE_ISSUES'),(10006,0,'创建事项','','CREATE_ISSUES'),(10007,0,'评论','','ADD_COMMENTS'),(10008,0,'上传和删除附件','','CREATE_ATTACHMENTS'),(10013,0,'编辑事项','项目的事项都可以编辑','EDIT_ISSUES'),(10014,0,'删除事项','项目的所有事项可以删除','DELETE_ISSUES'),(10015,0,'关闭事项','项目的所有事项可以关闭','CLOSE_ISSUES'),(10028,0,'删除评论','项目的所有的评论均可以删除','DELETE_COMMENTS'),(10902,0,'管理backlog','','MANAGE_BACKLOG'),(10903,0,'管理sprint','','MANAGE_SPRINT'),(10904,0,'管理kanban',NULL,'MANAGE_KANBAN'),(10905,0,'导入事项','可以到导入excel数据到项目中','IMPORT_EXCEL'),(10906,0,'导出事项','可以将项目中的数据导出为excel格式','EXPORT_EXCEL');
/*!40000 ALTER TABLE `permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permission_default_role`
--

DROP TABLE IF EXISTS `permission_default_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permission_default_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `description` varchar(256) DEFAULT NULL,
  `project_id` int(11) unsigned DEFAULT '0' COMMENT '如果为0表示系统初始化的角色，不为0表示某一项目特有的角色',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10007 DEFAULT CHARSET=utf8 COMMENT='项目角色表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permission_default_role`
--

LOCK TABLES `permission_default_role` WRITE;
/*!40000 ALTER TABLE `permission_default_role` DISABLE KEYS */;
INSERT INTO `permission_default_role` VALUES (10000,'Users','普通用户',0),(10001,'Developers','开发者',0),(10002,'Administrators','项目管理员',0),(10003,'Researchers','研究人员',0),(10006,'Professors','教职人员',0);
/*!40000 ALTER TABLE `permission_default_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permission_default_role_relation`
--

DROP TABLE IF EXISTS `permission_default_role_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permission_default_role_relation` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `default_role_id` int(11) unsigned DEFAULT NULL,
  `perm_id` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `default_role_id` (`default_role_id`) USING HASH,
  KEY `role_id-and-perm_id` (`default_role_id`,`perm_id`) USING HASH
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permission_default_role_relation`
--

LOCK TABLES `permission_default_role_relation` WRITE;
/*!40000 ALTER TABLE `permission_default_role_relation` DISABLE KEYS */;
INSERT INTO `permission_default_role_relation` VALUES (42,10000,10005),(43,10000,10006),(44,10000,10007),(45,10000,10008),(46,10000,10013),(47,10001,10005),(48,10001,10006),(49,10001,10007),(50,10001,10008),(51,10001,10013),(52,10001,10014),(53,10001,10015),(54,10001,10028),(55,10002,10004),(56,10002,10005),(57,10002,10006),(58,10002,10007),(59,10002,10008),(60,10002,10013),(61,10002,10014),(62,10002,10015),(63,10002,10028),(64,10002,10902),(65,10002,10903),(66,10002,10904),(67,10006,10004),(68,10006,10005),(69,10006,10006),(70,10006,10007),(71,10006,10008),(72,10006,10013),(73,10006,10014),(74,10006,10015),(75,10006,10028),(76,10006,10902),(77,10006,10903),(78,10006,10904);
/*!40000 ALTER TABLE `permission_default_role_relation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permission_global`
--

DROP TABLE IF EXISTS `permission_global`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permission_global` (
  `id` int(11) unsigned NOT NULL,
  `_key` varchar(64) DEFAULT NULL,
  `name` varchar(64) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `_key` (`_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='全局权限定义表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permission_global`
--

LOCK TABLES `permission_global` WRITE;
/*!40000 ALTER TABLE `permission_global` DISABLE KEYS */;
INSERT INTO `permission_global` VALUES (10000,'系统管理员','系统管理员','负责执行所有管理功能。至少在这个权限中设置一个用户组。');
/*!40000 ALTER TABLE `permission_global` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permission_global_group`
--

DROP TABLE IF EXISTS `permission_global_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permission_global_group` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `perm_global_id` int(11) unsigned DEFAULT NULL,
  `group_id` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `perm_global_id` (`perm_global_id`),
  KEY `group_id` (`group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permission_global_group`
--

LOCK TABLES `permission_global_group` WRITE;
/*!40000 ALTER TABLE `permission_global_group` DISABLE KEYS */;
INSERT INTO `permission_global_group` VALUES (1,10000,1);
/*!40000 ALTER TABLE `permission_global_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permission_global_relation`
--

DROP TABLE IF EXISTS `permission_global_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permission_global_relation` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `perm_global_id` int(11) unsigned DEFAULT NULL,
  `group_id` int(11) unsigned DEFAULT NULL,
  `is_system` tinyint(1) unsigned DEFAULT '0' COMMENT '是否系统自带',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique` (`perm_global_id`,`group_id`) USING BTREE,
  KEY `perm_global_id` (`perm_global_id`) USING HASH
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='用户组拥有的全局权限';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permission_global_relation`
--

LOCK TABLES `permission_global_relation` WRITE;
/*!40000 ALTER TABLE `permission_global_relation` DISABLE KEYS */;
INSERT INTO `permission_global_relation` VALUES (2,10001,5,1),(8,10000,1,1),(9,10000,4,0),(10,10003,2,0);
/*!40000 ALTER TABLE `permission_global_relation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_category`
--

DROP TABLE IF EXISTS `project_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_category` (
  `id` int(18) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  `color` varchar(20) DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `idx_project_category_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_category`
--

LOCK TABLES `project_category` WRITE;
/*!40000 ALTER TABLE `project_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_flag`
--

DROP TABLE IF EXISTS `project_flag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_flag` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` int(11) unsigned NOT NULL,
  `flag` varchar(64) NOT NULL,
  `value` text NOT NULL,
  `update_time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_flag`
--

LOCK TABLES `project_flag` WRITE;
/*!40000 ALTER TABLE `project_flag` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_flag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_issue_report`
--

DROP TABLE IF EXISTS `project_issue_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_issue_report` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` int(11) unsigned NOT NULL,
  `date` date NOT NULL,
  `week` tinyint(2) unsigned DEFAULT NULL,
  `month` varchar(20) DEFAULT NULL,
  `done_count` int(11) unsigned DEFAULT '0' COMMENT '今天汇总完成的事项总数',
  `no_done_count` int(11) unsigned DEFAULT '0' COMMENT '今天汇总未完成的事项总数,安装状态进行统计',
  `done_count_by_resolve` int(11) unsigned DEFAULT '0' COMMENT '今天汇总完成的事项总数,按照解决结果进行统计',
  `no_done_count_by_resolve` int(11) unsigned DEFAULT '0' COMMENT '今天汇总未完成的事项总数,按照解决结果进行统计',
  `today_done_points` int(11) unsigned DEFAULT '0' COMMENT '敏捷开发中的事项工作量或点数',
  `today_done_number` int(11) unsigned DEFAULT '0' COMMENT '当天完成的事项数量',
  PRIMARY KEY (`id`),
  KEY `project_id` (`project_id`),
  KEY `projectIdAndDate` (`project_id`,`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_issue_report`
--

LOCK TABLES `project_issue_report` WRITE;
/*!40000 ALTER TABLE `project_issue_report` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_issue_report` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_issue_type_scheme_data`
--

DROP TABLE IF EXISTS `project_issue_type_scheme_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_issue_type_scheme_data` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `issue_type_scheme_id` int(11) unsigned DEFAULT NULL,
  `project_id` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `project_id` (`project_id`) USING BTREE,
  KEY `issue_type_scheme_id` (`issue_type_scheme_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_issue_type_scheme_data`
--

LOCK TABLES `project_issue_type_scheme_data` WRITE;
/*!40000 ALTER TABLE `project_issue_type_scheme_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_issue_type_scheme_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_key`
--

DROP TABLE IF EXISTS `project_key`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_key` (
  `id` decimal(18,0) NOT NULL,
  `project_id` decimal(18,0) DEFAULT NULL,
  `project_key` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_all_project_keys` (`project_key`),
  KEY `idx_all_project_ids` (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_key`
--

LOCK TABLES `project_key` WRITE;
/*!40000 ALTER TABLE `project_key` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_key` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_label`
--

DROP TABLE IF EXISTS `project_label`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_label` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` int(11) unsigned NOT NULL,
  `title` varchar(64) NOT NULL,
  `color` varchar(20) NOT NULL,
  `bg_color` varchar(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `project_id` (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_label`
--

LOCK TABLES `project_label` WRITE;
/*!40000 ALTER TABLE `project_label` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_label` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_list_count`
--

DROP TABLE IF EXISTS `project_list_count`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_list_count` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `project_type_id` smallint(5) unsigned DEFAULT NULL,
  `project_total` int(10) unsigned DEFAULT NULL,
  `remark` varchar(50) DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_list_count`
--

LOCK TABLES `project_list_count` WRITE;
/*!40000 ALTER TABLE `project_list_count` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_list_count` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_main`
--

DROP TABLE IF EXISTS `project_main`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_main` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `org_id` int(11) NOT NULL DEFAULT '1',
  `org_path` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lead` int(11) unsigned DEFAULT '0',
  `description` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `key` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pcounter` decimal(18,0) DEFAULT NULL,
  `default_assignee` int(11) unsigned DEFAULT '0',
  `assignee_type` int(11) DEFAULT NULL,
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `category` int(11) unsigned DEFAULT NULL,
  `type` tinyint(2) DEFAULT '1',
  `type_child` tinyint(2) DEFAULT '0',
  `permission_scheme_id` int(11) unsigned DEFAULT '0',
  `workflow_scheme_id` int(11) unsigned NOT NULL,
  `create_uid` int(11) unsigned DEFAULT '0',
  `create_time` int(11) unsigned DEFAULT '0',
  `un_done_count` int(6) unsigned NOT NULL DEFAULT '0' COMMENT '未完成事项数',
  `done_count` int(6) unsigned NOT NULL DEFAULT '0' COMMENT '已经完成事项数',
  `closed_count` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_project_key` (`key`),
  UNIQUE KEY `name` (`name`) USING BTREE,
  KEY `uid` (`create_uid`),
  FULLTEXT KEY `fulltext_name_description` (`name`,`description`) /*!50100 WITH PARSER `ngram` */ ,
  FULLTEXT KEY `fulltext_name` (`name`) /*!50100 WITH PARSER `ngram` */ 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_main`
--

LOCK TABLES `project_main` WRITE;
/*!40000 ALTER TABLE `project_main` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_main` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_main_extra`
--

DROP TABLE IF EXISTS `project_main_extra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_main_extra` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` int(10) unsigned DEFAULT '0',
  `detail` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `project_id` (`project_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_main_extra`
--

LOCK TABLES `project_main_extra` WRITE;
/*!40000 ALTER TABLE `project_main_extra` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_main_extra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_module`
--

DROP TABLE IF EXISTS `project_module`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_module` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` int(11) unsigned DEFAULT NULL,
  `name` varchar(64) DEFAULT '',
  `description` varchar(256) DEFAULT NULL,
  `lead` int(11) unsigned DEFAULT NULL,
  `default_assignee` int(11) unsigned DEFAULT NULL,
  `ctime` int(10) unsigned DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `project_id` (`project_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_module`
--

LOCK TABLES `project_module` WRITE;
/*!40000 ALTER TABLE `project_module` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_module` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_role`
--

DROP TABLE IF EXISTS `project_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_role` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` int(11) unsigned DEFAULT NULL,
  `name` varchar(40) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `is_system` tinyint(1) unsigned DEFAULT '0' COMMENT '是否是默认角色',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_role`
--

LOCK TABLES `project_role` WRITE;
/*!40000 ALTER TABLE `project_role` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_role_relation`
--

DROP TABLE IF EXISTS `project_role_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_role_relation` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` int(11) unsigned DEFAULT NULL,
  `role_id` int(11) unsigned DEFAULT NULL,
  `perm_id` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `role_id` (`role_id`) USING HASH,
  KEY `role_id-and-perm_id` (`role_id`,`perm_id`) USING HASH,
  KEY `unique_data` (`project_id`,`role_id`,`perm_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_role_relation`
--

LOCK TABLES `project_role_relation` WRITE;
/*!40000 ALTER TABLE `project_role_relation` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_role_relation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_user_role`
--

DROP TABLE IF EXISTS `project_user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_user_role` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned DEFAULT '0',
  `project_id` int(11) unsigned DEFAULT '0',
  `role_id` int(11) unsigned DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique` (`user_id`,`project_id`,`role_id`) USING BTREE,
  KEY `uid` (`user_id`) USING BTREE,
  KEY `uid_project` (`user_id`,`project_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_user_role`
--

LOCK TABLES `project_user_role` WRITE;
/*!40000 ALTER TABLE `project_user_role` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_user_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_version`
--

DROP TABLE IF EXISTS `project_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_version` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) unsigned DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  `sequence` decimal(18,0) DEFAULT NULL,
  `released` tinyint(10) unsigned DEFAULT '0' COMMENT '0未发布 1已发布',
  `archived` varchar(10) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `start_date` int(10) unsigned DEFAULT NULL,
  `release_date` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `project_name_unique` (`project_id`,`name`) USING BTREE,
  KEY `idx_version_project` (`project_id`),
  KEY `idx_version_sequence` (`sequence`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_version`
--

LOCK TABLES `project_version` WRITE;
/*!40000 ALTER TABLE `project_version` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_workflow_status`
--

DROP TABLE IF EXISTS `project_workflow_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_workflow_status` (
  `id` decimal(18,0) NOT NULL,
  `status` varchar(255) DEFAULT NULL,
  `parentname` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_parent_name` (`parentname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_workflow_status`
--

LOCK TABLES `project_workflow_status` WRITE;
/*!40000 ALTER TABLE `project_workflow_status` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_workflow_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_workflows`
--

DROP TABLE IF EXISTS `project_workflows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_workflows` (
  `id` decimal(18,0) NOT NULL,
  `workflowname` varchar(255) DEFAULT NULL,
  `creatorname` varchar(255) DEFAULT NULL,
  `descriptor` longtext,
  `islocked` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_workflows`
--

LOCK TABLES `project_workflows` WRITE;
/*!40000 ALTER TABLE `project_workflows` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_workflows` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `report_project_issue`
--

DROP TABLE IF EXISTS `report_project_issue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report_project_issue` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` int(11) unsigned NOT NULL,
  `date` date NOT NULL,
  `week` tinyint(2) unsigned DEFAULT NULL,
  `month` varchar(20) DEFAULT NULL,
  `count_done` int(11) unsigned DEFAULT '0' COMMENT '今天汇总完成的事项总数',
  `count_no_done` int(11) unsigned DEFAULT '0' COMMENT '今天汇总未完成的事项总数,安装状态进行统计',
  `count_done_by_resolve` int(11) unsigned DEFAULT '0' COMMENT '今天汇总完成的事项总数,按照解决结果进行统计',
  `count_no_done_by_resolve` int(11) unsigned DEFAULT '0' COMMENT '今天汇总未完成的事项总数,按照解决结果进行统计',
  `today_done_points` int(11) unsigned DEFAULT '0' COMMENT '敏捷开发中的事项工作量或点数',
  `today_done_number` int(11) unsigned DEFAULT '0' COMMENT '当天完成的事项数量',
  PRIMARY KEY (`id`),
  UNIQUE KEY `projectIdAndDate` (`project_id`,`date`) USING BTREE,
  KEY `project_id` (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `report_project_issue`
--

LOCK TABLES `report_project_issue` WRITE;
/*!40000 ALTER TABLE `report_project_issue` DISABLE KEYS */;
/*!40000 ALTER TABLE `report_project_issue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `report_sprint_issue`
--

DROP TABLE IF EXISTS `report_sprint_issue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report_sprint_issue` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sprint_id` int(11) unsigned NOT NULL,
  `date` date NOT NULL,
  `week` tinyint(2) unsigned DEFAULT NULL,
  `month` varchar(20) DEFAULT NULL,
  `count_done` int(11) unsigned DEFAULT '0' COMMENT '今天汇总完成的事项总数',
  `count_no_done` int(11) unsigned DEFAULT '0' COMMENT '今天汇总未完成的事项总数,安装状态进行统计',
  `count_done_by_resolve` int(11) unsigned DEFAULT '0' COMMENT '今天汇总完成的事项总数,按照解决结果进行统计',
  `count_no_done_by_resolve` int(11) unsigned DEFAULT '0' COMMENT '今天汇总未完成的事项总数,按照解决结果进行统计',
  `today_done_points` int(11) unsigned DEFAULT '0' COMMENT '敏捷开发中的事项工作量或点数',
  `today_done_number` int(11) unsigned DEFAULT '0' COMMENT '当天完成的事项数量',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sprintIdAndDate` (`sprint_id`,`date`) USING BTREE,
  KEY `sprint_id` (`sprint_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `report_sprint_issue`
--

LOCK TABLES `report_sprint_issue` WRITE;
/*!40000 ALTER TABLE `report_sprint_issue` DISABLE KEYS */;
/*!40000 ALTER TABLE `report_sprint_issue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_config`
--

DROP TABLE IF EXISTS `service_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `service_config` (
  `id` decimal(18,0) NOT NULL,
  `delaytime` decimal(18,0) DEFAULT NULL,
  `clazz` varchar(255) DEFAULT NULL,
  `servicename` varchar(255) DEFAULT NULL,
  `cron_expression` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_config`
--

LOCK TABLES `service_config` WRITE;
/*!40000 ALTER TABLE `service_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `service_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `standard_link_main`
--

DROP TABLE IF EXISTS `standard_link_main`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `standard_link_main` (
  `sid` int(11) NOT NULL AUTO_INCREMENT,
  `father_sid` int(11) NOT NULL,
  `child_sid` int(11) NOT NULL,
  `description` varchar(128) NOT NULL,
  PRIMARY KEY (`sid`),
  KEY `father_sid` (`father_sid`),
  KEY `child_sid` (`child_sid`),
  CONSTRAINT `standard_link_main_ibfk_1` FOREIGN KEY (`father_sid`) REFERENCES `standard_main` (`sid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `standard_link_main_ibfk_2` FOREIGN KEY (`child_sid`) REFERENCES `standard_main` (`sid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `standard_link_main`
--

LOCK TABLES `standard_link_main` WRITE;
/*!40000 ALTER TABLE `standard_link_main` DISABLE KEYS */;
/*!40000 ALTER TABLE `standard_link_main` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `standard_main`
--

DROP TABLE IF EXISTS `standard_main`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `standard_main` (
  `sid` int(11) NOT NULL AUTO_INCREMENT,
  `standard_name` varchar(128) NOT NULL,
  `description` varchar(128) NOT NULL,
  `number` varchar(20) DEFAULT NULL,
  `left` int(11) NOT NULL,
  `right` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `tree_id` int(11) NOT NULL,
  PRIMARY KEY (`sid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `standard_main`
--

LOCK TABLES `standard_main` WRITE;
/*!40000 ALTER TABLE `standard_main` DISABLE KEYS */;
/*!40000 ALTER TABLE `standard_main` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_application`
--

DROP TABLE IF EXISTS `user_application`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_application` (
  `id` decimal(18,0) NOT NULL,
  `application_name` varchar(255) DEFAULT NULL,
  `lower_application_name` varchar(255) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `active` decimal(9,0) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `application_type` varchar(255) DEFAULT NULL,
  `credential` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_application_name` (`lower_application_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_application`
--

LOCK TABLES `user_application` WRITE;
/*!40000 ALTER TABLE `user_application` DISABLE KEYS */;
INSERT INTO `user_application` VALUES (1,'crowd-embedded','crowd-embedded','2013-02-28 11:57:51','2013-02-28 11:57:51',1,'','CROWD','X');
/*!40000 ALTER TABLE `user_application` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_attributes`
--

DROP TABLE IF EXISTS `user_attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_attributes` (
  `id` decimal(18,0) NOT NULL,
  `user_id` decimal(18,0) DEFAULT NULL,
  `directory_id` decimal(18,0) DEFAULT NULL,
  `attribute_name` varchar(255) DEFAULT NULL,
  `attribute_value` varchar(255) DEFAULT NULL,
  `lower_attribute_value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `uk_user_attr_name_lval` (`user_id`,`attribute_name`),
  KEY `idx_user_attr_dir_name_lval` (`directory_id`,`attribute_name`(240),`lower_attribute_value`(240)) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_attributes`
--

LOCK TABLES `user_attributes` WRITE;
/*!40000 ALTER TABLE `user_attributes` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_attributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_email_active`
--

DROP TABLE IF EXISTS `user_email_active`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_email_active` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(32) DEFAULT '',
  `email` varchar(64) NOT NULL DEFAULT '',
  `uid` int(11) unsigned NOT NULL,
  `verify_code` varchar(32) NOT NULL,
  `time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `email` (`email`,`verify_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_email_active`
--

LOCK TABLES `user_email_active` WRITE;
/*!40000 ALTER TABLE `user_email_active` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_email_active` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_email_find_password`
--

DROP TABLE IF EXISTS `user_email_find_password`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_email_find_password` (
  `email` varchar(50) NOT NULL,
  `uid` int(11) unsigned NOT NULL,
  `verify_code` varchar(32) NOT NULL,
  `time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`email`),
  UNIQUE KEY `email` (`email`,`verify_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_email_find_password`
--

LOCK TABLES `user_email_find_password` WRITE;
/*!40000 ALTER TABLE `user_email_find_password` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_email_find_password` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_email_token`
--

DROP TABLE IF EXISTS `user_email_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_email_token` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `uid` int(10) unsigned NOT NULL,
  `token` varchar(255) NOT NULL,
  `expired` int(10) unsigned NOT NULL COMMENT '有效期',
  `created_at` int(10) unsigned NOT NULL,
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '1-有效，0-无效',
  `used_model` varchar(255) NOT NULL DEFAULT '' COMMENT '用于哪个模型或功能',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_email_token`
--

LOCK TABLES `user_email_token` WRITE;
/*!40000 ALTER TABLE `user_email_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_email_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_group`
--

DROP TABLE IF EXISTS `user_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_group` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) unsigned DEFAULT NULL,
  `group_id` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique` (`uid`,`group_id`) USING BTREE,
  KEY `uid` (`uid`) USING HASH,
  KEY `group_id` (`group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_group`
--

LOCK TABLES `user_group` WRITE;
/*!40000 ALTER TABLE `user_group` DISABLE KEYS */;
INSERT INTO `user_group` VALUES (1,0,1),(2,1,1);
/*!40000 ALTER TABLE `user_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_ip_login_times`
--

DROP TABLE IF EXISTS `user_ip_login_times`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_ip_login_times` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip` varchar(20) NOT NULL DEFAULT '',
  `times` int(11) NOT NULL DEFAULT '0',
  `up_time` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ip` (`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_ip_login_times`
--

LOCK TABLES `user_ip_login_times` WRITE;
/*!40000 ALTER TABLE `user_ip_login_times` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_ip_login_times` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_issue_display_fields`
--

DROP TABLE IF EXISTS `user_issue_display_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_issue_display_fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `project_id` int(11) unsigned NOT NULL,
  `fields` varchar(512) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_fields` (`user_id`,`project_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_issue_display_fields`
--

LOCK TABLES `user_issue_display_fields` WRITE;
/*!40000 ALTER TABLE `user_issue_display_fields` DISABLE KEYS */;
INSERT INTO `user_issue_display_fields` VALUES (13,1,3,'issue_num,issue_type,priority,module,sprint,summary,assignee,status,plan_date');
/*!40000 ALTER TABLE `user_issue_display_fields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_login_log`
--

DROP TABLE IF EXISTS `user_login_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_login_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `session_id` varchar(64) NOT NULL DEFAULT '',
  `token` varchar(128) DEFAULT '',
  `uid` int(11) unsigned NOT NULL DEFAULT '0',
  `time` int(11) unsigned NOT NULL DEFAULT '0',
  `ip` varchar(24) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='登录日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_login_log`
--

LOCK TABLES `user_login_log` WRITE;
/*!40000 ALTER TABLE `user_login_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_login_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_main`
--

DROP TABLE IF EXISTS `user_main`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_main` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `directory_id` int(11) DEFAULT NULL,
  `phone` varchar(16) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `openid` varchar(32) NOT NULL,
  `status` tinyint(2) DEFAULT '1' COMMENT '0 审核中;1 正常; 2 禁用',
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `display_name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `sex` tinyint(1) unsigned DEFAULT '0' COMMENT '1男2女',
  `birthday` varchar(20) DEFAULT NULL,
  `create_time` int(11) unsigned DEFAULT '0',
  `update_time` int(11) DEFAULT '0',
  `avatar` varchar(100) DEFAULT '',
  `source` varchar(20) DEFAULT '',
  `ios_token` varchar(128) DEFAULT NULL,
  `android_token` varchar(128) DEFAULT NULL,
  `version` varchar(20) DEFAULT NULL,
  `token` varchar(64) DEFAULT '',
  `last_login_time` int(11) unsigned DEFAULT '0',
  `is_system` tinyint(1) unsigned DEFAULT '0' COMMENT '是否系统自带的用户,不可删除',
  `login_counter` int(11) unsigned DEFAULT '0' COMMENT '登录次数',
  `title` varchar(32) DEFAULT NULL,
  `sign` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`uid`),
  UNIQUE KEY `openid` (`openid`),
  UNIQUE KEY `email` (`email`) USING BTREE,
  UNIQUE KEY `username` (`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=12138 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_main`
--

LOCK TABLES `user_main` WRITE;
/*!40000 ALTER TABLE `user_main` DISABLE KEYS */;
INSERT INTO `user_main` VALUES (1,1,'15652579676','master','q7a752741f667201b54780c926faec4e',1,'','master','Master','BXYMartin@hotmail.com','$2y$10$88g8el9pk7yC4K4N8o2NFedeG5ytoUwwzQ5G6TFQbKTkpBOOrOBkm',1,'2019-01-13',0,0,'avatar/1.png?t=1562323397','',NULL,NULL,NULL,NULL,1562323381,1,0,'Administrator','Make Audit Great Again!');
/*!40000 ALTER TABLE `user_main` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_message`
--

DROP TABLE IF EXISTS `user_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sender_uid` int(11) unsigned NOT NULL,
  `sender_name` varchar(64) NOT NULL,
  `direction` smallint(4) unsigned NOT NULL,
  `receiver_uid` int(11) unsigned NOT NULL,
  `title` varchar(128) NOT NULL,
  `content` varchar(5000) NOT NULL,
  `readed` tinyint(1) unsigned NOT NULL,
  `type` tinyint(2) unsigned NOT NULL,
  `create_time` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_message`
--

LOCK TABLES `user_message` WRITE;
/*!40000 ALTER TABLE `user_message` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_password`
--

DROP TABLE IF EXISTS `user_password`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_password` (
  `user_id` int(11) unsigned NOT NULL,
  `hash` varchar(72) DEFAULT '' COMMENT 'password_hash()值',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_password`
--

LOCK TABLES `user_password` WRITE;
/*!40000 ALTER TABLE `user_password` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_password` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_password_strategy`
--

DROP TABLE IF EXISTS `user_password_strategy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_password_strategy` (
  `id` int(1) unsigned NOT NULL,
  `strategy` tinyint(1) unsigned DEFAULT NULL COMMENT '1允许所有密码;2不允许非常简单的密码;3要求强密码  关于安全密码策略',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_password_strategy`
--

LOCK TABLES `user_password_strategy` WRITE;
/*!40000 ALTER TABLE `user_password_strategy` DISABLE KEYS */;
INSERT INTO `user_password_strategy` VALUES (1,2);
/*!40000 ALTER TABLE `user_password_strategy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_phone_find_password`
--

DROP TABLE IF EXISTS `user_phone_find_password`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_phone_find_password` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phone` varchar(20) NOT NULL,
  `verify_code` varchar(128) NOT NULL DEFAULT '',
  `time` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`phone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='找回密码表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_phone_find_password`
--

LOCK TABLES `user_phone_find_password` WRITE;
/*!40000 ALTER TABLE `user_phone_find_password` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_phone_find_password` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_posted_flag`
--

DROP TABLE IF EXISTS `user_posted_flag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_posted_flag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL DEFAULT '0',
  `_date` date NOT NULL,
  `ip` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`,`_date`,`ip`),
  KEY `user_id_2` (`user_id`,`_date`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_posted_flag`
--

LOCK TABLES `user_posted_flag` WRITE;
/*!40000 ALTER TABLE `user_posted_flag` DISABLE KEYS */;
INSERT INTO `user_posted_flag` VALUES (1,1,'2020-02-08','172.17.0.1');
/*!40000 ALTER TABLE `user_posted_flag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_refresh_token`
--

DROP TABLE IF EXISTS `user_refresh_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_refresh_token` (
  `uid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `refresh_token` varchar(256) NOT NULL,
  `expire` int(10) unsigned NOT NULL,
  PRIMARY KEY (`uid`),
  KEY `refresh_token` (`refresh_token`(255))
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户刷新的token表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_refresh_token`
--

LOCK TABLES `user_refresh_token` WRITE;
/*!40000 ALTER TABLE `user_refresh_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_refresh_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_setting`
--

DROP TABLE IF EXISTS `user_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_setting` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `_key` varchar(64) DEFAULT NULL,
  `_value` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`_key`),
  KEY `uid` (`user_id`) USING HASH
) ENGINE=InnoDB AUTO_INCREMENT=263 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_setting`
--

LOCK TABLES `user_setting` WRITE;
/*!40000 ALTER TABLE `user_setting` DISABLE KEYS */;
INSERT INTO `user_setting` VALUES (51,1,'scheme_style','left'),(53,1,'project_view','issues'),(54,1,'issue_view','list'),(198,1,'initializedWidget','1'),(201,1,'initialized_widget','1'),(262,1,'layout','aa');
/*!40000 ALTER TABLE `user_setting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_token`
--

DROP TABLE IF EXISTS `user_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_token` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `token` varchar(255) NOT NULL DEFAULT '' COMMENT 'token',
  `token_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'token过期时间',
  `refresh_token` varchar(255) NOT NULL DEFAULT '' COMMENT '刷新token',
  `refresh_token_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '刷新token过期时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_token`
--

LOCK TABLES `user_token` WRITE;
/*!40000 ALTER TABLE `user_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_widget`
--

DROP TABLE IF EXISTS `user_widget`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_widget` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `user_id` int(11) unsigned NOT NULL COMMENT '用户id',
  `widget_id` int(11) NOT NULL COMMENT 'main_widget主键id',
  `order_weight` int(11) unsigned DEFAULT NULL COMMENT '工具顺序',
  `panel` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `parameter` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_saved_parameter` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否保存了过滤参数',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`,`widget_id`),
  KEY `order_weight` (`order_weight`)
) ENGINE=InnoDB AUTO_INCREMENT=932 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_widget`
--

LOCK TABLES `user_widget` WRITE;
/*!40000 ALTER TABLE `user_widget` DISABLE KEYS */;
INSERT INTO `user_widget` VALUES (929,1,2,1,'first','',0),(930,1,1,2,'first','',0),(931,1,3,1,'second','',0);
/*!40000 ALTER TABLE `user_widget` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workflow`
--

DROP TABLE IF EXISTS `workflow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `workflow` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(40) DEFAULT '',
  `description` varchar(100) DEFAULT '',
  `create_uid` int(11) unsigned DEFAULT NULL,
  `create_time` int(11) unsigned DEFAULT NULL,
  `update_uid` int(11) unsigned DEFAULT NULL,
  `update_time` int(11) unsigned DEFAULT NULL,
  `steps` tinyint(2) unsigned DEFAULT NULL,
  `data` text,
  `is_system` tinyint(1) unsigned DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workflow`
--

LOCK TABLES `workflow` WRITE;
/*!40000 ALTER TABLE `workflow` DISABLE KEYS */;
INSERT INTO `workflow` VALUES (1,'默认工作流','',1,0,NULL,1539675295,NULL,'{\"blocks\":[{\"id\":\"state_begin\",\"positionX\":506,\"positionY\":40,\"innerHTML\":\"BEGIN<div class=\\\"ep\\\" action=\\\"begin\\\"></div>\",\"innerText\":\"BEGIN\"},{\"id\":\"state_open\",\"positionX\":511,\"positionY\":159,\"innerHTML\":\"打开<div class=\\\"ep\\\" action=\\\"OPEN\\\"></div>\",\"innerText\":\"打开\"},{\"id\":\"state_resolved\",\"positionX\":830,\"positionY\":150,\"innerHTML\":\"已解决<div class=\\\"ep\\\" action=\\\"resolved\\\"></div>\",\"innerText\":\"已解决\"},{\"id\":\"state_reopen\",\"positionX\":942,\"positionY\":305,\"innerHTML\":\"重新打开<div class=\\\"ep\\\" action=\\\"reopen\\\"></div>\",\"innerText\":\"重新打开\"},{\"id\":\"state_in_progress\",\"positionX\":490,\"positionY\":395,\"innerHTML\":\"处理中<div class=\\\"ep\\\" action=\\\"in_progress\\\"></div>\",\"innerText\":\"处理中\"},{\"id\":\"state_closed\",\"positionX\":767,\"positionY\":429,\"innerHTML\":\"已关闭<div class=\\\"ep\\\" action=\\\"closed\\\"></div>\",\"innerText\":\"已关闭\"},{\"id\":\"state_delay\",\"positionX\":394,\"positionY\":276,\"innerHTML\":\"延迟处理  <div class=\\\"ep\\\" action=\\\"延迟处理\\\"></div>\",\"innerText\":\"延迟处理  \"},{\"id\":\"state_in_review\",\"positionX\":1243,\"positionY\":153,\"innerHTML\":\"回 顾  <div class=\\\"ep\\\" action=\\\"回 顾\\\"></div>\",\"innerText\":\"回 顾  \"},{\"id\":\"state_done\",\"positionX\":1247,\"positionY\":247,\"innerHTML\":\"完 成  <div class=\\\"ep\\\" action=\\\"完 成\\\"></div>\",\"innerText\":\"完 成  \"}],\"connections\":[{\"id\":\"con_3\",\"sourceId\":\"state_begin\",\"targetId\":\"state_open\"},{\"id\":\"con_10\",\"sourceId\":\"state_open\",\"targetId\":\"state_resolved\"},{\"id\":\"con_17\",\"sourceId\":\"state_in_progress\",\"targetId\":\"state_closed\"},{\"id\":\"con_24\",\"sourceId\":\"state_reopen\",\"targetId\":\"state_closed\"},{\"id\":\"con_31\",\"sourceId\":\"state_open\",\"targetId\":\"state_closed\"},{\"id\":\"con_38\",\"sourceId\":\"state_resolved\",\"targetId\":\"state_closed\"},{\"id\":\"con_45\",\"sourceId\":\"state_resolved\",\"targetId\":\"state_reopen\"},{\"id\":\"con_52\",\"sourceId\":\"state_in_progress\",\"targetId\":\"state_open\"},{\"id\":\"con_59\",\"sourceId\":\"state_in_progress\",\"targetId\":\"state_resolved\"},{\"id\":\"con_66\",\"sourceId\":\"state_closed\",\"targetId\":\"state_open\"},{\"id\":\"con_73\",\"sourceId\":\"state_open\",\"targetId\":\"state_delay\"},{\"id\":\"con_80\",\"sourceId\":\"state_resolved\",\"targetId\":\"state_open\"},{\"id\":\"con_87\",\"sourceId\":\"state_delay\",\"targetId\":\"state_in_progress\"},{\"id\":\"con_94\",\"sourceId\":\"state_closed\",\"targetId\":\"state_reopen\"},{\"id\":\"con_101\",\"sourceId\":\"state_reopen\",\"targetId\":\"state_resolved\"},{\"id\":\"con_108\",\"sourceId\":\"state_reopen\",\"targetId\":\"state_delay\"},{\"id\":\"con_115\",\"sourceId\":\"state_reopen\",\"targetId\":\"state_in_progress\"},{\"id\":\"con_125\",\"sourceId\":\"state_open\",\"targetId\":\"state_in_progress\"}]}',1),(2,'软件开发工作流','针对软件开发的过程状态流',1,NULL,NULL,1529647857,NULL,'{\"blocks\":[{\"id\":\"state_begin\",\"positionX\":506,\"positionY\":40,\"innerHTML\":\"BEGIN<div class=\\\"ep\\\" action=\\\"begin\\\"></div>\",\"innerText\":\"BEGIN\"},{\"id\":\"state_open\",\"positionX\":511,\"positionY\":159,\"innerHTML\":\"打开<div class=\\\"ep\\\" action=\\\"OPEN\\\"></div>\",\"innerText\":\"打开\"},{\"id\":\"state_resolved\",\"positionX\":830,\"positionY\":150,\"innerHTML\":\"已解决<div class=\\\"ep\\\" action=\\\"resolved\\\"></div>\",\"innerText\":\"已解决\"},{\"id\":\"state_reopen\",\"positionX\":942,\"positionY\":305,\"innerHTML\":\"重新打开<div class=\\\"ep\\\" action=\\\"reopen\\\"></div>\",\"innerText\":\"重新打开\"},{\"id\":\"state_in_progress\",\"positionX\":490,\"positionY\":395,\"innerHTML\":\"处理中<div class=\\\"ep\\\" action=\\\"in_progress\\\"></div>\",\"innerText\":\"处理中\"},{\"id\":\"state_closed\",\"positionX\":767,\"positionY\":429,\"innerHTML\":\"已关闭<div class=\\\"ep\\\" action=\\\"closed\\\"></div>\",\"innerText\":\"已关闭\"},{\"id\":\"state_delay\",\"positionX\":394,\"positionY\":276,\"innerHTML\":\"延迟处理  <div class=\\\"ep\\\" action=\\\"延迟处理\\\"></div>\",\"innerText\":\"延迟处理  \"},{\"id\":\"state_in_review\",\"positionX\":1243,\"positionY\":153,\"innerHTML\":\"回 顾  <div class=\\\"ep\\\" action=\\\"回 顾\\\"></div>\",\"innerText\":\"回 顾  \"},{\"id\":\"state_done\",\"positionX\":1247,\"positionY\":247,\"innerHTML\":\"完 成  <div class=\\\"ep\\\" action=\\\"完 成\\\"></div>\",\"innerText\":\"完 成  \"}],\"connections\":[{\"id\":\"con_3\",\"sourceId\":\"state_begin\",\"targetId\":\"state_open\"},{\"id\":\"con_10\",\"sourceId\":\"state_open\",\"targetId\":\"state_resolved\"},{\"id\":\"con_17\",\"sourceId\":\"state_in_progress\",\"targetId\":\"state_closed\"},{\"id\":\"con_24\",\"sourceId\":\"state_reopen\",\"targetId\":\"state_closed\"},{\"id\":\"con_31\",\"sourceId\":\"state_open\",\"targetId\":\"state_closed\"},{\"id\":\"con_38\",\"sourceId\":\"state_resolved\",\"targetId\":\"state_closed\"},{\"id\":\"con_45\",\"sourceId\":\"state_resolved\",\"targetId\":\"state_reopen\"},{\"id\":\"con_52\",\"sourceId\":\"state_in_progress\",\"targetId\":\"state_open\"},{\"id\":\"con_59\",\"sourceId\":\"state_in_progress\",\"targetId\":\"state_resolved\"},{\"id\":\"con_66\",\"sourceId\":\"state_closed\",\"targetId\":\"state_open\"},{\"id\":\"con_73\",\"sourceId\":\"state_open\",\"targetId\":\"state_delay\"},{\"id\":\"con_80\",\"sourceId\":\"state_resolved\",\"targetId\":\"state_open\"},{\"id\":\"con_87\",\"sourceId\":\"state_delay\",\"targetId\":\"state_in_progress\"},{\"id\":\"con_94\",\"sourceId\":\"state_closed\",\"targetId\":\"state_reopen\"},{\"id\":\"con_101\",\"sourceId\":\"state_reopen\",\"targetId\":\"state_resolved\"},{\"id\":\"con_108\",\"sourceId\":\"state_reopen\",\"targetId\":\"state_delay\"},{\"id\":\"con_115\",\"sourceId\":\"state_reopen\",\"targetId\":\"state_in_progress\"},{\"id\":\"con_125\",\"sourceId\":\"state_open\",\"targetId\":\"state_in_progress\"}]}',1),(3,'Task工作流','',1,NULL,NULL,1539675552,NULL,'{\"blocks\":[{\"id\":\"state_begin\",\"positionX\":506,\"positionY\":40,\"innerHTML\":\"BEGIN<div class=\\\"ep\\\" action=\\\"begin\\\"></div>\",\"innerText\":\"BEGIN\"},{\"id\":\"state_open\",\"positionX\":516,\"positionY\":170,\"innerHTML\":\"打开<div class=\\\"ep\\\" action=\\\"OPEN\\\"></div>\",\"innerText\":\"打开\"},{\"id\":\"state_resolved\",\"positionX\":807,\"positionY\":179,\"innerHTML\":\"已解决<div class=\\\"ep\\\" action=\\\"resolved\\\"></div>\",\"innerText\":\"已解决\"},{\"id\":\"state_reopen\",\"positionX\":1238,\"positionY\":81,\"innerHTML\":\"重新打开<div class=\\\"ep\\\" action=\\\"reopen\\\"></div>\",\"innerText\":\"重新打开\"},{\"id\":\"state_in_progress\",\"positionX\":494,\"positionY\":425,\"innerHTML\":\"处理中<div class=\\\"ep\\\" action=\\\"in_progress\\\"></div>\",\"innerText\":\"处理中\"},{\"id\":\"state_closed\",\"positionX\":784,\"positionY\":424,\"innerHTML\":\"已关闭<div class=\\\"ep\\\" action=\\\"closed\\\"></div>\",\"innerText\":\"已关闭\"},{\"id\":\"state_delay\",\"positionX\":385,\"positionY\":307,\"innerHTML\":\"延迟处理  <div class=\\\"ep\\\" action=\\\"延迟处理\\\"></div>\",\"innerText\":\"延迟处理  \"},{\"id\":\"state_in_review\",\"positionX\":1243,\"positionY\":153,\"innerHTML\":\"回 顾  <div class=\\\"ep\\\" action=\\\"回 顾\\\"></div>\",\"innerText\":\"回 顾  \"},{\"id\":\"state_done\",\"positionX\":1247,\"positionY\":247,\"innerHTML\":\"完 成  <div class=\\\"ep\\\" action=\\\"完 成\\\"></div>\",\"innerText\":\"完 成  \"}],\"connections\":[{\"id\":\"con_3\",\"sourceId\":\"state_begin\",\"targetId\":\"state_open\"},{\"id\":\"con_10\",\"sourceId\":\"state_open\",\"targetId\":\"state_resolved\"},{\"id\":\"con_17\",\"sourceId\":\"state_in_progress\",\"targetId\":\"state_closed\"},{\"id\":\"con_24\",\"sourceId\":\"state_open\",\"targetId\":\"state_closed\"},{\"id\":\"con_31\",\"sourceId\":\"state_resolved\",\"targetId\":\"state_closed\"},{\"id\":\"con_38\",\"sourceId\":\"state_in_progress\",\"targetId\":\"state_open\"},{\"id\":\"con_45\",\"sourceId\":\"state_in_progress\",\"targetId\":\"state_resolved\"},{\"id\":\"con_52\",\"sourceId\":\"state_closed\",\"targetId\":\"state_open\"},{\"id\":\"con_59\",\"sourceId\":\"state_open\",\"targetId\":\"state_delay\"},{\"id\":\"con_66\",\"sourceId\":\"state_resolved\",\"targetId\":\"state_open\"},{\"id\":\"con_73\",\"sourceId\":\"state_delay\",\"targetId\":\"state_in_progress\"},{\"id\":\"con_83\",\"sourceId\":\"state_open\",\"targetId\":\"state_in_progress\"}]}',1);
/*!40000 ALTER TABLE `workflow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workflow_block`
--

DROP TABLE IF EXISTS `workflow_block`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `workflow_block` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `workflow_id` int(11) unsigned DEFAULT NULL,
  `status_id` int(11) unsigned DEFAULT NULL,
  `blcok_id` varchar(64) DEFAULT NULL,
  `position_x` smallint(4) unsigned DEFAULT NULL,
  `position_y` smallint(4) unsigned DEFAULT NULL,
  `inner_html` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `workflow_id` (`workflow_id`) USING HASH
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workflow_block`
--

LOCK TABLES `workflow_block` WRITE;
/*!40000 ALTER TABLE `workflow_block` DISABLE KEYS */;
/*!40000 ALTER TABLE `workflow_block` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workflow_connector`
--

DROP TABLE IF EXISTS `workflow_connector`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `workflow_connector` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `workflow_id` int(11) unsigned DEFAULT NULL,
  `connector_id` varchar(32) DEFAULT NULL,
  `title` varchar(64) DEFAULT NULL,
  `source_id` varchar(64) DEFAULT NULL,
  `target_id` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `workflow_id` (`workflow_id`) USING HASH
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workflow_connector`
--

LOCK TABLES `workflow_connector` WRITE;
/*!40000 ALTER TABLE `workflow_connector` DISABLE KEYS */;
/*!40000 ALTER TABLE `workflow_connector` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workflow_scheme`
--

DROP TABLE IF EXISTS `workflow_scheme`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `workflow_scheme` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) DEFAULT NULL,
  `description` varchar(256) DEFAULT NULL,
  `is_system` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10105 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workflow_scheme`
--

LOCK TABLES `workflow_scheme` WRITE;
/*!40000 ALTER TABLE `workflow_scheme` DISABLE KEYS */;
INSERT INTO `workflow_scheme` VALUES (1,'默认工作流方案','',1),(10100,'敏捷开发工作流方案','敏捷开发适用',1),(10101,'普通的软件开发工作流方案','',1),(10102,'流程管理工作流方案','',1);
/*!40000 ALTER TABLE `workflow_scheme` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workflow_scheme_data`
--

DROP TABLE IF EXISTS `workflow_scheme_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `workflow_scheme_data` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `scheme_id` int(11) unsigned DEFAULT NULL,
  `issue_type_id` int(11) unsigned DEFAULT NULL,
  `workflow_id` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `workflow_scheme` (`scheme_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10337 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workflow_scheme_data`
--

LOCK TABLES `workflow_scheme_data` WRITE;
/*!40000 ALTER TABLE `workflow_scheme_data` DISABLE KEYS */;
INSERT INTO `workflow_scheme_data` VALUES (10000,1,0,1),(10105,10100,0,1),(10200,10200,10105,1),(10201,10200,0,1),(10202,10201,10105,1),(10203,10201,0,1),(10300,10300,0,1),(10307,10307,1,1),(10308,10307,2,2),(10311,10101,2,1),(10312,10101,0,1),(10319,10305,1,2),(10320,10305,2,2),(10321,10305,4,2),(10322,10305,5,2),(10323,10102,2,1),(10324,10102,0,1),(10325,10102,10105,1);
/*!40000 ALTER TABLE `workflow_scheme_data` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-02-08  5:04:29
