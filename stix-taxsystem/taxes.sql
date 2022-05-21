
CREATE TABLE IF NOT EXISTS `taxes` (
  `time` int(11) DEFAULT 5000,
  `prize` int(11) DEFAULT 5000,
  `enabled` int(11) DEFAULT 1,
  UNIQUE KEY `Index 1` (`time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


INSERT INTO `taxes` (`time`, `prize`, `enabled`) VALUES (20155, 300, 1);

