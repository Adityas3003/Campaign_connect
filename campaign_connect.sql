-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Mar 25, 2025 at 07:51 AM
-- Server version: 8.0.40
-- PHP Version: 8.2.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `campaign_connect`
--

-- --------------------------------------------------------

--
-- Table structure for table `campaigns`
--

DROP TABLE IF EXISTS `campaigns`;
CREATE TABLE IF NOT EXISTS `campaigns` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `date` date NOT NULL,
  `location` varchar(255) NOT NULL,
  `roles` text NOT NULL,
  `image_url` varchar(800) DEFAULT NULL,
  `organizer` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `campaigns`
--

INSERT INTO `campaigns` (`id`, `title`, `description`, `date`, `location`, `roles`, `image_url`, `organizer`) VALUES
(8, 'Food Donation Drive', 'A charitable effort to collect, pack, and distribute food to the underprivileged.', '2025-03-05', 'wakad', 'Food collection, sorting & packing, distribution, awareness campaigning, logistics & transport.', 'https://th.bing.com/th?id=OIP.BVF0S9R9DlWudDge-8CBqwHaE8&w=306&h=204&c=8&rs=1&qlt=90&o=6&cb=15&dpr=1.4&pid=3.1&rm=2', 'Aditya3003'),
(9, 'Blood Donation Campaign', 'A life-saving initiative to collect and donate blood for patients in need.', '2025-03-12', 'pune', 'Donor registration, medical support, awareness promotion, refreshment service, logistics coordination.', 'https://th.bing.com/th/id/OIP.P9rwNHoNNVJIWl7g4AC5zAHaE7?w=290&h=193&c=7&r=0&o=5&dpr=1.4&pid=1.7', 'chaitanya'),
(10, 'Clean Up Drive', 'A community-driven initiative to clean up our local parks and streets. Volunteers will be provided with necessary materials like gloves, trash bags, and safety gear.', '2025-04-15', 'Chinchwad, Pune', 'Volunteer to clean up the park, distribute materials, help with waste sorting.', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqnNQETMnEpWzykvAIhQLGUE4lDh_x_50ggbMBbeMUj1qNdJFKvCoCBL316Lu1shymF2I&usqp=CAU', 'sevaOrg'),
(11, 'Food Drive for Homeless', 'Collect non-perishable food items and deliver them to homeless shelters in our area. Help distribute food packages to those in need', '2025-02-12', 'mumbai', 'Food collection, distribution, organizing donations.', 'https://img.freepik.com/premium-vector/donation-box-with-food-hunger-people-different-grocery-products-homeless-people-shelter_458444-20.jpg', 'sevaOrg'),
(12, 'Tree Planting Initiative', 'Help us green our city by planting trees and shrubs in urban areas. The event is aimed at increasing the green cover and improving air quality in our neighborhoods.', '2025-09-12', 'Satara', 'Tree planter, volunteer for organizing, providing tools and refreshments.', 'https://www.maasavitringo.org/wp-content/uploads/2024/07/CMP_TP_1.jpg', 'sevaOrg');

-- --------------------------------------------------------

--
-- Table structure for table `campaign_volunteers`
--

DROP TABLE IF EXISTS `campaign_volunteers`;
CREATE TABLE IF NOT EXISTS `campaign_volunteers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `volunteer_id` int NOT NULL,
  `campaign_id` int NOT NULL,
  `joined_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `volunteer_id` (`volunteer_id`),
  KEY `campaign_id` (`campaign_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `campaign_volunteers`
--

INSERT INTO `campaign_volunteers` (`id`, `volunteer_id`, `campaign_id`, `joined_at`) VALUES
(7, 1, 8, '2025-03-06 11:38:42'),
(8, 1, 9, '2025-03-06 11:48:54'),
(9, 19, 8, '2025-03-22 04:45:18');

-- --------------------------------------------------------

--
-- Table structure for table `enquiry_form`
--

DROP TABLE IF EXISTS `enquiry_form`;
CREATE TABLE IF NOT EXISTS `enquiry_form` (
  `id` int NOT NULL AUTO_INCREMENT,
  `full_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `submitted_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `enquiry_form`
--

INSERT INTO `enquiry_form` (`id`, `full_name`, `email`, `message`, `submitted_at`) VALUES
(1, 'Aditya', 'abc@gamil.com', 'rtyu', '2025-03-04 07:40:02'),
(2, 'Aditya', 'abc@gamil.com', 'agghav', '2025-03-04 07:41:39'),
(3, 'kaustubh', 'kaustubh@gmail.com', 'vhah', '2025-03-05 16:15:58'),
(4, 'kaustubh', 'kaustubh1423@gmail.com', 'good website', '2025-03-08 06:52:17'),
(5, 'ishant', 'ishant.koli2205@gmail.com', 'I want about your expeience', '2025-03-08 07:01:18'),
(6, 'Aditya Ramesh Shinde ', 'shindeaditya3003@gmail.com', 'want campaign on food danation in Pune', '2025-03-22 06:10:13');

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

DROP TABLE IF EXISTS `feedback`;
CREATE TABLE IF NOT EXISTS `feedback` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `rating` int NOT NULL,
  `comments` text,
  `submission_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `feedback`
--

INSERT INTO `feedback` (`id`, `name`, `email`, `rating`, `comments`, `submission_date`) VALUES
(1, 'pradip', 'pradip@gmail.com', 3, 'vhhs', '2025-03-04 07:34:04'),
(2, 'kaustubh', 'kau@gmail.com', 3, 'gagsac', '2025-03-05 16:15:15');

-- --------------------------------------------------------

--
-- Table structure for table `organizations`
--

DROP TABLE IF EXISTS `organizations`;
CREATE TABLE IF NOT EXISTS `organizations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `org_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `location` varchar(255) NOT NULL,
  `registered_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `organizations`
--

INSERT INTO `organizations` (`id`, `org_name`, `email`, `username`, `password`, `location`, `registered_at`) VALUES
(1, 'aditya', 'aditya@gmail.com', 'Aditya3003', 'aditya3', 'pune', '2025-03-04 08:23:10'),
(3, 'chaitanya', 'chait@gmail.com', 'chaitanya', '123', 'pune', '2025-03-04 08:57:19'),
(4, 'sayali', 'sayali.shinde.233@gmail.com', 'sayali11', 'sayali0011', 'wakad pune', '2025-03-05 16:05:43'),
(5, 'Seva Organization', 'seva@gmail.com', 'sevaOrg', '987', 'Pune', '2025-03-22 05:20:18');

-- --------------------------------------------------------

--
-- Table structure for table `volunteers`
--

DROP TABLE IF EXISTS `volunteers`;
CREATE TABLE IF NOT EXISTS `volunteers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `full_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `location` varchar(255) NOT NULL,
  `registered_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `contact_no` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `volunteers`
--

INSERT INTO `volunteers` (`id`, `full_name`, `email`, `username`, `password`, `location`, `registered_at`, `contact_no`) VALUES
(1, 'Aditya', 'aditya@gmail.com', 'Aditya3003', 'aditya', 'pune', '2025-03-03 15:28:37', '9638527412'),
(4, 'kaustubh', 'kaustubh@gmail.com', 'kaustubh', '12345678', 'pune', '2025-03-04 08:20:13', '9876543210'),
(5, 'pradip', 'pradip@gmail.com', 'pradip77', 'pradip1', 'pune', '2025-03-04 08:49:55', '9812345670'),
(6, 'sakshi', 'sakshi@gmail.com', 'sakshi11', 'sakshi0011', 'pune', '2025-03-05 16:03:39', '8887766554'),
(7, 'manas', 'manas@gmail.com', 'manas12', 'manas@12', 'pune', '2025-03-06 07:01:56', '9001234567'),
(8, 'prabhu', 'prabhu@gmail.com', 'prabhu11', 'prabhu@11', 'pune', '2025-03-06 14:19:24', '8899776655'),
(14, 'chaitanya', 'chait@gmail.com', 'chaitanya11', 'chaitanya', 'pune', '2025-03-07 14:13:56', '9900112233'),
(18, 'aditya', 'test2@gmail.com', 'aditya303', 'aditya', 'pune', '2025-03-08 11:07:49', '8776543210'),
(19, 'Venkatesh Gajul', 'venkatesh@gmail.com', 'Venky', '9876', 'Pune', '2025-03-22 04:44:42', '9638527412'),
(20, 'ChintaMani', 'chinta@gmail.com', 'chinta', '1234', 'Mumbai', '2025-03-22 05:03:25', '8767234512'),
(21, 'harsh', 'harsh@gmail.com', 'harsh', '987', 'Nashik', '2025-03-22 05:12:45', '7865453212'),
(23, 'kaustubh dhamane', 'ktd@gmail.com', 'kaustubh14', '987', 'Nashik', '2025-03-22 06:24:14', '9876543243');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `campaign_volunteers`
--
ALTER TABLE `campaign_volunteers`
  ADD CONSTRAINT `campaign_volunteers_ibfk_1` FOREIGN KEY (`volunteer_id`) REFERENCES `volunteers` (`id`),
  ADD CONSTRAINT `campaign_volunteers_ibfk_2` FOREIGN KEY (`campaign_id`) REFERENCES `campaigns` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
