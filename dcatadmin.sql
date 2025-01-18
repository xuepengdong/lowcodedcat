/*
 Navicat Premium Dump SQL

 Source Server         : 本地
 Source Server Type    : MySQL
 Source Server Version : 80035 (8.0.35-0ubuntu0.22.04.1)
 Source Host           : 127.0.0.1:33060
 Source Schema         : dcatadmin

 Target Server Type    : MySQL
 Target Server Version : 80035 (8.0.35-0ubuntu0.22.04.1)
 File Encoding         : 65001

 Date: 09/01/2025 17:41:26
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin_extension_histories
-- ----------------------------
DROP TABLE IF EXISTS `admin_extension_histories`;
CREATE TABLE `admin_extension_histories`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` tinyint NOT NULL DEFAULT 1,
  `version` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `detail` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `admin_extension_histories_name_index`(`name` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_extension_histories
-- ----------------------------

-- ----------------------------
-- Table structure for admin_extensions
-- ----------------------------
DROP TABLE IF EXISTS `admin_extensions`;
CREATE TABLE `admin_extensions`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `version` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `is_enabled` tinyint NOT NULL DEFAULT 0,
  `options` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `admin_extensions_name_unique`(`name` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_extensions
-- ----------------------------

-- ----------------------------
-- Table structure for admin_field
-- ----------------------------
DROP TABLE IF EXISTS `admin_field`;
CREATE TABLE `admin_field`  (
  `fieldid` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `pk_admin_model_id` int NOT NULL COMMENT '所属模型表外键',
  `field_name_cn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '中文名字',
  `field_name_en` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '英文名字',
  `field_type` int NOT NULL COMMENT '字段类型',
  `field_unique` enum('1','0') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '是否唯一',
  `is_system` enum('1','0') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '是否系统字段',
  `field_length` int NULL DEFAULT NULL COMMENT '字段长度',
  `field_remarks` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '字段备注',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '修改时间',
  `created_by` int NULL DEFAULT NULL COMMENT '创建人',
  `updated_by` int NULL DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`fieldid`) USING BTREE,
  UNIQUE INDEX `index_pk_admin_model_id`(`pk_admin_model_id` ASC, `field_name_en` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 262 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_field
-- ----------------------------
INSERT INTO `admin_field` VALUES (192, 89, '主键ID', 'test1ID', 1, '1', '0', NULL, '主键', '2024-12-26 06:54:21', '2024-12-26 06:54:21', 1, 1);
INSERT INTO `admin_field` VALUES (193, 89, '创建时间', 'created_at1', 16, '0', '1', 0, '记录的创建时间', '2024-12-26 06:54:21', '2025-01-04 03:45:48', 1, 1);
INSERT INTO `admin_field` VALUES (194, 89, '更新时间', 'updated_at', 2, '0', '1', NULL, '记录的更新时间', '2024-12-26 06:54:21', '2024-12-26 06:54:21', 1, 1);
INSERT INTO `admin_field` VALUES (195, 89, '创建人', 'created_by', 3, '0', '1', 3, '记录的创建人', '2024-12-26 06:54:21', '2025-01-04 03:22:28', 1, 1);
INSERT INTO `admin_field` VALUES (196, 89, '修改人', 'updated_by', 3, '0', '1', NULL, '记录的修改人', '2024-12-26 06:54:21', '2024-12-26 06:54:21', 1, 1);
INSERT INTO `admin_field` VALUES (236, 89, 'test1', 'test1', 1, '1', '1', NULL, 'test2remark', '2024-12-28 10:07:34', '2024-12-28 10:07:34', NULL, NULL);
INSERT INTO `admin_field` VALUES (239, 90, '主键ID', 'test2ID', 1, '1', '1', NULL, '主键', '2025-01-02 03:10:20', '2025-01-02 03:10:20', 1, 1);
INSERT INTO `admin_field` VALUES (240, 90, '创建时间', 'created_at', 2, '0', '1', NULL, '记录的创建时间', '2025-01-02 03:10:20', '2025-01-02 03:10:20', 1, 1);
INSERT INTO `admin_field` VALUES (241, 90, '更新时间', 'updated_at', 2, '0', '1', NULL, '记录的更新时间', '2025-01-02 03:10:20', '2025-01-02 03:10:20', 1, 1);
INSERT INTO `admin_field` VALUES (242, 90, '创建人', 'created_by', 3, '0', '1', NULL, '记录的创建人', '2025-01-02 03:10:20', '2025-01-02 03:10:20', 1, 1);
INSERT INTO `admin_field` VALUES (243, 90, '修改人', 'updated_by', 3, '0', '1', NULL, '记录的修改人', '2025-01-02 03:10:20', '2025-01-02 03:10:20', 1, 1);
INSERT INTO `admin_field` VALUES (245, 89, '上传图片', 'uploadimage1', 21, '0', '1', NULL, NULL, '2025-01-03 10:23:46', '2025-01-03 10:23:46', NULL, NULL);
INSERT INTO `admin_field` VALUES (248, 89, '手机1', 'phone1', 15, '1', '0', 11, NULL, '2025-01-04 05:54:48', '2025-01-04 05:54:48', NULL, NULL);
INSERT INTO `admin_field` VALUES (249, 89, 'phone2', 'phone2', 15, '0', '0', 11, NULL, '2025-01-04 05:56:55', '2025-01-04 05:56:55', NULL, NULL);
INSERT INTO `admin_field` VALUES (250, 89, 'phone3', 'phone3', 15, '0', '0', 11, NULL, '2025-01-04 05:58:31', '2025-01-04 05:58:31', NULL, NULL);
INSERT INTO `admin_field` VALUES (251, 89, 'phone5', 'phone5', 15, '0', '0', 1, NULL, '2025-01-04 06:02:56', '2025-01-04 06:02:56', NULL, NULL);
INSERT INTO `admin_field` VALUES (252, 89, 'phone6', 'phone6', 15, '0', '0', 11, NULL, '2025-01-04 06:03:24', '2025-01-04 06:03:24', NULL, NULL);
INSERT INTO `admin_field` VALUES (253, 89, 'phone7', 'phone7', 15, '0', '0', 11, NULL, '2025-01-04 06:07:31', '2025-01-04 06:07:31', NULL, NULL);
INSERT INTO `admin_field` VALUES (254, 89, 'phone8', 'phone8', 15, '0', '0', 11, NULL, '2025-01-04 06:10:01', '2025-01-04 06:10:01', NULL, NULL);
INSERT INTO `admin_field` VALUES (256, 89, 'phone9', 'phon9', 15, '1', '0', 11, NULL, '2025-01-04 06:12:07', '2025-01-04 06:12:07', NULL, NULL);
INSERT INTO `admin_field` VALUES (257, 89, 'phone9', 'phone9', 15, '1', '0', 11, NULL, '2025-01-04 06:15:00', '2025-01-04 06:15:00', NULL, NULL);
INSERT INTO `admin_field` VALUES (258, 89, 'phone11', 'phone11', 15, '1', '0', 11, NULL, '2025-01-04 06:16:09', '2025-01-04 06:52:43', NULL, NULL);
INSERT INTO `admin_field` VALUES (259, 89, 'phone12', 'phone12', 15, '0', '0', 11, NULL, '2025-01-04 07:00:31', '2025-01-04 07:00:31', NULL, NULL);
INSERT INTO `admin_field` VALUES (260, 89, '普通文本', 'wenben', 1, '1', '1', 255, NULL, '2025-01-04 07:07:39', '2025-01-04 07:07:39', NULL, NULL);
INSERT INTO `admin_field` VALUES (261, 89, 'phone23', 'phone23', 15, '1', '1', 19, '手机13', '2025-01-04 07:20:45', '2025-01-04 07:59:15', NULL, NULL);

-- ----------------------------
-- Table structure for admin_fieldtype
-- ----------------------------
DROP TABLE IF EXISTS `admin_fieldtype`;
CREATE TABLE `admin_fieldtype`  (
  `fieldtype_id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '对象主键',
  `fieldtype_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '对象英文名字',
  `model_remarks` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '对象备注',
  `created_at` timestamp NOT NULL COMMENT '创建时间',
  `updated_at` timestamp NOT NULL COMMENT '修改时间',
  `created_by` int UNSIGNED NULL DEFAULT NULL COMMENT '创建人',
  `updated_by` int UNSIGNED NULL DEFAULT NULL COMMENT '修改人',
  `sort` int NULL DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`fieldtype_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 31 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_fieldtype
-- ----------------------------
INSERT INTO `admin_fieldtype` VALUES (1, '文本', NULL, '2025-01-02 19:08:17', '2025-01-02 19:08:20', 1, 1, 1);
INSERT INTO `admin_fieldtype` VALUES (2, '隐藏文本', NULL, '2025-01-02 19:08:34', '2025-01-02 19:08:36', 1, 1, 3);
INSERT INTO `admin_fieldtype` VALUES (3, '下拉选框单选', NULL, '2025-01-02 19:09:03', '2025-01-02 19:09:05', 1, 1, 6);
INSERT INTO `admin_fieldtype` VALUES (4, '下拉选框联动', NULL, '2025-01-02 19:11:30', '2025-01-02 19:11:32', 1, 1, 8);
INSERT INTO `admin_fieldtype` VALUES (5, '下拉选框多选', NULL, '2025-01-02 19:20:50', '2025-01-02 19:20:54', 1, 1, 7);
INSERT INTO `admin_fieldtype` VALUES (6, '表格选择器', NULL, '2025-01-03 11:39:39', '2025-01-03 11:39:41', 1, 1, 26);
INSERT INTO `admin_fieldtype` VALUES (7, '多选盒子', NULL, '2025-01-03 11:42:57', '2025-01-03 11:42:59', 1, 1, 27);
INSERT INTO `admin_fieldtype` VALUES (8, '长文本', NULL, '2025-01-03 11:43:08', '2025-01-03 11:43:10', 1, 1, 2);
INSERT INTO `admin_fieldtype` VALUES (9, '单选', NULL, '2025-01-03 11:45:51', '2025-01-03 11:45:53', 1, 1, 5);
INSERT INTO `admin_fieldtype` VALUES (10, '多选', NULL, '2025-01-03 11:46:01', '2025-01-03 11:46:04', 1, 1, 9);
INSERT INTO `admin_fieldtype` VALUES (11, '邮箱', NULL, '2025-01-03 11:49:09', '2025-01-03 11:49:12', 1, 1, 16);
INSERT INTO `admin_fieldtype` VALUES (12, '密码', NULL, '2025-01-03 11:49:24', '2025-01-03 11:49:27', 1, 1, 15);
INSERT INTO `admin_fieldtype` VALUES (13, '链接', NULL, '2025-01-03 11:49:41', '2025-01-03 11:49:45', 1, 1, 17);
INSERT INTO `admin_fieldtype` VALUES (14, 'IP', NULL, '2025-01-03 11:49:52', '2025-01-03 11:49:55', 1, 1, 18);
INSERT INTO `admin_fieldtype` VALUES (15, '手机', NULL, '2025-01-03 11:50:15', '2025-01-03 11:50:18', 1, 1, 19);
INSERT INTO `admin_fieldtype` VALUES (16, '颜色取色器', NULL, '2025-01-03 11:50:29', '2025-01-03 11:50:32', 1, 1, 25);
INSERT INTO `admin_fieldtype` VALUES (17, '时间', NULL, '2025-01-03 11:50:44', '2025-01-03 11:50:47', 1, 1, 13);
INSERT INTO `admin_fieldtype` VALUES (18, '日期', NULL, '2025-01-03 11:50:56', '2025-01-03 11:50:59', 1, 1, 12);
INSERT INTO `admin_fieldtype` VALUES (19, '时间日期', NULL, '2025-01-03 11:51:09', '2025-01-03 11:51:11', 1, 1, 14);
INSERT INTO `admin_fieldtype` VALUES (20, '文件', NULL, '2025-01-03 11:51:51', '2025-01-03 11:51:57', 1, 1, 11);
INSERT INTO `admin_fieldtype` VALUES (21, '图片', NULL, '2025-01-03 11:52:05', '2025-01-03 11:52:07', 1, 1, 10);
INSERT INTO `admin_fieldtype` VALUES (22, '富文本编辑器', NULL, '2025-01-03 11:54:05', '2025-01-03 11:54:29', 1, 1, 28);
INSERT INTO `admin_fieldtype` VALUES (23, 'Markdown 编辑器', NULL, '2025-01-03 13:36:55', '2025-01-03 13:36:58', 1, 1, 27);
INSERT INTO `admin_fieldtype` VALUES (24, '开关', NULL, '2025-01-03 13:38:53', '2025-01-03 13:38:55', 1, 1, 20);
INSERT INTO `admin_fieldtype` VALUES (25, '地图', NULL, '2025-01-03 13:39:05', '2025-01-03 13:39:07', 1, 1, 21);
INSERT INTO `admin_fieldtype` VALUES (26, '数字', NULL, '2025-01-03 13:45:59', '2025-01-03 13:46:01', 1, 1, 4);
INSERT INTO `admin_fieldtype` VALUES (27, '分割线', NULL, '2025-01-03 13:47:48', '2025-01-03 13:47:50', 1, 1, 22);
INSERT INTO `admin_fieldtype` VALUES (28, '费率', NULL, '2025-01-03 13:48:07', '2025-01-03 13:48:10', 1, 1, 23);
INSERT INTO `admin_fieldtype` VALUES (29, 'icon', NULL, '2025-01-03 13:49:15', '2025-01-03 13:49:17', 1, 1, 24);
INSERT INTO `admin_fieldtype` VALUES (30, '联动模型', NULL, '2025-01-03 14:01:45', '2025-01-03 14:01:46', 1, 1, 28);

-- ----------------------------
-- Table structure for admin_menu
-- ----------------------------
DROP TABLE IF EXISTS `admin_menu`;
CREATE TABLE `admin_menu`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `parent_id` bigint NOT NULL DEFAULT 0,
  `order` int NOT NULL DEFAULT 0,
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `icon` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `uri` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `extension` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `show` tinyint NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_menu
-- ----------------------------
INSERT INTO `admin_menu` VALUES (1, 0, 4, 'Index', 'feather icon-bar-chart-2', '/', '', 1, '2024-11-28 11:21:35', '2025-01-09 08:39:30');
INSERT INTO `admin_menu` VALUES (2, 0, 5, 'Admin', 'feather icon-settings', '', '', 1, '2024-11-28 11:21:35', '2025-01-09 08:39:30');
INSERT INTO `admin_menu` VALUES (3, 2, 6, 'Users', '', 'auth/users', '', 1, '2024-11-28 11:21:35', '2025-01-09 08:39:30');
INSERT INTO `admin_menu` VALUES (4, 2, 7, 'Roles', '', 'auth/roles', '', 1, '2024-11-28 11:21:35', '2025-01-09 08:39:30');
INSERT INTO `admin_menu` VALUES (5, 2, 8, 'Permission', '', 'auth/permissions', '', 1, '2024-11-28 11:21:35', '2025-01-09 08:39:30');
INSERT INTO `admin_menu` VALUES (6, 0, 2, 'Menu', 'fa-battery-3', 'auth/menu', '', 1, '2024-11-28 11:21:35', '2025-01-09 08:40:08');
INSERT INTO `admin_menu` VALUES (7, 2, 9, 'Extensions', '', 'auth/extensions', '', 1, '2024-11-28 11:21:35', '2025-01-09 08:39:30');
INSERT INTO `admin_menu` VALUES (8, 0, 1, 'model', 'fa-apple', '/model', '', 1, '2025-01-09 08:35:07', '2025-01-09 08:39:19');
INSERT INTO `admin_menu` VALUES (9, 0, 3, 'page', 'fa-automobile', '/admin_page', '', 1, '2025-01-09 08:37:14', '2025-01-09 08:40:08');
INSERT INTO `admin_menu` VALUES (10, 0, 10, '测试', NULL, NULL, '', 1, '2025-01-09 08:41:36', '2025-01-09 08:41:36');

-- ----------------------------
-- Table structure for admin_model
-- ----------------------------
DROP TABLE IF EXISTS `admin_model`;
CREATE TABLE `admin_model`  (
  `model_id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '对象主键',
  `model_name_en` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '对象英文名字',
  `model_name_cn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '对象中文名字',
  `model_remarks` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '对象备注',
  `created_at` timestamp NOT NULL COMMENT '创建时间',
  `updated_at` timestamp NOT NULL COMMENT '修改时间',
  `created_by` int UNSIGNED NULL DEFAULT NULL COMMENT '创建人',
  `updated_by` int UNSIGNED NULL DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`model_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 91 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_model
-- ----------------------------
INSERT INTO `admin_model` VALUES (89, 'test1', 'test1', 'test1', '2024-12-26 06:54:21', '2024-12-26 06:54:21', 1, 1);
INSERT INTO `admin_model` VALUES (90, 'test2', 'test2', 'test2', '2025-01-02 03:10:20', '2025-01-02 03:10:20', 1, 1);

-- ----------------------------
-- Table structure for admin_page
-- ----------------------------
DROP TABLE IF EXISTS `admin_page`;
CREATE TABLE `admin_page`  (
  `page_id` int NOT NULL AUTO_INCREMENT,
  `pk_admin_model_id` int NOT NULL COMMENT '所属模型表外键',
  `page_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `page_type` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL COMMENT '创建时间',
  `updated_at` timestamp NOT NULL COMMENT '修改时间',
  `created_by` int UNSIGNED NULL DEFAULT NULL COMMENT '创建人',
  `updated_by` int UNSIGNED NULL DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`page_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_page
-- ----------------------------
INSERT INTO `admin_page` VALUES (1, 90, '用户列表', 'list', '2025-01-04 16:42:38', '2025-01-09 03:34:35', 1, 1);
INSERT INTO `admin_page` VALUES (2, 90, '列表页面', 'list', '2025-01-07 09:55:34', '2025-01-07 09:55:34', 1, 1);
INSERT INTO `admin_page` VALUES (3, 90, '列表页面', 'list', '2025-01-07 09:56:55', '2025-01-07 09:56:55', 1, 1);
INSERT INTO `admin_page` VALUES (4, 90, '列表页面', 'list', '2025-01-07 09:59:58', '2025-01-07 09:59:58', 1, 1);
INSERT INTO `admin_page` VALUES (5, 90, '列表页面', 'list', '2025-01-07 10:00:15', '2025-01-07 10:00:15', 1, 1);
INSERT INTO `admin_page` VALUES (6, 90, '列表页面', 'list', '2025-01-07 10:00:26', '2025-01-07 10:00:26', 1, 1);
INSERT INTO `admin_page` VALUES (7, 90, '列表页面', 'list', '2025-01-07 10:02:43', '2025-01-07 10:02:43', 1, 1);
INSERT INTO `admin_page` VALUES (8, 90, '列表页面', 'list', '2025-01-07 10:02:49', '2025-01-07 10:02:49', 1, 1);
INSERT INTO `admin_page` VALUES (9, 90, '列表页面', 'list', '2025-01-07 10:03:19', '2025-01-07 10:03:19', 1, 1);
INSERT INTO `admin_page` VALUES (10, 90, '列表页面', 'list', '2025-01-07 10:03:39', '2025-01-07 10:03:39', 1, 1);
INSERT INTO `admin_page` VALUES (11, 90, '列表页面', 'list', '2025-01-07 10:06:21', '2025-01-07 10:06:21', 1, 1);
INSERT INTO `admin_page` VALUES (12, 90, '列表页面', 'list', '2025-01-07 10:06:42', '2025-01-07 10:06:42', 1, 1);
INSERT INTO `admin_page` VALUES (13, 90, '添加页面', 'add', '2025-01-07 10:09:33', '2025-01-07 10:09:33', 1, 1);
INSERT INTO `admin_page` VALUES (14, 89, '列表页面', 'list', '2025-01-08 09:08:01', '2025-01-08 09:08:01', 1, 1);

-- ----------------------------
-- Table structure for admin_permission_menu
-- ----------------------------
DROP TABLE IF EXISTS `admin_permission_menu`;
CREATE TABLE `admin_permission_menu`  (
  `permission_id` bigint NOT NULL,
  `menu_id` bigint NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  UNIQUE INDEX `admin_permission_menu_permission_id_menu_id_unique`(`permission_id` ASC, `menu_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_permission_menu
-- ----------------------------

-- ----------------------------
-- Table structure for admin_permissions
-- ----------------------------
DROP TABLE IF EXISTS `admin_permissions`;
CREATE TABLE `admin_permissions`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `http_method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `http_path` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `order` int NOT NULL DEFAULT 0,
  `parent_id` bigint NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `admin_permissions_slug_unique`(`slug` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_permissions
-- ----------------------------
INSERT INTO `admin_permissions` VALUES (1, 'Auth management', 'auth-management', '', '', 1, 0, '2024-11-28 11:21:35', NULL);
INSERT INTO `admin_permissions` VALUES (2, 'Users', 'users', '', '/auth/users*', 2, 1, '2024-11-28 11:21:35', NULL);
INSERT INTO `admin_permissions` VALUES (3, 'Roles', 'roles', '', '/auth/roles*', 3, 1, '2024-11-28 11:21:35', NULL);
INSERT INTO `admin_permissions` VALUES (4, 'Permissions', 'permissions', '', '/auth/permissions*', 4, 1, '2024-11-28 11:21:35', NULL);
INSERT INTO `admin_permissions` VALUES (5, 'Menu', 'menu', '', '/auth/menu*', 5, 1, '2024-11-28 11:21:35', NULL);
INSERT INTO `admin_permissions` VALUES (6, 'Extension', 'extension', '', '/auth/extensions*', 6, 1, '2024-11-28 11:21:35', NULL);

-- ----------------------------
-- Table structure for admin_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `admin_role_menu`;
CREATE TABLE `admin_role_menu`  (
  `role_id` bigint NOT NULL,
  `menu_id` bigint NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  UNIQUE INDEX `admin_role_menu_role_id_menu_id_unique`(`role_id` ASC, `menu_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_role_menu
-- ----------------------------

-- ----------------------------
-- Table structure for admin_role_permissions
-- ----------------------------
DROP TABLE IF EXISTS `admin_role_permissions`;
CREATE TABLE `admin_role_permissions`  (
  `role_id` bigint NOT NULL,
  `permission_id` bigint NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  UNIQUE INDEX `admin_role_permissions_role_id_permission_id_unique`(`role_id` ASC, `permission_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_role_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for admin_role_users
-- ----------------------------
DROP TABLE IF EXISTS `admin_role_users`;
CREATE TABLE `admin_role_users`  (
  `role_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  UNIQUE INDEX `admin_role_users_role_id_user_id_unique`(`role_id` ASC, `user_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_role_users
-- ----------------------------
INSERT INTO `admin_role_users` VALUES (1, 1, '2024-11-28 11:21:36', '2024-11-28 11:21:36');

-- ----------------------------
-- Table structure for admin_roles
-- ----------------------------
DROP TABLE IF EXISTS `admin_roles`;
CREATE TABLE `admin_roles`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `admin_roles_slug_unique`(`slug` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_roles
-- ----------------------------
INSERT INTO `admin_roles` VALUES (1, 'Administrator', 'administrator', '2024-11-28 11:21:35', '2024-11-28 11:21:36');

-- ----------------------------
-- Table structure for admin_settings
-- ----------------------------
DROP TABLE IF EXISTS `admin_settings`;
CREATE TABLE `admin_settings`  (
  `slug` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`slug`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_settings
-- ----------------------------

-- ----------------------------
-- Table structure for admin_users
-- ----------------------------
DROP TABLE IF EXISTS `admin_users`;
CREATE TABLE `admin_users`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `admin_users_username_unique`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_users
-- ----------------------------
INSERT INTO `admin_users` VALUES (1, 'admin', '$2y$12$I2DVQmuOc1EY7o1vkAJlxuVZX8NbWOw0VZyOFEqyB9DQge7fwyGEe', 'Administrator', NULL, 'KyBdTsSs28rJHKjBTaQVmBlhOZ8g4KOEYL3N8WfTv0j6zhnjrJm6NatLkrkZ', '2024-11-28 11:21:35', '2024-11-28 11:21:35');

-- ----------------------------
-- Table structure for cache
-- ----------------------------
DROP TABLE IF EXISTS `cache`;
CREATE TABLE `cache`  (
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cache
-- ----------------------------

-- ----------------------------
-- Table structure for cache_locks
-- ----------------------------
DROP TABLE IF EXISTS `cache_locks`;
CREATE TABLE `cache_locks`  (
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cache_locks
-- ----------------------------

-- ----------------------------
-- Table structure for failed_jobs
-- ----------------------------
DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE `failed_jobs`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `failed_jobs_uuid_unique`(`uuid` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of failed_jobs
-- ----------------------------

-- ----------------------------
-- Table structure for job_batches
-- ----------------------------
DROP TABLE IF EXISTS `job_batches`;
CREATE TABLE `job_batches`  (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `cancelled_at` int NULL DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of job_batches
-- ----------------------------

-- ----------------------------
-- Table structure for jobs
-- ----------------------------
DROP TABLE IF EXISTS `jobs`;
CREATE TABLE `jobs`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED NULL DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `jobs_queue_index`(`queue` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of jobs
-- ----------------------------

-- ----------------------------
-- Table structure for migrations
-- ----------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of migrations
-- ----------------------------
INSERT INTO `migrations` VALUES (1, '0001_01_01_000000_create_users_table', 1);
INSERT INTO `migrations` VALUES (2, '0001_01_01_000001_create_cache_table', 1);
INSERT INTO `migrations` VALUES (3, '0001_01_01_000002_create_jobs_table', 1);
INSERT INTO `migrations` VALUES (4, '2016_01_04_173148_create_admin_tables', 1);
INSERT INTO `migrations` VALUES (5, '2020_09_07_090635_create_admin_settings_table', 1);
INSERT INTO `migrations` VALUES (6, '2020_09_22_015815_create_admin_extensions_table', 1);
INSERT INTO `migrations` VALUES (7, '2020_11_01_083237_update_admin_menu_table', 1);

-- ----------------------------
-- Table structure for password_reset_tokens
-- ----------------------------
DROP TABLE IF EXISTS `password_reset_tokens`;
CREATE TABLE `password_reset_tokens`  (
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of password_reset_tokens
-- ----------------------------

-- ----------------------------
-- Table structure for sessions
-- ----------------------------
DROP TABLE IF EXISTS `sessions`;
CREATE TABLE `sessions`  (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED NULL DEFAULT NULL,
  `ip_address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `user_agent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sessions_user_id_index`(`user_id` ASC) USING BTREE,
  INDEX `sessions_last_activity_index`(`last_activity` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sessions
-- ----------------------------
INSERT INTO `sessions` VALUES ('4t2Ru6tnsRwxUdGV5kI6I4tQFYZ8qDF4TpqpNbgW', NULL, '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoidGtLb1Q4UHlMVlBRMEdjZ2J6ODZaSndtbWJPVVFCVHhIREhDQVlJaiI7czo1MjoibG9naW5fYWRtaW5fNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO3M6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjE6e2k6MDtzOjE0OiJhZG1pbi5wcmV2LnVybCI7fXM6MzoibmV3IjthOjA6e319czo1OiJhZG1pbiI7YToxOntzOjQ6InByZXYiO2E6MTp7czozOiJ1cmwiO3M6NDU6Imh0dHA6Ly9kY2F0YWRtaW4uYmFpbGl0b3AuY29tL2FkbWluL2F1dGgvbWVudSI7fX1zOjk6Il9wcmV2aW91cyI7YToxOntzOjM6InVybCI7czo1MzoiaHR0cDovL2RjYXRhZG1pbi5iYWlsaXRvcC5jb20vYWRtaW4vYWRtaW5fcGFnZS8xL2VkaXQiO319', 1736394296);
INSERT INTO `sessions` VALUES ('LjDlpiaTQKLKKpOFzGUwci3cVyegdKneSO9L6QfR', NULL, '192.168.56.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoicnpEb1FoNTNUdmdRMEpIaWNxRG5jbnUySVN5clkxcWhmQXgwbXFIUSI7czo1MjoibG9naW5fYWRtaW5fNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO3M6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjE6e2k6MDtzOjE0OiJhZG1pbi5wcmV2LnVybCI7fXM6MzoibmV3IjthOjA6e319czo1OiJhZG1pbiI7YToxOntzOjQ6InByZXYiO2E6MTp7czozOiJ1cmwiO3M6NTM6Imh0dHA6Ly9kY2F0YWRtaW4uYmFpbGl0b3AuY29tL2FkbWluL2FkbWluX3BhZ2UvMS9lZGl0Ijt9fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjQ1OiJodHRwOi8vZGNhdGFkbWluLmJhaWxpdG9wLmNvbS9hZG1pbi9hdXRoL21lbnUiO319', 1736414175);

-- ----------------------------
-- Table structure for test1
-- ----------------------------
DROP TABLE IF EXISTS `test1`;
CREATE TABLE `test1`  (
  `test1ID` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at1` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int UNSIGNED NULL DEFAULT NULL,
  `updated_by` int UNSIGNED NULL DEFAULT NULL,
  `phone9` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `phone11` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `phone12` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `wenben` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `phone23` varchar(19) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`test1ID`) USING BTREE,
  UNIQUE INDEX `test1_wenben_unique`(`wenben` ASC) USING BTREE,
  UNIQUE INDEX `test1_phone23_unique`(`phone23` ASC) USING BTREE,
  INDEX `test1_created_by_foreign`(`created_by` ASC) USING BTREE,
  INDEX `test1_updated_by_foreign`(`updated_by` ASC) USING BTREE,
  CONSTRAINT `test1_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `test1_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of test1
-- ----------------------------

-- ----------------------------
-- Table structure for test2
-- ----------------------------
DROP TABLE IF EXISTS `test2`;
CREATE TABLE `test2`  (
  `test2ID` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int UNSIGNED NULL DEFAULT NULL,
  `updated_by` int UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`test2ID`) USING BTREE,
  INDEX `test2_created_by_foreign`(`created_by` ASC) USING BTREE,
  INDEX `test2_updated_by_foreign`(`updated_by` ASC) USING BTREE,
  CONSTRAINT `test2_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `test2_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of test2
-- ----------------------------

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `users_email_unique`(`email` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
