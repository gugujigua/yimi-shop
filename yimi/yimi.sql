/*
 Navicat MySQL Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50728
 Source Host           : localhost:3306
 Source Schema         : yimi

 Target Server Type    : MySQL
 Target Server Version : 50728
 File Encoding         : 65001

 Date: 07/05/2021 20:59:57
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL,
  `password` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admin
-- ----------------------------
BEGIN;
INSERT INTO `admin` VALUES (1, 'admin', 'e8dec3338ce3571a159f28ac685cebd953fe9cd0');
COMMIT;

-- ----------------------------
-- Table structure for cars
-- ----------------------------
DROP TABLE IF EXISTS `cars`;
CREATE TABLE `cars` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL COMMENT '用户',
  `gid` int(11) NOT NULL COMMENT '商品ID',
  `nums` int(11) DEFAULT '0',
  `specs_id` int(11) DEFAULT NULL,
  `create_time` varchar(13) DEFAULT NULL,
  `update_time` varchar(13) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for category_goods
-- ----------------------------
DROP TABLE IF EXISTS `category_goods`;
CREATE TABLE `category_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `catename` varchar(20) NOT NULL,
  `pid` int(11) DEFAULT '0',
  `is_enable` tinyint(4) DEFAULT '1',
  `thumb` varchar(255) DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of category_goods
-- ----------------------------
BEGIN;
INSERT INTO `category_goods` VALUES (1, '手机 热卖', 0, 1, '/public/uploads/20210507/1620385949947.jpg');
INSERT INTO `category_goods` VALUES (2, '小米', 1, 1, NULL);
INSERT INTO `category_goods` VALUES (3, '华为', 1, 1, NULL);
INSERT INTO `category_goods` VALUES (4, 'ViVO', 1, 1, NULL);
INSERT INTO `category_goods` VALUES (5, 'OPPO', 1, 1, NULL);
INSERT INTO `category_goods` VALUES (10, '笔记本 显示器', 0, 1, NULL);
INSERT INTO `category_goods` VALUES (12, '华为笔记本', 10, 1, NULL);
INSERT INTO `category_goods` VALUES (11, '小米笔记本', 10, 1, NULL);
INSERT INTO `category_goods` VALUES (13, '联想笔记本', 10, 1, NULL);
INSERT INTO `category_goods` VALUES (14, '家电 插线板', 0, 1, NULL);
INSERT INTO `category_goods` VALUES (15, '家电 插线板', 0, 1, NULL);
INSERT INTO `category_goods` VALUES (16, '家电 插线板', 0, 1, NULL);
INSERT INTO `category_goods` VALUES (17, '家电 插线板', 0, 1, NULL);
INSERT INTO `category_goods` VALUES (18, '家电 插线板', 0, 1, NULL);
INSERT INTO `category_goods` VALUES (19, '家电 插线板', 0, 1, NULL);
INSERT INTO `category_goods` VALUES (20, '家电 插线板', 0, 1, NULL);
INSERT INTO `category_goods` VALUES (21, '家电 插线板', 0, 1, NULL);
INSERT INTO `category_goods` VALUES (22, '家电 插线板', 0, 1, NULL);
COMMIT;

-- ----------------------------
-- Table structure for category_news
-- ----------------------------
DROP TABLE IF EXISTS `category_news`;
CREATE TABLE `category_news` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `catename` varchar(20) NOT NULL,
  `is_enable` tinyint(4) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of category_news
-- ----------------------------
BEGIN;
INSERT INTO `category_news` VALUES (1, '企业新闻', 1);
INSERT INTO `category_news` VALUES (2, '产品新闻', 1);
INSERT INTO `category_news` VALUES (3, '最新产品', 1);
INSERT INTO `category_news` VALUES (5, '国际新闻', 1);
INSERT INTO `category_news` VALUES (6, '娱乐新闻', 1);
INSERT INTO `category_news` VALUES (7, '财经新闻', 1);
INSERT INTO `category_news` VALUES (8, '热点推荐', 1);
COMMIT;

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL COMMENT '标题',
  `sub_title` varchar(50) DEFAULT '' COMMENT '副标题',
  `thumb` varchar(100) DEFAULT NULL COMMENT '缩略图',
  `description` varchar(200) DEFAULT '' COMMENT '商品描述',
  `cate_id` int(11) NOT NULL COMMENT '分类ID',
  `content` varchar(10000) DEFAULT '' COMMENT '商品内容',
  `create_time` varchar(13) DEFAULT NULL,
  `update_time` varchar(13) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of goods
-- ----------------------------
BEGIN;
INSERT INTO `goods` VALUES (1, '黑鲨4', '黑鲨4 磁动力升降肩键', '/public/uploads/20210408/1617814988826.png', '骁龙870 | 120W极速闪充+4500mAh双电竞电池 | 磁动力升降肩键 | 720Hz触控采样率+144Hz 三星E4屏幕 | 高品质双扬声器', 2, '<p>骁龙870 | 120W极速闪充+4500mAh双电竞电池 | 磁动力升降肩键 | 720Hz触控采样率+144Hz 三星E4屏幕 | 高品质双扬声器<br/></p><p><img src=\"http://127.0.0.1:7001/public/uploads/20210408/1617815086017.png\" style=\"max-width:100%;\"/><br/></p>', '1617815081975', '1617815081975');
INSERT INTO `goods` VALUES (2, '小米10S', '骁龙870 | 对称式双扬立体声', '/public/uploads/20210408/1617815424663.jpg', '骁龙870 | 对称式双扬立体声 | 1亿像素 8K电影相机 | 33W有线快充 | 30W无线快充 | 10W反向充电 | 4780mAh超大电池 | LPDDR5+UFS3.0+Wi-Fi 6 | VC液冷散热 | 双模5G', 2, '<p><img src=\"http://127.0.0.1:7001/public/uploads/20210408/1617815340459.jpg\" style=\"max-width:100%;\"/><br/></p><p><img src=\"https://cdn.cnbj1.fds.api.mi-img.com/product-images/mi10s/section23-1.png\" alt=\"\"/></p><p>多功能 NFC</p><p>手机就是公交卡、 门禁卡、银行卡<br/>手机还是身份证明、车钥匙</p><p><img src=\"https://cdn.cnbj1.fds.api.mi-img.com/product-images/mi10s/section23-2.png\" alt=\"\"/></p><p>高端X轴线性马达</p><p>横向线性马达，带来更加丰富立<br/>体的振感体验。</p><p><img src=\"https://cdn.cnbj1.fds.api.mi-img.com/product-images/mi10s/section23-3.png\" alt=\"\"/></p><p>红外遥控</p><p>用手机操控电视、<br/>空调等智能家居电器</p><p><img src=\"https://cdn.cnbj1.fds.api.mi-img.com/product-images/mi10s/section23-4.png\" alt=\"\"/></p><p>前后双感光单元</p><p>智能检测手机正面和背面光线，<br/>找到眼睛最舒适的亮度，在复杂<br/>光源里，保护眼睛。</p><p><img src=\"https://cdn.cnbj1.fds.api.mi-img.com/product-images/mi10s/section23-5.png\" alt=\"\"/></p><p>传感器 自研敲击算法</p><p>增加背部双击和三击检测，可自由定制<br/>动作检测功能，比如打开手电筒，截图等</p><p><img src=\"https://cdn.cnbj1.fds.api.mi-img.com/product-images/mi10s/section23-6.png\" alt=\"\"/></p><p>蓝牙绝对音量开关</p><p></p><p>针对支持绝对音量的设备，可在蓝<br/>牙设备详情里选择是否打开关闭该<br/>功能，规避绝对音量设备的兼容性<br/>问题，提升音频使用体验</p>', '1617815425239', '1617815425239');
INSERT INTO `goods` VALUES (3, '小米11S', '骁龙870 | 对称式双扬立体声', '/public/uploads/20210408/1617815424663.jpg', '骁龙870 | 对称式双扬立体声 | 1亿像素 8K电影相机 | 33W有线快充 | 30W无线快充 | 10W反向充电 | 4780mAh超大电池 | LPDDR5+UFS3.0+Wi-Fi 6 | VC液冷散热 | 双模5G', 2, '<p><img src=\"http://127.0.0.1:7001/public/uploads/20210408/1617815340459.jpg\" style=\"max-width:100%;\"/><br/></p><p><img src=\"https://cdn.cnbj1.fds.api.mi-img.com/product-images/mi10s/section23-1.png\" alt=\"\"/></p><p>多功能 NFC</p><p>手机就是公交卡、 门禁卡、银行卡<br/>手机还是身份证明、车钥匙</p><p><img src=\"https://cdn.cnbj1.fds.api.mi-img.com/product-images/mi10s/section23-2.png\" alt=\"\"/></p><p>高端X轴线性马达</p><p>横向线性马达，带来更加丰富立<br/>体的振感体验。</p><p><img src=\"https://cdn.cnbj1.fds.api.mi-img.com/product-images/mi10s/section23-3.png\" alt=\"\"/></p><p>红外遥控</p><p>用手机操控电视、<br/>空调等智能家居电器</p><p><img src=\"https://cdn.cnbj1.fds.api.mi-img.com/product-images/mi10s/section23-4.png\" alt=\"\"/></p><p>前后双感光单元</p><p>智能检测手机正面和背面光线，<br/>找到眼睛最舒适的亮度，在复杂<br/>光源里，保护眼睛。</p><p><img src=\"https://cdn.cnbj1.fds.api.mi-img.com/product-images/mi10s/section23-5.png\" alt=\"\"/></p><p>传感器 自研敲击算法</p><p>增加背部双击和三击检测，可自由定制<br/>动作检测功能，比如打开手电筒，截图等</p><p><img src=\"https://cdn.cnbj1.fds.api.mi-img.com/product-images/mi10s/section23-6.png\" alt=\"\"/></p><p>蓝牙绝对音量开关</p><p></p><p>针对支持绝对音量的设备，可在蓝<br/>牙设备详情里选择是否打开关闭该<br/>功能，规避绝对音量设备的兼容性<br/>问题，提升音频使用体验</p>', '1617815425239', '1617815425239');
INSERT INTO `goods` VALUES (4, '小米12S', '骁龙870 | 对称式双扬立体声', '/public/uploads/20210408/1617815424663.jpg', '骁龙870 | 对称式双扬立体声 | 1亿像素 8K电影相机 | 33W有线快充 | 30W无线快充 | 10W反向充电 | 4780mAh超大电池 | LPDDR5+UFS3.0+Wi-Fi 6 | VC液冷散热 | 双模5G', 2, '<p><img src=\"http://127.0.0.1:7001/public/uploads/20210408/1617815340459.jpg\" style=\"max-width:100%;\"/><br/></p><p><img src=\"https://cdn.cnbj1.fds.api.mi-img.com/product-images/mi10s/section23-1.png\" alt=\"\"/></p><p>多功能 NFC</p><p>手机就是公交卡、 门禁卡、银行卡<br/>手机还是身份证明、车钥匙</p><p><img src=\"https://cdn.cnbj1.fds.api.mi-img.com/product-images/mi10s/section23-2.png\" alt=\"\"/></p><p>高端X轴线性马达</p><p>横向线性马达，带来更加丰富立<br/>体的振感体验。</p><p><img src=\"https://cdn.cnbj1.fds.api.mi-img.com/product-images/mi10s/section23-3.png\" alt=\"\"/></p><p>红外遥控</p><p>用手机操控电视、<br/>空调等智能家居电器</p><p><img src=\"https://cdn.cnbj1.fds.api.mi-img.com/product-images/mi10s/section23-4.png\" alt=\"\"/></p><p>前后双感光单元</p><p>智能检测手机正面和背面光线，<br/>找到眼睛最舒适的亮度，在复杂<br/>光源里，保护眼睛。</p><p><img src=\"https://cdn.cnbj1.fds.api.mi-img.com/product-images/mi10s/section23-5.png\" alt=\"\"/></p><p>传感器 自研敲击算法</p><p>增加背部双击和三击检测，可自由定制<br/>动作检测功能，比如打开手电筒，截图等</p><p><img src=\"https://cdn.cnbj1.fds.api.mi-img.com/product-images/mi10s/section23-6.png\" alt=\"\"/></p><p>蓝牙绝对音量开关</p><p></p><p>针对支持绝对音量的设备，可在蓝<br/>牙设备详情里选择是否打开关闭该<br/>功能，规避绝对音量设备的兼容性<br/>问题，提升音频使用体验</p>', '1617815425239', '1617815425239');
INSERT INTO `goods` VALUES (5, '小米13S', '骁龙870 | 对称式双扬立体声', '/public/uploads/20210408/1617815424663.jpg', '骁龙870 | 对称式双扬立体声 | 1亿像素 8K电影相机 | 33W有线快充 | 30W无线快充 | 10W反向充电 | 4780mAh超大电池 | LPDDR5+UFS3.0+Wi-Fi 6 | VC液冷散热 | 双模5G', 2, '<p><img src=\"http://127.0.0.1:7001/public/uploads/20210408/1617815340459.jpg\" style=\"max-width:100%;\"/><br/></p><p><img src=\"https://cdn.cnbj1.fds.api.mi-img.com/product-images/mi10s/section23-1.png\" alt=\"\"/></p><p>多功能 NFC</p><p>手机就是公交卡、 门禁卡、银行卡<br/>手机还是身份证明、车钥匙</p><p><img src=\"https://cdn.cnbj1.fds.api.mi-img.com/product-images/mi10s/section23-2.png\" alt=\"\"/></p><p>高端X轴线性马达</p><p>横向线性马达，带来更加丰富立<br/>体的振感体验。</p><p><img src=\"https://cdn.cnbj1.fds.api.mi-img.com/product-images/mi10s/section23-3.png\" alt=\"\"/></p><p>红外遥控</p><p>用手机操控电视、<br/>空调等智能家居电器</p><p><img src=\"https://cdn.cnbj1.fds.api.mi-img.com/product-images/mi10s/section23-4.png\" alt=\"\"/></p><p>前后双感光单元</p><p>智能检测手机正面和背面光线，<br/>找到眼睛最舒适的亮度，在复杂<br/>光源里，保护眼睛。</p><p><img src=\"https://cdn.cnbj1.fds.api.mi-img.com/product-images/mi10s/section23-5.png\" alt=\"\"/></p><p>传感器 自研敲击算法</p><p>增加背部双击和三击检测，可自由定制<br/>动作检测功能，比如打开手电筒，截图等</p><p><img src=\"https://cdn.cnbj1.fds.api.mi-img.com/product-images/mi10s/section23-6.png\" alt=\"\"/></p><p>蓝牙绝对音量开关</p><p></p><p>针对支持绝对音量的设备，可在蓝<br/>牙设备详情里选择是否打开关闭该<br/>功能，规避绝对音量设备的兼容性<br/>问题，提升音频使用体验</p>', '1617815425239', '1617815425239');
INSERT INTO `goods` VALUES (6, '小米14S', '骁龙870 | 对称式双扬立体声', '/public/uploads/20210408/1617815424663.jpg', '骁龙870 | 对称式双扬立体声 | 1亿像素 8K电影相机 | 33W有线快充 | 30W无线快充 | 10W反向充电 | 4780mAh超大电池 | LPDDR5+UFS3.0+Wi-Fi 6 | VC液冷散热 | 双模5G', 2, '<p><img src=\"http://127.0.0.1:7001/public/uploads/20210408/1617815340459.jpg\" style=\"max-width:100%;\"/><br/></p><p><img src=\"https://cdn.cnbj1.fds.api.mi-img.com/product-images/mi10s/section23-1.png\" alt=\"\"/></p><p>多功能 NFC</p><p>手机就是公交卡、 门禁卡、银行卡<br/>手机还是身份证明、车钥匙</p><p><img src=\"https://cdn.cnbj1.fds.api.mi-img.com/product-images/mi10s/section23-2.png\" alt=\"\"/></p><p>高端X轴线性马达</p><p>横向线性马达，带来更加丰富立<br/>体的振感体验。</p><p><img src=\"https://cdn.cnbj1.fds.api.mi-img.com/product-images/mi10s/section23-3.png\" alt=\"\"/></p><p>红外遥控</p><p>用手机操控电视、<br/>空调等智能家居电器</p><p><img src=\"https://cdn.cnbj1.fds.api.mi-img.com/product-images/mi10s/section23-4.png\" alt=\"\"/></p><p>前后双感光单元</p><p>智能检测手机正面和背面光线，<br/>找到眼睛最舒适的亮度，在复杂<br/>光源里，保护眼睛。</p><p><img src=\"https://cdn.cnbj1.fds.api.mi-img.com/product-images/mi10s/section23-5.png\" alt=\"\"/></p><p>传感器 自研敲击算法</p><p>增加背部双击和三击检测，可自由定制<br/>动作检测功能，比如打开手电筒，截图等</p><p><img src=\"https://cdn.cnbj1.fds.api.mi-img.com/product-images/mi10s/section23-6.png\" alt=\"\"/></p><p>蓝牙绝对音量开关</p><p></p><p>针对支持绝对音量的设备，可在蓝<br/>牙设备详情里选择是否打开关闭该<br/>功能，规避绝对音量设备的兼容性<br/>问题，提升音频使用体验</p>', '1617815425239', '1617815425239');
INSERT INTO `goods` VALUES (7, '小米15S', '骁龙870 | 对称式双扬立体声', '/public/uploads/20210408/1617815424663.jpg', '骁龙870 | 对称式双扬立体声 | 1亿像素 8K电影相机 | 33W有线快充 | 30W无线快充 | 10W反向充电 | 4780mAh超大电池 | LPDDR5+UFS3.0+Wi-Fi 6 | VC液冷散热 | 双模5G', 2, '<p><img src=\"http://127.0.0.1:7001/public/uploads/20210408/1617815340459.jpg\" style=\"max-width:100%;\"/><br/></p><p><img src=\"https://cdn.cnbj1.fds.api.mi-img.com/product-images/mi10s/section23-1.png\" alt=\"\"/></p><p>多功能 NFC</p><p>手机就是公交卡、 门禁卡、银行卡<br/>手机还是身份证明、车钥匙</p><p><img src=\"https://cdn.cnbj1.fds.api.mi-img.com/product-images/mi10s/section23-2.png\" alt=\"\"/></p><p>高端X轴线性马达</p><p>横向线性马达，带来更加丰富立<br/>体的振感体验。</p><p><img src=\"https://cdn.cnbj1.fds.api.mi-img.com/product-images/mi10s/section23-3.png\" alt=\"\"/></p><p>红外遥控</p><p>用手机操控电视、<br/>空调等智能家居电器</p><p><img src=\"https://cdn.cnbj1.fds.api.mi-img.com/product-images/mi10s/section23-4.png\" alt=\"\"/></p><p>前后双感光单元</p><p>智能检测手机正面和背面光线，<br/>找到眼睛最舒适的亮度，在复杂<br/>光源里，保护眼睛。</p><p><img src=\"https://cdn.cnbj1.fds.api.mi-img.com/product-images/mi10s/section23-5.png\" alt=\"\"/></p><p>传感器 自研敲击算法</p><p>增加背部双击和三击检测，可自由定制<br/>动作检测功能，比如打开手电筒，截图等</p><p><img src=\"https://cdn.cnbj1.fds.api.mi-img.com/product-images/mi10s/section23-6.png\" alt=\"\"/></p><p>蓝牙绝对音量开关</p><p></p><p>针对支持绝对音量的设备，可在蓝<br/>牙设备详情里选择是否打开关闭该<br/>功能，规避绝对音量设备的兼容性<br/>问题，提升音频使用体验</p>', '1617815425239', '1617815425239');
INSERT INTO `goods` VALUES (8, '黑鲨5', '黑鲨4 磁动力升降肩键', '/public/uploads/20210408/1617814988826.png', '骁龙870 | 120W极速闪充+4500mAh双电竞电池 | 磁动力升降肩键 | 720Hz触控采样率+144Hz 三星E4屏幕 | 高品质双扬声器', 2, '<p>骁龙870 | 120W极速闪充+4500mAh双电竞电池 | 磁动力升降肩键 | 720Hz触控采样率+144Hz 三星E4屏幕 | 高品质双扬声器<br/></p><p><img src=\"http://127.0.0.1:7001/public/uploads/20210408/1617815086017.png\" style=\"max-width:100%;\"/><br/></p>', '1617815081975', '1617815081975');
INSERT INTO `goods` VALUES (9, '黑鲨6', '黑鲨4 磁动力升降肩键', '/public/uploads/20210408/1617814988826.png', '骁龙870 | 120W极速闪充+4500mAh双电竞电池 | 磁动力升降肩键 | 720Hz触控采样率+144Hz 三星E4屏幕 | 高品质双扬声器', 2, '<p>骁龙870 | 120W极速闪充+4500mAh双电竞电池 | 磁动力升降肩键 | 720Hz触控采样率+144Hz 三星E4屏幕 | 高品质双扬声器<br/></p><p><img src=\"http://127.0.0.1:7001/public/uploads/20210408/1617815086017.png\" style=\"max-width:100%;\"/><br/></p>', '1617815081975', '1617815081975');
INSERT INTO `goods` VALUES (10, '黑鲨7', '黑鲨4 磁动力升降肩键', '/public/uploads/20210408/1617814988826.png', '骁龙870 | 120W极速闪充+4500mAh双电竞电池 | 磁动力升降肩键 | 720Hz触控采样率+144Hz 三星E4屏幕 | 高品质双扬声器', 2, '<p>骁龙870 | 120W极速闪充+4500mAh双电竞电池 | 磁动力升降肩键 | 720Hz触控采样率+144Hz 三星E4屏幕 | 高品质双扬声器<br/></p><p><img src=\"http://127.0.0.1:7001/public/uploads/20210408/1617815086017.png\" style=\"max-width:100%;\"/><br/></p>', '1617815081975', '1617815081975');
INSERT INTO `goods` VALUES (11, 'Air 13.3\" 2019款', '第八代四核处理器，显卡再升级', '/public/uploads/20210409/1617980933804.jpg', '轻薄全金属机身 / MX250独立显卡 / 9.5小时超长续航 / FHD全高清屏幕 / 指纹解锁 / 兼顾办公娱乐与轻薄的高性能笔记本', 11, '<p>小米笔记本Air 13.3\"<br/>第八代四核处理器，显卡再升级<br/>¥5399起<br/><br/>第八代四核<br/>英特尔®酷睿™处理器<br/><br/>NVIDIA 独立显卡<br/>GeForce®MX250<br/><br/>8GB DDR4 内存<br/>512GB / 256GB PCIe SSD<br/><br/>散热系统升级<br/>超薄金属扇叶<br/><br/>14.8mm | 1.3kg<br/>纤薄全金属机身¹<br/><br/>9.5小时<br/>超长续航</p><p><br/></p><p><img src=\"http://127.0.0.1:7001/public/uploads/20210409/1617981033475.jpg\" style=\"max-width:100%;\"/><br/></p>', '1617981033142', '1617981033142');
INSERT INTO `goods` VALUES (12, '小米显示器1A 23.8英寸', '高清画质，超广视角', '/public/uploads/20210409/1617981325144.jpg', '178°广视角 / 1080P 高清画质 / 薄机身高颜值 / 三微边设计 / 低蓝光不伤眼 / 3年质保', 11, '<p><img src=\"http://127.0.0.1:7001/public/uploads/20210409/1617981200050.jpg\" style=\"max-width:100%;\"/><br/></p>', '1617981200110', '1617981200110');
INSERT INTO `goods` VALUES (13, 'Air 13.3\" 2019款', '第八代四核处理器，显卡再升级', '/public/uploads/20210409/1617980933804.jpg', '轻薄全金属机身 / MX250独立显卡 / 9.5小时超长续航 / FHD全高清屏幕 / 指纹解锁 / 兼顾办公娱乐与轻薄的高性能笔记本', 11, '<p>小米笔记本Air 13.3\"<br/>第八代四核处理器，显卡再升级<br/>¥5399起<br/><br/>第八代四核<br/>英特尔®酷睿™处理器<br/><br/>NVIDIA 独立显卡<br/>GeForce®MX250<br/><br/>8GB DDR4 内存<br/>512GB / 256GB PCIe SSD<br/><br/>散热系统升级<br/>超薄金属扇叶<br/><br/>14.8mm | 1.3kg<br/>纤薄全金属机身¹<br/><br/>9.5小时<br/>超长续航</p><p><br/></p><p><img src=\"http://127.0.0.1:7001/public/uploads/20210409/1617981033475.jpg\" style=\"max-width:100%;\"/><br/></p>', '1617981033142', '1617981033142');
INSERT INTO `goods` VALUES (14, '小米显示器1A 23.8英寸', '高清画质，超广视角', '/public/uploads/20210409/1617981325144.jpg', '178°广视角 / 1080P 高清画质 / 薄机身高颜值 / 三微边设计 / 低蓝光不伤眼 / 3年质保', 11, '<p><img src=\"http://127.0.0.1:7001/public/uploads/20210409/1617981200050.jpg\" style=\"max-width:100%;\"/><br/></p>', '1617981200110', '1617981200110');
INSERT INTO `goods` VALUES (15, '小米显示器1A 23.8英寸', '178°广视角 / 1080P 高清画质', '/public/uploads/20210409/1617981325144.jpg', '178°广视角 / 1080P 高清画质 / 薄机身高颜值 / 三微边设计 / 低蓝光不伤眼 / 3年质保', 11, '<p><img src=\"http://127.0.0.1:7001/public/uploads/20210409/1617981337493.jpg\" style=\"max-width:100%;\"/><br/></p>', '1617981335464', '1617981335464');
INSERT INTO `goods` VALUES (16, 'Air 13.3\" 2019款', '第八代四核处理器，显卡再升级', '/public/uploads/20210409/1617980933804.jpg', '轻薄全金属机身 / MX250独立显卡 / 9.5小时超长续航 / FHD全高清屏幕 / 指纹解锁 / 兼顾办公娱乐与轻薄的高性能笔记本', 11, '<p>小米笔记本Air 13.3\"<br/>第八代四核处理器，显卡再升级<br/>¥5399起<br/><br/>第八代四核<br/>英特尔®酷睿™处理器<br/><br/>NVIDIA 独立显卡<br/>GeForce®MX250<br/><br/>8GB DDR4 内存<br/>512GB / 256GB PCIe SSD<br/><br/>散热系统升级<br/>超薄金属扇叶<br/><br/>14.8mm | 1.3kg<br/>纤薄全金属机身¹<br/><br/>9.5小时<br/>超长续航</p><p><br/></p><p><img src=\"http://127.0.0.1:7001/public/uploads/20210409/1617981033475.jpg\" style=\"max-width:100%;\"/><br/></p>', '1617981033142', '1617981033142');
INSERT INTO `goods` VALUES (17, '小米显示器1A 23.8英寸', '高清画质，超广视角', '/public/uploads/20210409/1617981325144.jpg', '178°广视角 / 1080P 高清画质 / 薄机身高颜值 / 三微边设计 / 低蓝光不伤眼 / 3年质保', 11, '<p><img src=\"http://127.0.0.1:7001/public/uploads/20210409/1617981200050.jpg\" style=\"max-width:100%;\"/><br/></p>', '1617981200110', '1617981200110');
INSERT INTO `goods` VALUES (18, 'Air 13.3\" 2019款', '第八代四核处理器，显卡再升级', '/public/uploads/20210409/1617980933804.jpg', '轻薄全金属机身 / MX250独立显卡 / 9.5小时超长续航 / FHD全高清屏幕 / 指纹解锁 / 兼顾办公娱乐与轻薄的高性能笔记本', 11, '<p>小米笔记本Air 13.3\"<br/>第八代四核处理器，显卡再升级<br/>¥5399起<br/><br/>第八代四核<br/>英特尔®酷睿™处理器<br/><br/>NVIDIA 独立显卡<br/>GeForce®MX250<br/><br/>8GB DDR4 内存<br/>512GB / 256GB PCIe SSD<br/><br/>散热系统升级<br/>超薄金属扇叶<br/><br/>14.8mm | 1.3kg<br/>纤薄全金属机身¹<br/><br/>9.5小时<br/>超长续航</p><p><br/></p><p><img src=\"http://127.0.0.1:7001/public/uploads/20210409/1617981033475.jpg\" style=\"max-width:100%;\"/><br/></p>', '1617981033142', '1617981033142');
INSERT INTO `goods` VALUES (19, '小米显示器1A 23.8英寸', '高清画质，超广视角', '/public/uploads/20210409/1617981325144.jpg', '178°广视角 / 1080P 高清画质 / 薄机身高颜值 / 三微边设计 / 低蓝光不伤眼 / 3年质保', 11, '<p><img src=\"http://127.0.0.1:7001/public/uploads/20210409/1617981200050.jpg\" style=\"max-width:100%;\"/><br/></p>', '1617981200110', '1617981200110');
INSERT INTO `goods` VALUES (20, 'Air 13.3\" 2019款', '第八代四核处理器，显卡再升级', '/public/uploads/20210409/1617980933804.jpg', '轻薄全金属机身 / MX250独立显卡 / 9.5小时超长续航 / FHD全高清屏幕 / 指纹解锁 / 兼顾办公娱乐与轻薄的高性能笔记本', 11, '<p>小米笔记本Air 13.3\"<br/>第八代四核处理器，显卡再升级<br/>¥5399起<br/><br/>第八代四核<br/>英特尔®酷睿™处理器<br/><br/>NVIDIA 独立显卡<br/>GeForce®MX250<br/><br/>8GB DDR4 内存<br/>512GB / 256GB PCIe SSD<br/><br/>散热系统升级<br/>超薄金属扇叶<br/><br/>14.8mm | 1.3kg<br/>纤薄全金属机身¹<br/><br/>9.5小时<br/>超长续航</p><p><br/></p><p><img src=\"http://127.0.0.1:7001/public/uploads/20210409/1617981033475.jpg\" style=\"max-width:100%;\"/><br/></p>', '1617981033142', '1617981033142');
COMMIT;

-- ----------------------------
-- Table structure for goods_specs
-- ----------------------------
DROP TABLE IF EXISTS `goods_specs`;
CREATE TABLE `goods_specs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gid` int(11) NOT NULL COMMENT '商品ID',
  `specs` varchar(255) NOT NULL COMMENT '规格',
  `price` decimal(10,2) NOT NULL COMMENT '现价',
  `original_price` decimal(10,2) DEFAULT NULL COMMENT '原价',
  `stock` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of goods_specs
-- ----------------------------
BEGIN;
INSERT INTO `goods_specs` VALUES (16, 16, 'i7 8G 512G PCIe MX250\n', 5699.00, 5999.00, 10);
INSERT INTO `goods_specs` VALUES (15, 15, '黑色', 899.00, 999.00, 10);
INSERT INTO `goods_specs` VALUES (14, 14, '黑色', 5699.00, 5999.00, 10);
INSERT INTO `goods_specs` VALUES (13, 13, 'i7 8G 512G PCIe MX250\n', 5699.00, 5999.00, 10);
INSERT INTO `goods_specs` VALUES (12, 12, '黑色', 899.00, 999.00, 10);
INSERT INTO `goods_specs` VALUES (11, 11, 'i7 8G 512G PCIe MX250\n', 5699.00, 5999.00, 10);
INSERT INTO `goods_specs` VALUES (10, 10, '8GB+256GB', 3899.00, 3999.00, 10);
INSERT INTO `goods_specs` VALUES (9, 9, '8GB+256GB', 3999.00, 3999.00, 10);
INSERT INTO `goods_specs` VALUES (8, 8, '8GB+256GB', 3799.00, 3999.00, 10);
INSERT INTO `goods_specs` VALUES (7, 7, '8GB+256GB', 3799.00, 3999.00, 10);
INSERT INTO `goods_specs` VALUES (6, 6, '8GB+256GB', 3799.00, 3999.00, 10);
INSERT INTO `goods_specs` VALUES (5, 5, '8GB+256GB', 3799.00, 3999.00, 10);
INSERT INTO `goods_specs` VALUES (4, 4, '8GB+256GB', 3799.00, 3999.00, 10);
INSERT INTO `goods_specs` VALUES (3, 3, '8GB+256GB', 3799.00, 3999.00, 10);
INSERT INTO `goods_specs` VALUES (2, 2, '8GB+256GB', 3799.00, 3999.00, 10);
INSERT INTO `goods_specs` VALUES (1, 1, '8GB+256GB', 3799.00, 3999.00, 10);
INSERT INTO `goods_specs` VALUES (17, 17, '黑色', 5699.00, 5999.00, 10);
INSERT INTO `goods_specs` VALUES (18, 18, 'i7 8G 512G PCIe MX250\n', 5699.00, 5999.00, 10);
INSERT INTO `goods_specs` VALUES (19, 19, '黑色', 5699.00, 5999.00, 10);
INSERT INTO `goods_specs` VALUES (20, 20, 'i7 8G 512G PCIe MX250\n', 5699.00, 5999.00, 10);
COMMIT;

-- ----------------------------
-- Table structure for info
-- ----------------------------
DROP TABLE IF EXISTS `info`;
CREATE TABLE `info` (
  `id` int(11) NOT NULL,
  `name` varchar(20) DEFAULT NULL COMMENT '商城名称',
  `title` varchar(50) DEFAULT NULL COMMENT '商城标题',
  `keywords` varchar(50) DEFAULT NULL COMMENT '关键词',
  `description` varchar(200) DEFAULT NULL COMMENT '描述',
  `copyright` varchar(200) DEFAULT NULL COMMENT '版权信息',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of info
-- ----------------------------
BEGIN;
INSERT INTO `info` VALUES (1, '十米商城', '十米商城-正品低价、品质保障、配送及时、轻松购物！', '十米商城', '十米商城-正品低价、品质保障、配送及时、轻松购物！', 'Copyright © 2021十米商城 All Rights Reserved. 十米商城公司 版权所有');
COMMIT;

-- ----------------------------
-- Table structure for news
-- ----------------------------
DROP TABLE IF EXISTS `news`;
CREATE TABLE `news` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL DEFAULT '',
  `description` varchar(200) NOT NULL DEFAULT '',
  `thumb` varchar(100) DEFAULT NULL,
  `content` varchar(10000) DEFAULT '',
  `cat_id` int(11) DEFAULT NULL COMMENT '分类ID',
  `create_time` varchar(13) DEFAULT NULL,
  `update_time` varchar(13) DEFAULT NULL,
  `click` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of news
-- ----------------------------
BEGIN;
INSERT INTO `news` VALUES (2, '15个新一线城市人均收入：三城突破6万，长沙超青岛天津', '一般来说，经济发达的大城市，就业机会较多，工资水平较高，吸引人口流入也比较多。那么四大一线城市之外，15个新一线城市的收入水平如何？', '/public/uploads/20210405/1617629047445.jpeg', '<p>总体上看，江浙地区集体经济更为发达，也有很多大型企业。集体经济比较规范， 老百姓从集体经济中所获得的收入会比较高。目前，15个新一线城市中，仍有三个城市的全体居民人均收入低于4万元大关，分别是西部的重庆、西安以及来自中部地区的郑州。</p><p>一般来说，经济发达的大城市，就业机会较多，工资水平较高，吸引人口流入也比较多。那么四大一线城市之外，15个新一线城市的收入水平如何？</p><p>第一财经记者根据公开资料，梳理统计15个新一线城市居民人均可支配收入数据发现，苏州在15个新一线城市中人均收入水平最高，杭州和南京紧随其后，这三城人均收入均超过6万元；长沙在中西部领跑，并且超越了东部的青岛和天津。</p><p>根据第一财经·新一线城市研究所2020年6月发布的《2020城市商业魅力排行榜》，2020年15个新一线城市分别是：成都、重庆、杭州、武汉、西安、天津、苏州、南京、郑州、长沙、东莞、沈阳、青岛、合肥、佛山。</p>', 2, '1617620912865', '1617629043764', 0);
INSERT INTO `news` VALUES (3, '快递再掀价格战：最低8毛一单，网点老板入不敷出', '3月底，义乌当地一位兼做圆通、申通、百世快递的网点老板告诉作者，现在，一次发3000-5000票、均重100克以下的商家，圆通1.2元可发全国；发到新疆、西藏只要1.5元。发申通1.35元，百世则是1.3元。', '/public/uploads/20210405/1617629206129.png', '<p>据一位极兔代理商王君（化名）向作者透露：总部对义乌的许多拼多多商家给予了运费补贴，超万件的大单小件可做到1元发货。“轻飘飘像纸一样的快递，看情况最低可做到8毛。”在义乌之外的散件，极兔则比照通达系8-10元的省外快递要低2元左右。</p><p>“面单费和派费都赚不回来。”前述义乌网点老板表示，现在即便是1.2元发全国也是亏的，唯一的利润来源是每天超过一定单量，总部有每单0.5元的返点奖励。她在抖音上写道：“现在的行情有点乱，该亏的亏，该赚的赚。”</p><p>过去几年，通达系“以价换量”，市场份额不断提升，但同时也面临着净利萎缩、股价下跌的困局。更让他们担心的是，极兔在起网一年内就达成了2000万的稳定日单量，如果接下来累及他们核心的市场份额，市值前景将更加黯淡。</p>', 3, '1617620912865', '1617629201466', 10);
INSERT INTO `news` VALUES (5, '埃及救援队小伙复盘如何拯救大船“长赐号”，潮水帮了忙', '为了拯救大船“长赐号”，一台小小的黄色挖掘机在那儿孤独地挖土。“长赐号”搁浅导致苏伊士运河断航后，陆陆续续造成近500艘船只的拥堵，队伍延伸到80千米外的红海。在这些船上，有几万头等待饲料和淡水投喂的牛羊，也有各个码头所等待的原油、纸浆、咖啡和机械。', '/public/uploads/20210405/1617628849676.jpeg', '<p>为了拯救大船“长赐号”，一台小小的黄色挖掘机在那儿孤独地挖土。“长赐号”搁浅导致苏伊士运河断航后，陆陆续续造成近500艘船只的拥堵，队伍延伸到80千米外的红海。在这些船上，有几万头等待饲料和淡水投喂的牛羊，也有各个码头所等待的原油、纸浆、咖啡和机械。海事律师的电话里收到了数不清的抱怨，美国航母也被困在地中海。苏伊士运河是全球化的大动脉，它的拥堵让我们知道了现代生活方式的脆弱。最终，上涨的潮水帮了埃及工人们一把——在当地时间3月29日凌晨，“长赐号”浮起来了。它缓慢地转身、向前行驶，期间晃动了一下，但还好没有再次搁浅。</p><p><br/></p><p><img src=\"http://127.0.0.1:7001/public/uploads/20210405/1617628880957.jpeg\" style=\"max-width:100%;\"/><br/></p>', 1, '1617629096951', '1617628877564', 4);
INSERT INTO `news` VALUES (6, '王毅：中方不认可这个世界上还有高人一等的国家', '关于美方就对华关系反复提出的竞争、合作、对抗几个说法，中方的立场是一贯和明确的。如果要对话，中方的大门随时敞开，但对话应该在平等的基础上，以相互尊重态度进行，中方不认可这个世界上还有高人一等的国家，不接受世界上的事只能一国说了算。', '/public/uploads/20210405/1617629100930.jpeg', '<p>关于美方就对华关系反复提出的竞争、合作、对抗几个说法，中方的立场是一贯和明确的。如果要对话，中方的大门随时敞开，但对话应该在平等的基础上，以相互尊重态度进行，中方不认可这个世界上还有高人一等的国家，不接受世界上的事只能一国说了算。</p>', 2, '1617629096951', '1617629096951', 1);
INSERT INTO `news` VALUES (7, '银行薪酬大曝光！3家银行人均年薪超50万元，这家人均降薪15％', '人均年薪方面，招商银行、浙商银行、中信银行排名靠前，均超过50万元。高管薪酬方面，平安银行、招商银行、民生银行排名靠前，行长薪酬均超过400万元。', '/public/uploads/20210405/1617629261125.jpg', '<p>目前，38家A股上市银行中，已有21家披露了2020年年报。银行员工薪酬、高管薪酬也一并曝光。</p><p>人均年薪方面，招商银行、浙商银行、中信银行排名靠前，均超过50万元。高管薪酬方面，平安银行、招商银行、民生银行排名靠前，行长薪酬均超过400万元。</p><p>从薪酬变化情况来看，变化方向与银行业绩高度相关。光大银行、常熟银行、兴业银行人均薪酬均增长5%以上，而浙商银行人均薪酬降幅达15%，行长薪酬降幅更是超过30%。</p><p><strong>平安银行员工创收最“强悍”</strong></p><p>总体来看，股份行、城商行、农商行在人均创收、人均创利、人均薪酬方面排名靠前。</p><p>人均创收方面，平安银行的员工最“强悍”，人均创收达425.15万元，远超第二、第三名的兴业银行（340.66万元）、中信银行（330.73万元）。此外，招商银行、浦发银行、民生银行、光大银行的人均创收均超过300万元。</p>', 3, '1617605267547', '1617629260575', 5);
INSERT INTO `news` VALUES (8, '继辽宁舰编队之后，解放军巡逻机穿越宫古海峡，美航母同日进南海', '日本统合幕僚监部发布的情况通报显示，解放军一架运-9巡逻机4日经宫古海峡在东海和太平洋空域之间往返飞行。日本航空自卫队还拍摄了解放军巡逻机飞行时的照片，由日本统合幕僚监部对外公开。', '/public/uploads/20210405/1617620918732.jpeg', '<p>日本统合幕僚监部发布的情况通报显示，解放军一架运-9巡逻机4日经宫古海峡在东海和太平洋空域之间往返飞行。日本航空自卫队还拍摄了解放军巡逻机飞行时的照片，由日本统合幕僚监部对外公开。</p><p>据日本防卫省统合幕僚监部4日发布的消息，解放军一架海上巡逻机当天在东海和太平洋空域飞行，日本航空自卫队紧急起飞战斗机应对。</p>', 1, '1617620912865', '1617620912865', 9);
INSERT INTO `news` VALUES (9, '13个主要方面！习近平详述调整发展理念全过程', '5月1日出版的《求是》杂志发表中共中央总书记、国家主席、中央军委主席习近平的重要文章《把握新发展阶段，贯彻新发展理念，构建新发展格局》。文章强调，党的十八大以来我们党对经济形势进行科学判断，对发展理念和思路作出及时调整，习近平讲了十三个主要方面，这些内容对于引导我国经济发展取得历史性成就、发生历史性变革至关重要。新华社《学习进行时》为您梳理。', '/public/uploads/20210507/1620369379055.jpeg', '<p>党的十八大以来，我们党对经济形势进行科学判断，对发展理念和思路作出及时调整，引导我国经济发展取得了历史性成就、发生了历史性变革。这里，我概要讲一下其中主要的方面。<br/></p><p><br/></p><p>2012年11月15日，刚刚在中共十八届一中全会上当选的中共中央总书记习近平和中央政治局常委在北京人民大会堂同采访十八大的中外记者亲切见面。这是习近平总书记发表讲话。新华社记者 谢环驰 摄<br/></p>', 1, '1620369396273', '1620369396273', 7);
INSERT INTO `news` VALUES (10, '不打疫苗出行将受限？不让坐飞机、高铁？假的！', '近日，在百度贴吧、知乎等各大平台上，“不打疫苗会不会对出行有限制？”“据说不打疫苗不可以坐飞机？”“不打疫苗能坐高铁吗？”等问题频繁出现。', '/public/uploads/20210507/1620369479368.jpg', '<p>网友提问</p><p>上海辟谣平台记者帮大家咨询了权威部门，请看相关部门的回复——</p><p><strong>铁路12306上海客服</strong></p><p>是否接种新冠疫苗都不影响乘车。</p><p><strong>上海机场客服96990</strong></p><p>乘坐国内航班，只要体温正常、健康码绿色，就能进入候机大厅；</p><p>乘坐国际及港澳台航班请咨询相关航空公司。</p><p><strong>上海海关12360</strong></p><p>对于出境旅客，健康码绿色并填写健康申明卡即可，对是否接种疫苗没有硬性要求。</p><p><strong>东航官方客服95530</strong></p><p>对乘坐国内航班的旅客，没有接种疫苗的要求；</p><p>至于国际航班，要以入境国的防疫政策为准。以美国为例，目前乘坐赴美国际航班，需提供航班起飞前3天内的核酸检测阴性证明，是否接种疫苗不做硬性规定，相关防疫政策以大使馆公告为准。</p><p><strong>目前来看，是否接种新冠疫苗都不影响国内出行；至于国际旅行，要以各国大使馆公告为准。</strong></p><p>我国新冠病毒疫苗接种遵循“知情、同意、自愿”的基本原则免费接种。虽然疫苗接种是非强制性的，但接种疫苗可以建立基础免疫，保护自己和家人的健康。</p><p>当前，新冠疫情仍在全球肆虐，个别国家甚至呈现疫情防控失控状态，我们始终暴露在疫情风险之下，也始终受到输入病例的影响。及时接种疫苗是实现群体免疫最安全、最高效、最经济的方式。</p><p>因此，总结一句话：越早接种越好。</p>', 1, '1620369471759', '1620369471759', 0);
INSERT INTO `news` VALUES (11, '曾骂哭30多岁男主管的董明珠，为何突然变和善了？', '文字时代，很多人只知道董明珠强势的一面，以为她总是板着脸，不怒自威。直到她开始上直播、上综艺，人们才发现，有脾气的“董小姐”其实很克制，接地气，也爱笑。有媒体曾提到过一个细节，如果朋友在微信群里称赞董明珠今天好漂亮，她会丢来“董明珠赏你一个电饭锅”的表情包。', '/public/uploads/20210507/1620369538820.png', '<p>文字时代，很多人只知道董明珠强势的一面，以为她总是板着脸，不怒自威。直到她开始上直播、上综艺，人们才发现，有脾气的“董小姐”其实很克制，接地气，也爱笑。有媒体曾提到过一个细节，如果朋友在微信群里称赞董明珠今天好漂亮，她会丢来“董明珠赏你一个电饭锅”的表情包。<br/></p>', 1, '1620369536260', '1620369536260', 0);
INSERT INTO `news` VALUES (12, '女子5年5次起诉才离婚，连家人都被赌瘾丈夫殴打', '如今，这个跟不好的婚姻勇敢说不，顽强抗争了五年之久的女人，终于迎来了，新的，自由的，坦荡的人生。', '/public/uploads/20210507/1620369588215.jpeg', '<p>她自由了</p><p>一场长达5年的离婚官司终于结束。4月30号中午，在开庭三个多小时后，法官当场宣判了宁顺花和陈定华的离婚决定。听到“准许离婚”的结果时，宁顺花的内心没有想象中的激动，而是被一种解脱后瞬间产生的疲惫感攫住。她把早已准备好的一些物品——一颗大而发黄的钻戒（陈定华声称买成十几万，宁顺花说其实是在街边的铺子花两三万随便买的）、一条金项链、一只戒指、一本写有两人名字的房产证——交还给前夫陈定华，陈定华仍旧不愿意接受离婚的事实，当场将交还之物掷在地上。</p>', 1, '1620369580413', '1620369580413', 0);
INSERT INTO `news` VALUES (13, '“五一”消费活力向世界展示耀眼中国', '即将过去的“五一”小长假，人们纷纷外出旅游、观看电影、品尝美食、运动健身，再次把小长假过出了春节味。与此同时，各地相关职能部门和商圈商户也结合春夏时节消费旺季推出花样繁多的活动，让各地消费市场暖意融融。', '/public/uploads/20210507/1620369650461.jpeg', '<p>去年上半年，面对新冠肺炎疫情，全国上下齐心协力、全力以赴，用一个多月时间就初步遏制了疫情蔓延势头，用三个月左右时间就取得了决定性成果。当前，境外疫情防控形势仍然非常严峻，全国各地在严格做好常态化疫情防控的同时，不断释放消费活力，让整个中国经济活络起来。网上网下，不少人感慨：家国无恙，国泰民安，我有一个强大的祖国！</p><p>“五一”小长假期间，走出家门的人们纷纷通过各种网络介质晒美景、晒美食。一张张照片、一段段视频，一组组数据，无不向世界展示着中国的美好与奋进。的确，仅5月1日晚间，在上海举行的“2021年全国消费促进月暨上海五五购物节”，仅用了2小时，上海地区就累计消费支付实时金额突破20亿元。活动24小时，消费金额就累计达到了173亿元，同时段同比增长了11%。5月3日，中国银联发布消息，5月1日—2日，银联网络交易总金额达到7543亿元，相比去年同期增长5.5%（综合新华网、央视网2021年5月4日报道）。这些数据，只是“五一”小长假消费数据的一个缩影，其背后是中国经济旺盛的消费活力。</p>', 1, '1620369641876', '1620369641876', 0);
COMMIT;

-- ----------------------------
-- Table structure for order_goods
-- ----------------------------
DROP TABLE IF EXISTS `order_goods`;
CREATE TABLE `order_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` varchar(50) NOT NULL COMMENT '订单号',
  `good_id` int(11) NOT NULL COMMENT '商品ID',
  `specs_id` int(11) DEFAULT NULL COMMENT '规格ID',
  `nums` int(11) DEFAULT '0' COMMENT '商品数量',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of order_goods
-- ----------------------------
BEGIN;
INSERT INTO `order_goods` VALUES (14, '20210413161831246151898727', 1, 1, 1);
INSERT INTO `order_goods` VALUES (13, '20210412161816204527777690', 1, 1, 1);
INSERT INTO `order_goods` VALUES (12, '20210412161816193363439383', 1, 1, 1);
INSERT INTO `order_goods` VALUES (11, '20210411161815328650955347', 10, 10, 1);
COMMIT;

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` varchar(30) NOT NULL COMMENT '订单ID',
  `state` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '订单状态  1待付款 2已取消 3待发货 4已发货 5已收货',
  `money` decimal(20,2) NOT NULL COMMENT '订单金额',
  `username` varchar(20) NOT NULL COMMENT '用户名',
  `address_id` int(11) DEFAULT '0' COMMENT '订单地址',
  `express_id` int(11) DEFAULT '0' COMMENT '快递号',
  `pay_time` varchar(13) DEFAULT '0' COMMENT '支付时间',
  `create_time` varchar(13) DEFAULT '0' COMMENT '创建时间',
  `update_time` varchar(13) DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of orders
-- ----------------------------
BEGIN;
INSERT INTO `orders` VALUES (12, '20210413161831246151898727', 1, 3799.00, 'zhangsan', 0, 0, '0', '1618312461518', '1618312461518');
INSERT INTO `orders` VALUES (11, '20210412161816204527777690', 0, 3799.00, 'zhangsan', 0, 0, '0', '1618162045277', '1618162045277');
INSERT INTO `orders` VALUES (10, '20210412161816193363439383', 0, 3799.00, 'zhangsan', 0, 0, '0', '1618161933634', '1618161933634');
INSERT INTO `orders` VALUES (9, '20210411161815328650955347', 1, 3799.00, 'zhangsan', 0, 0, '0', '1618153286509', '1618153286509');
COMMIT;

-- ----------------------------
-- Table structure for theme
-- ----------------------------
DROP TABLE IF EXISTS `theme`;
CREATE TABLE `theme` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `good_cate` int(11) DEFAULT '1',
  `good_list` int(11) DEFAULT '1',
  `good_list_num` int(11) DEFAULT '5',
  `good_align` varchar(255) DEFAULT 'left',
  `new_list` int(255) DEFAULT '1',
  `list_num` int(11) DEFAULT '3',
  `new_rank` int(255) DEFAULT '1',
  `new_rank_num` int(11) DEFAULT '5',
  `title_align` varchar(255) DEFAULT 'left',
  `page_align` varchar(255) DEFAULT 'left',
  `new_list_num` int(11) DEFAULT '3',
  `new_type` int(255) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of theme
-- ----------------------------
BEGIN;
INSERT INTO `theme` VALUES (1, 2, 2, 3, 'center', 1, 3, 2, 5, 'center', 'center', 6, 2);
COMMIT;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL,
  `password` varchar(40) NOT NULL,
  `nickname` varchar(255) DEFAULT '用户',
  `email` varchar(100) DEFAULT '',
  `phone` varchar(11) DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of users
-- ----------------------------
BEGIN;
INSERT INTO `users` VALUES (1, 'a', '8cb2237d0679ca88db6464eac60da96345513964', '用户', NULL, '');
INSERT INTO `users` VALUES (2, 'zhangsan', '8cb2237d0679ca88db6464eac60da96345513964', '张三爱洗澡', '', '');
INSERT INTO `users` VALUES (3, 'lisi', '8cb2237d0679ca88db6464eac60da96345513964', '用户', NULL, '');
INSERT INTO `users` VALUES (4, 'wang', '8cb2237d0679ca88db6464eac60da96345513964', '用户', NULL, '');
INSERT INTO `users` VALUES (5, 'b', '8cb2237d0679ca88db6464eac60da96345513964', '用户', NULL, '');
INSERT INTO `users` VALUES (6, 'c', '8cb2237d0679ca88db6464eac60da96345513964', '用户', NULL, '');
INSERT INTO `users` VALUES (7, 'd', '8cb2237d0679ca88db6464eac60da96345513964', '用户', NULL, '');
INSERT INTO `users` VALUES (8, 'e', '8cb2237d0679ca88db6464eac60da96345513964', '用户', NULL, '');
COMMIT;

-- ----------------------------
-- Table structure for wheel
-- ----------------------------
DROP TABLE IF EXISTS `wheel`;
CREATE TABLE `wheel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) DEFAULT NULL,
  `thumb` varchar(100) NOT NULL,
  `url` varchar(100) NOT NULL,
  `sort` int(255) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wheel
-- ----------------------------
BEGIN;
INSERT INTO `wheel` VALUES (1, '米粉节', '/public/uploads/20210405/1617635460252.jpeg', 'http://www.mi.com', 0);
INSERT INTO `wheel` VALUES (2, '小米笔记本', '/public/uploads/20210405/1617635902258.webp', 'http://www.min.com', 0);
INSERT INTO `wheel` VALUES (3, '米家无刷智能家用电钻', '/public/uploads/20210405/1617635966968.webp', 'http://www.mi.com', 0);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
