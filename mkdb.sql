-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.6.4-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for mkdb
CREATE DATABASE IF NOT EXISTS `mkdb` /*!40100 DEFAULT CHARACTER SET utf8mb3 */;
USE `mkdb`;

-- Dumping structure for table mkdb.guests
CREATE TABLE IF NOT EXISTS `guests` (
  `meal_id` int(10) unsigned NOT NULL,
  `user_id` char(36) DEFAULT NULL,
  KEY `user_id` (`user_id`),
  KEY `FK_meal` (`meal_id`),
  CONSTRAINT `FK_meal` FOREIGN KEY (`meal_id`) REFERENCES `meals` (`mid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`uid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table mkdb.guests: ~24 rows (approximately)
/*!40000 ALTER TABLE `guests` DISABLE KEYS */;
INSERT INTO `guests` (`meal_id`, `user_id`) VALUES
	(3, 'b051a093-303c-11ec-a84e-7a79195350e1'),
	(3, 'bd898d0e-303b-11ec-a84e-7a79195350e1'),
	(3, 'b050cac4-303c-11ec-a84e-7a79195350e1'),
	(3, 'b053609d-303c-11ec-a84e-7a79195350e1'),
	(3, 'b04f5d24-303c-11ec-a84e-7a79195350e1'),
	(3, 'b04e8011-303c-11ec-a84e-7a79195350e1'),
	(3, 'b052bae5-303c-11ec-a84e-7a79195350e1'),
	(4, 'b053609d-303c-11ec-a84e-7a79195350e1'),
	(4, 'bd898d0e-303b-11ec-a84e-7a79195350e1'),
	(4, 'b04f5d24-303c-11ec-a84e-7a79195350e1'),
	(4, 'b04e8011-303c-11ec-a84e-7a79195350e1'),
	(4, 'b054f1b1-303c-11ec-a84e-7a79195350e1'),
	(4, 'b0500b3f-303c-11ec-a84e-7a79195350e1'),
	(4, 'b05420e4-303c-11ec-a84e-7a79195350e1'),
	(4, 'b052bae5-303c-11ec-a84e-7a79195350e1'),
	(1, 'bd898d0e-303b-11ec-a84e-7a79195350e1'),
	(1, 'b04f5d24-303c-11ec-a84e-7a79195350e1'),
	(1, 'b050cac4-303c-11ec-a84e-7a79195350e1'),
	(1, 'b04e8011-303c-11ec-a84e-7a79195350e1'),
	(1, 'b05420e4-303c-11ec-a84e-7a79195350e1'),
	(2, 'b052bae5-303c-11ec-a84e-7a79195350e1'),
	(2, 'b051a093-303c-11ec-a84e-7a79195350e1'),
	(2, 'b053609d-303c-11ec-a84e-7a79195350e1'),
	(2, 'b054f1b1-303c-11ec-a84e-7a79195350e1'),
	(2, 'b04f5d24-303c-11ec-a84e-7a79195350e1'),
	(2, 'b0500b3f-303c-11ec-a84e-7a79195350e1');
/*!40000 ALTER TABLE `guests` ENABLE KEYS */;

-- Dumping structure for table mkdb.meals
CREATE TABLE IF NOT EXISTS `meals` (
  `mid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` tinytext DEFAULT NULL,
  `description` tinytext DEFAULT NULL,
  `dessert` tinytext DEFAULT NULL,
  `active` set('true','false') NOT NULL DEFAULT 'false',
  `date` char(10) NOT NULL DEFAULT '',
  KEY `mid` (`mid`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table mkdb.meals: ~5 rows (approximately)
/*!40000 ALTER TABLE `meals` DISABLE KEYS */;
INSERT INTO `meals` (`mid`, `name`, `description`, `dessert`, `active`, `date`) VALUES
	(3, 'Sambousas', 'Empanadas fritas típicas de Somalia rellenas de carne desmechada con vegetales salteados, acompañado de dips de babaganoush y salsa tipo Ranch casera.', NULL, 'false', '2021-10-08'),
	(4, 'Hamburguesa con Papas Fritas', 'Hamburguesa doble con pan de papa casero, lechuga, cebolla, salsa Big Mac casera y papas fritas acompañadas de un dip de barbacoa casera.', 'Ice Cream Sandwich', 'false', '2021-10-15'),
	(5, 'Tikka Masala', 'Pollo marinado en yogur natural, cocido con crema de leche y salsa de tomate, acompañado de arroz basmati con cúrcuma y pan de Naan.', 'Gulab Jamun con Crema', 'true', '2021-10-22'),
	(2, 'Bao de Ceviche', 'Pan Bao cocido al vapor con relleno de ceviche de portobelos y gírgolas', NULL, 'false', '2021-10-01'),
	(1, 'Ñoquis de papa con salsa Putanesca', 'Ñoquis de papa con salsa que incluye ajo, albahaca, alcaparras, aceitunas negras y anchoas', 'Tiramisú', 'false', '2021-09-24');
/*!40000 ALTER TABLE `meals` ENABLE KEYS */;

-- Dumping structure for table mkdb.users
CREATE TABLE IF NOT EXISTS `users` (
  `name` varchar(80) DEFAULT NULL,
  `uid` char(36) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `password` char(32) DEFAULT NULL,
  KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table mkdb.users: ~11 rows (approximately)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`name`, `uid`, `username`, `password`) VALUES
	('Federico Bracone', 'bd898d0e-303b-11ec-a84e-7a79195350e1', 'fbracone', '411a14cd22f16a53a8b29e642b6a29b7'),
	('Juan Manuel Paberolis', 'b04e8011-303c-11ec-a84e-7a79195350e1', 'jmpaberolis', 'd0624dc68e319469708a5438989e1a7f'),
	('Gonzalo Orellana', 'b04f5d24-303c-11ec-a84e-7a79195350e1', 'gorellana', '8932b1f4b86d55fab25d90c0a22c9cd9'),
	('Martín Prenassi', 'b0500b3f-303c-11ec-a84e-7a79195350e1', 'mprenassi', '5abd1934dbdc9cde0b2e10e0c1602ca9'),
	('Nicolás Demaio', 'b050cac4-303c-11ec-a84e-7a79195350e1', 'ndemaio', 'b53d7945ff8b353414c9ea573a4fdd8e'),
	('Micaela Premat', 'b051a093-303c-11ec-a84e-7a79195350e1', 'mpremat', '80794ffb7adac49d3cb122a76991bc57'),
	('Milagros Montone', 'b052bae5-303c-11ec-a84e-7a79195350e1', 'mmontone', '7fb8c9a07dbb5bfe1ae39488c703cf17'),
	('Emilia Mayo', 'b053609d-303c-11ec-a84e-7a79195350e1', 'emayo', '2c9966200222e0e67e2663a87d248ab3'),
	('Matías Ruggieri', 'b05420e4-303c-11ec-a84e-7a79195350e1', 'mruggieri', 'e5b168733e5960045434ea1c308a357c'),
	('Juliana Fernández', 'b054f1b1-303c-11ec-a84e-7a79195350e1', 'jfernandez', '8787df20c38f11ddd0ecf1561b982ff3'),
	('Kevin Coscarelli', 'b0559be8-303c-11ec-a84e-7a79195350e1', 'kcoscarelli', '03d07eadb0aa888e8f2f633bf2d401dc');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
