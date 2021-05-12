-- phpMyAdmin SQL Dump
-- version 4.4.10
-- http://www.phpmyadmin.net
--
-- Host: localhost:3306
-- Generation Time: Mar 25, 2019 at 03:25 AM
-- Server version: 5.5.42
-- PHP Version: 5.6.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `amplify`
--

-- --------------------------------------------------------

--
-- Table structure for table `accepted_interest`
--

CREATE TABLE `accepted_interest` (
  `accepted_interest_id` int(11) NOT NULL,
  `youtuber_id` varchar(21) NOT NULL,
  `campaign_id` int(11) NOT NULL,
  `message` varchar(1000) NOT NULL,
  `date_interested` datetime NOT NULL,
  `submission_status_id` int(11) NOT NULL,
  `withvideo` int(11) DEFAULT '0',
  `israted` int(11) DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `accepted_interest`
--

INSERT INTO `accepted_interest` (`accepted_interest_id`, `youtuber_id`, `campaign_id`, `message`, `date_interested`, `submission_status_id`, `withvideo`, `israted`) VALUES
(1, '117671937129903037593', 1, 'I''m interested', '2019-01-28 03:32:21', 3, 1, 1),
(4, '117671937129903037593', 5, 'Lemme join!', '2019-02-07 22:22:04', 1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `activity_log_businessman`
--

CREATE TABLE `activity_log_businessman` (
  `activity_log_id` int(11) NOT NULL,
  `activity` varchar(4000) NOT NULL,
  `date_added` date NOT NULL,
  `businessman_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Triggers `activity_log_businessman`
--
DELIMITER $$
CREATE TRIGGER `update_campaign_deadline` BEFORE INSERT ON `activity_log_businessman`
 FOR EACH ROW UPDATE campaign
SET campaign.campaign_status_id = 2
WHERE campaign.campaign_deadline < CURRENT_DATE()
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_production_deadline` AFTER INSERT ON `activity_log_businessman`
 FOR EACH ROW UPDATE accepted_interest
SET accepted_interest.submission_status_id = 3
WHERE accepted_interest.submission_status_id != 1 AND CURRENT_DATE() > (SELECT campaign.production_deadline FROM campaign WHERE accepted_interest.campaign_id = campaign.campaign_id)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `admin_id` int(11) NOT NULL,
  `username` varchar(4000) NOT NULL,
  `password` varchar(4000) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`admin_id`, `username`, `password`) VALUES
(1, 'admin', 'admin');

-- --------------------------------------------------------

--
-- Table structure for table `advertising_details`
--

CREATE TABLE `advertising_details` (
  `advertising_details_id` int(11) NOT NULL,
  `detail` varchar(1000) NOT NULL,
  `campaign_id` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `advertising_details`
--

INSERT INTO `advertising_details` (`advertising_details_id`, `detail`, `campaign_id`) VALUES
(1, 'Put it back', 1),
(6, 'Open 1', 3),
(7, 'Open 3', 3),
(8, 'Open 2', 3),
(9, 'Open 4', 3),
(10, 'Open 2', 3),
(11, 'Open 1', 3),
(12, 'Open 3', 3),
(13, 'Open 2', 5),
(14, 'Open 3', 5),
(15, 'Open 1', 5),
(16, 'Open 4', 5);

-- --------------------------------------------------------

--
-- Table structure for table `businessman`
--

CREATE TABLE `businessman` (
  `businessman_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(100) NOT NULL,
  `business_name` text NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `email_address` text NOT NULL,
  `company_address` varchar(100) NOT NULL,
  `abouts` varchar(100) NOT NULL,
  `profile_picture` longtext NOT NULL,
  `date_added` date NOT NULL,
  `contact_number` text NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `businessman`
--

INSERT INTO `businessman` (`businessman_id`, `username`, `password`, `business_name`, `first_name`, `last_name`, `email_address`, `company_address`, `abouts`, `profile_picture`, `date_added`, `contact_number`) VALUES
(37, 'ace', '$2y$07$S56yEIZup5D/5RhwkRpkfek/E/JVPFjPs2VAM4ebcHu.rkdhGKPF6', 'Harold''s Hotel', 'Ace', 'Cerio', 'acecerio1@gmail.com', '450 Peace Valley Homes, Bulacao, Cebu City', 'Hey there!', '5baa0cce1eb34.png', '2018-09-25', '9566026047');

-- --------------------------------------------------------

--
-- Table structure for table `businessman_rating`
--

CREATE TABLE `businessman_rating` (
  `businessman_rating_id` int(11) NOT NULL,
  `engaging` int(11) NOT NULL,
  `credibility` int(11) NOT NULL,
  `impression` int(11) NOT NULL,
  `action_oriented` int(11) NOT NULL,
  `significance` int(11) NOT NULL,
  `integrated` int(11) NOT NULL,
  `brand_service` int(11) NOT NULL,
  `brand_innovation` int(11) NOT NULL,
  `brand_quality` int(11) NOT NULL,
  `accepted_interest_id` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `businessman_rating`
--

INSERT INTO `businessman_rating` (`businessman_rating_id`, `engaging`, `credibility`, `impression`, `action_oriented`, `significance`, `integrated`, `brand_service`, `brand_innovation`, `brand_quality`, `accepted_interest_id`) VALUES
(1, 8, 9, 8, 10, 8, 8, 0, 8, 10, 1),
(4, 10, 10, 10, 10, 10, 10, 0, 10, 10, 4);

-- --------------------------------------------------------

--
-- Table structure for table `campaign`
--

CREATE TABLE `campaign` (
  `campaign_id` int(11) NOT NULL,
  `businessman_id` int(11) NOT NULL,
  `project_name` varchar(100) NOT NULL,
  `starting_budget` int(11) NOT NULL,
  `ending_budget` int(11) NOT NULL,
  `project_description` varchar(1000) NOT NULL,
  `campaign_deadline` date NOT NULL,
  `production_deadline` date NOT NULL,
  `video_duration` int(11) NOT NULL,
  `advertiser_needed` int(11) NOT NULL,
  `date_added` date NOT NULL,
  `category_id` int(11) NOT NULL,
  `campaign_status_id` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `campaign`
--

INSERT INTO `campaign` (`campaign_id`, `businessman_id`, `project_name`, `starting_budget`, `ending_budget`, `project_description`, `campaign_deadline`, `production_deadline`, `video_duration`, `advertiser_needed`, `date_added`, `category_id`, `campaign_status_id`) VALUES
(1, 37, 'Sample Product', 5000, 6000, 'Sample Product Description', '2018-10-06', '2018-10-10', 3, 1, '2018-10-04', 11, 3),
(3, 37, 'Sample Project 3', 7000, 18000, 'Sample project 3 has a description', '2019-02-09', '2019-02-12', 5, 4, '2019-02-07', 5, 1),
(5, 37, 'Sample Project 4', 5000, 8000, 'Sample Project 4 Description', '2019-02-12', '2019-02-21', 3, 5, '2019-02-07', 11, 1);

-- --------------------------------------------------------

--
-- Table structure for table `campaign_photo`
--

CREATE TABLE `campaign_photo` (
  `campaign_photo_id` int(11) NOT NULL,
  `campaign_id` int(11) NOT NULL,
  `photo` varchar(1000) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `campaign_photo`
--

INSERT INTO `campaign_photo` (`campaign_photo_id`, `campaign_id`, `photo`) VALUES
(1, 1, '5bb5b8dcd2f16.png'),
(4, 3, '5c5c32c4ee2c6.png'),
(5, 3, '5c5c32c501def.png'),
(6, 3, '5c5c3d8a574c6.png'),
(7, 5, '5c5c3ef1984b6.png');

-- --------------------------------------------------------

--
-- Table structure for table `campaign_status`
--

CREATE TABLE `campaign_status` (
  `campaign_status_id` int(11) NOT NULL,
  `status` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `campaign_status`
--

INSERT INTO `campaign_status` (`campaign_status_id`, `status`) VALUES
(1, 'On Going Campaign'),
(2, 'On Going Production'),
(3, 'Done');

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `category_id` int(11) NOT NULL,
  `category_name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`category_id`, `category_name`) VALUES
(1, 'Comedy'),
(2, 'Drama'),
(3, 'Education'),
(4, 'Entertainment'),
(5, 'Family'),
(6, 'Gaming'),
(7, 'Howto and Styles'),
(8, 'Music'),
(11, 'People and Blogs'),
(9, 'Sports'),
(10, 'Travel and Events');

-- --------------------------------------------------------

--
-- Table structure for table `criteria`
--

CREATE TABLE `criteria` (
  `criteria_id` int(11) NOT NULL,
  `criteria_name` varchar(1000) NOT NULL,
  `criteria_percentage` double NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `criteria`
--

INSERT INTO `criteria` (`criteria_id`, `criteria_name`, `criteria_percentage`) VALUES
(1, 'View Count', 0.7),
(2, 'Reaction Count', 0.2),
(3, 'Comment Count', 0.1),
(4, 'Engaging', 0.1),
(5, 'Credibility', 0.1),
(6, 'Impression', 0.1),
(7, 'Action Oriented', 0.1),
(8, 'Significance', 0.1),
(9, 'Integrated', 0.1),
(10, 'Brand Service', 0.1),
(11, 'Brand Innovation', 0.1),
(12, 'Brand Quality', 0.2);

-- --------------------------------------------------------

--
-- Table structure for table `mediakit`
--

CREATE TABLE `mediakit` (
  `id` int(11) NOT NULL,
  `youtuber_id` varchar(21) NOT NULL,
  `firstName` text NOT NULL,
  `lastName` text NOT NULL,
  `address` text NOT NULL,
  `contact_no` text NOT NULL,
  `youtubeCh` varchar(100) NOT NULL,
  `ig_ac` text NOT NULL,
  `fb_ac` text NOT NULL,
  `twitter_ac` text NOT NULL,
  `gender` text NOT NULL,
  `photoUrl` text NOT NULL,
  `date_added` datetime NOT NULL,
  `abouts` text NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `mediakit`
--

INSERT INTO `mediakit` (`id`, `youtuber_id`, `firstName`, `lastName`, `address`, `contact_no`, `youtubeCh`, `ig_ac`, `fb_ac`, `twitter_ac`, `gender`, `photoUrl`, `date_added`, `abouts`) VALUES
(2, '117671937129903037593', 'Ace Glicerio', 'Cerio', 'Bulacao, Cebu City', '9566026047', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'instagram.com/acecerio', 'facebook.com/acecerio', 'twitter.com/acecerio', 'Male', 'https://lh4.googleusercontent.com/-h7d_717BcUE/AAAAAAAAAAI/AAAAAAAACPM/zIoDvdJ7CO8/s96-c/photo.jpg', '2018-10-03 00:00:00', 'Hey there!'),
(3, '107428558023590518907', 'Arnold', 'Agura', 'Talisay, Cebu City', '8888702', 'UCzVJzbTxCFSFbjbpDQ1Yblg', 'instagram.com/arnold', 'facebook.com/arnold', 'twitter.com/arnold', 'Male', 'https://lh4.googleusercontent.com/-vxnXgykVfTk/AAAAAAAAAAI/AAAAAAAAG2Q/pkLgJb-PXUk/s96-c/photo.jpg', '2018-10-04 00:00:00', 'Hey there!');

-- --------------------------------------------------------

--
-- Table structure for table `mediakit_interest`
--

CREATE TABLE `mediakit_interest` (
  `mediakit_interest_id` int(11) NOT NULL,
  `interest` varchar(4000) NOT NULL,
  `id` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `mediakit_interest`
--

INSERT INTO `mediakit_interest` (`mediakit_interest_id`, `interest`, `id`) VALUES
(3, 'Basketball', 2),
(4, 'Volleyball', 2),
(5, 'Play Volleyball', 3),
(6, 'Play Dota', 3);

-- --------------------------------------------------------

--
-- Table structure for table `notification`
--

CREATE TABLE `notification` (
  `notif_id` int(11) NOT NULL,
  `user_img` longtext NOT NULL,
  `name` varchar(100) NOT NULL,
  `notif_subject` varchar(255) NOT NULL,
  `notif_msg` varchar(255) NOT NULL,
  `notif_to` varchar(21) NOT NULL,
  `notif_from` varchar(21) NOT NULL,
  `seen` tinyint(1) NOT NULL,
  `date_added` datetime NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `notification`
--

INSERT INTO `notification` (`notif_id`, `user_img`, `name`, `notif_subject`, `notif_msg`, `notif_to`, `notif_from`, `seen`, `date_added`) VALUES
(1, '//localhost/Amplify-API/api/uploads/profile/5baa0cce1eb34.png', 'Harold''s Hotel', '1', 'recommended you', '117671937129903037593', '37', 1, '2019-01-27 04:10:23'),
(2, '//localhost/Amplify-API/api/uploads/profile/5baa0cce1eb34.png', 'Harold''s Hotel', '1', 'recommended you', '117671937129903037593', '37', 1, '2019-01-27 04:18:40'),
(3, 'https://lh4.googleusercontent.com/-h7d_717BcUE/AAAAAAAAAAI/AAAAAAAACPM/zIoDvdJ7CO8/s96-c/photo.jpg', 'Ace Glicerio', '1', 'is interested', '37', '117671937129903037593', 1, '2019-01-28 03:32:21'),
(4, '//localhost/Amplify-API/api/uploads/profile/5baa0cce1eb34.png', 'Harold''s Hotel', '1', 'accepted your interest', '117671937129903037593', '37', 1, '2019-01-28 03:33:13'),
(5, 'https://lh4.googleusercontent.com/-h7d_717BcUE/AAAAAAAAAAI/AAAAAAAACPM/zIoDvdJ7CO8/s96-c/photo.jpg', 'Ace Glicerio', '2', 'is interested', '37', '117671937129903037593', 1, '2019-02-07 21:42:26'),
(6, 'http://amplify.smartstart.us/api/uploads/profile/5baa0cce1eb34.png', 'Harold''s Hotel', '2', 'accepted your interest', '117671937129903037593', '37', 1, '2019-02-07 21:44:50'),
(7, 'https://lh4.googleusercontent.com/-h7d_717BcUE/AAAAAAAAAAI/AAAAAAAACPM/zIoDvdJ7CO8/s96-c/photo.jpg', 'Ace Glicerio', '4', 'is interested', '37', '117671937129903037593', 1, '2019-02-07 22:16:57'),
(8, 'http://amplify.smartstart.us/api/uploads/profile/5baa0cce1eb34.png', 'Harold''s Hotel', '4', 'accepted your interest', '117671937129903037593', '37', 1, '2019-02-07 22:17:08'),
(9, 'https://lh4.googleusercontent.com/-h7d_717BcUE/AAAAAAAAAAI/AAAAAAAACPM/zIoDvdJ7CO8/s96-c/photo.jpg', 'Ace Glicerio', '5', 'is interested', '37', '117671937129903037593', 1, '2019-02-07 22:22:04'),
(10, 'http://amplify.smartstart.us/api/uploads/profile/5baa0cce1eb34.png', 'Harold''s Hotel', '5', 'accepted your interest', '117671937129903037593', '37', 1, '2019-02-07 22:22:20'),
(11, 'http://amplify.smartstart.us/api/uploads/profile/5baa0cce1eb34.png', 'Harold''s Hotel', '5', 'recommended you', '117671937129903037593', '37', 1, '2019-02-07 22:53:50'),
(12, 'http://amplify.smartstart.us/api/uploads/profile/5baa0cce1eb34.png', 'Harold''s Hotel', '5', 'recommended you', '117671937129903037593', '37', 1, '2019-02-07 22:53:53'),
(13, 'http://amplify.smartstart.us/api/uploads/profile/5baa0cce1eb34.png', 'Harold''s Hotel', '5', 'recommended you', '117671937129903037593', '37', 1, '2019-02-07 22:57:24'),
(14, 'http://amplify.smartstart.us/api/uploads/profile/5baa0cce1eb34.png', 'Harold''s Hotel', '5', 'recommended you', '117671937129903037593', '37', 1, '2019-02-07 22:57:26'),
(15, 'http://amplify.smartstart.us/api/uploads/profile/5baa0cce1eb34.png', 'Harold''s Hotel', '5', 'recommended you', '117671937129903037593', '37', 1, '2019-02-07 22:57:27');

-- --------------------------------------------------------

--
-- Table structure for table `recommendation`
--

CREATE TABLE `recommendation` (
  `recommendation_id` int(11) NOT NULL,
  `youtuber_id` varchar(21) NOT NULL,
  `category_id` int(11) NOT NULL,
  `points` double NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `recommendation`
--

INSERT INTO `recommendation` (`recommendation_id`, `youtuber_id`, `category_id`, `points`) VALUES
(1, '117671937129903037593', 1, 0),
(2, '117671937129903037593', 2, 0),
(3, '117671937129903037593', 3, 0),
(4, '117671937129903037593', 4, 0),
(5, '117671937129903037593', 5, 0),
(6, '117671937129903037593', 6, 0),
(7, '117671937129903037593', 7, 0),
(8, '117671937129903037593', 8, 0),
(9, '117671937129903037593', 9, 0),
(10, '117671937129903037593', 10, 0.000369280623087),
(11, '117671937129903037593', 11, 1.59566979156),
(12, '107428558023590518907', 1, 0),
(13, '107428558023590518907', 2, 0),
(14, '107428558023590518907', 3, 0),
(15, '107428558023590518907', 4, 0),
(16, '107428558023590518907', 5, 0),
(17, '107428558023590518907', 6, 0),
(18, '107428558023590518907', 7, 0),
(19, '107428558023590518907', 8, 0),
(20, '107428558023590518907', 9, 0),
(21, '107428558023590518907', 10, 0),
(22, '107428558023590518907', 11, 0);

-- --------------------------------------------------------

--
-- Table structure for table `submission_status`
--

CREATE TABLE `submission_status` (
  `submission_status_id` int(11) NOT NULL,
  `submission_status` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `submission_status`
--

INSERT INTO `submission_status` (`submission_status_id`, `submission_status`) VALUES
(1, 'Submitted'),
(2, 'On Going'),
(3, 'Late');

-- --------------------------------------------------------

--
-- Table structure for table `v2_accepted_interest`
--

CREATE TABLE `v2_accepted_interest` (
  `accepted_interest_id` int(11) NOT NULL,
  `youtuber_id` varchar(21) NOT NULL,
  `campaign_id` int(11) NOT NULL,
  `message` int(11) DEFAULT NULL,
  `date_interested` date DEFAULT NULL,
  `submission_status_id` int(11) NOT NULL,
  `israted` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `v2_accepted_interest`
--

INSERT INTO `v2_accepted_interest` (`accepted_interest_id`, `youtuber_id`, `campaign_id`, `message`, `date_interested`, `submission_status_id`, `israted`) VALUES
(1, '117671937129903037593', 1, NULL, NULL, 1, 1),
(2, '107428558023590518907', 2, NULL, NULL, 1, 1),
(3, '107428558023590518907', 3, NULL, NULL, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `v2_businessman_rating`
--

CREATE TABLE `v2_businessman_rating` (
  `businessman_rating_id` int(11) NOT NULL,
  `engaging` int(11) NOT NULL,
  `credibility` int(11) NOT NULL,
  `impression` int(11) NOT NULL,
  `action_oriented` int(11) NOT NULL,
  `significance` int(11) NOT NULL,
  `integrated` int(11) NOT NULL,
  `brand_service` int(11) NOT NULL,
  `brand_innovation` int(11) NOT NULL,
  `brand_quality` int(11) NOT NULL,
  `accepted_interest_id` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `v2_businessman_rating`
--

INSERT INTO `v2_businessman_rating` (`businessman_rating_id`, `engaging`, `credibility`, `impression`, `action_oriented`, `significance`, `integrated`, `brand_service`, `brand_innovation`, `brand_quality`, `accepted_interest_id`) VALUES
(1, 5, 8, 9, 10, 4, 6, 8, 8, 8, 1),
(2, 8, 9, 9, 7, 6, 8, 4, 6, 8, 2),
(3, 6, 5, 7, 8, 2, 7, 8, 8, 8, 3);

-- --------------------------------------------------------

--
-- Table structure for table `v2_video`
--

CREATE TABLE `v2_video` (
  `video_id` varchar(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `views_count` int(11) NOT NULL,
  `likes_count` int(11) NOT NULL,
  `dislikes_count` int(11) NOT NULL,
  `comments_count` int(11) NOT NULL,
  `date_accomplished` date DEFAULT NULL,
  `youtuber_id` varchar(21) NOT NULL,
  `accepted_interest_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `v2_video`
--

INSERT INTO `v2_video` (`video_id`, `category_id`, `views_count`, `likes_count`, `dislikes_count`, `comments_count`, `date_accomplished`, `youtuber_id`, `accepted_interest_id`) VALUES
('-J7bznreUsk', 1, 51757, 546, 28, 37, NULL, '107428558023590518907', NULL),
('0dxp5D0gr2o', 5, 11758, 241, 0, 22, NULL, '117671937129903037593', NULL),
('78Ow3fjkdAA', 7, 2345, 234, 22, 21, '2018-09-11', '107428558023590518907', 2),
('808Jew6VMug', 7, 48490, 772, 101, 136, NULL, '107428558023590518907', NULL),
('ajgu-6YvS4I', 3, 911, 14, 2, 3, NULL, '117671937129903037593', NULL),
('C1CD7epnmMQ', 1, 1276135, 14313, 466, 939, NULL, '117671937129903037593', NULL),
('d42sb6_Th14', 4, 562092, 7868, 119, 593, NULL, '101564480374644982161', NULL),
('dVhkM2UZ-1U', 1, 3104390, 15141, 1551, 1675, NULL, '117671937129903037593', NULL),
('DWYVtVgb5cM', 1, 1494665, 8534, 934, 1152, NULL, '117671937129903037593', NULL),
('IZnwxKXUsAo', 5, 14456, 492, 8, 95, NULL, '107428558023590518907', NULL),
('Lxu6LQnGODo', 2, 1222582, 6671, 355, 504, NULL, '117671937129903037593', NULL),
('mRmHDeyDE1w', 8, 22478, 610, 4, 74, NULL, '101564480374644982161', NULL),
('oQ-K7tXwrA4', 1, 415692, 25770, 213, 4791, '2018-02-10', '117671937129903037593', 1),
('OUsre0i7Oz8', 1, 20648, 425, 3, 45, NULL, '107428558023590518907', NULL),
('RNPnxxyjpyA', 1, 1129556, 54210, 253, 5176, NULL, '101564480374644982161', NULL),
('ssb1LLSgzxY', 7, 20680, 724, 15, 117, '2018-09-11', '107428558023590518907', 3),
('to_Lch68PqQ', 1, 940728, 31723, 273, 3953, NULL, '101564480374644982161', NULL),
('Wi4WUCbBepg', 7, 129400, 3933, 63, 465, NULL, '117671937129903037593', NULL),
('WSlsYr3kk_g', 4, 1311042, 58166, 473, 13713, NULL, '101564480374644982161', NULL),
('ZYuSmswsl0E', 4, 562113, 20093, 874, 5788, NULL, '101564480374644982161', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `v2_youtube_data`
--

CREATE TABLE `v2_youtube_data` (
  `youtube` int(11) NOT NULL,
  `videoId` varchar(25) NOT NULL,
  `category_id` int(11) NOT NULL,
  `likeCount` int(11) NOT NULL,
  `dislikeCount` int(11) NOT NULL,
  `commentCount` int(11) NOT NULL,
  `viewCount` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `v2_youtube_data`
--

INSERT INTO `v2_youtube_data` (`youtube`, `videoId`, `category_id`, `likeCount`, `dislikeCount`, `commentCount`, `viewCount`) VALUES
(1, 'Comedy', 1, 472947, 47857, 15307, 83605128),
(2, 'Drama', 2, 139876, 4242, 6399, 18599427),
(3, 'Education', 3, 1439227, 57381, 57157, 320432364),
(4, 'Entertainment', 4, 3289518, 126196, 440242, 192182891),
(5, 'Family', 5, 1113938, 618583, 216113, 800560640),
(6, 'Gaming', 6, 323919, 17526, 41176, 39139594),
(7, 'Howto and Styles', 7, 1286858, 45661, 227578, 49272431),
(8, 'Music', 8, 7009246, 473790, 423667, 1202090641),
(9, 'Sports', 9, 4120626, 128459, 592738, 160538744),
(10, 'Travel and Events', 10, 403506, 63898, 79850, 62359380),
(11, 'People and Blogs', 11, 2239624, 453403, 353253, 678615208),
(12, 'Comedy', 1, 0, 9, 0, 1235),
(13, 'Drama', 2, 2, 3, 0, 4390),
(14, 'Education', 3, 0, 0, 0, 308),
(15, 'Entertainment', 4, 0, 0, 0, 0),
(16, 'Family', 5, 0, 0, 0, 0),
(17, 'Gaming', 6, 2, 1, 4, 5752),
(18, 'Howto and Styles ', 7, 0, 0, 0, 367),
(19, 'Music', 8, 0, 0, 0, 194),
(20, 'Sports', 9, 0, 0, 0, 548),
(21, 'Travel and Events', 10, 0, 0, 0, 66),
(22, 'People and Blogs', 11, 0, 0, 0, 167);

-- --------------------------------------------------------

--
-- Table structure for table `video`
--

CREATE TABLE `video` (
  `video_id` varchar(11) NOT NULL,
  `video_title` varchar(4000) NOT NULL,
  `video_description` varchar(4000) NOT NULL,
  `channel_id` varchar(40) NOT NULL,
  `channel_title` varchar(4000) NOT NULL,
  `category_id` int(11) NOT NULL,
  `default_thumbnail` varchar(4000) NOT NULL,
  `views_count` int(11) NOT NULL,
  `likes_count` int(11) NOT NULL,
  `dislikes_count` int(11) NOT NULL,
  `comments_count` int(11) NOT NULL,
  `date_accomplished` date DEFAULT NULL,
  `youtuber_id` varchar(21) NOT NULL,
  `accepted_interest_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `video`
--

INSERT INTO `video` (`video_id`, `video_title`, `video_description`, `channel_id`, `channel_title`, `category_id`, `default_thumbnail`, `views_count`, `likes_count`, `dislikes_count`, `comments_count`, `date_accomplished`, `youtuber_id`, `accepted_interest_id`) VALUES
('-dFLdTIr0hI', 'HOW TO USE CHOPSTICKS AT KPUB BBQ CEBU PLUS AISAKU, SHARLLA CERILLES PERFORMANCES!!!', 'I''ve been eating a lot of korean food yet I don''t know how to properly use chopsticks! Hence, in this video, we will be learning how to do it with my blogger friend - Dannea!\n\nAlso, we got some special performances from Japanese OPM artist - Aisaku and The Voice Kids Season 2 Artist - Sharlla Cerilles. BONUS PERFORMANCE FROM THE ONE AND ONLY CJ ESTRADA HAHAHAHAHAHA\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/iamcjestrada\nTwitter: https://twitter.com/iamcjestrada_\nInstagram: https://instagram.com/iamcjestrada\nBlog: https://www.foureyedlaagan.com\n\nGadgets Used:\n\nCamera: Panasonic Lumix G7 - https://bit.ly/CJEstradalumixg7\nMicrophone: Rode Video Micro - https://bit.ly/CJEstradaRodeMicro\nGorilla Pod: CDR-King gorilla pod - https://bit.ly/CJEstradaGorillaPod\n\nEditor:\nAdobe Premier Pro\n\n#NoSmallCreator', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/-dFLdTIr0hI/default.jpg', 165, 17, 0, 28, NULL, '117671937129903037593', NULL),
('-HqxgGDm6YE', 'AM I CUTE ENOUGH? | Cebu in Focus 2 | VLOG 53', 'And I just turned into a Pikachu! Hahaha! Am I cute enough? Hahaha!\n\nMe and my vlogger buddies Skip the Flip and Kevin Durano recently went to Cebu in Focus 2 sponsored by Henry''s Professional that promoted and conducted FREE photography and videography workshops. It was participated by several photographers and photo enthusiast that were eager to enhance their skills and knowledge in photography.\n\nI also joined Canon PH''s contest to win a Canon EOS M10 camera and a Selphy Photo Printer by wearing a Pikachu costume and posting it on Social Media. And luckily, I won the photo printer! Yay!\n\nThank you very much Henry''s Professional and Canon PH!\n\nAlso special thanks to Totem Magallano of http://www.totemgineer.com for letting me borrow his pikachu onesie! ????\n\nSubscribe to the channels of my buddies:\n\nSkip the Flip - https://www.youtube.com/user/flippy0721\n\nKevin Durano - https://www.youtube.com/channel/UC4vVM_Y6QeXo0-BewQzwQgw\n\n#cebuinfocus2 #eosM10adventure #toytravelincebuincebuinfocus2017 #TeamCanonPH\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down below your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nFacebook: https://facebook.com/foureyedlaagan\nTwitter: https://twitter.com/foureyedlaagan\nInstagram: https://instagram.com/foureyedlaagan\nBlog: http://www.foureyedlaagan.com\n\nMusic credits:\nAhxello - Levitate\nLauren Alaina - Painting Pillows\nSugar Zone - Silent Partner\n\nTHANK YOU!!!', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/-HqxgGDm6YE/default.jpg', 174, 20, 0, 31, NULL, '117671937129903037593', NULL),
('-VfwVw9Aotw', 'HIDEAWAY DIVE HOSTEL // AN AWESOME PLACE TO ESCAPE REALITY (Mactan, Cebu)', 'The only dive hostel in Mactan, Cebu - Hideaway Dive Hostel is a one stop shop for you to enjoy and learn diving and get to chill and stay for a night at the hostel.\n\nVisit Hideaway Dive Hostel on Facebook:\nhttps://facebook.com/hideawaydivehostel\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down on your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/iamcjestrada\nTwitter: https://twitter.com/iamcjestrada_\nInstagram: https://instagram.com/iamcjestrada\nBlog: https://www.foureyedlaagan.com\n\nGadgets Used:\n\nCamera: Panasonic Lumix G7 - https://bit.ly/CJEstradalumixg7\nMicrophone: Rode Video Micro - https://bit.ly/CJEstradaRodeMicro\nGorilla Pod: Joby Gorillapod 3K Set - http://bit.ly/Joby3KGorillaPod\n\nEditor:\nAdobe Premiere Pro', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/-VfwVw9Aotw/default.jpg', 228, 17, 0, 10, NULL, '117671937129903037593', NULL),
('-vLLr5AIxfA', 'I''M TIRED OF VLOGGING! | SPARTAN TRAIL W/ TEAM BANG | VLOG 72', 'Laspag trek ever!! Haha!! This was our 13-hour route:\n\nBanawa-Good Shepperd-Spartan Trail-Pamutan Trail-Bocaue Peak-Babag-Mountain View-Mang Inasal!!!\n\nThanks Bisaya Traveler, Kev Incredible and the rest the Team Bang for the invite!\n\nFollow these guys on Instagram:\n\nBisaya Traveler - https://instagram.com/bisayatraveler\n\nKev Incredible (barefoot guy) - https://instagram.com/kev.incredible\n\nThe Weekday Traveler - https://instagram.com/theweekdaytraveler\n\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down below your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nFacebook: https://facebook.com/foureyedlaagan\nTwitter: https://twitter.com/foureyedlaagan\nInstagram: https://instagram.com/foureyedlaagan\nBlog: http://www.foureyedlaagan.com\n\nTHANK YOU!!!', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/-vLLr5AIxfA/default.jpg', 727, 28, 0, 27, NULL, '117671937129903037593', NULL),
('0IKEHWAP-N0', 'BIRTHDAY PRESENT CAME REALLY EARLY!!! | VLOG 94', 'And my birthday present came really early!!! Hahaha! Thank you self, sweldo and 13th month! Hahaha!\n\nEdited using iMovie app in iPhone 6s thus might be the reason why the video for the G7 deteriorated. Imma try it on PC next time! ????\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down below your thoughts and questions and I''d be happy to read them all! \n\nOrder #FourEyedMerch NOW!: https://www.foureyedlaagan.com/foureyedmerch\n\nGadgets used:\n\nCamera (iPhone 6s) - https://goo.gl/yhwsPX\nGorilla Pod: https://goo.gl/Do1DPW\nBuy your gadgets here: https://goo.gl/LYf5Ne\n\nLet''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/foureyedlaagan\nTwitter: https://twitter.com/foureyedlaagan\nInstagram: https://instagram.com/foureyedlaagan\nBlog: https://www.foureyedlaagan.com', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/0IKEHWAP-N0/default.jpg', 343, 27, 1, 62, NULL, '117671937129903037593', NULL),
('1-6sSfL8TQ0', 'Enchanting Malubog Lake and Falls + Tagaytay Hill! | VLOG 36', 'One of the most enchanting beauty of Toledo City, Cebu - Malubog Lake + Falls and Tagaytay Hill. I was mesmerized by its beauty and silenced with its serenity.\n\nThis vlog is different from my usual vlogs because I wasn''t so wacky here. We were advised to behave especially near the lake because of some myths of a giant octopus or locally known as "Mantaga" that''s living underneath. But behold and be amazed by its wonder!\n\nVisit my blog for complete details, itinerary and expenses for this adventure:\n\nhttp://www.foureyedlaagan.com/2017/04/28/malubog-lake-falls-tagaytay-hills-toledo-city/\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down below your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nFacebook: facebook.com/foureyedlaagan\nTwitter: twitter.com/foureyedlaagan\nInstagram: instagram.com/foureyedlaagan\nBlog: www.foureyedlaagan.com\n\nMusic Credits:\nDJ Quads\nA Himitsu\nAnikdotes\n\nTHANK YOU!!!', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/1-6sSfL8TQ0/default.jpg', 2704, 28, 4, 37, NULL, '117671937129903037593', NULL),
('2pZpcBtHVR0', 'FINEST STAYCATION!!! | Mezzo Hotel Cebu | VLOG 58', 'The #bloggerkigwas just had a hell of staycation! watch our unforgettable experience in the hotel and a quick tour to Mezzo''s rooms and facilities. Also, we were so full with sumptuous food during our dinner and breakfast at Cafe Mezzo. Food are surely heavenly and the people are so accommodating and friendly.\n\nFull experience coming up soon at http://www.foureyedlaagan.com!\n\nSpecial thanks to Mezzo Hotel for this sponsored and amazing weekend!\n\nFollow Mezzo Hotel at Facebook:\nhttps://www.facebook.com/mezzohotelcebu/\n\nAlso subscribe to the channels of the blogger kigwas:\n\nSkip the Flip: https://www.youtube.com/user/flippy0721\nBean in Transit: https://www.youtube.com/channel/UCAy4lSY_ekIdBZJ4DW-3CfQ\n\nMusic Credits:\nDJ Quads - First\nDJ Quads - Legend\nDJ Quads - Stop\nJoakim Karud - Great Days\nNicolai Hedlas - The Land of Happiness\nSophomore Makeout - The Silent Partner\n\nTHANK YOU!!!!!!!', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/2pZpcBtHVR0/default.jpg', 1069, 30, 2, 39, NULL, '117671937129903037593', NULL),
('2zAuANHpiH8', 'Garleth and El-El Pre-nuptials', 'I do not own anything. No copyright infringement intended.', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/2zAuANHpiH8/default.jpg', 177, 1, 0, 0, NULL, '117671937129903037593', NULL),
('37vBOwo6S_s', 'PINOY LOST IN UNIVERSAL STUDIOS SINGAPORE! | VLOG 77', 'Universal Studios Singapore - the place we should not miss when visiting Singapore!\n\nIt was amazing even though I''m solo. It''s not bad at all and it was FUN vlogging when nobody knows you HAHA\n\nRead FULL Story in my blog: http://www.foureyedlaagan.com/2017/09/13/universal-studios-singapore-enjoying-rides-im-solo/\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down below your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nFacebook: https://facebook.com/foureyedlaagan\nTwitter: https://twitter.com/foureyedlaagan\nInstagram: https://instagram.com/foureyedlaagan\nBlog: http://www.foureyedlaagan.com\n\nTHANK YOU!!!', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/37vBOwo6S_s/default.jpg', 470, 23, 2, 24, NULL, '117671937129903037593', NULL),
('3dRuInEuMIg', 'Beautiful Beach and Eating Tago-Angkan! | Traveling Bantayan Part 1 | VLOG 37', 'I had an amazing vacation at Bantayan. Special thanks to Chasing Potatoes for accommodating me on their house and joining me touring the island.\n\nFollow her blog at www.chasingpotatoes.com\n\nCheck out my blog for details reaction and taste of Tago-angkan here: \n\nhttp://www.foureyedlaagan.com/2017/04/25/eating-tago-angkan-wasay-wasay-bantayan-first-time/\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down below your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nFacebook: facebook.com/foureyedlaagan\nTwitter: twitter.com/foureyedlaagan\nInstagram: instagram.com/foureyedlaagan\nBlog: www.foureyedlaagan.com\n\nTHANK YOU!!!', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/3dRuInEuMIg/default.jpg', 1180, 32, 0, 49, NULL, '117671937129903037593', NULL),
('3Eg6HYYme7o', '#MatteoMadeInCebu: Secret Love Song', '#MatteoMadeInCebu concert in Waterfront Hotel, Lahug, Cebu City\n\nSpecial thanks to #PLDTHomeDSL for the sponsored ticket.\n\nFollow me on social media:\nFacebook: facebook.com/foureyedlaagan\nTwitter: twitter.com/foureyedlaagan\nInstagram: instagram.com/foureyedlaagan\nBlog: https://foureyedlaagan.com', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/3Eg6HYYme7o/default.jpg', 369, 0, 0, 0, NULL, '117671937129903037593', NULL),
('3gX5Litk694', 'WE DON''T WANNA GO HOME! | Last Day of #Gensanventure | VLOG 52', 'And every happy moments must end...\n\nIt''s the last day of our amazing General Santos-South Cotabado adventure and let''s look back on what happened before we went home to Cebu. Welcome back to reality!!!\n\nSpecial thanks to our sponsors making this trip possible!\n\nPinobreTel Suites - https://www.facebook.com/pinobretelsuites\n\nPinobre Beach Resort - https://www.facebook.com/PinobreBeachResort/\n\nRanchero Group of Restaurants - https://www.facebook.com/rancherogroup1\n\nASUS Philippines - https://www.facebook.com/ASUSph\n\nSubscribe to my friends'' channels:\n\nSkip the Flip - https://www.youtube.com/user/flippy0721\n\nBean in Transit - https://www.youtube.com/channel/UCAy4lSY_ekIdBZJ4DW-3CfQ\n\nPlease don''t forget to hit like and subscribe!!! #gensanventures #pinobretelsuites\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down below your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nFacebook: https://facebook.com/foureyedlaagan\nTwitter: https://twitter.com/foureyedlaagan\nInstagram: https://instagram.com/foureyedlaagan\nBlog: http://www.foureyedlaagan.com\n\nTHANK YOU!!!', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/3gX5Litk694/default.jpg', 133, 12, 0, 6, NULL, '117671937129903037593', NULL),
('3hQTHAimnAU', 'Bocaue Peak - A Day Trek of Muddy and Lost Trail', 'Day trek is always fun - especially when you get lost in a muddy and unestablished! Get lost and be found with nature in Bocaue Peak, Bonbon, Cebu City.\n\nLet''s talk in my other accounts!\nFacebook: facebook.com/foureyedlaagan\nTwitter: twitter.com/foureyedlaagan\nInstagram: instagram.com/foureyedlaagan\nBlog: foureyedlaagan.com', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/3hQTHAimnAU/default.jpg', 546, 12, 0, 24, NULL, '117671937129903037593', NULL),
('48Hqznc-Uy0', 'Valentines sa mga BITTER | VLOG 24', 'Apir sa mga single ug mga ting-bits sa pag-celebrate sa Valentines Day!!! Spread the ??????!!!\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down below your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nFacebook: facebook.com/foureyedlaagan\nTwitter: twitter.com/foureyedlaagan\nInstagram: instagram.com/foureyedlaagan\nBlog: www.foureyedlaagan.com\n\nTHANK YOU!!!', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/48Hqznc-Uy0/default.jpg', 168, 14, 0, 24, NULL, '117671937129903037593', NULL),
('4Az38OzUjGM', 'WE BROKE THE INFINITY SWING! (Bacalla Woods Campsite, San Fernando, Cebu)', 'It was all an accident and we did not expect that to happen!!!\n\nCheck out our fun experience for a chill and flippin'' camping at Bacalla Woods Campsite only at San Fernando, Cebu City)\n\nHOW TO GO THERE?\n\n1. From Cebu City, ride a bus going to San Fernando at Cebu South Terminal\n2. Then disembark at Pitalo Church\n3. Then get a motorcycle taxi going straight to Bacalla Woods Campsite\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down on your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/iamcjestrada\nTwitter: https://twitter.com/iamcjestrada_\nInstagram: https://instagram.com/iamcjestrada\nBlog: https://www.foureyedlaagan.com\n\nGadgets Used:\n\nCamera: Panasonic Lumix G7 - https://bit.ly/CJEstradalumixg7\nMicrophone: Rode Video Micro - https://bit.ly/CJEstradaRodeMicro\nGorilla Pod: CDR-King gorilla pod - https://bit.ly/CJEstradaGorillaPod\n\nEditor:\nAdobe Premier Pro', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/4Az38OzUjGM/default.jpg', 2842, 81, 1, 46, NULL, '117671937129903037593', NULL),
('4s9TwSrk8tQ', 'WIN THESE AMAZING ITEMS! | LAZADA ONLINE REVOLUTION SALE ON NOV 9 TO 11 | VLOG 90', 'HEADS UP! Lazada Philippines will be having the #LazadaRevolution Sale offering great deals and big discounts of up to 95%!!!\n\nBecause I had so much fun during the Lazada Affiliate Roadshow last Nov 6, I will be GIVING AWAY some goodies displayed in the thumbnail!! \n\nMECHANICS:\n1. Like and share this YouTube video on Facebook with hashtags: #LazadaRevolution #Nov9to11 #ShopTheUniverse #CJLazadaGiveaway\n2. Make sure your Facebook post is in PUBLIC.\n3. SUBSCRIBE to my YouTube channel: https://youtube.com/CJEstrada\n4. Comment your thoughts in the YouTube video (because sometimes, I couldn’t see your post in Facebook even if it’s in public)\n5. CEBU only.\n6. Giveaway period: November 7 to November 9, 2017; 8:00 PM\n7. 1 Winner will be announced November 9th, 10:00 PM in my Facebook Page.\n\nGood luck and Thank You!!\n\nGadgets used:\n\nCamera (iPhone 6s) - https://goo.gl/yhwsPX\nGorilla Pod: https://goo.gl/Do1DPW\nBuy your gadgets here: https://goo.gl/LYf5Ne', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/4s9TwSrk8tQ/default.jpg', 257, 20, 0, 18, NULL, '117671937129903037593', NULL),
('4SkhPtkZR9k', 'THE HILARIOUS "S" GAME WITH SABAW FRIENDS!', 'Perfect game for your friends during inuman time and camping!!\n\nCheck out my friends'' channel:\n\nWellbein Borja - https://youtube.com/wellbeinborja\n\nMerc C''zar - https://www.youtube.com/user/GuvonliebeMurk21\n\nThe Lykwatsera - Lykwatseratravelstories.blogspot.com\n\nLet''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/iamcjestrada\nTwitter: https://twitter.com/iamcjestrada_\nInstagram: https://instagram.com/iamcjestrada\nBlog: https://www.foureyedlaagan.com\n\nGadgets Used:\n\nCamera: Panasonic Lumix G7 - https://bit.ly/CJEstradalumixg7\nMicrophone: Rode Video Micro - https://bit.ly/CJEstradaRodeMicro\nGorilla Pod: Joby Gorillapod 3K Kit - http://bit.ly/Joby3KGorillaPod\n\nEditor:\nAdobe Premiere Pro', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/4SkhPtkZR9k/default.jpg', 160, 16, 0, 11, NULL, '117671937129903037593', NULL),
('5lLJbhMw65c', 'WHAT''S THE BEST PART OF LECHON??? | RICO''S LECHON | VLOG 62', 'BEST PART OF THE VLOG??? KAINAN NAHH!! Stress eating tayo sa Rico''s Lechon mga bes!!\n\nCOMMENT DOWN YOUR ANSWER ON WHAT''S THE BEST PART OF LECHON with #TeamRibs #TeamPanit or #TeamUnod! Hahaha!\n\nThank you Rico''s Lechon for the sumptuous dinner and congratulations for winning the Silver Award in the Stevie Awards 2017. #DaBestGyud!', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/5lLJbhMw65c/default.jpg', 215, 13, 0, 23, NULL, '117671937129903037593', NULL),
('6VtzwnAbZhQ', 'REACTING TO MY FIRST VLOG!', 'Because I haven’t recently traveled, I decided to watch my cringey early vlogs. I know they’re not good and it always makes me laugh watching it.\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down below your thoughts and questions and I''d be happy to read them all! \n\nOrder #FourEyedMerch NOW!: https://www.foureyedlaagan.com/foureyedmerch\n\nLet''s stay connected!\n\nFacebook: https://facebook.com/foureyedlaagan\nTwitter: https://twitter.com/foureyedlaagan\nInstagram: https://instagram.com/foureyedlaagan\nBlog: https://www.foureyedlaagan.com', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/6VtzwnAbZhQ/default.jpg', 214, 18, 0, 15, NULL, '117671937129903037593', NULL),
('73uYXWXpiTI', 'THE EARTH IS OUR HOME BUT WHAT HAVE WE DONE?', 'Earth Day 2018 Special: We love to travel and enjoy the nature but our home is dying because of the irresponsibility of the people. Let us practice the #LeaveNoTrace principle and help save the environment.\n\nThank you to all who contributed in making this video possible.\n\nDrone video credits:\nMartin Tabanag - https://youtube.com/martintabanag\nLouis Brian - https://instagram.com/bryehero\n\nMy friends who love to travel:\nChasing Potatoes - https://chasingpotatoes.com/\nVernon Go - http://www.vernongo.com/\nWandering Feet PH - https://wanderingfeetph.com/\nMartin Tabanag - https://youtube.com/martintabanag\nLaag Sparkles - https://laagsparkles.wordpress.com/\nRam of Destination Dream - https://facebook.com/teamdndm\nReymund Requina - https://idolwandererblog.wordpress.com/\nKarl Olivier - https://kotheexplorer.com/\nFerna Fernandez - https://www.everywherewithferna.com/\nDoi Domasan - https://thetravellingfeet.com/\nGian Jubela and Shiela Mei of Adrenaline Romance - https://adrenalineromance.com/\nRogelio Gabiano Jr. - http://www.pinoytravelfreak.com/\nEdgar Alan Zeta-Yap - http://eazytraveler.net/\n\nSpecial Thanks to Johanna Frejoles (https://beanintransit.com/) for proofreading and editing the script for this video.\n\nCheck out #LeaveNoTrace website for more details: https://lnt.org\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down on your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/iamcjestrada\nTwitter: https://twitter.com/iamcjestrada_\nInstagram: https://instagram.com/iamcjestrada\nBlog: https://www.foureyedlaagan.com\n\nGadgets Used:\n\nCamera: Panasonic Lumix G7 - https://bit.ly/CJEstradalumixg7\nMicrophone: Rode Video Micro - https://bit.ly/CJEstradaRodeMicro\nGorilla Pod: Joby Gorillapod 3K Set - http://bit.ly/Joby3KGorillaPod\n\nEditor:\nAdobe Premiere Pro\n\nMusic Credits:\n\nA Himitsu - Two Places\nBeach Buggy Ride - Sirprice\nAs We Go', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/73uYXWXpiTI/default.jpg', 197, 22, 0, 39, NULL, '117671937129903037593', NULL),
('7dBwk6BMYAA', 'EARLY 4TH OF JULY CELEB + YOUTUBERS MEETUP | MARRIOTT HOTEL | VLOG 66', 'Many things happened today.\n\nFIRST. We got to have a mini-meetup with fellow Cebu YouTubers and it was fun getting to know them and sharing tips and ideas.\n\nSECOND. We hopped into a dinner buffet at Cebu City Marriot Hotel for early celebration of 4th of July.\n\nTHIRD. We had a short party at the poolside of Marriot Hotel and enjoyed the DJ and some beer pong (not included in the vlog)\n\nThe 4th of July - American Independence Day Dinner Buffet is available at Php 1,600 net per person. You can also check out Cebu City Marriott Hotel''s page for more information or call 411-5800 for reservations.\n\nPlease subscribe on the channels of theeesseee amazing YouTubers:\n\nMartin Tabanag - https://www.youtube.com/user/martinlouis99\nWellbein Borja - https://www.youtube.com/channel/UCMRWphZv5OzqXNfPJ8fEIWg\nWanna Bees - https://www.youtube.com/channel/UCio7-yUGz2_ymY1Mupouevg\nJive Bedonia - https://www.youtube.com/user/0Feedback1\nMadibeats - https://www.youtube.com/user/madisongallentes1\nTara the Snap Vlogger - https://www.youtube.com/channel/UCvZ1FDozSxFjnalJ9F9rkWw\nRamzy Rizzle - https://www.youtube.com/user/RamzyRizzle\nKalami Cebu - https://www.youtube.com/channel/UCaggFZp28MnvMCr8zGCAXlA\nAldrincore Moshpit - https://www.youtube.com/channel/UCiEx8uvlOJI9vrhGqdAWZVA\nUtterly Random Techie - https://www.youtube.com/channel/UCTvnDnRTjNsmWWsuKbL1ZxA\n\nAlso, like the page of my favorite local band, FOUR TUNES!!\n\nhttps://www.facebook.com/FourTunesCebu/\n\nTHANK YOU!!!!', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/7dBwk6BMYAA/default.jpg', 134, 15, 0, 20, NULL, '117671937129903037593', NULL),
('7rFll3_lWy4', 'STRANDED IN DAPITAN CITY (Storm Agaton)', 'RAW VLOG 102: STRANDED IN DAPITAN CITY (Storm Agaton)\n\nOur trips were still not sure if it is canceled or pushed through because of Tropical Storm Agaton in Dapitan City, Philippines. So instead of exploring the city that morning, I chose to stay at the seaport and wait for further updates.\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down on your thoughts and questions and I''d be happy to read them all! \n\nOrder #FourEyedMerch NOW!: https://www.foureyedlaagan.com/fourey...\n\nLet''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/foureyedlaagan\nTwitter: https://twitter.com/foureyedlaagan\nInstagram: https://instagram.com/foureyedlaagan\nBlog: https://www.foureyedlaagan.com', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/7rFll3_lWy4/default.jpg', 205, 17, 0, 11, NULL, '117671937129903037593', NULL),
('7UwEZ3YBcDw', 'I LEFT MY CAMERA AND HERE''S WHAT HAPPENED (Doyscapade 3 at VILLA MARA)', 'Finally after a year, me and my college buddies were back on an epic #DOYscapade! We were at Villa Mara in Minglanilla, Cebu, and we spent the night with good food, good place and unlimited laughters!\n\nVlog 115.\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down on your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/iamcjestrada\nTwitter: https://twitter.com/iamcjestrada_\nInstagram: https://instagram.com/iamcjestrada\nBlog: https://www.foureyedlaagan.com\n\nGadgets Used:\n\nCamera: Panasonic Lumix G7 - https://bit.ly/CJEstradalumixg7\nMicrophone: Rode Video Micro - https://bit.ly/CJEstradaRodeMicro\nGorilla Pod: CDR-King gorilla pod - https://bit.ly/CJEstradaGorillaPod\n\nEditor:\nAdobe Premiere  Pro\n\nMusic Credits:\nDog and Pony Show - Silent Partner\nDog Park - Silent Partner\nBrain Trust - Silent Partner\nStory Teller - DJ Quads', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/7UwEZ3YBcDw/default.jpg', 336, 24, 0, 34, NULL, '117671937129903037593', NULL),
('8iZbg3TCLns', 'STRANDED IN BANTAYAN??? | Traveling Bantayan Part 3 | VLOG 40', '2nd day of my Bantayan trip and it was full of fun! But the day has ended and it was already dawn of Sunday, would I be stranded in Bantayan???\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down below your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nFacebook: facebook.com/foureyedlaagan\nTwitter: twitter.com/foureyedlaagan\nInstagram: instagram.com/foureyedlaagan\nBlog: www.foureyedlaagan.com\n\nTHANK YOU!!!', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/8iZbg3TCLns/default.jpg', 295, 17, 0, 17, NULL, '117671937129903037593', NULL),
('9eyc-RGjFB0', 'SPICY FOOD TRIP IN ILIGAN CITY | PALAPA & MORE | VLOG 88', 'When we are home, food trip is always on the go! This time, we had local dishes which includes maranao cuisine, balut and much more! It''s a day of munching indeed\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down below your thoughts and questions and I''d be happy to read them all! \n\nOrder #FourEyedMerch NOW!: https://www.foureyedlaagan.com/fourey...\n\nLet''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/foureyedlaagan\nTwitter: https://twitter.com/foureyedlaagan\nInstagram: https://instagram.com/foureyedlaagan\nBlog: https://www.foureyedlaagan.com', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/9eyc-RGjFB0/default.jpg', 2308, 39, 1, 39, NULL, '117671937129903037593', NULL),
('9kqc2UmPjqE', 'MY STORY FEATURED ON MARTIN TABANAG''S WHAT''S YOUR STORY (Reaction Video)', 'Chur the boys! Check out my reaction watching MY STORY being featured on fellow YouTuber and amazing filmmaker, Martin Tabanag, on his segment - #WhatsYourStory!\n\nCheck out the full video here: https://youtu.be/TgLG8wa2ST0\n\nDon''t forget to SUBSCRIBE to my boi - https://www.youtube.com/channel/UCofHpIZbDEKOh-Blevc1G9g\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down on your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/iamcjestrada\nTwitter: https://twitter.com/iamcjestrada_\nInstagram: https://instagram.com/iamcjestrada\nBlog: https://www.foureyedlaagan.com\n\nGadgets Used:\n\nCamera: Panasonic Lumix G7 - https://bit.ly/CJEstradalumixg7\nMicrophone: Rode Video Micro - https://bit.ly/CJEstradaRodeMicro\nGorilla Pod: CDR-King gorilla pod - https://bit.ly/CJEstradaGorillaPod\n\nEditor:\nAdobe Premiere Pro', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/9kqc2UmPjqE/default.jpg', 161, 16, 1, 24, NULL, '117671937129903037593', NULL),
('9mW8NRSE9KU', '#MatteoMadeInCebu: Hahasula with Kurt Flick', '#MatteoMadeInCebu concert in Waterfront Hotel, Lahug, Cebu City\n\nSpecial thanks to #PLDTHomeDSL for the sponsored ticket.\n\nFollow me on social media:\nFacebook: facebook.com/foureyedlaagan\nTwitter: twitter.com/foureyedlaagan\nInstagram: instagram.com/foureyedlaagan\nBlog: https://foureyedlaagan.com', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/9mW8NRSE9KU/default.jpg', 231, 2, 0, 0, NULL, '117671937129903037593', NULL),
('A-YYvkXyBPg', 'MIND BLOWN AT THE MIND MUSEUM (BGC, Taguig)', 'When I was in Manila, I was invited by my travel blogger friend and had a tour at the Mind Museum where I found it sooo nostalgic from my science tours during my childhood years.\n\nVisit Mind Museum at BGC, Taguig! Check out their site for more details:\nhttps://themindmuseum.org\n\nVlog 128.\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down on your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/iamcjestrada\nTwitter: https://twitter.com/iamcjestrada_\nInstagram: https://instagram.com/iamcjestrada\nBlog: https://www.foureyedlaagan.com\n\nGadgets Used:\n\nCamera: Panasonic Lumix G7 - https://bit.ly/CJEstradalumixg7\nMicrophone: Rode Video Micro - https://bit.ly/CJEstradaRodeMicro\nGorilla Pod: Joby Gorillapod 3K Set - http://bit.ly/Joby3KGorillaPod\n\nEditor:\nAdobe Premiere Pro', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/A-YYvkXyBPg/default.jpg', 873, 22, 1, 31, NULL, '117671937129903037593', NULL),
('adoN1dvIhFo', 'A Day Trek of First Times to Sirao Peak via Budlaan-Malubog | VLOG 35', 'Many things happened here:\n\nOur company had a trekking challenge inline with their fitness program and we had it on Sirao Peak via Budlaan-Malubog. Most of the group are first timers! They''re struggling yet they''re having super fun!\n\nI got tripped while running around Malubog Golf Course and my phone was dropped! ???? and\n\nThe heat of the sun was unforgivable yet provided us a stunning view of the mountains and city.\n\nFrequently Asked Questions for Sirao Peak: \n\nhttp://www.foureyedlaagan.com/2017/04/09/faqs-trekking-sirao-peak-mt-kan-irag/\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down below your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nFacebook: facebook.com/foureyedlaagan\nTwitter: twitter.com/foureyedlaagan\nInstagram: instagram.com/foureyedlaagan\n\nTHANK YOU!!!', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/adoN1dvIhFo/default.jpg', 1411, 22, 0, 29, NULL, '117671937129903037593', NULL),
('aI0AN2CN3JA', 'LIFE IN SINGAPORE | VLOG 76', 'Part 1.\n\nHectic schedule during my business trip in Singapore and I did my best to vlog everyday and here''s what happened!\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down below your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nFacebook: https://facebook.com/foureyedlaagan\nTwitter: https://twitter.com/foureyedlaagan\nInstagram: https://instagram.com/foureyedlaagan\nBlog: http://www.foureyedlaagan.com\n\nTHANK YOU!!!', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/aI0AN2CN3JA/default.jpg', 271, 20, 1, 20, NULL, '117671937129903037593', NULL),
('akRMgIfEjNk', 'HOME FOR VACATION!!! (Iligan City, Philippines)', 'VLOG 101: HOME FOR VACATION!!! (Iligan City, Philippines)\n\nFirst Vlog of the year and it''s all about my vacation in Iligan City! Swimming, eating, going to some places and fun times with my family!\n\nAnd it''s my first time doing this kind of video format, so if you like this video, please give this video a thumbs up and SHARE this with your friends.\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down on your thoughts and questions and I''d be happy to read them all! \n\nOrder #FourEyedMerch NOW!: https://www.foureyedlaagan.com/fourey...\n\nLet''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/foureyedlaagan\nTwitter: https://twitter.com/foureyedlaagan\nInstagram: https://instagram.com/foureyedlaagan\nBlog: https://www.foureyedlaagan.com', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/akRMgIfEjNk/default.jpg', 518, 27, 0, 27, NULL, '117671937129903037593', NULL),
('AoLUfpPpovI', 'IT HAPPENED AGAIN', 'My trip back to Cebu got cancelled again so it means more time to spend with the family!!! vlog 111\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down on your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/iamcjestrada\nTwitter: https://twitter.com/iamcjestrada_\nInstagram: https://instagram.com/iamcjestrada\nBlog: https://www.foureyedlaagan.com\n\nGadgets Used:\n\nCamera: Panasonic Lumix G7 - https://bit.ly/CJEstradalumixg7\nMicrophone: Rode Video Micro - https://bit.ly/CJEstradaRodeMicro\nGorilla Pod: CDR-King gorilla pod - https://bit.ly/CJEstradaGorillaPod\n\nEditor:\nAdobe Premier Pro', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/AoLUfpPpovI/default.jpg', 246, 18, 0, 24, NULL, '117671937129903037593', NULL),
('APM-jsn35y8', 'MALAPASCUA: A GLIMPSE OF PARADISE', 'Just recently had a relaxing trip at Malapascua Island. Check out a glimpse of what this paradise has to offer and be amazed by its beauty.\n\nMalapascua Budget Inn, the best and cheapest accommodation to stay in this island. Check out their page for more info:\n\nhttps://www.facebook.com/malapascuabudgetinn/\n\nTravel Guide ???????? https://www.foureyedlaagan.com/2017/10/06/malapascua-island-stay/\n\nMusic:\nDJ Quads - Wonderful World', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/APM-jsn35y8/default.jpg', 233, 13, 0, 12, NULL, '117671937129903037593', NULL),
('Ay2hahgMXNw', 'DANIEL MARSH JUST WATCHED MY VLOG!!! | VLOG 39', 'Fanboy activated! Hahaha! Finally got to meet one of my idols in YouTube world - Daniel Marsh - in Cebu!\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down below your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nFacebook: facebook.com/foureyedlaagan\nTwitter: twitter.com/foureyedlaagan\nInstagram: instagram.com/foureyedlaagan\nBlog: www.foureyedlaagan.com\n\nTHANK YOU!!!\n\nMusic by: DJ Quads', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/Ay2hahgMXNw/default.jpg', 1078, 82, 2, 113, NULL, '117671937129903037593', NULL),
('AZVEzyJF5Zk', 'BUWIS BUHAY RIDE SA HABAL-HABAL! | Travels By Omnia Bellus Part 2 | VLOG 46', 'This is day 2 of our round south weekend getaway made possible by excellent tour services of #TravelsByOmniaBellus!\n\nCheck out my blog for the details of this trip: http://www.foureyedlaagan.com/2017/05/24/8-destinations-awesome-cebu-south-adventure/\n\nInquire and book your travels now at #TravelsByOmniaBellus!\n\nhttps://www.facebook.com/travelsbyomniabellus/\n\nFollow the blogs of the people in this vlog:\n\nBisdak Explorer - http://thebisdakexplorer.blogspot.com\nChasing Potatoes - http://chasingpotatoes.com\nVivomigsgee - http://vivomigsgee.com\nEAZY Traveler - http://eazytraveler.net\nTracking Treasure - http://trackingtreasure.net\nFour-eyed Laagan - http://www.foureyedlaagan.com\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down below your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nFacebook: https://facebook.com/foureyedlaagan\nTwitter: https://twitter.com/foureyedlaagan\nInstagram: https://instagram.com/foureyedlaagan\nBlog: http://www.foureyedlaagan.com\n\nTHANK YOU!!!', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/AZVEzyJF5Zk/default.jpg', 708, 31, 0, 40, NULL, '117671937129903037593', NULL),
('BDe82UvV1B4', 'VIVA PIT SEÑOR! Sinulog 2017 Grand Parade and Fireworks! | VLOG 19', 'Sinulog is one of the grandest festivals in the Philippines. From colorful costumes, graceful dances and vivacious vibe, name it!\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down below your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nFacebook: facebook.com/foureyedlaagan\nTwitter: twitter.com/foureyedlaagan\nInstagram: instagram.com/foureyedlaagan\nBlog: www.foureyedlaagan.com\n\nTHANK YOU!!!\n\nMUSIC CREDITS:\nJulian Avila - Good Times', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/BDe82UvV1B4/default.jpg', 776, 9, 4, 7, NULL, '117671937129903037593', NULL),
('Bm-TgppS6Nc', 'Go Karting at JPark Island Resort | VLOG 33', 'I found an amazing spot within JPark Island Resort & Waterpark, Cebu that has remedied my agony of swimming. It was new to me because I never really thought it existed within the vicinity. These activities are exciting enough to fulfill my fun-seeking heart without getting wet. \n\nContinue Reading: http://www.foureyedlaagan.com/2017/03/25/must-try-activities-jpark-island-resort/ \n\nSpecial thanks to JPark Island Resort for this day of happiness!\n\n#ilovejparkforsummer2017 #ilovejpark #summer2017 #itsmorefuninthephilippines #iluvcebu\n\nMusic by: DJ Quads!!', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/Bm-TgppS6Nc/default.jpg', 510, 13, 0, 20, NULL, '117671937129903037593', NULL),
('Bmj3zPSu1RE', 'THE SILENT ME VLOG | VLOG 57', 'Hey guys! This is CJ again and welcome to my channel!\n\nThis vlog is kinda different because I haven''t said a thing. Hope you will still enjoy this style and COMMENT DOWN if you want more. If you don''t want it, you can browse some other vlogs in my channel ????\n\nSeries of events:\nPart 1: Ayala Center Cebu random photoshoot with my stylish socks\nPart 2: BTS Video shoot at Dolce Cafe, Nivel Hills, Lahug\nPart 3: KFC Mabolo to meet Juzkding\nPart 4: Moments after Juzkding Live at Uke Cafe Hub, Lapu-lapu City\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down below your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nFacebook: https://facebook.com/foureyedlaagan\nTwitter: https://twitter.com/foureyedlaagan\nInstagram: https://instagram.com/foureyedlaagan\nBlog: http://www.foureyedlaagan.com\n\nTHANK YOU!!!', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/Bmj3zPSu1RE/default.jpg', 229, 13, 1, 26, NULL, '117671937129903037593', NULL),
('Bt_bUp5J40A', 'Mt. Naupa Camp Out | VLOG 1', 'NCR Trekkers trekking and camp out at Mt. Naupa, City of Naga.\n\nNo copyright infringement intended.', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/Bt_bUp5J40A/default.jpg', 821, 11, 0, 5, NULL, '117671937129903037593', NULL),
('BUICYHbGgec', 'THE ADVENTURES OF THE NINJA TITO (Bisaya Episode 1)', 'P.S. If maabot nig 1K views kay maghimo mig 2nd episode so please like, comment and shareeeee!!! hahahah\n\nEPISODE 1 - Atangi ang mga adventures sa duha ka tito na nakipagsapalaran sa pagpangita ug "treasures" sa kabukiran.\n\nCheck out Idol Wanderer''s page:\nhttps://www.facebook.com/Idolwanderer-Photography-336613057083583/\n\n#TheAdventuresofNinjaTito #NoSmallCreator\nLet''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/iamcjestrada\nTwitter: https://twitter.com/iamcjestrada_\nInstagram: https://instagram.com/iamcjestrada\nBlog: https://www.foureyedlaagan.com\n\nGadgets Used:\n\nCamera: Panasonic Lumix G7 - https://bit.ly/CJEstradalumixg7\nMicrophone: Rode Video Micro - https://bit.ly/CJEstradaRodeMicro\nGorilla Pod: Joby Gorillapod 3K Kit - http://bit.ly/Joby3KGorillaPod\n\nEditor:\nAdobe Premiere Pro', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/BUICYHbGgec/default.jpg', 486, 51, 0, 60, NULL, '117671937129903037593', NULL),
('bxPuRxmWoVc', '#ALLSTARSLAAG: Manuel Resort - I FELL DOWN WHILE I WAS WALL CLIMBING!!!', 'Our family recently had our Post-Christmas vacation at Manuel Resort, Pinan, Zamboanga del Norte and we had so much fun!\n\nFull post coming soon at www.foureyedlaagan.com\n\nNo copyright infringement intended.', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/bxPuRxmWoVc/default.jpg', 278, 2, 0, 3, NULL, '117671937129903037593', NULL),
('c17OqXMGBik', 'FREE DIVING 101 AT NORTH SANDBAR WITH HIDEAWAY DIVE HOSTEL (Mactan, Cebu)', 'Part 1 of the awesome weekend with #HideawayDiveHostel! We got to learn basic static breathing exercises at The North Sandbar as the first step to do free diving.\n\nThank you HideAway Dive Hostel for having us! Visit their page on Facebook:\nhttps://facebook.com/hideawaydivehostel\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down on your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/iamcjestrada\nTwitter: https://twitter.com/iamcjestrada_\nInstagram: https://instagram.com/iamcjestrada\nBlog: https://www.foureyedlaagan.com\n\nGadgets Used:\n\nCamera: Panasonic Lumix G7 - https://bit.ly/CJEstradalumixg7\nMicrophone: Rode Video Micro - https://bit.ly/CJEstradaRodeMicro\nGorilla Pod: Joby Gorillapod 3K Set - http://bit.ly/Joby3KGorillaPod\n\nEditor:\nAdobe Premiere Pro', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/c17OqXMGBik/default.jpg', 251, 23, 1, 43, NULL, '117671937129903037593', NULL),
('cYCy9-Vs9SQ', 'WORST THANKSGIVING EVER??? | VLOG 93', 'Is it the worst thanksgiving ever??? You’d be the judge! Comment your thoughts below!\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down below your thoughts and questions and I''d be happy to read them all! \n\nOrder #FourEyedMerch NOW!: https://www.foureyedlaagan.com/foureyedmerch\n\nGadgets used:\n\nCamera (iPhone 6s) - https://goo.gl/yhwsPX\nGorilla Pod: https://goo.gl/Do1DPW\nBuy your gadgets here: https://goo.gl/LYf5Ne\n\nLet''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/foureyedlaagan\nTwitter: https://twitter.com/foureyedlaagan\nInstagram: https://instagram.com/foureyedlaagan\nBlog: https://www.foureyedlaagan.com', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/cYCy9-Vs9SQ/default.jpg', 249, 22, 0, 26, NULL, '117671937129903037593', NULL),
('Cyp3o_rqq74', 'VOMIT is the best! Bean Boozled Challenge with Travel Bloggers | VLOG 21', 'First time collab with awesome travel bloggers and rising YouTube star, Glenn Abucay. We had one trendy challenge, the Bean Boozled Challenge! Our face and reaction says it all.\n\nFollow them on their amazing blogs!\n\nHanna of beanintransit.com\nJunji of wanderingfeetph.com\nAJ of wanderingsoulscamper.com\n\nAaaanddddd\n\nGlenn of Glenn Abucay on https://www.youtube.com/channel/UCsuf1Awv4tiEHv-UUp1I7Qg\n\nSpecial thanks to Hanna of Bean In Transit for sponsoring the Bean Boozled Game.\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down below your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nFacebook: facebook.com/foureyedlaagan\nTwitter: twitter.com/foureyedlaagan\nInstagram: instagram.com/foureyedlaagan\nBlog: www.foureyedlaagan.com\n\nTHANK YOU!!!\n\nMusic By: Julian Avila - Good Times', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/Cyp3o_rqq74/default.jpg', 437, 19, 0, 38, NULL, '117671937129903037593', NULL),
('cztoDdJ48KQ', '8 COMMON RANTS OF A VLOGGER', 'Vlogging is surely FUN but there''s always challenges behind it! I''ve gathered my friends from Cebu Content Creators and asked them what they would rant as a vlogger.\n\nCheck out their channels of #TatakC3:\n\nCykaniki - https://youtube.com/cykaniki\nWellbein Borja - https://youtube.com/wellbeinborja\nVernon Joseph Go - https://goo.gl/esQiRP\nKalami Cebu - https://youtube.com/kalamicebu\nCall Center Ninja - https://youtube.com/callcenterninja\nBlaire Bustillo - https://youtube.com/Blairebustillo\nAldrincore Moshpit - https://www.youtube.com/channel/UCiEx8uvlOJI9vrhGqdAWZVA\n\nThis video is entry to the #C3VideoCarnival.\n\nLet''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/iamcjestrada\nTwitter: https://twitter.com/iamcjestrada_\nInstagram: https://instagram.com/iamcjestrada\nBlog: https://www.foureyedlaagan.com\n\nGadgets Used:\n\nCamera: Panasonic Lumix G7 - https://bit.ly/CJEstradalumixg7\nMicrophone: Rode Video Micro - https://bit.ly/CJEstradaRodeMicro\nGorilla Pod: Joby Gorillapod 3K Kit - http://bit.ly/Joby3KGorillaPod\n\nEditor:\nAdobe Premiere Pro', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/cztoDdJ48KQ/default.jpg', 220, 30, 1, 50, NULL, '117671937129903037593', NULL),
('D56ikFaZWvA', 'Fun Korean Night Food Trip at KPub BBQ Cebu with Jomie Hospital, Alem Garcia and More!!! | VLOG 43', 'Hey Guys! This is a FUN AND SUMPTUOUS Korean food trip vlog and I''m with amazing Filipino Youtubers (and a Japanese!). We were at KPub BBQ Cebu trying out wide array of Korean Dishes that made our tummies really stuffed!\n\nVisit KPub BBQ Cebu at Ayala Center Cebu and dine out with a wide array of sumptuous Korean dishes and jam with astounding live bands that adds up the total Korean experience!\n\nSpecial thanks to KPub BBQ Cebu for this amazing experience!\n\n\nFollow these guys who were with me on this trip:\n\nJomie Hospital - https://www.youtube.com/user/PoweredByJomie\n\nUkay Ukay Diva - https://www.youtube.com/channel/UCotDKhqOIisjSBq1poSKzNw\n\nKalami Cebu - https://www.youtube.com/channel/UCaggFZp28MnvMCr8zGCAXlA\n\nRamzy Rizzle - https://www.youtube.com/user/RamzyRizzle\n\nTara The Snap Vlogger - https://www.youtube.com/channel/UCvZ1FDozSxFjnalJ9F9rkWw\n\nYoshi Tube - https://www.youtube.com/channel/UCA2mbZQirLFGM3hQnfSTFnA\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down below your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nFacebook: https://facebook.com/foureyedlaagan\nTwitter: https://twitter.com/foureyedlaagan\nInstagram: https://instagram.com/foureyedlaagan\nBlog: http://www.foureyedlaagan.com\n\nTHANK YOU!!!', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/D56ikFaZWvA/default.jpg', 921, 25, 0, 39, NULL, '117671937129903037593', NULL),
('dab4hS_V1ug', 'HEART-TUGGING FEELS IN LAKE HOLON! | VLOG 49', 'Everything was amazing from the 4 hours trek, the breathtaking view and the campsite experience during our adventure at Lake Holon in TBoli, South Cotabato.\n\nIt even made more special and heart-tugging feels when we witnessed how compassionate T''Bolis are when they had their worship dawn of Sunday.\n\nREAD FULL STORY, TIPS, ITINERARY, AND EXPENSES HERE:\nhttp://www.foureyedlaagan.com/2017/06/14/lake-holon-adventure-adrenaline-benevolence-culture/\n\nSubscribe my friends on their channels:\n\nBean in Transit - https://www.youtube.com/channel/UCAy4lSY_ekIdBZJ4DW-3CfQ\n\nTrip Bisagasa - https://www.youtube.com/channel/UC2xzDmeHJi6HooyQ9HENIpA\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down below your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nFacebook: https://facebook.com/foureyedlaagan\nTwitter: https://twitter.com/foureyedlaagan\nInstagram: https://instagram.com/foureyedlaagan\nBlog: http://www.foureyedlaagan.com\n\nTHANK YOU!!!', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/dab4hS_V1ug/default.jpg', 449, 19, 0, 28, NULL, '117671937129903037593', NULL),
('DiGvLXeEuMo', 'ICE CREAM OVERLOAD AT AYSKEN D'' HAN | VLOG 79', 'One of the best and unique ice cream shops in Cebu - AYSKEN D'' HAN - offers healthy ice creams such as variety of vegan and vegetarian organic designer ice creams.\n\nThe #BloggerKigwas got to try 5 flavors and we were indulged with such rich taste! PLUS they let hs taste THREE ALCOHOL-BASED ICE CREAM which was absolutely new to anybody.\n\nEverything was so heavenly that we couldn''t get over. \n\nCheck out our reaction and our experience at AYSKEN D'' HAN.\n\nFollow Aysken D'' Han on their Facebook page:\n\nhttps://www.facebook.com/ayskendhanofficial/\nLocation: Suba-basbas, Lapu-Lapu City', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/DiGvLXeEuMo/default.jpg', 214, 9, 0, 16, NULL, '117671937129903037593', NULL);
INSERT INTO `video` (`video_id`, `video_title`, `video_description`, `channel_id`, `channel_title`, `category_id`, `default_thumbnail`, `views_count`, `likes_count`, `dislikes_count`, `comments_count`, `date_accomplished`, `youtuber_id`, `accepted_interest_id`) VALUES
('dOTZWk1yA_M', 'TRAVELLING BACK TO GRAND RAPIDS AND A QUICK TOUR AT NAPERVILLE, IL', 'And the reason why I''m away from adventures in the Philippines! I''m back at Grand Rapids, Michigan and here''s what happened during my looong flight from Cebu, PH to the US! And a quick tour at Naperville, Illinois with Lesterizing Journey!\n\nVlog 131.\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down on your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/iamcjestrada\nTwitter: https://twitter.com/iamcjestrada_\nInstagram: https://instagram.com/iamcjestrada\nBlog: https://www.foureyedlaagan.com\n\nGadgets Used:\n\nCamera: Panasonic Lumix G7 - https://bit.ly/CJEstradalumixg7\nMicrophone: Rode Video Micro - https://bit.ly/CJEstradaRodeMicro\nGorilla Pod: Joby Gorillapod 3K Set - http://bit.ly/Joby3KGorillaPod\n\nEditor:\nAdobe Premiere Pro', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/dOTZWk1yA_M/default.jpg', 238, 22, 0, 26, NULL, '117671937129903037593', NULL),
('DqHnGnJSpFc', 'Ultimate Siquijor Island Tour - 12 DESTINATIONS A DAY!', 'This is the ultimate Siquijor Island tour with 12 destinations in a day!\n\nLet''s continue talking on my social media accounts:\n\nFacebook: https://facebook.com/foureyedlaagan\nTwitter: https://twitter.com/foureyedlaagan\nInstagram: https://instagram.com/foureyedlaagan\nBlog: http://www.foureyedlaagan\n\nNo Copyright Infringement Intended.', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/DqHnGnJSpFc/default.jpg', 3748, 35, 7, 13, NULL, '117671937129903037593', NULL),
('e7dqBVmDykQ', 'AN EXTREME LONG FIERY TREK TO CEBU''S GEMS (Osmeña Peak to Casino Peak to Kawasan Falls)', 'Got to camp again at Osmeña Peak with new friends and trekked to the majestic falls of Kawasan Falls in Badian, Cebu.\n\nHow to Get There?\n\nRide a bus from Cebu’s South Bus Terminal and disembark at Poblacion, Dalaguete (town proper). There are numerous motorcycle taxis that are waiting for a ride and you can get one. They can ride you to Mantalongon Market or even at the foot of Mantolongon Ranges, where Osmeña Peak hails.\n\nExpenses:\n\nBus ride from South Bus Terminal – EST P135\nDalaguete Proper to Foot of Osmeña Peak – P100/pax\nRegistration Fee – P30/pax\nTent Fee – P50 per tent\n\nCheck out my old blog about Osmeña Peak here:\nhttps://www.foureyedlaagan.com/2016/11/04/snapandponder-sea-of-clouds-at-osmena-peak-appreciate/\n\nVlog 114. \n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down on your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/iamcjestrada\nTwitter: https://twitter.com/iamcjestrada_\nInstagram: https://instagram.com/iamcjestrada\nBlog: https://www.foureyedlaagan.com\n\nGadgets Used:\n\nCamera: Panasonic Lumix G7 - https://bit.ly/CJEstradalumixg7\nMicrophone: Rode Video Micro - https://bit.ly/CJEstradaRodeMicro\nGorilla Pod: CDR-King gorilla pod - https://bit.ly/CJEstradaGorillaPod\n\nEditor:\nAdobe Premiere Pro', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/e7dqBVmDykQ/default.jpg', 559, 38, 0, 71, NULL, '117671937129903037593', NULL),
('eJ8z68VnXgQ', 'EXPLORE TABOGON: THE ARTSY BUNZIES COVE AND THE TOWN TOUR', 'Summer doesn''t end there! We got to explore the municipality of Tabogon, Cebu and we got to stay for a night at the amazingly artsy Bunzies Cove and got to see the spots Tabogon can offer.\n\nCheck out Bunzies Cove''s Facebook page and Website for inquiries:\nhttps://facebook.com/bunziescove\nhttp://bunziescove.com\n\n#bunziescove #exploretabogon #sharePishAndLove\nvlog 129.\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down on your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/iamcjestrada\nTwitter: https://twitter.com/iamcjestrada_\nInstagram: https://instagram.com/iamcjestrada\nBlog: https://www.foureyedlaagan.com\n\nGadgets Used:\n\nCamera: Panasonic Lumix G7 - https://bit.ly/CJEstradalumixg7\nMicrophone: Rode Video Micro - https://bit.ly/CJEstradaRodeMicro\nGorilla Pod: Joby Gorillapod 3K Set - http://bit.ly/Joby3KGorillaPod\n\nEditor:\nAdobe Premiere Pro', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/eJ8z68VnXgQ/default.jpg', 303, 21, 0, 22, NULL, '117671937129903037593', NULL),
('eWHeb5m1um8', '30 HOURS IN MANILA, PHILIPPINES', 'Well, you gotta do what you gotta do in short visit in Manila. Also, I got to meet my Pinoy Travel Blogger friends, Angel of @thelakwatsero and Darwin of @trackingtreasure.\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down on your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/iamcjestrada\nTwitter: https://twitter.com/iamcjestrada_\nInstagram: https://instagram.com/iamcjestrada\nBlog: https://www.foureyedlaagan.com\n\nGadgets Used:\n\nCamera: Panasonic Lumix G7 - https://bit.ly/CJEstradalumixg7\nMicrophone: Rode Video Micro - https://bit.ly/CJEstradaRodeMicro\nGorilla Pod: Joby Gorillapod 3K Set - http://bit.ly/Joby3KGorillaPod\n\nEditor:\nAdobe Premiere Pro', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/eWHeb5m1um8/default.jpg', 191, 23, 0, 30, NULL, '117671937129903037593', NULL),
('eWKnxgjoY18', 'Babag-Bocaue LEG BREAKING Trek!!! | VLOG 26', 'We just went to Bocaue Peak for the 4TH TIME!! But this time we took Babag Trail which is one bar easier than the usual 5 Towers Trail.\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down below your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nFacebook: facebook.com/foureyedlaagan\nTwitter: twitter.com/foureyedlaagan\nInstagram: instagram.com/foureyedlaagan\nBlog: www.foureyedlaagan.com\n\nTHANK YOU!!!', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/eWKnxgjoY18/default.jpg', 428, 23, 0, 29, NULL, '117671937129903037593', NULL),
('E_3Nx1IW7sk', '#MatteoMadeInCebu: KZ Tandingan sings Rolling In the Deep', '#MatteoMadeInCebu concert in Waterfront Hotel, Lahug, Cebu City\n\nSpecial thanks to #PLDTHomeDSL for the sponsored ticket.\n\nFollow me on social media:\nFacebook: facebook.com/foureyedlaagan\nTwitter: twitter.com/foureyedlaagan\nInstagram: instagram.com/foureyedlaagan\nBlog: https://foureyedlaagan.com', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/E_3Nx1IW7sk/default.jpg', 443, 8, 0, 1, NULL, '117671937129903037593', NULL),
('F53ObTc8g4A', 'Matteo Guidicelli and Kz Tandingan - Wag Ka Ng Umiyak', 'Matteo and Kz sang Wag ka ng umiyak at #MatteoMadeInCebu concert.\n\nCheck out my blog for FULL concert review: http://www.foureyedlaagan.com/2016/11/21/matteomadeincebu-a-night-of-entertainment/\n\nThanks!', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/F53ObTc8g4A/default.jpg', 19189, 181, 1, 4, NULL, '117671937129903037593', NULL),
('Fhr0WYlQiRA', 'I GOT A SURPRISE FOR YOU!!! (WATCH UNTIL THE END)', 'VLOG 113. YAYY WE FINALLY REACHED THE 1,000 SUBSCRIBER MARK! To celebrate this milestone, get a chance to win these prizes from the #CJ1KGiveaway:\n\n1. YouTube Notebook\n2. Transcend 16 GB USB-C Flash Drive by Zenfone\n3. Greenwich GC worth P500\n4. Four-eyed Red Cap\n\nHERE''S HOW TO JOIN THE #CJ1KGiveaway\n\n1. SMASH the Subscribe button and TICK the notification bell of my YouTube channel (https://youtube.com/CJEstrada)\n2. SHARE this VLOG on Facebook or Twitter with the following hashtags - #CJ1KGiveaway and #SharePishAndLove\n3. TAG 3 friends in your shared post. Make sure your post is in PUBLIC.\n4. and COMMENT down in this vlog the TITLE of your favorite vlog.\n5. OPEN to ALL subscribers on the Philippines (yaayyy!!!)\n\n#CJ1KGiveaway Period: Feb. 25, 2018 - Mar. 2, 2018 7 PM. Winners will be selected via Random.org and will be announced on Mar. 3, 2018, 10 PM on my Facebook page (https://facebook.com/iamcjestrada)\n\nSpecial Thanks to the Sponsors:\n\n1. ASUS Philippines\n2. ILuvCebu.com and CountOCram.com\n3. #FourEyedMerch\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down on your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/iamcjestrada\nTwitter: https://twitter.com/iamcjestrada_\nInstagram: https://instagram.com/iamcjestrada\nBlog: https://www.foureyedlaagan.com\n\nGadgets Used:\n\nCamera: Panasonic Lumix G7 - https://bit.ly/CJEstradalumixg7\nMicrophone: Rode Video Micro - https://bit.ly/CJEstradaRodeMicro\nGorilla Pod: CDR-King gorilla pod - https://bit.ly/CJEstradaGorillaPod\n\nEditor:\nAdobe Premiere Pro\n\nMusic Credits:\nDJ Quads - Show Me\nDJ Quads - Dreams\nJoakim Karud - Dizzy\nSugar Zone - Silent Partner', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/Fhr0WYlQiRA/default.jpg', 659, 60, 3, 102, NULL, '117671937129903037593', NULL),
('fiJJt2dnuK0', 'Lola Dors Goes to Heaven', 'A tribute video to our ever loving Lola Adoracion "Doring" Restauro who passed away last October 11, 2016.\n\nThank you Lola Dors for everything.\n\nNo Copyright Infringement Intended.', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/fiJJt2dnuK0/default.jpg', 157, 4, 0, 0, NULL, '117671937129903037593', NULL),
('FQuaIcyOx5A', 'WHY AM I SO HANDSOME?', '#AskCJEstrada answered! ????\n\nLet''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/iamcjestrada\nTwitter: https://twitter.com/iamcjestrada_\nInstagram: https://instagram.com/iamcjestrada\nBlog: https://www.foureyedlaagan.com\n\nGadgets Used:\n\nCamera: Panasonic Lumix G7 - https://bit.ly/CJEstradalumixg7\nMicrophone: Rode Video Micro - https://bit.ly/CJEstradaRodeMicro\nGorilla Pod: Joby Gorillapod 3K Kit - http://bit.ly/Joby3KGorillaPod\n\nEditor:\nAdobe Premiere Pro', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/FQuaIcyOx5A/default.jpg', 272, 31, 0, 31, NULL, '117671937129903037593', NULL),
('gF6PI-mFxi8', 'MARAVILLA BEACH PARK // BORACAY OF THE NORTHERN CEBU', 'GET YOUR SUMMER OOTDs ON AND TAG AND SHARE THIS TO YOUR FRIENDS THEN GO TO MARAVILLA BEACH PARK!!!\n\nLet''s enjoy the beautiful and vast beach with a stunning view of the sunset and... and... and... amazing place for a quick escape from the daily stress of the city! You also bring your own tent, get to camp at the beach and enjoy star gazing at night.\n\nTRAVEL GUIDE: https://bit.ly/maravillabeachpark\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down on your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/iamcjestrada\nTwitter: https://twitter.com/iamcjestrada_\nInstagram: https://instagram.com/iamcjestrada\nBlog: https://www.foureyedlaagan.com\n\nGadgets Used:\n\nCamera: Panasonic Lumix G7 - https://bit.ly/CJEstradalumixg7\nMicrophone: Rode Video Micro - https://bit.ly/CJEstradaRodeMicro\nGorilla Pod: CDR-King gorilla pod - https://bit.ly/CJEstradaGorillaPod\n\nEditor:\nAdobe Premiere Pro\n\nMusic by:\nRaven Kreyn - So Happy', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 10, 'https://i.ytimg.com/vi/gF6PI-mFxi8/default.jpg', 1441, 19, 1, 31, NULL, '117671937129903037593', NULL),
('GQ4E6TeFQGg', 'HIKING AND GETTING LOST AT REEDS LAKE | GRAND RAPIDS, MI | VLOG 96', 'Finally, I was able to explore Grand Rapids, Michigan after few weeks of staying here. Time to go back to the woods and enjoy hiking at Reeds Lake!\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down below your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nFacebook: https://facebook.com/foureyedlaagan\nTwitter: https://twitter.com/foureyedlaagan\nInstagram: https://instagram.com/foureyedlaagan\nBlog: http://www.foureyedlaagan.com\n\nTHANK YOU!!!', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/GQ4E6TeFQGg/default.jpg', 217, 21, 0, 31, NULL, '117671937129903037593', NULL),
('H3Er6-OWB3g', 'THANK YOU (I QUIT) | VLOG 100', 'It has been more than a year since I started my vlogging journey. To all followers, readers, friends and family, YOU ROCK! Thank you for making my journey awesome!\n\nSorry for the clickbait title :)\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down on your thoughts and questions and I''d be happy to read them all! \n\nOrder #FourEyedMerch NOW!: https://www.foureyedlaagan.com/fourey...\n\nLet''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/iamcjestrada\nTwitter: https://twitter.com/iamcjestrada\nInstagram: https://instagram.com/iamcjestrada\nBlog: https://www.foureyedlaagan.com', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/H3Er6-OWB3g/default.jpg', 1067, 73, 1, 83, NULL, '117671937129903037593', NULL),
('H7iXFWhearo', 'CEBU KOREAN FOOD PORN AT BADA KOREAN RESTAURANT', 'Watching a horror movie could be stressful so food porn covers it up! We went to Bada Korean Restaurant for an unli-korean food then we went for a dessert!\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down on your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/iamcjestrada\nTwitter: https://twitter.com/iamcjestrada_\nInstagram: https://instagram.com/iamcjestrada\nBlog: https://www.foureyedlaagan.com\n\nGadgets Used:\n\nCamera: Panasonic Lumix G7 - https://bit.ly/CJEstradalumixg7\nMicrophone: Rode Video Micro - https://bit.ly/CJEstradaRodeMicro\nGorilla Pod: CDR-King gorilla pod - https://bit.ly/CJEstradaGorillaPod\n\nEditor:\nAdobe Premier Pro', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/H7iXFWhearo/default.jpg', 406, 19, 0, 26, NULL, '117671937129903037593', NULL),
('H8GoDi8l-Ks', 'RIDING TARTANILLA WITH THE GANG! | GABII SA KABILIN 2017 | VLOG 50', 'Hey guys! It''s CJ again!\n\nIt''s the last friday of the May again and it''s time for Cebu''s most awaited event to explore the heritage sites of the city - The Gabii Sa Kabilin 2017. We got to explore several sites like San Nicolas de Tolentino Church, Parian Monument, Fort San Pedro and Sugbu Chinese Heritage Museum. We also got to visit Cebu Museum, Jose R. Gullas Halad Museum and the Basilica del Sto. Niño Museum.\n\nThe gang also had fun while riding tartanilla from Fort San Pedro to the Sugbu Chinese Heritage Museum. In fact, it was my first time since high school! Haha!\n\nPlease support my #GabiiSaKabilin2017 vlog entry by liking and sharing this video! Please also subscribe to my YouTube channel: https://youtube.com/foureyedlaagan.com\n\nMusic credits:\nDJ Quads - Storyteller\nA Himitsu - Adventure\nNicolai Hedlas - Drive\nSophomore Makeout - Silent Partner\n\nThank you and see ya!', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/H8GoDi8l-Ks/default.jpg', 522, 16, 0, 27, NULL, '117671937129903037593', NULL),
('HHK3jq9Rr1Q', 'FREE WINE TASTING at the Gourmet Walk | VLOG 25', 'We were recently invited at Waterfront Hotel and Casino in Cebu City and we were able to taste all wines available during the Winefest.\n\nWine Festival at the Gourmet Walk is a celebration of happy sensation that can be tasted from various selections of red and white wines. Visit Waterfront''s Gourmet section and get a free wine tasting! You can also buy a bottle to enjoy fully. This event will last until February 19, 2017.\n\nFor information and reservations, call 232 6888.\n#WineFest\n#BestOfGourmetWalk\n#WaterfrontCebu\n#WereAtTheCenterOfItAll\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down below your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nFacebook: facebook.com/foureyedlaagan\nTwitter: twitter.com/foureyedlaagan\nInstagram: instagram.com/foureyedlaagan\nBlog: www.foureyedlaagan.com\n\nTHANK YOU!!!\n\nMusic by: EVER AWESOME DJ QUADS!!!', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/HHK3jq9Rr1Q/default.jpg', 366, 14, 0, 29, NULL, '117671937129903037593', NULL),
('HnnhYhwKJmY', 'BEHOLD BOHOL // THE ULTIMATE DIY BACKPACKING ADVENTURE', 'Bohol is an amazing island in the Visayas Region offering a lot of attractions, from mountains, to caves, to waterfalls, and to the beach. I was in 3D3N adventure and got to explore 9 spots and had an amazing time!\n\nWell, every adventure comes a misadventure that makes it more exciting. Check out the FULL video and find out what happened during my trip.\n\nTRAVEL GUIDE: http://bit.ly/BoholAdventure\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down on your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/iamcjestrada\nTwitter: https://twitter.com/iamcjestrada_\nInstagram: https://instagram.com/iamcjestrada\nBlog: https://www.foureyedlaagan.com\n\nGadgets Used:\n\nCamera: Panasonic Lumix G7 - https://bit.ly/CJEstradalumixg7\nMicrophone: Rode Video Micro - https://bit.ly/CJEstradaRodeMicro\nGorilla Pod: Joby Gorillapod 3K Kit - http://bit.ly/Joby3KGorillaPod\n\nEditor:\nAdobe Premiere Pro\n\nMusic Credits:\nIkson - Alive\nIkson - Free\nIkson - Lights\nIkson - New Day\nIkson - Skyline\nIkson - Wander\nIkson - Heartbeat\nDJ Quads - Wonderful World\nNico Cipriano - Nowhere Now Here\nRaven Kreyn - So Happy', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/HnnhYhwKJmY/default.jpg', 1385, 62, 1, 74, NULL, '117671937129903037593', NULL),
('HxQSd2hf2nQ', 'I MET KARENCITTA AND SINULOG 2018 KICKED OFF! (Cebu City, Philippines)', 'Karencitta, a cebuana artist, had a presscon at SM Seaside City Cebu to promote her current viral single, "Cebuana" and had a teaser for her next single.\n\nALSO in this vlog, Sinulog 2018 Kicked off last January 12 at Plaza Independencia. Various bands, schools, singers, and dancers are set to perform every night until January 21 for FREE.\n\nDownload Sinulog 2018 app now for your ultimate digital guide for the grand festival.\n\nSubscribe to my friend:\n\nIt''s me boi - https://youtube.com/itsmeboi\n\nVlog 105.\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down on your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/iamcjestrada\nTwitter: https://twitter.com/iamcjestrada_\nInstagram: https://instagram.com/iamcjestrada\nBlog: https://www.foureyedlaagan.com\n\nGadgets Used:\n\nCamera: Panasonic Lumix G7 - https://bit.ly/CJEstradalumixg7\nMicrophone: Rode Video Micro - https://bit.ly/CJEstradaRodeMicro\nGorilla Pod: CDR-King gorilla pod - https://bit.ly/CJEstradaGorillaPod\n\nEditor:\nAdobe Premier Pro\n\nMusic Credits:\n\nCebuana - Karencitta\nSinulog 2018 song - Pedro Miralles', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/HxQSd2hf2nQ/default.jpg', 27927, 348, 14, 125, NULL, '117671937129903037593', NULL),
('i1gna2KYT4g', 'BISAYA FAN FEST 2018: BISAYA VLOGGERS REUNITED! FT. GLENN ABUCAY, ANGELA MORALES, IT''S ME BOI & MORE', 'We finally got reunited with my friends from the vlogosphere during the first ever #BisayaFanFest2018. It was an awesome and FUN event together as the top bisaya content creators presented their best!\n\nLet''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/iamcjestrada\nTwitter: https://twitter.com/iamcjestrada_\nInstagram: https://instagram.com/iamcjestrada\nBlog: https://www.foureyedlaagan.com\n\nGadgets Used:\n\nCamera: Panasonic Lumix G7 - https://bit.ly/CJEstradalumixg7\nMicrophone: Rode Video Micro - https://bit.ly/CJEstradaRodeMicro\nGorilla Pod: Joby Gorillapod 3K Kit - http://bit.ly/Joby3KGorillaPod\n\nEditor:\nAdobe Premiere Pro', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/i1gna2KYT4g/default.jpg', 1639, 47, 1, 26, NULL, '117671937129903037593', NULL),
('i3n2t4FWABg', 'WHEN CEBU YOUTUBERS MEET', 'When vloggers and YouTubers meet, it''s a total disaster. HAHAHA! Cameras and talking everywhere!\n\nCheck out their channels and make sure to subscribe ''em!!\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down on your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/iamcjestrada\nTwitter: https://twitter.com/iamcjestrada_\nInstagram: https://instagram.com/iamcjestrada\nBlog: https://www.foureyedlaagan.com\n\nGadgets Used:\n\nCamera: Panasonic Lumix G7 - https://bit.ly/CJEstradalumixg7\nMicrophone: Rode Video Micro - https://bit.ly/CJEstradaRodeMicro\nGorilla Pod: Joby Gorillapod 3K Set - http://bit.ly/Joby3KGorillaPod\n\nEditor:\nAdobe Premiere Pro', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/i3n2t4FWABg/default.jpg', 929, 44, 2, 73, NULL, '117671937129903037593', NULL),
('iLBhDheykfk', 'Dahilayan Adventure Park - SCARY RIDES!', 'The squad had a day of adrenaline-pumping activities at Dahilayan Adventure Park, Bukidnon. \n\nFull post coming up soon at www.foureyedlaagan.com!\n\nMusic by: DJ Quads', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/iLBhDheykfk/default.jpg', 460, 12, 0, 0, NULL, '117671937129903037593', NULL),
('iNAaJC0gtWQ', 'BANTAYAN ISLAND WITH GOPRO FUSION', 'I recently went into a short adventure at Bantayan Island with my GoPro Fusion. Check out the spots I''ve been to and hope you enjoy this video!\n\nTRAVEL GUIDE: https://www.foureyedlaagan.com/2018/08/07/bantayan-island-captured/\n\n#GoProExplorePH #ExperienceDifferent\n\nLet''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/iamcjestrada\nTwitter: https://twitter.com/iamcjestrada_\nInstagram: https://instagram.com/iamcjestrada\nBlog: https://www.foureyedlaagan.com\n\nGadgets Used:\n\nCamera: Panasonic Lumix G7 - https://bit.ly/CJEstradalumixg7\nMicrophone: Rode Video Micro - https://bit.ly/CJEstradaRodeMicro\nGorilla Pod: Joby Gorillapod 3K Kit - http://bit.ly/Joby3KGorillaPod\n\nEditor:\nAdobe Premiere Pro', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/iNAaJC0gtWQ/default.jpg', 295, 16, 1, 22, NULL, '117671937129903037593', NULL),
('IoC45v7K9CM', 'LOCAL AND POSH FOOD TRIP AT BANTAYAN ISLAND, CEBU', 'Let''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/iamcjestrada\nTwitter: https://twitter.com/iamcjestrada_\nInstagram: https://instagram.com/iamcjestrada\nBlog: https://www.foureyedlaagan.com\n\nGadgets Used:\n\nCamera: Panasonic Lumix G7 - https://bit.ly/CJEstradalumixg7\nMicrophone: Rode Video Micro - https://bit.ly/CJEstradaRodeMicro\nGorilla Pod: Joby Gorillapod 3K Kit - http://bit.ly/Joby3KGorillaPod\n\nEditor:\nAdobe Premiere Pro', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/IoC45v7K9CM/default.jpg', 450, 15, 0, 21, NULL, '117671937129903037593', NULL),
('iqOKpOpUnGc', 'TREKKING WITH HANGOVER | MAUYOG-MANUNGGAL, CEBU | VLOG 61', 'And I''m back in the mountains! Yay! I so missed it! However this time, I was having a hangover from getting drunk on that previous night. Luckily, I was able to survive and enjoyed the trek and the view and the rocks were surely breathtaking!!!\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down below your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nFacebook: https://facebook.com/foureyedlaagan\nTwitter: https://twitter.com/foureyedlaagan\nInstagram: https://instagram.com/foureyedlaagan\nBlog: http://www.foureyedlaagan.com\n\nTHANK YOU!!!', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/iqOKpOpUnGc/default.jpg', 359, 25, 0, 25, NULL, '117671937129903037593', NULL),
('IQ_pcvRFPaQ', 'THE ECOBRICKS PROJECT', 'Get to know #Ecobricks by visiting this link:\n\nhttps://ecobricks.org\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down on your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/iamcjestrada\nTwitter: https://twitter.com/iamcjestrada_\nInstagram: https://instagram.com/iamcjestrada\nBlog: https://www.foureyedlaagan.com\n\nGadgets Used:\n\nCamera: Panasonic Lumix G7 - https://bit.ly/CJEstradalumixg7\nMicrophone: Rode Video Micro - https://bit.ly/CJEstradaRodeMicro\nGorilla Pod: Joby Gorillapod 3K Set - http://bit.ly/Joby3KGorillaPod\n\nEditor:\nAdobe Premiere Pro', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/IQ_pcvRFPaQ/default.jpg', 117, 17, 0, 13, NULL, '117671937129903037593', NULL),
('iZ3JTXjHioQ', 'LAMI KAAYO! | Korean Dishes at Fat Dois | VLOG 54', 'THE BEST SPICY NOODLES IN TOWN!\n\nFat Dois is located at AS Fortuna St, Mandaue City, Cebu (near Oakridge). Find the RED door (just like my cap! Lol) and see what''s inside.\n\nThe best cheesy chix and spicy noodles with spam and egg at affordable price. Busog kaayo! Lami kaayo!\n\nCheck out Fat Dois'' FB page at:\nhttps://www.facebook.com/fatdoiscebu/\n\nAlso check out my friend''s blogs:\nhttp://lamikaayo.com\nhttp://countocram.com\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down below your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nFacebook: https://facebook.com/foureyedlaagan\nTwitter: https://twitter.com/foureyedlaagan\nInstagram: https://instagram.com/foureyedlaagan\nBlog: http://www.foureyedlaagan.com\n\nTHANK YOU!!!', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/iZ3JTXjHioQ/default.jpg', 2068, 33, 0, 27, NULL, '117671937129903037593', NULL),
('j3VA9SLtsBM', '7 REASONS WHY GOPRO FUSION ROCKS AND SUCKS', 'I''ve been using my #GoProFusion for 3 months on my adventures and have captured adventures in 360. Here''s my personal review of this amazing device.\n\nThis GoPro Fusion is a collaboration with CJ Estrada and GoPro PH.\n\nLet''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/iamcjestrada\nTwitter: https://twitter.com/iamcjestrada_\nInstagram: https://instagram.com/iamcjestrada\nBlog: https://www.foureyedlaagan.com\n\nGadgets Used:\n\nCamera: Panasonic Lumix G7 - https://bit.ly/CJEstradalumixg7\nMicrophone: Rode Video Micro - https://bit.ly/CJEstradaRodeMicro\nGorilla Pod: Joby Gorillapod 3K Kit - http://bit.ly/Joby3KGorillaPod\n\nEditor:\nAdobe Premiere Pro\n\nMusic by:\nCartoon - On and On (ft. Daniel Levi)\n\n#NoSmallCreator', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/j3VA9SLtsBM/default.jpg', 409, 19, 1, 11, NULL, '117671937129903037593', NULL),
('J5ZYawV6reE', 'Vegan Eating Challenge ft. Glenn Abucay | VLOG 22', 'I''m an eater but I always make sure that there''s a meat in every meal. Today, I was invited by rising YouTube star, Glenn Abucay, to have the Vegan Eating Challenge. No meat! All Veggies! So nangamong pud ko ug friends na carnivorous pud like me. Hahaha!\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down below your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nFacebook: facebook.com/foureyedlaagan\nTwitter: twitter.com/foureyedlaagan\nInstagram: instagram.com/foureyedlaagan\nBlog: www.foureyedlaagan.com\n\nTHANK YOU!!!\n\nMusic credits: DJ Quads - Darling', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/J5ZYawV6reE/default.jpg', 351, 15, 0, 13, NULL, '117671937129903037593', NULL),
('jcCBLhhUKJ0', '10000 Roses Cafe and More!!! | VLOG 23', '10,000 Rose Cafe & More VLOG with vloggers - Glenn Abucay, Junji and AJ!\n\nHow to get there:\n\nFrom SM, ride a vhire to Cordova for P35\nDisembark at Gaisano Grand Mall, Cordova then ride a tricycle or pedicab for P15-25/pax\n\nOpens at 10:00 am - 11:00 pm with various  coffees, lattes and snacks.\n\nPlease visit and read my blog for this cafe at: \n\nhttp://www.foureyedlaagan.com/2017/02/14/snap-ponder-10000-roses-cafe-responsible-enjoying/\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down below your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nFacebook: facebook.com/foureyedlaagan\nTwitter: twitter.com/foureyedlaagan\nInstagram: instagram.com/foureyedlaagan\nBlog: www.foureyedlaagan.com\n\nTHANK YOU!!!\n\nMusic By : DJ Quads', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/jcCBLhhUKJ0/default.jpg', 4532, 43, 11, 49, NULL, '117671937129903037593', NULL),
('JgvvVhCvRXM', 'Best Island Hopping Team Outing Ever! Part 2 | VLOG 32', 'This is part 2 of our awesome team outing. Check out part 1 at https://youtu.be/SRv48BChB-Y\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down below your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nFacebook: facebook.com/foureyedlaagan\nTwitter: twitter.com/foureyedlaagan\nInstagram: instagram.com/foureyedlaagan\nBlog: www.foureyedlaagan.com\n\nTHANK YOU!!!\n\nMusic by: DJ Quads', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/JgvvVhCvRXM/default.jpg', 167, 6, 0, 15, NULL, '117671937129903037593', NULL),
('JiUMDbugKSI', 'LOST (AGAIN) IN SM SEASIDE + VLOGGER GIVEAWAY!!! | VLOG 69', '[UPDATE] and CONGRATULATIONS TO OUR WINNER ~ ANGEL ACE VIAGEDOR!!!\n\nThank you for joining the giveaway and hope to see you next time! ????\n\n\nURGENT GIVEAWAY ALERT!\n\nI''LL BE GIVING AWAY TWO TICKETS FOR CARS 3 MOVIE PREMIER AT SM SEASIDE SHOWING THIS JULY 21, 7:00 PM!\n\nTo join, follow these simple steps:\n\n1. Subscribe to my YouTube channel - https://youtube.com/CJEstrada and Like my Facebook page - https://facebook.com/foureyedlaagan\n\n2. Share this video on Facebook with a hashtag #CJGives and Tag your date! (Make sure to make your posts public)\n\n3. 1 winner will be picked via Random.org and will receive 2 free tickets for the movie Cars 3 on July 20, 6 PM.\n\n\n*ONLY IN CEBU CITY*\nJOIN NOW, ENJOY AND GOOD LUCK!!!', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/JiUMDbugKSI/default.jpg', 239, 22, 0, 24, NULL, '117671937129903037593', NULL),
('Jtlayo1cIHA', 'Re-source Yoga with Rainbow Play Cebu | VLOG 30', 'It''s my first time having yoga and it''s not the typical yoga. It is called as Re-source Yoga which concentrates to the inner core of our body bringing out our inner child.\n\nRainbow Playroom Psychological Services\nFB page: https://www.facebook.com/RainbowPlayTherapy/\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down below your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nFacebook: facebook.com/foureyedlaagan\nTwitter: twitter.com/foureyedlaagan\nInstagram: instagram.com/foureyedlaagan\nBlog: www.foureyedlaagan.com\n\nTHANK YOU!!!\n\nMusic by: DJ Quads - Darling', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/Jtlayo1cIHA/default.jpg', 160, 10, 0, 22, NULL, '117671937129903037593', NULL),
('KiT0DYeV6_w', 'RAIDING DAVID GUISON''S BOOTH AT INFLUENCITY PH, CHINKYTITA AND MORE', 'Get a chance to raid, meet and greet influencers like David Guison, Vina Guerrero, Chinkytita, Maria Gigantes, Doyzkie Buenaviaje, Marco Paulo Diala, Issa Please, Jesse Daan, Sofia Sanchez, Etienne Chantal and many more from all over the country at Influencity PH!\n\nLet''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/iamcjestrada\nTwitter: https://twitter.com/iamcjestrada_\nInstagram: https://instagram.com/iamcjestrada\nBlog: https://www.foureyedlaagan.com\n\nGadgets Used:\n\nCamera: Panasonic Lumix G7 - https://bit.ly/CJEstradalumixg7\nMicrophone: Rode Video Micro - https://bit.ly/CJEstradaRodeMicro\nGorilla Pod: Joby Gorillapod 3K Kit - http://bit.ly/Joby3KGorillaPod\n\nEditor:\nAdobe Premiere Pro', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/KiT0DYeV6_w/default.jpg', 544, 36, 1, 29, NULL, '117671937129903037593', NULL),
('kKBUm0iBrS0', 'BALO-I, LANAO DEL NORTE // EXPLORING THE MUSLIM COMMUNITY', 'Vlog 103: Exploring the Muslim Community (Balo-i, Lanao del Note)\n\nWe got a to explore the municipality next to Iligan City where we got to experience Muslim food and see beautiful spots around.\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down on your thoughts and questions and I''d be happy to read them all! \n\nOrder #FourEyedMerch NOW!: https://www.foureyedlaagan.com/fourey...\n\nLet''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/foureyedlaagan\nTwitter: https://twitter.com/foureyedlaagan\nInstagram: https://instagram.com/foureyedlaagan\nBlog: https://www.foureyedlaagan.com', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/kKBUm0iBrS0/default.jpg', 936, 31, 1, 25, NULL, '117671937129903037593', NULL),
('kN3nBquGWKs', 'Nabusog Ko Sa BINTANA | VLOG 20', 'A perfect secluded destination within the city to chill out with coffee and get stuffed with home-made dishes.\n\nHIBsters had their graduation at BINTANA COFFEE HOUSE AND RESTAURANT located at Camputhaw, Cebu City. Also, we welcomed the new members of the CEBU BLOGGING COMMUNITY during the Blog Bites.\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down below your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nFacebook: facebook.com/foureyedlaagan\nTwitter: twitter.com/foureyedlaagan\nInstagram: instagram.com/foureyedlaagan\nBlog: www.foureyedlaagan.com\n\nTHANK YOU!!!\n\nMusic Credits:\nDJ Quads - Back in Time\nDJ Quads - Fading', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/kN3nBquGWKs/default.jpg', 243, 14, 0, 25, NULL, '117671937129903037593', NULL),
('KOeE2pk8_hc', 'GAAHH IT''S WIL DASOVICH IN CEBU!!! | VLOG 68', 'WIL DASOVICH IN THE VLOG!!! Where''s the #DGAF #VlogSquad at??? \n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down below your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nFacebook: https://facebook.com/foureyedlaagan\nTwitter: https://twitter.com/foureyedlaagan\nInstagram: https://instagram.com/foureyedlaagan\nBlog: http://www.foureyedlaagan.com\n\nTHANK YOU!!!', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/KOeE2pk8_hc/default.jpg', 2561, 47, 1, 32, NULL, '117671937129903037593', NULL),
('Kth1pdT7kSA', 'I JUST SPOKE IN FRONT OF THE PUBLIC! | CEBU CREATORS DAY! | VLOG 85', 'Cebu Creators Day Success!\n\nT’was nice meeting ya’ll and I hope you got to learn something from my talk. Hahaha!\n\nThanks to Skip the Flip for the videos of mine.\n\nSubscribe to these channels:\n\nSkip the Flip - https://www.youtube.com/user/flippy0721\nMartin Tabanag - https://www.youtube.com/user/martinlouis99\nJustin Mahilum - https://www.youtube.com/channel/UC_55yu7vHjbMBfTFWw1uUXg\nIt’s me boi - https://www.youtube.com/channel/UCss6_eZecv9X2KTwuAwtDCw\nJrUniverse - https://www.youtube.com/channel/UCZyFDjlu7r1q70xVfWQ7P_w\nXMNN - https://www.youtube.com/channel/UCqftEZ3GcfaUd8Kaw3jAK6w\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down below your thoughts and questions and I''d be happy to read them all! \n\nOrder #FourEyedMerch NOW!: https://www.foureyedlaagan.com/foureyedmerch\n\nLet''s stay connected!\n\nFacebook: https://facebook.com/foureyedlaagan\nTwitter: https://twitter.com/foureyedlaagan\nInstagram: https://instagram.com/foureyedlaagan\nBlog: https://www.foureyedlaagan.com', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/Kth1pdT7kSA/default.jpg', 289, 25, 0, 31, NULL, '117671937129903037593', NULL),
('LS66-2SLobU', 'THIRD WHEELING AT ITS BEST! | Summer Funtastic Outing | VLOG 44', 'Hello guys! It''s another summer outing together at Danao Coco Palm Beach Resort. So many things happened and we had a blast! Not mentioning our not only 1 but 2 lechons! Woohoo! Thank you for the sponsors and people behind the success of this outing.\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down below your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nFacebook: https://facebook.com/foureyedlaagan\nTwitter: https://twitter.com/foureyedlaagan\nInstagram: https://instagram.com/foureyedlaagan\nBlog: http://www.foureyedlaagan.com\n\nTHANK YOU!!!', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/LS66-2SLobU/default.jpg', 159, 15, 0, 23, NULL, '117671937129903037593', NULL),
('LUc275DSow4', 'BINABAJE HILLS, ALICIA, BOHOL // A DAY OF MISADVENTURES AND LAUGHTER', 'Vlog 108. We had a day trip to Bohol, Philippines and trekked Binabaje Hills at the municipality of Bohol. The weather was not good and so as my stomach.\n\nAlso, we got into a minor motorcycle accident when we were traveling from Binabaje Hills going back the municipal hall. Thanks to the health center nearby, they aided my wound.\n\nWe also went on a side trip to the Twin Falls of Dimiao (also in Bohol) and plunged into the cold water of the falls.\n\nThanks to Team Bang - Cebu for the invitation! ''till next time.\n\nEXPENSES:\n\nJ & N Ship from Cebu City to Ubay, Bohol - P250/each (economy)\nBus from Ubay, Bohol to Alicia, Bohol - P20/each (non-aircon)\nHabal2x + Guide Fee to Binabaje Hills - P260/each\n\nWe rented a multicab that fetched us to Dimiao and to Tubigon Port - P3000/11 pax = P272/each\n\nWeesam Fastcraft from Tubigon, Bohol to Cebu City - P250 (tourist class)\n\nITINERARY:\n\n9 PM - ETD from Cebu City Port\n\n2 AM - ETA Ubay, Bohol\n2 AM - ETD to Alicia, Bohol\n3 AM - ETA Alicia, Bohol\n4 AM - ETD to Binabaje Hills Jump-off\n5 AM - ETA Jump-off and waiting game\n6 AM - Start Trek\n7 AM - Reached the peak\n7 AM - 11 AM - rest and palanay\n11 AM - recommenced trek\n12 NN - back to jump-off\n1 PM - back to Municipal Hall, Alicia, Bohol then lunch\n1:30 PM - Travel to Dimiao, Bohol\n4 PM - ETA Twin Falls, Dimiao, Bohol and enjoy\n6 PM - ETD to Tubigon Port\n8:30 PM - ETA Tubigon Port\n9:20 PM - ETD to Cebu City\n10:20 PM - ETA Cebu City HOME!!!\n\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down on your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/iamcjestrada\nTwitter: https://twitter.com/iamcjestrada_\nInstagram: https://instagram.com/iamcjestrada\nBlog: https://www.foureyedlaagan.com\n\nGadgets Used:\n\nCamera: Panasonic Lumix G7 - https://bit.ly/CJEstradalumixg7\nMicrophone: Rode Video Micro - https://bit.ly/CJEstradaRodeMicro\nGorilla Pod: CDR-King gorilla pod - https://bit.ly/CJEstradaGorillaPod\n\nEditor:\nAdobe Premiere Pro\n\nMusic by:\n\nDJ Quads\nJoakim Karud\nIkson\nSilent Partner', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/LUc275DSow4/default.jpg', 875, 60, 0, 58, NULL, '117671937129903037593', NULL),
('LudLcUV6fvo', 'WELCOME TO GENSAN!!! | #GenSanVenture | VLOG 47', 'Welcome to General Santos City!!!!\n\n1st day of 6 days Mindanao trip and we are staying at PinobreTel Suites for the next few days.\n\nSpecial thanks to our sponsors:\n\nPinobreTel Suites - https://www.facebook.com/pinobretelsuites\n\nPinobre Beach Resort - https://www.facebook.com/PinobreBeachResort/\n\nASUS Philippines - https://www.facebook.com/ASUSph \n\nRanchero Group of Restaurants - https://www.facebook.com/rancherogroup1\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down below your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nFacebook: https://facebook.com/foureyedlaagan\nTwitter: https://twitter.com/foureyedlaagan\nInstagram: https://instagram.com/foureyedlaagan\nBlog: http://www.foureyedlaagan.com\n\nTHANK YOU!!!', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/LudLcUV6fvo/default.jpg', 380, 14, 0, 9, NULL, '117671937129903037593', NULL),
('MIXNZGcqQuU', 'Negros Oriental Adventure - HAPPY BIRTHDAY TO ME!!!', 'Read full story at: http://www.foureyedlaagan.com\nNo copyright infringement intended.', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/MIXNZGcqQuU/default.jpg', 131, 6, 0, 2, NULL, '117671937129903037593', NULL),
('NcnIZnonh4k', 'CONGRATS TO THE GIVEAWAY WINNERS! | BYE CEBU (FOR NOW) | VLOG 75', 'Congrats to the #CJRedCapGiveaway!\n1. Jenny Garcia\n2. Jhon Carlo Aporbo\n3. Kurolicious\n\nPlease PM me on Facebook on how you can get your awesome red cap.\n\nThank you guys for joining!! Till next giveaway. Woohoo!!', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/NcnIZnonh4k/default.jpg', 229, 21, 0, 21, NULL, '117671937129903037593', NULL),
('NEEVisJP0qw', 'SHE CRIED AT THE CONCERT!!! (#MajaOnStage: Maja Salvador Cebu City Concert)', 'Maja Salvador recently hit the stage at IEC Convention Center and had a night of singing, dancing and entertainment.\n\nThank you @queencitycebu for the tickets and we really had fun!\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down on your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/iamcjestrada\nTwitter: https://twitter.com/iamcjestrada_\nInstagram: https://instagram.com/iamcjestrada\nBlog: https://www.foureyedlaagan.com\n\nGadgets Used:\n\nCamera: Panasonic Lumix G7 - https://bit.ly/CJEstradalumixg7\nMicrophone: Rode Video Micro - https://bit.ly/CJEstradaRodeMicro\nGorilla Pod: CDR-King gorilla pod - https://bit.ly/CJEstradaGorillaPod\n\nEditor:\nAdobe Premiere Pro', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/NEEVisJP0qw/default.jpg', 1910, 98, 0, 25, NULL, '117671937129903037593', NULL),
('NjS_f29ShfA', 'FUNNIEST GUESS THAT 90s FILIPINO SNACK CHALLENGE EVER!!! (Bisaya)', 'It''s time for another Challenge video and today''s challenge is "Guess that 90s  Filipino Snack Challenge"!!!\n\nThis challenge video is not possible without the help of these amazing creators, so please follow them on IG and check their blogsites out!!!\n\nWellbein Borja -\nhttps://wellbeinborja.com\nhttps://instagram.com/wellbeinb\n\nJulian Sibi -\nhttps://utterlyrandomtechie.com\nhttps://instagram.com/utterlyrandomtechie\n\nHanna Frejoles -\nhttps://beanintransit.com\nhttps://instagram.com/beanintransit\n\nAldrin Jake Suan -\nhttps://aldrincoremoshpit.com\nhttps://instagram.com/aldrincoremoshpit\n\nRome Nicolas -\nhttps://bastabisaya.com\nhttps://instagram.com/bastabisaya\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down on your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/iamcjestrada\nTwitter: https://twitter.com/iamcjestrada_\nInstagram: https://instagram.com/iamcjestrada\nBlog: https://www.foureyedlaagan.com\n\nGadgets Used:\n\nCamera: Panasonic Lumix G7 - https://bit.ly/CJEstradalumixg7\nMicrophone: Rode Video Micro - https://bit.ly/CJEstradaRodeMicro\nGorilla Pod: Joby Gorillapod 3K Set - http://bit.ly/Joby3KGorillaPod\n\nEditor:\nAdobe Premiere Pro', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/NjS_f29ShfA/default.jpg', 258, 29, 0, 24, NULL, '117671937129903037593', NULL),
('NlsLDw0aDvk', 'SOMETHING HAPPENED IN MANILA | VLOG 87', 'I spent a night at Manila for a purpose - work and family. My second day was a mixture of emotions. Check out my vlog and I hope you enjoyed it.\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down below your thoughts and questions and I''d be happy to read them all! \n\nOrder #FourEyedMerch NOW!: https://www.foureyedlaagan.com/foureyedmerch\n\nLet''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/foureyedlaagan\nTwitter: https://twitter.com/foureyedlaagan\nInstagram: https://instagram.com/foureyedlaagan\nBlog: https://www.foureyedlaagan.com', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/NlsLDw0aDvk/default.jpg', 192, 17, 1, 18, NULL, '117671937129903037593', NULL),
('OYT0I3R7iZI', 'SHOCKED ON WHAT I SAW!!! #4KLens (Bisaya Vlog)', 'Finally, after few weeks, got my new specs to replace my old specs and I was shocked on what I saw!!\n\nLet''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/iamcjestrada\nTwitter: https://twitter.com/iamcjestrada_\nInstagram: https://instagram.com/iamcjestrada\nBlog: https://www.foureyedlaagan.com\n\nGadgets Used:\n\nCamera: Panasonic Lumix G7 - https://bit.ly/CJEstradalumixg7\nMicrophone: Rode Video Micro - https://bit.ly/CJEstradaRodeMicro\nGorilla Pod: CDR-King gorilla pod - https://bit.ly/CJEstradaGorillaPod\n\nEditor:\nAdobe Premier Pro', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/OYT0I3R7iZI/default.jpg', 288, 29, 0, 33, NULL, '117671937129903037593', NULL),
('p5mi_74n3T8', 'THE UKAY-UKAY SHOPPING SPREE! FT. ALDRINCORE MOSHPIT (Cebu City)', 'Uhm, I''m not a fashion blogger but clearly, I enjoyed looking some stuff at the Ukay-ukay store! Thanks to Aldrin for joining me!\n\nCheck out Aldrin''s blog:\nhttp://www.aldrincoremoshpit.com\n\nVlog 121.\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down on your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/iamcjestrada\nTwitter: https://twitter.com/iamcjestrada_\nInstagram: https://instagram.com/iamcjestrada\nBlog: https://www.foureyedlaagan.com\n\nGadgets Used:\n\nCamera: Panasonic Lumix G7 - https://bit.ly/CJEstradalumixg7\nMicrophone: Rode Video Micro - https://bit.ly/CJEstradaRodeMicro\nGorilla Pod: Joby Gorillapod 3K Set - http://bit.ly/Joby3KGorillaPod\n\nEditor:\nAdobe Premiere Pro', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/p5mi_74n3T8/default.jpg', 542, 31, 0, 29, NULL, '117671937129903037593', NULL),
('Pb19fcR6Cig', 'Cuernos de Negros Day 1 - CATCH ME IF I FALL? ! | VLOG 27', 'Cuernos de Negros Day 1!\n\nClimb mountains to test your limits and it was a hell of adventure!!! 3-days trekking at the grandiose #CuernosDeNegros with the ever awesome #NCRTrekkersClub with #OneMC and #TeamRelax. Daghang salamat!!\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down below your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nFacebook: facebook.com/foureyedlaagan\nTwitter: twitter.com/foureyedlaagan\nInstagram: instagram.com/foureyedlaagan\nBlog: www.foureyedlaagan.com\n\nTHANK YOU!!!', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/Pb19fcR6Cig/default.jpg', 341, 23, 0, 32, NULL, '117671937129903037593', NULL),
('pB2eLkVfST8', '#MatteoMadeInCebu: Ipapadama Na lang', '#MatteoMadeInCebu concert in Waterfront Hotel, Lahug, Cebu City\n\nSpecial thanks to #PLDTHomeDSL for the sponsored ticket.\n\nFollow me on social media:\nFacebook: facebook.com/foureyedlaagan\nTwitter: twitter.com/foureyedlaagan\nInstagram: instagram.com/foureyedlaagan\nBlog: https://foureyedlaagan.com', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/pB2eLkVfST8/default.jpg', 136, 1, 0, 0, NULL, '117671937129903037593', NULL),
('PkQFWo-B_co', 'BUSUGA NAKO SA KAN-ANAN! | VLOG 15', 'Kaon time at Kan-Anan, Parklane International Hotel. My fellow bloggers and I had so much fun while getting stuffed and entertained by Kan-Anan and mostly felt the Sinulog vibes! Prititit!!!\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down below your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nFacebook: facebook.com/foureyedlaagan\nTwitter: twitter.com/foureyedlaagan\nInstagram: instagram.com/foureyedlaagan\nBlog: www.foureyedlaagan.com\n\nTHANK YOU!!!', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/PkQFWo-B_co/default.jpg', 129, 6, 0, 0, NULL, '117671937129903037593', NULL);
INSERT INTO `video` (`video_id`, `video_title`, `video_description`, `channel_id`, `channel_title`, `category_id`, `default_thumbnail`, `views_count`, `likes_count`, `dislikes_count`, `comments_count`, `date_accomplished`, `youtuber_id`, `accepted_interest_id`) VALUES
('pLTyTz7Yym0', '#Staycation at Holiday Spa & Hotel', 'Recent #staycation at the near Holiday Spa & Hotel. Thanks to travelbookPH!\n\nLet''s talk in my other accounts!\nFacebook: facebook.com/foureyedlaagan\nTwitter: twitter.com/foureyedlaagan\nInstagram: instagram.com/foureyedlaagan\nBlog: foureyedlaagan.com', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/pLTyTz7Yym0/default.jpg', 305, 5, 0, 2, NULL, '117671937129903037593', NULL),
('pm8YjZpI4lQ', 'I DON''T WANT TO TAKE RISKS', 'Thanks for responding to my tweet last May 14! and I hope you enjoyed my answers. woot woot!\n\n#askCJ #sharePishandLove\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down on your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/iamcjestrada\nTwitter: https://twitter.com/iamcjestrada_\nInstagram: https://instagram.com/iamcjestrada\nBlog: https://www.foureyedlaagan.com\n\nGadgets Used:\n\nCamera: Panasonic Lumix G7 - https://bit.ly/CJEstradalumixg7\nMicrophone: Rode Video Micro - https://bit.ly/CJEstradaRodeMicro\nGorilla Pod: Joby Gorillapod 3K Set - http://bit.ly/Joby3KGorillaPod\n\nEditor:\nAdobe Premiere Pro', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/pm8YjZpI4lQ/default.jpg', 272, 36, 0, 37, NULL, '117671937129903037593', NULL),
('PNtW8jAdldo', 'HANNA''S LOVE SEARCH IN LANDERS AND COOKING SHOW | VLOG 59', 'Adulting hits hard and it''s true. The #bloggerkigwas went to Landers Super Store and bought some stuff. Andddd Hanna of Bean in Transit is searching for lovelife, can she find it in Landers? Furthermore, she decided to cook for us so she doin'' her first cooking show ever!\n\nCONGRATS TO CEBU FINEST''S 5TH ANNIVERSARY!!!\n\nWhat do you think? COMMENT DOWN BELOW!\n\nSubscribe to the channels of my friends:\n\nHanna/Bean in Transit - https://www.youtube.com/channel/UCAy4lSY_ekIdBZJ4DW-3CfQ\n\nFlip/Skip The Flip - https://www.youtube.com/user/flippy0721\n\nCebu Finest - cebufinest.com\n\nPlease LIKE AND SUBSCRIBE!!!', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/PNtW8jAdldo/default.jpg', 427, 20, 0, 24, NULL, '117671937129903037593', NULL),
('PYbTOoCHtSk', 'Saturday Night Parties! | WATCH UNTIL THE END | VLOG 42', 'Party here, party there, party everywhere! Hahaha!\n\nYay! 300 subscibers! Thanks ya''ll! In celebration for this milestone, I''m gonna be doing an ASK ME video next week. Please comment down below using #askCJ hashtag so that I can answer your questions! ????????????\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down below your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nFacebook: facebook.com/foureyedlaagan\nTwitter: twitter.com/foureyedlaagan\nInstagram: instagram.com/foureyedlaagan\nBlog: www.foureyedlaagan.com\n\nTHANK YOU!!!', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/PYbTOoCHtSk/default.jpg', 226, 14, 0, 16, NULL, '117671937129903037593', NULL),
('q29k7NRDya0', 'YOU WON''T BELIEVE WHAT HAPPENS WHEN CREATORS HAVE CHRISTMAS PARTY | VLOG 98', 'First and foremost, sorry for being super shaky. HAHAHA! I was jumpin'' up and down because of the fun and excitement! hahaha!\n\nCebu Weekly Blogging Challengers unite with Cebu Content Creators for a fun-filled night Christmas Party at Center Suites, Escario, Cebu City. This was also the opportunity to recognize finishers and non-finishers of 2017''s weekly blogging challenger where participants were obliged to do and submit 1 blog post whole year! Congrats!!!', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/q29k7NRDya0/default.jpg', 182, 25, 0, 41, NULL, '117671937129903037593', NULL),
('QbColQYM87M', 'Terrazas de Flores Hilarious Jaunt | VLOG 2', 'No copyright infringement intended.', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/QbColQYM87M/default.jpg', 552, 4, 0, 2, NULL, '117671937129903037593', NULL),
('QWNCNPN6b3s', 'Guihulngan City Travel Vlog: Exploring Kansalakan River and Hinakpan Hills', 'Explored Guihulngan City''s natural wonders - Kansalakan Enchanted River and HInakpan Hills. All possible within a half day.\n\nI charted a motorcycle bike at the Central Market for P450 (since I was solo). It was worth the price for the distance and amazing view!\n\nVlog 135.\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down on your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/iamcjestrada\nTwitter: https://twitter.com/iamcjestrada_\nInstagram: https://instagram.com/iamcjestrada\nBlog: https://www.foureyedlaagan.com\n\nGadgets Used:\n\nCamera: Panasonic Lumix G7 - https://bit.ly/CJEstradalumixg7\nMicrophone: Rode Video Micro - https://bit.ly/CJEstradaRodeMicro\nGorilla Pod: Joby Gorillapod 3K Set - http://bit.ly/Joby3KGorillaPod\n\nEditor:\nAdobe Premiere Pro', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/QWNCNPN6b3s/hqdefault.jpg', 119, 16, 0, 27, '2019-02-07', '117671937129903037593', 4),
('Qz6jEtoZeJs', 'UNBOXING! CAPDASE Armor Suit Combo for iPhone 7', 'This is my first ever unboxing video!!! :D\n\nFeaturing the latest from the Capdase, Armor Suit Combo with Newton Cover and Rider jacket best fit for travels and outdoors. With it''s outstanding technology, your phone is surely protected and will let you enjoy more the outdoors.\n\nAdventure and Drop test video will come soon! Stay tuned!\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down below your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nFacebook: facebook.com/foureyedlaagan\nTwitter: twitter.com/foureyedlaagan\nInstagram: instagram.com/foureyedlaagan\nBlog: www.foureyedlaagan.com\n\nTHANK YOU!!!\n\nMusic by: DJ Quads', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/Qz6jEtoZeJs/default.jpg', 810, 14, 3, 19, NULL, '117671937129903037593', NULL),
('RGu6Yu312oY', 'TOP 10 VLOGS OF CJ ESTRADA | 2017 YEAR-END SPECIAL', 'Hey Guys! Welcome to my 2017 Year-end Special! Today we will list down the Top 10 Vlogs of CJ Estrada.\n\nJudged based on the cinematics, fun factor, quality and over-all impact (number of views and shares aren''t counted ^_^).\n\nLinks to the Top 10 Vlogs:\n10. HIKING AND GETTING LOST AT REEDS LAKE | GRAND RAPIDS, MI | VLOG 96 - https://youtu.be/GQ4E6TeFQGg\n\n9. From Waterfalls to Sea Adventure | Travels by Omnia Bellus Part 1 | VLOG 45 - https://youtu.be/vXXNoDbjnUo\n\n8. GAAHH IT''S WIL DASOVICH IN CEBU!!! | VLOG 68 - https://youtu.be/KOeE2pk8_hc\n\n7. PHOTOWALKIN’ WITH CMS | SCOTT KELBY’S WORLDWIDE PHOTOWALK 2017 | VLOG 83 - https://youtu.be/RsyTDzqTgO8\n\n6. FINEST STAYCATION!!! | Mezzo Hotel Cebu | VLOG 58 - https://youtu.be/2pZpcBtHVR0\n\n5. HEART-TUGGING FEELS IN LAKE HOLON! | VLOG 49  - https://youtu.be/dab4hS_V1ug\n\n4. YOU WON''T BELIEVE WHAT HAPPENS WHEN CREATORS HAVE CHRISTMAS PARTY | VLOG 98 - https://youtu.be/q29k7NRDya0\n\n3. I''M TIRED OF VLOGGING! | SPARTAN TRAIL W/ TEAM BANG | VLOG 72 - https://youtu.be/-vLLr5AIxfA\n\n2. WENT CRAZY OVER SPICY NOODLE CHALLENGE X2!!! | VLOG 82 - https://youtu.be/YIPOZjbfa1w\n\n1. THE REVENGE! | MOALBOAL, CEBU | VLOG 74 - https://youtu.be/YrqI1N3K_24\n\nTHANK YOU TO ALL PEOPLE WHO’S IN THE VLOG AND SUPPORTED ME ALL THE WAY!! SEE YOU NEXT YEAR!!!\n\nBdw, it took me almost more than 3 days to edit this video HAHAHA *need more practice*\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down on your thoughts and questions and I''d be happy to read them all! \n\nOrder #FourEyedMerch NOW!: https://www.foureyedlaagan.com/fourey...\n\nLet''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/foureyedlaagan\nTwitter: https://twitter.com/foureyedlaagan\nInstagram: https://instagram.com/foureyedlaagan\nBlog: https://www.foureyedlaagan.com', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/RGu6Yu312oY/default.jpg', 222, 30, 0, 23, NULL, '117671937129903037593', NULL),
('RiNIctiBnZw', 'THE BIGGEST VLOGGER MISTAKE | MOALBOAL DIVING + KAWASAN CANYONEERING | VLOG 63', 'YAZ TO LONG WEEKEND! We went to Moalboal for diving and island hopping that includes Pescador Island, swimming with turtles and sardines run. Also, we went to Badian for an adrenaline-pumping canyoneering adventure.\n\nBUT! Every adventure has mishaps and this time was the worst ever for a vlogger like me. I accidentally deleted ALL PESCADOR CLIPS from my SJCAM and I was like HUHU.\n\nUPDATE 6 PM, I was able to recover 6 out  of almost 50 clips and I''ve included it in the vlog.\n\nSpecial thanks to our sponsor:\n\nRaymund Sande Cebu Adventures\nContact Info:\nhttps://www.facebook.com/raymundsandecebuadventures/', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/RiNIctiBnZw/default.jpg', 401, 19, 0, 43, NULL, '117671937129903037593', NULL),
('RJDUpwiY5bE', 'CONTENT CREATORS UNITE! | #HobFes2017 | VLOG 55', 'It''s an afternoon of fun, learning and collaboration at the Cebu Content Creators Convention held at Parkmall, Mandaue City during the #HobFes2017. Several guest speakers share their tips and thoughts on the stage to the aspiring content creators.\n\nSubscribe to channels of the awesome people in this blog or YouTube channel:\n\nAldrincore Moshpit - http://aldrincoremoshpit.wordpress.com\nBlissful Snapshots - http://blissfulsnapshots.com\nMs. Meeting Adventures - http://www.msmeetingadventures.com\nHuko Productions - https://www.youtube.com/channel/UCSuCmvGI_LbSkDA3y2mXvWQ\nWellbein Borja - https://www.youtube.com/channel/UCMRWphZv5OzqXNfPJ8fEIWg\nSkip The Flip - https://www.youtube.com/user/flippy0721\nBasta Bisaya - http://bastabisaya.com\nBean in Transit - https://www.youtube.com/channel/UCAy4lSY_ekIdBZJ4DW-3CfQ\nJomie Hospital - https://www.youtube.com/user/PoweredByJomie\nMartin Tabanag - https://www.youtube.com/user/martinlouis99\nKalami Cebu - https://www.youtube.com/channel/UCaggFZp28MnvMCr8zGCAXlA\nRamzyrizzle - https://www.youtube.com/user/RamzyRizzle\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down below your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nFacebook: https://facebook.com/foureyedlaagan\nTwitter: https://twitter.com/foureyedlaagan\nInstagram: https://instagram.com/foureyedlaagan\nBlog: http://www.foureyedlaagan.com\n\nMusic credits:\nDJ Quads - Darling\nDJ Quads - I Be Good\nSteps - 5, 6, 7, 8\nSophomore Makeout - Silent Partner\n\nTHANK YOU!!!', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/RJDUpwiY5bE/default.jpg', 240, 18, 0, 43, NULL, '117671937129903037593', NULL),
('RqKWRSeoujY', 'The Other Side of Bantayan | Traveling Bantayan Part 2 | VLOG 38', 'This is Part 2 of Bantayan Adventure! We had an amazing ride amidst the fiery heat of the sun and here are our destinations that day that we surely had an amazing time.\n\nCheck out my blog for further details http://www.foureyedlaagan.com/2017/04/19/road-tripping-beautiful-bantayan-island/\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down below your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nFacebook: facebook.com/foureyedlaagan\nTwitter: twitter.com/foureyedlaagan\nInstagram: instagram.com/foureyedlaagan\nBlog: www.foureyedlaagan.com\n\nTHANK YOU!!!', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/RqKWRSeoujY/default.jpg', 398, 11, 1, 13, NULL, '117671937129903037593', NULL),
('RQV9ty_mqwI', 'WHAT IT''S LIKE TO BE A PINOY IN SINGAPORE? (with Blaire Bustillo)', '#CJAsks: What it''s like to be a Pinoy in Singapore?\n\nSpecial thanks to Sir Blaire Bustillo for answering this #CJAsks episode! Check out his channel for more Singapore content:\n\nhttps://www.youtube.com/user/EmjayCuenco\n\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down on your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/iamcjestrada\nTwitter: https://twitter.com/iamcjestrada_\nInstagram: https://instagram.com/iamcjestrada\nBlog: https://www.foureyedlaagan.com\n\nGadgets Used:\n\nCamera: Panasonic Lumix G7 - https://bit.ly/CJEstradalumixg7\nMicrophone: Rode Video Micro - https://bit.ly/CJEstradaRodeMicro\nGorilla Pod: Joby Gorillapod 3K Set - http://bit.ly/Joby3KGorillaPod\n\nEditor:\nAdobe Premiere Pro', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/RQV9ty_mqwI/default.jpg', 387, 20, 0, 27, NULL, '117671937129903037593', NULL),
('rrOmJf5ELBU', 'REVISITING CEBU''S RICH HISTORY WITH THE GANG!', 'The most awaited event in the Queen City of the South to explore and revisit the colorful history of Cebu is finally here! We get to enjoy and learn the fun and interesting historical facts and trivia about the destinations that we went.\n\nThank you #queencitycebu and #gabiisakabilin for the media pass!\n\nThis is my official entry for the #GabiiSaKabilin2018 vlogging contest.\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down on your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/iamcjestrada\nTwitter: https://twitter.com/iamcjestrada_\nInstagram: https://instagram.com/iamcjestrada\nBlog: https://www.foureyedlaagan.com\n\nGadgets Used:\n\nCamera: Panasonic Lumix G7 - https://bit.ly/CJEstradalumixg7\nMicrophone: Rode Video Micro - https://bit.ly/CJEstradaRodeMicro\nGorilla Pod: Joby Gorillapod 3K Set - http://bit.ly/Joby3KGorillaPod\n\nEditor:\nAdobe Premiere Pro', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/rrOmJf5ELBU/default.jpg', 243, 21, 0, 43, NULL, '117671937129903037593', NULL),
('RsyTDzqTgO8', 'PHOTOWALKIN’ WITH CMS | SCOTT KELBY’S WORLDWIDE PHOTOWALK 2017 | VLOG 83', '‘Sup people in the world! Recently, I participated the Scott Kelby’s Worldwide Photo 2017 with the Cebu Mobile Shutterbugs. We took photos from the busy streets of Cebu City and check out our photos using #CMSWWPW. Also, check out my photos at the end of the video.\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down below your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nFacebook: https://facebook.com/foureyedlaagan\nTwitter: https://twitter.com/foureyedlaagan\nInstagram: https://instagram.com/foureyedlaagan\nBlog: https://www.foureyedlaagan.com', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/RsyTDzqTgO8/default.jpg', 376, 29, 0, 31, NULL, '117671937129903037593', NULL),
('rtHZSHx07ws', 'MT. LANAYA, CEBU // LOOK WHAT WE''VE FOUND AT THE PEAK', 'Mt. Lanaya, hailed to be one of the hardest mountains to trek in Cebu due to the seemingly never-ending uphill trek up to 70 degrees but with a very breathtaking view from the campsite in Legaspi and at the Kalo-Kalo Peak.\n\nTRAVEL GUIDE: https://bit.ly/LanayaTravelGuide\n\nThank you Laag Bisaya for accommodating me even if I haven''t registered for your event. bwahaha!\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down on your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/iamcjestrada\nTwitter: https://twitter.com/iamcjestrada_\nInstagram: https://instagram.com/iamcjestrada\nBlog: https://www.foureyedlaagan.com\n\nGadgets Used:\n\nCamera: Panasonic Lumix G7 - https://bit.ly/CJEstradalumixg7\nMicrophone: Rode Video Micro - https://bit.ly/CJEstradaRodeMicro\nGorilla Pod: Joby Gorillapod 3K Set - http://bit.ly/Joby3KGorillaPod\n\nEditor:\nAdobe Premiere Pro', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/rtHZSHx07ws/default.jpg', 673, 28, 0, 32, NULL, '117671937129903037593', NULL),
('rvArJO_a_5s', 'LAST DAY IN GRAND RAPIDS, MICHIGAN | VLOG 97', 'Finally, it''s my last day in Grand Rapids, MI! Time to go hooomee! \n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down below your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nFacebook: https://facebook.com/foureyedlaagan\nTwitter: https://twitter.com/foureyedlaagan\nInstagram: https://instagram.com/foureyedlaagan\nBlog: http://www.foureyedlaagan.com\n\nTHANK YOU!!!', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/rvArJO_a_5s/default.jpg', 391, 27, 1, 42, NULL, '117671937129903037593', NULL),
('ryPHNQgNLTo', 'INTENSE STREET BATTLE!!!  (120th Anniversary of the Battle of Tres de Abril)', 'As part of the 120th Anniversary of the Battle of Tres de Abril and Palm Grass Hotel''s, the only heritage hotel in Cebu, anniversary, eskrimadors of Cacoy Doce Pares re-enact the battle against Spanish colonizers.\n\nTogether with their leader, General Pantaleon "Leon Kilat" Solde Villegas, they bravely conquered the Spanish colonizers and faced victory.\n\nIf you want to witness Cebu''s heritage and culture, book your stay at the Palm Grass Hotel. \n\nPalm Grass Hotel is located at 68 General Junquera Street, Cebu City, Cebu, Philippines.\n\nVlog 117.\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down on your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/iamcjestrada\nTwitter: https://twitter.com/iamcjestrada_\nInstagram: https://instagram.com/iamcjestrada\nBlog: https://www.foureyedlaagan.com\n\nGadgets Used:\n\nCamera: Panasonic Lumix G7 - https://bit.ly/CJEstradalumixg7\nMicrophone: Rode Video Micro - https://bit.ly/CJEstradaRodeMicro\nGorilla Pod: Joby Gorillapod 3K Set - http://bit.ly/Joby3KGorillaPod\n\nEditor:\nAdobe Premiere Pro', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/ryPHNQgNLTo/default.jpg', 162, 13, 0, 18, NULL, '117671937129903037593', NULL),
('sErBvbU-KkU', 'BIRTHDAY BASH, CMS OUTREACH AND MORE!!! | VLOG 99', 'It''s December and it means birthday and the season of sharing!!! In this vlog, let me take you on how I celebrated my birthday with my friends and workmates and the outreach activity I joined with Cebu Mobile Shutterbugs!\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down on your thoughts and questions and I''d be happy to read them all! \n\nOrder #FourEyedMerch NOW!: https://www.foureyedlaagan.com/fourey...\n\nLet''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/foureyedlaagan\nTwitter: https://twitter.com/foureyedlaagan\nInstagram: https://instagram.com/foureyedlaagan\nBlog: https://www.foureyedlaagan.com', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/sErBvbU-KkU/default.jpg', 217, 17, 0, 24, NULL, '117671937129903037593', NULL),
('SnzjZhy20v4', 'FAT DOIS: BEST PLACE FOR YOUR CHEESY FOOD CRAVINGS', 'WHERE TO EAT IN CEBU? Check out FAT DOIS'' latest food - CHREEMPS and their version of DOSIRAK!\n\nVisit Fat Dois at A.S. Fortuna St, Mandaue City (near Oakridge) or follow them on social media @fatdoiscebu\n\nvlog 139 #FatDoisCebu #LamiKaayo\n\nLet''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/iamcjestrada\nTwitter: https://twitter.com/iamcjestrada_\nInstagram: https://instagram.com/iamcjestrada\nBlog: https://www.foureyedlaagan.com\n\nGadgets Used:\n\nCamera: Panasonic Lumix G7 - https://bit.ly/CJEstradalumixg7\nMicrophone: Rode Video Micro - https://bit.ly/CJEstradaRodeMicro\nGorilla Pod: Joby Gorillapod 3K Kit - http://bit.ly/Joby3KGorillaPod\n\nEditor:\nAdobe Premiere Pro', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/SnzjZhy20v4/default.jpg', 458, 20, 0, 23, NULL, '117671937129903037593', NULL),
('SRv48BChB-Y', 'Best Island Hopping Team Outing Ever! Part 1 | VLOG 31', 'Well, we had one amazing team outing! Unlimited laughs and wacky moments, can''t move on! Hahaha!\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down below your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nFacebook: facebook.com/foureyedlaagan\nTwitter: twitter.com/foureyedlaagan\nInstagram: instagram.com/foureyedlaagan\nBlog: www.foureyedlaagan.com\n\nTHANK YOU!!!\n\nMusic by: DJ Quads', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/SRv48BChB-Y/default.jpg', 232, 8, 0, 26, NULL, '117671937129903037593', NULL),
('T2R954f1kTk', 'Piliin mo ang Pilipinas (karaoke-shortened)', '', 'UCzVJzbTxCFSFbjbpDQ1Yblg', 'Arnold Agura', 11, 'https://i.ytimg.com/vi/T2R954f1kTk/default.jpg', 1507, 3, 0, 0, NULL, '107428558023590518907', NULL),
('T5BG2d9WIP0', 'SIQUIJOR: EXPLORING THE MYSTIC ISLAND WITH GOPRO FUSION', 'SIQUIJOR - tagged as the Mystical Island because of the spooky stories of the past but the real beauty of this paradise came to witness to my four eyes.\n\nI got to explore this beautiful island again and captured its magic with my #GoProFusion.\n\nLet''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/iamcjestrada\nTwitter: https://twitter.com/iamcjestrada_\nInstagram: https://instagram.com/iamcjestrada\nBlog: https://www.foureyedlaagan.com\n\nGadgets Used:\n\nCamera: Panasonic Lumix G7 - https://bit.ly/CJEstradalumixg7\nMicrophone: Rode Video Micro - https://bit.ly/CJEstradaRodeMicro\nGorilla Pod: Joby Gorillapod 3K Kit - http://bit.ly/Joby3KGorillaPod\n\nEditor:\nAdobe Premiere Pro\n\nMusic by:\nCartoon - On and On (ft. Daniel Levi)', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/T5BG2d9WIP0/default.jpg', 553, 22, 0, 45, NULL, '117671937129903037593', NULL),
('t6rG13XQKRk', 'ONE CENTRAL HOTEL CEBU TOUR AND CRAZY BLOGGER MOMENTS (Bisaya Vlog)', 'Finally back in my hometown - Cebu! This time, me and my friends from #CebuContentCreators went on a tour of One Central Hotel, the newest hotel in Downtown Cebu. It was fun and crazy good!\n\nOne Central Hotel offers 3 sets of Barkada Meal Packages - The Western Comfort Food, Asian Cuisine and True-blue Cebuano - that will surely fill up your empty stomachs!\n\n#TakeMeToOneCentralHotel and Check out their facebook page for more info:\nhttps://www.facebook.com/OneCentralHotel/\n\nPowered by #GoProFusion.\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down on your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/iamcjestrada\nTwitter: https://twitter.com/iamcjestrada_\nInstagram: https://instagram.com/iamcjestrada\nBlog: https://www.foureyedlaagan.com\n\nGadgets Used:\n\nCamera: Panasonic Lumix G7 - https://bit.ly/CJEstradalumixg7\nMicrophone: Rode Video Micro - https://bit.ly/CJEstradaRodeMicro\nGorilla Pod: Joby Gorillapod 3K Set - http://bit.ly/Joby3KGorillaPod\n\nEditor:\nAdobe Premiere Pro', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/t6rG13XQKRk/default.jpg', 467, 24, 1, 17, NULL, '117671937129903037593', NULL),
('tpF9AWunwLg', 'MOST ORGANIZED SINULOG TO DATE??? (Sinulog 2018, Cebu City, Philippines)', 'VIVA PIT SENYOR!!!\n\nHere''s what happened during the grandest festival of the city, #Sinulog2018 and I have a question - Is this the most organized and most peaceful Sinulog celebration to date?\n\nCOMMENT down your opinion :)\n\nVlog 107.\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down on your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/iamcjestrada\nTwitter: https://twitter.com/iamcjestrada_\nInstagram: https://instagram.com/iamcjestrada\nBlog: https://www.foureyedlaagan.com\n\nGadgets Used:\n\nCamera: Panasonic Lumix G7 - https://bit.ly/CJEstradalumixg7\nMicrophone: Rode Video Micro - https://bit.ly/CJEstradaRodeMicro\nGorilla Pod: CDR-King gorilla pod - https://bit.ly/CJEstradaGorillaPod\n\nEditor:\nAdobe Premier Pro', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/tpF9AWunwLg/default.jpg', 3513, 125, 0, 100, NULL, '117671937129903037593', NULL),
('tVLUYEiDcLo', 'FIRST TIME!!! BUDLAAN FALLS FILM SHOOTING FT. MARTIN TABANAG', 'It''s my first time to be featured on an amazing film by an amazing YouTuber - Martin Tabanag - on his #WhatsYourStory segment.\n\nWatch the episode here: https://youtu.be/TgLG8wa2ST0\n\nThe shoot is not easy to them because it''s their first time doing a long trek, so here you can see their struggles and laughters.\n\nSubscribe to Martin''s Channel for amazing videos:\nhttps://youtube.com/martintabanag\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down on your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/iamcjestrada\nTwitter: https://twitter.com/iamcjestrada_\nInstagram: https://instagram.com/iamcjestrada\nBlog: https://www.foureyedlaagan.com\n\nGadgets Used:\n\nCamera: Panasonic Lumix G7 - https://bit.ly/CJEstradalumixg7\nMicrophone: Rode Video Micro - https://bit.ly/CJEstradaRodeMicro\nGorilla Pod: Joby Gorillapod 3K Set - http://bit.ly/Joby3KGorillaPod\n\nEditor:\nAdobe Premiere Pro', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/tVLUYEiDcLo/default.jpg', 221, 21, 0, 24, NULL, '117671937129903037593', NULL),
('UEv_7Afd6P0', 'SAAN AABOT ANG 1K MO? | METRO SIDEWALK SALE | VLOG 80', 'Saan aabot ang 1K mo??? Dito saaaa Metro Ayala Cebu!!!\n\nAll Metro Stores is on SIDEWALK SALE!! Items are on 50% or more discounts!!! Check out http://cebufinest.com for more details!\n\nP.S. We got a permission from the management to film inside the store. ;)', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/UEv_7Afd6P0/default.jpg', 248, 9, 0, 14, NULL, '117671937129903037593', NULL),
('UJkPFaDg9Rs', 'FIRST CONCERT AT BAYFRONT HOTEL CEBU! | VLOG 81', 'Orayt! Just had my first concert at Bayfront Hotel Cebu!!\n\nCheck out #BayfrontHotelCebu''s page for latest updates of their accommodation and facilities:\n\nhttps://www.facebook.com/bayfrontcebu/\n\nALSO READ: Top 5 Reasons why you should stay at Bayfront Hotel Cebu: http://www.foureyedlaagan.com/2017/09/24/top-5-reasons-stay-bayfront-hotel-cebu/\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down below your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nFacebook: https://facebook.com/foureyedlaagan\nTwitter: https://twitter.com/foureyedlaagan\nInstagram: https://instagram.com/foureyedlaagan\nBlog: http://www.foureyedlaagan.com', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/UJkPFaDg9Rs/default.jpg', 420, 19, 0, 18, NULL, '117671937129903037593', NULL),
('uqVjVCRq91g', 'CAPITANCILLO: AN ESCAPADE TO THE RUINED ISLET (Cebu)', 'This is our Day 2 of our #ExploreTabogon trip with #bunziescove and we got to explore the islet nearby (belongs to Bogo town) - the Capitancillo. It''s a beautiful islet and it has ruins really good for pictures and videos.\n\nAlso, we went to a nearby attraction - the Guiwanon Spring - a brackish area in Tabogon town. We spent a few minutes there before going back to Bunzies Cove.\n\nCheck out Bunzies Cove for the best accommodation in Tabogon, Cebu!:\nhttp://bunziescove.com\n\nvlog 130.\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down on your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/iamcjestrada\nTwitter: https://twitter.com/iamcjestrada_\nInstagram: https://instagram.com/iamcjestrada\nBlog: https://www.foureyedlaagan.com\n\nGadgets Used:\n\nCamera: Panasonic Lumix G7 - https://bit.ly/CJEstradalumixg7\nMicrophone: Rode Video Micro - https://bit.ly/CJEstradaRodeMicro\nGorilla Pod: Joby Gorillapod 3K Set - http://bit.ly/Joby3KGorillaPod\n\nEditor:\nAdobe Premiere Pro', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/uqVjVCRq91g/default.jpg', 347, 26, 1, 23, NULL, '117671937129903037593', NULL),
('v1qZ8i9vYaY', 'Balik Alindog Program | MUAY THAI CEBU | VLOG 41', 'First MUAY THAI experience ever!!! Makes me wanna come back practicing Karatedo!!\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down below your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nFacebook: facebook.com/foureyedlaagan\nTwitter: twitter.com/foureyedlaagan\nInstagram: instagram.com/foureyedlaagan\nBlog: www.foureyedlaagan.com\n\nTHANK YOU!!!', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/v1qZ8i9vYaY/default.jpg', 686, 17, 0, 18, NULL, '117671937129903037593', NULL),
('V2w3aad2cAk', '7 TREKKING TIPS FOR BEGINNERS', 'Trekking is indeed a risky and extreme adventure but is one of the best things to do in life.\n\nThere are things you need to remember and think before and during your trek and check out my tips for beginners in trekking!\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down on your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/iamcjestrada\nTwitter: https://twitter.com/iamcjestrada_\nInstagram: https://instagram.com/iamcjestrada\nBlog: https://www.foureyedlaagan.com\n\nGadgets Used:\n\nCamera: Panasonic Lumix G7 - https://bit.ly/CJEstradalumixg7\nMicrophone: Rode Video Micro - https://bit.ly/CJEstradaRodeMicro\nGorilla Pod: Joby Gorillapod 3K Set - http://bit.ly/Joby3KGorillaPod\n\nEditor:\nAdobe Premiere Pro', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/V2w3aad2cAk/default.jpg', 691, 24, 1, 31, NULL, '117671937129903037593', NULL),
('vXXNoDbjnUo', 'From Waterfalls to Sea Adventure | Travels by Omnia Bellus Part 1 | VLOG 45', 'This is our Day 1 of our amazing weekend getaway. Cebu Round South experience at its best! Special thanks to Travels By Omnia Bellus for a remarkable and exception van for hire and tour services.\n\nCheck out my blog for the details of this trip: http://www.foureyedlaagan.com/2017/05/24/8-destinations-awesome-cebu-south-adventure/\n\nInquire and book your travels now at #TravelsByOmniaBellus!\n\nhttps://www.facebook.com/travelsbyomniabellus/\n\nFollow the blogs of the people in this vlog:\n\nBisdak Explorer - http://thebisdakexplorer.blogspot.com\nChasing Potatoes - http://chasingpotatoes.com\nVivomigsgee - http://vivomigsgee.com\nEAZY Traveler - http://eazytraveler.net\nTracking Treasure - http://trackingtreasure.net\nFour-eyed Laagan - http://www.foureyedlaagan.com\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down below your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nFacebook: https://facebook.com/foureyedlaagan\nTwitter: https://twitter.com/foureyedlaagan\nInstagram: https://instagram.com/foureyedlaagan\nBlog: http://www.foureyedlaagan.com\n\nTHANK YOU!!!', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/vXXNoDbjnUo/default.jpg', 334, 17, 0, 23, NULL, '117671937129903037593', NULL),
('vYcxopGK8XE', 'SINULOG 2018 PROCESSION AND EPIC PYROFEST (Cebu City, Philippines)', 'It''s the day before the Sinulog 2018 Grand Parade and we joined the annual devotional activities such as the Solemn Procession.\n\nThen the squad goes to SM City Cebu to witness the Pyrofest Competition and then watched the Insidious movie right after!\n\nVideo Credits:\nFluvial Parade Timelapse - https://instagram.com/kev.incredible\n\nRaw Vlog 106.\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down on your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/iamcjestrada\nTwitter: https://twitter.com/iamcjestrada_\nInstagram: https://instagram.com/iamcjestrada\nBlog: https://www.foureyedlaagan.com\n\nGadgets Used:\n\nCamera: Panasonic Lumix G7 - https://bit.ly/CJEstradalumixg7\nMicrophone: Rode Video Micro - https://bit.ly/CJEstradaRodeMicro\nGorilla Pod: CDR-King gorilla pod - https://bit.ly/CJEstradaGorillaPod\n\nEditor:\nAdobe Premiere Pro', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/vYcxopGK8XE/default.jpg', 544, 33, 0, 27, NULL, '117671937129903037593', NULL),
('VzbefVrRD6c', 'MODEL OF AN ARTWORK?! FT. ALDRINCORE AND CEBU MOBILE SHUTTERBUGS', '#ArtForEveryone2018 is an annual event where local artists, photographers, digital artists showcase their work in an exhibit for a week.\n\nThe exhibit will run from August 27, 2018 to September 2, 2018 at the Art Center of SM City Cebu.\n\nLet''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/iamcjestrada\nTwitter: https://twitter.com/iamcjestrada_\nInstagram: https://instagram.com/iamcjestrada\nBlog: https://www.foureyedlaagan.com\n\nGadgets Used:\n\nCamera: Panasonic Lumix G7 - https://bit.ly/CJEstradalumixg7\nMicrophone: Rode Video Micro - https://bit.ly/CJEstradaRodeMicro\nGorilla Pod: Joby Gorillapod 3K Kit - http://bit.ly/Joby3KGorillaPod\n\nEditor:\nAdobe Premiere Pro', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/VzbefVrRD6c/default.jpg', 94, 9, 1, 7, NULL, '117671937129903037593', NULL),
('W0pyYzKGQEY', 'I REGRET! | Eating Jollibee''s Choco Mallow Pie | VLOG 56', 'I REGRET! That I only bought 1 choco mallow pie, Jollibee''s newest dessert. It tastes so good!\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down below your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nFacebook: https://facebook.com/foureyedlaagan\nTwitter: https://twitter.com/foureyedlaagan\nInstagram: https://instagram.com/foureyedlaagan\nBlog: http://www.foureyedlaagan.com\n\nTHANK YOU!!!', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/W0pyYzKGQEY/default.jpg', 962, 23, 1, 38, NULL, '117671937129903037593', NULL),
('WC6nYzMiviM', '#MatteoMadeInCebu: Mannequin challenge with Martin Nievera', '#MatteoMadeInCebu concert in Waterfront Hotel, Lahug, Cebu City\n\nSpecial thanks to #PLDTHomeDSL for the sponsored ticket.\n\nFollow me on social media:\nFacebook: facebook.com/foureyedlaagan\nTwitter: twitter.com/foureyedlaagan\nInstagram: instagram.com/foureyedlaagan\nBlog: https://foureyedlaagan.com', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/WC6nYzMiviM/default.jpg', 494, 0, 0, 0, NULL, '117671937129903037593', NULL),
('WcxZpJGvMug', 'Cuernos de Negros Day 3 - ACHIEVEMENT UNLOCKED! | VLOG 29', 'Cuernos de Negros Day 3!\n\nFor complete details of our major trek, please visit my blog www.foureyedlaagan.com.\n\nAlso, please watch Day 1 and Day 2 on my YouTube Channel to see and relive our entire journey.\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down below your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nFacebook: facebook.com/foureyedlaagan\nTwitter: twitter.com/foureyedlaagan\nInstagram: instagram.com/foureyedlaagan\nBlog: www.foureyedlaagan.com\n\nTHANK YOU!!!\n\nMusic by: DJ Quads', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/WcxZpJGvMug/default.jpg', 242, 17, 0, 32, NULL, '117671937129903037593', NULL),
('WDiM_GEiCNc', '#CJASKS - If you were given a chance to travel, where would it be and why?', 'Episode 1. #CJAsks is a monthly series where I got to ask a question to random people in malls, tourist spots or basically anywhere!\n\nComment your answers below to today''s question and I would love to hear that: IF YOU WERE GIVEN A CHANCE TO TRAVEL WITHIN THE PHILIPPINES, WHERE WOULD IT BE AND WHY?\n\nGot an amazing question that you would want me to ask for the next episode? Comment it also with hashtag #CJAsks\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down on your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/iamcjestrada\nTwitter: https://twitter.com/iamcjestrada_\nInstagram: https://instagram.com/iamcjestrada\nBlog: https://www.foureyedlaagan.com\n\nGadgets Used:\n\nCamera: Panasonic Lumix G7 - https://bit.ly/CJEstradalumixg7\nMicrophone: Rode Video Micro - https://bit.ly/CJEstradaRodeMicro\nGorilla Pod: CDR-King gorilla pod - https://bit.ly/CJEstradaGorillaPod\n\nEditor:\nAdobe Premier Pro', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/WDiM_GEiCNc/default.jpg', 232, 19, 0, 42, NULL, '117671937129903037593', NULL),
('WEY5KBMitPs', 'WHAT A WEEK IT HAS BEEN! PLUS 500 SUBS GIVEAWAY! | VLOG 73', 'THANK YOU FOR BEING WITH ME!\n\nYayy! 500 subs and counting! At dahil jan, I''m giving away THREE FOUR-EYED LAAGAN RED CAPS and here''s the mechanics:\n\n1. Subscribe to my YouTube channel: https://youtube.com/CJEstrada\n\n2. Like this YouTube video and share it in your Facebook with hashtag #CJRedCapGiveaway (make sure to make your post PUBLIC)\n\n3. Comment on my YouTube video anything you want to say. (Because sometimes I couldn''t see public posts if we''re not FB friends. Weird! Lol)\n\n4. Cebu only.. sorry :(\n\n5. THREE Lucky Winners will be announced next week on my next vlog at August 15th!\n\nGood luck and thank you!!!\n\nAnd oh, MERCH COMIN'' UP SOON!!! \n\nOh, by the way, I just took you to my boring week. So please like and subscribe! ????', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/WEY5KBMitPs/default.jpg', 242, 32, 0, 67, NULL, '117671937129903037593', NULL),
('WMTlBIYoaKM', 'EKSIBISYON UNO (Cebu Mobile Shutterbugs'' Anniversary Special)', 'Vlog 109. Cebu Mobile Shutterbugs celebrates its first year anniversary with workshops and exhibit featuring Top 45 photos of the members from last year, all using mobile phones!\n\nVisit our exhibit at SM City Cebu 3rd Floor (fronting Maxx''s Restaurant). Exhibit runs from Feb. 4 to Feb 11.\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down on your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/iamcjestrada\nTwitter: https://twitter.com/iamcjestrada_\nInstagram: https://instagram.com/iamcjestrada\nBlog: https://www.foureyedlaagan.com\n\nGadgets Used:\n\nCamera: Panasonic Lumix G7 - https://bit.ly/CJEstradalumixg7\nMicrophone: Rode Video Micro - https://bit.ly/CJEstradaRodeMicro\nGorilla Pod: CDR-King gorilla pod - https://bit.ly/CJEstradaGorillaPod\n\nEditor:\nAdobe Premier Pro', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/WMTlBIYoaKM/default.jpg', 334, 37, 0, 28, NULL, '117671937129903037593', NULL),
('WtavtTCJ9_o', 'WHAT IT FEELS TO TRAVEL ACROSS THE WORLD? | VLOG 91', 'Approximately a total of 18 hours of 3 connecting flights and 8 hours lay overs in big airports! Deymm SABAW!\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down below your thoughts and questions and I''d be happy to read them all! \n\nOrder #FourEyedMerch NOW!: https://www.foureyedlaagan.com/foureyedmerch\n\nGadgets used:\n\nCamera (iPhone 6s) - https://goo.gl/yhwsPX\nGorilla Pod: https://goo.gl/Do1DPW\nBuy your gadgets here: https://goo.gl/LYf5Ne\n\nLet''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/foureyedlaagan\nTwitter: https://twitter.com/foureyedlaagan\nInstagram: https://instagram.com/foureyedlaagan\nBlog: https://www.foureyedlaagan.com', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/WtavtTCJ9_o/default.jpg', 467, 48, 0, 59, NULL, '117671937129903037593', NULL),
('wzP1QWi3g-o', '#MakeITSafePH: Disconnect to Connect', '#MakeITSafePH campaign promotes education to consumers about online threats such as phishing, scamming and cyberbullying and what they can do to avoid becoming a victim.  The campaign also teaches the public proper online etiquette so that they would not become a source of such deplorable behavior.\n\nThis video is a collaboration with Globe''s #MakeITSafePH campaign.\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down on your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/iamcjestrada\nTwitter: https://twitter.com/iamcjestrada_\nInstagram: https://instagram.com/iamcjestrada\nBlog: https://www.foureyedlaagan.com\n\nGadgets Used:\n\nCamera: Panasonic Lumix G7 - https://bit.ly/CJEstradalumixg7\nMicrophone: Rode Video Micro - https://bit.ly/CJEstradaRodeMicro\nGorilla Pod: CDR-King gorilla pod - https://bit.ly/CJEstradaGorillaPod\n\nEditor:\nAdobe Premier Pro', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/wzP1QWi3g-o/default.jpg', 232, 26, 0, 21, NULL, '117671937129903037593', NULL),
('x-5yJzZxrAo', 'EXTREME CROSSFIT WORKOUT AT SOUTHSIDE FITNESS CEBU', 'We just had a taste of some CrossFit workouts and had an amazing experience at Southside Fitness Cebu!\n\nBe #SouthsideStrong, visit their page on Facebook for inquiries:\nhttps://facebook.com/southsidefitnesscebu\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down on your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/iamcjestrada\nTwitter: https://twitter.com/iamcjestrada_\nInstagram: https://instagram.com/iamcjestrada\nBlog: https://www.foureyedlaagan.com\n\nGadgets Used:\n\nCamera: Panasonic Lumix G7 - https://bit.ly/CJEstradalumixg7\nMicrophone: Rode Video Micro - https://bit.ly/CJEstradaRodeMicro\nGorilla Pod: Joby Gorillapod 3K Set - http://bit.ly/Joby3KGorillaPod\n\nEditor:\nAdobe Premiere Pro', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/x-5yJzZxrAo/default.jpg', 371, 14, 0, 14, NULL, '117671937129903037593', NULL),
('xEPvt_fjX6E', 'Cuernos de Negros Day 2 - That BIG Notch! | VLOG 28', 'Day 2 of Cuernos de Negros Major Trek!\n\nFor complete details of our climb, visit my blog http://www.foureyedlaagan.com :)\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down below your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nFacebook: facebook.com/foureyedlaagan\nTwitter: twitter.com/foureyedlaagan\nInstagram: instagram.com/foureyedlaagan\nBlog: www.foureyedlaagan.com\n\nTHANK YOU!!!\n\nMusic by: DJ Quads', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/xEPvt_fjX6E/default.jpg', 315, 16, 0, 30, NULL, '117671937129903037593', NULL),
('xJs5LPeZ7rA', 'WHAT ARE YOUR PLANS THIS VALENTINE''S DAY? (Bisaya Vlog)', 'It''s the most loving season of the year but a lot of people are still salty/bitter about it. hahaha single man gud mao na bwahahaha\n\nCheck out how Cebuano''s plan out Valentines Day this 2018!\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down on your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/iamcjestrada\nTwitter: https://twitter.com/iamcjestrada_\nInstagram: https://instagram.com/iamcjestrada\nBlog: https://www.foureyedlaagan.com\n\nMusic by:\nSAAD - Arn Dela Cruz - https://goo.gl/tqbdoD\n\nGadgets Used:\n\nCamera: Panasonic Lumix G7 - https://bit.ly/CJEstradalumixg7\nMicrophone: Rode Video Micro - https://bit.ly/CJEstradaRodeMicro\nGorilla Pod: CDR-King gorilla pod - https://bit.ly/CJEstradaGorillaPod\n\nEditor:\nAdobe Premier Pro', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/xJs5LPeZ7rA/default.jpg', 348, 31, 0, 49, NULL, '117671937129903037593', NULL),
('xOtACohmsdE', 'FIRST TIME! Blogging Tips for Beginners | VLOG 17', 'I really had a blast sharing my thoughts and experiences to young minds about blogging. I hope they learned a lot and will inculcate the tips I''ve mentioned.\n\nThank you USC-North Campus'' TLE Department for the invite!\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down below your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nFacebook: facebook.com/foureyedlaagan\nTwitter: twitter.com/foureyedlaagan\nInstagram: instagram.com/foureyedlaagan\nBlog: www.foureyedlaagan.com\n\nTHANK YOU!!!\n\nMUSIC CREDITS TO: DJ Squads - Fading', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/xOtACohmsdE/default.jpg', 693, 15, 0, 14, NULL, '117671937129903037593', NULL),
('xsiYe3l4awE', 'THE BEST VALENTINE''S DATE EVER', 'Here''s what happened on my valentine''s day. vlog 112\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down on your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/iamcjestrada\nTwitter: https://twitter.com/iamcjestrada_\nInstagram: https://instagram.com/iamcjestrada\nBlog: https://www.foureyedlaagan.com\n\nGadgets Used:\n\nCamera: Panasonic Lumix G7 - https://bit.ly/CJEstradalumixg7\nMicrophone: Rode Video Micro - https://bit.ly/CJEstradaRodeMicro\nGorilla Pod: CDR-King gorilla pod - https://bit.ly/CJEstradaGorillaPod\n\nEditor:\nAdobe Premier Pro', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/xsiYe3l4awE/default.jpg', 294, 21, 0, 25, NULL, '117671937129903037593', NULL),
('xztgRWchCXA', 'CHILL MACTAN SUNSET CRUISE WITH ABENTURA VISAYAN CRUISES', 'Epic fail sunset cruise because of the not-so-good weather. No glorious sunset showed so it turned out be just "cruising" hahahahaha\n\nSpecial thanks to Abentura Visayan Cruises! Book your Epic Mactan Sunset Cruise now at:\nhttp://www.abenturacruises.ph\n\nOr visit their Facebook page at:\nhttps://www.facebook.com/adventurervisayan/\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down on your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/iamcjestrada\nTwitter: https://twitter.com/iamcjestrada_\nInstagram: https://instagram.com/iamcjestrada\nBlog: https://www.foureyedlaagan.com\n\nGadgets Used:\n\nCamera: Panasonic Lumix G7 - https://bit.ly/CJEstradalumixg7\nMicrophone: Rode Video Micro - https://bit.ly/CJEstradaRodeMicro\nGorilla Pod: CDR-King gorilla pod - https://bit.ly/CJEstradaGorillaPod\n\nEditor:\nAdobe Premier Pro', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/xztgRWchCXA/default.jpg', 174, 16, 0, 25, NULL, '117671937129903037593', NULL),
('YIPOZjbfa1w', 'WENT CRAZY OVER SPICY NOODLE CHALLENGE X2!!! | VLOG 82', 'What is the best way to wipe out stress? Syempre FOOD! Last Friday, I got to invite my fellow colleague and blogger friend, Eloise of Ms. Meeting Adventures and we took the challenge that Internet goes crazy, the #SpicyNoodleChallenge!\n\nVisit Eloise’s blog and follow her on social media:\nhttp://msmeetingadventures.com\nhttps://facebook.com/msmeetingadventures\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down below your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nFacebook: https://facebook.com/foureyedlaagan\nTwitter: https://twitter.com/foureyedlaagan\nInstagram: https://instagram.com/foureyedlaagan', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/YIPOZjbfa1w/default.jpg', 410, 40, 0, 35, NULL, '117671937129903037593', NULL),
('yOjtmdL3u7c', 'Dumaguete Tempura Challenge - MY FACE SAYS IT ALL!', 'Today I tried the most recommended #DumagueteTempuraChallenge! Burnin'' yummy it is! My face says it all! Hahahaha!\n\nLet''s talk on my other social media accounts:\nFacebook: https://facebook.com/foureyedlaagan\nTwitter: https://twitter.com/foureyedlaagan\nInstagram: https://instagram.com/foureyedlaagan\nBlog: www.foureyedlaagan.com', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/yOjtmdL3u7c/default.jpg', 180, 8, 0, 7, NULL, '117671937129903037593', NULL);
INSERT INTO `video` (`video_id`, `video_title`, `video_description`, `channel_id`, `channel_title`, `category_id`, `default_thumbnail`, `views_count`, `likes_count`, `dislikes_count`, `comments_count`, `date_accomplished`, `youtuber_id`, `accepted_interest_id`) VALUES
('yokUxT2Klmc', 'CRAZIEST FIRST DAY CLASS EXPERIENCE AS A TRANSFEREE', 'I hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down on your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/iamcjestrada\nTwitter: https://twitter.com/iamcjestrada_\nInstagram: https://instagram.com/iamcjestrada\nBlog: https://www.foureyedlaagan.com\n\nGadgets Used:\n\nCamera: Panasonic Lumix G7 - https://bit.ly/CJEstradalumixg7\nMicrophone: Rode Video Micro - https://bit.ly/CJEstradaRodeMicro\nGorilla Pod: Joby Gorillapod 3K Set - http://bit.ly/Joby3KGorillaPod\n\nEditor:\nAdobe Premiere Pro', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/yokUxT2Klmc/default.jpg', 205, 18, 0, 17, NULL, '117671937129903037593', NULL),
('YrqI1N3K_24', 'THE REVENGE! | MOALBOAL, CEBU | VLOG 74', 'Revenge is real! Hahaha! Find out what happened during our Moalboal trip with fellow Cebu Bloggers and def we had a blast!\n\nThank you Cabana Beach Club Resort for this amazing sponsored trip and finally I got some cool shots with Pescador Island and Sardine Run (unlike before hahaha)\n\nCheck out #CabanaMoalboal rates and send ''em inquiries on their facebook page:\n\nhttps://www.facebook.com/CabanaBeachClubResort/\n\nCheck my blog for FAQs:\nhttp://www.foureyedlaagan.com/2017/09/05/faq-moalboal-cebu-non-divers/', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/YrqI1N3K_24/default.jpg', 294, 16, 0, 16, NULL, '117671937129903037593', NULL),
('YUXVs7DwhUk', '14 KINDS OF OFFICEMATES!!! MUST WATCH! (Bisaya)', 'I''ve been working for more than 3 years now in the industry and I''ve countered different kinds of officemates. They maybe crazy or meek but you''ll always have to deal with them.\n\nHere are 14 Kinds of Officemates that you will or might have encountered in the industry.\n\nThis video is a collaboration of #iNCRediBloggers, Please check out their channels and blogs:\n\nEloise Enriquez – http://msmeetingadventures.com\nMary Chris Auza – http://forkandbeens.com\nWellbein Borja – https://instagram.com/wellbeinb\nEfren Mendoza – https://instagram.com/francois.ephraim\nDiana Palconit – https://instagram.com/withlovegams\nCJ Estrada – https://youtube.com/CJEstrada\nMerco Salise – https://www.youtube.com/user/GuvonliebeMurk21\n\n#NoSmallCreator\nLet''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/iamcjestrada\nTwitter: https://twitter.com/iamcjestrada_\nInstagram: https://instagram.com/iamcjestrada\nBlog: https://www.foureyedlaagan.com\n\nGadgets Used:\n\nCamera: Panasonic Lumix G7 - https://bit.ly/CJEstradalumixg7\nMicrophone: Rode Video Micro - https://bit.ly/CJEstradaRodeMicro\nGorilla Pod: Joby Gorillapod 3K Kit - http://bit.ly/Joby3KGorillaPod\n\nEditor:\nAdobe Premiere Pro', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/YUXVs7DwhUk/default.jpg', 359, 52, 0, 60, NULL, '117671937129903037593', NULL),
('YXQKuXw-QeA', 'Living with TBoli''s Culture at Lake Sebu | VLOG 51', 'It''s def one of the best travels I''ve been in this year not only because of its breathtaking views but also the privilege to live and experience TBoli''s way of living and culture.\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down below your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nFacebook: https://facebook.com/foureyedlaagan\nTwitter: https://twitter.com/foureyedlaagan\nInstagram: https://instagram.com/foureyedlaagan\nBlog: http://www.foureyedlaagan.com\n\nTHANK YOU!!!', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/YXQKuXw-QeA/default.jpg', 299, 12, 0, 21, NULL, '117671937129903037593', NULL),
('Z1Js-SDgHmc', 'AMAZING FREE KOREA TRANSIT TOUR!!! GYEONGBOKGUNG PALACE AND MORE', 'MY BEST LAYOVER YET!!! I had a 13-hour layover at South Korea and I got the chance to avail not only 1, not 2, BUT 3 FREE TRANSIT TOURS!!!! I also got to meet new friends and enjoyed the tour together.\n\nCheck out this link below to know more about the Free Transit Tour and how to avail them:\nhttps://www.airport.kr/ap_cnt/en/trn/tour/trtour/trtour.do \n\nPowered by #GoProFusion.\nVlog 134.\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down on your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/iamcjestrada\nTwitter: https://twitter.com/iamcjestrada_\nInstagram: https://instagram.com/iamcjestrada\nBlog: https://www.foureyedlaagan.com\n\nGadgets Used:\n\nCamera: Panasonic Lumix G7 - https://bit.ly/CJEstradalumixg7\nMicrophone: Rode Video Micro - https://bit.ly/CJEstradaRodeMicro\nGorilla Pod: Joby Gorillapod 3K Set - http://bit.ly/Joby3KGorillaPod\n\nEditor:\nAdobe Premiere Pro', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/Z1Js-SDgHmc/default.jpg', 1837, 59, 2, 56, NULL, '117671937129903037593', NULL),
('Z27l4BfLP0k', 'The Sinulog 2019 Bisaya Vlog, Procession, Fireworks and Crazy Fun People!', '#Sinulog2019 - The Grandest Festival of the Philippines happens every 3rd Sunday of January at the Queen City of  the South - Cebu City. Check out what happened the struggles, the fun and the crazy good moments!\n\nVlog 163 #Sinulog #sharepishandlove\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down on your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/iamcjestrada\nTwitter: https://twitter.com/iamcjestrada_\nInstagram: https://instagram.com/iamcjestrada\nBlog: https://www.foureyedlaagan.com\n\nGadgets Used:\n\nCamera: Panasonic Lumix G7 - https://bit.ly/CJEstradalumixg7\nMicrophone: Rode Video Micro - https://bit.ly/CJEstradaRodeMicro\nGorilla Pod: Joby Gorillapod 3K Set - http://bit.ly/Joby3KGorillaPod\n\nEditor:\nAdobe Premiere Pro CC', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/Z27l4BfLP0k/hqdefault.jpg', 1996, 123, 2, 95, '2019-01-28', '117671937129903037593', 1),
('Z4zB63IRbJ4', 'GRAND RAPIDS, MICHIGAN // EXPLORING THE ARTISTIC BEER CITY', 'Finally, I went out for the weekend and I went to the downtown of Grand Rapids, Michigan. It''s where we could find the tall buildings, parks. restaurants, ARENA, musuems, and beer breweries!\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down on your thoughts and questions and I''d be happy to read them all! \n\nVlog 133.\n\nLet''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/iamcjestrada\nTwitter: https://twitter.com/iamcjestrada_\nInstagram: https://instagram.com/iamcjestrada\nBlog: https://www.foureyedlaagan.com\n\nGadgets Used:\n\nCamera: Panasonic Lumix G7 - https://bit.ly/CJEstradalumixg7\nMicrophone: Rode Video Micro - https://bit.ly/CJEstradaRodeMicro\nGorilla Pod: Joby Gorillapod 3K Set - http://bit.ly/Joby3KGorillaPod\n\nEditor:\nAdobe Premiere Pro\n\n?Music By?\n?Julian Avila - The City https://youtu.be/QY4BdHoAUZ8\n?Twitter - https://twitter.com/avilabeats\n?Soundcloud - https://soundcloud.com/julian_avila', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/Z4zB63IRbJ4/default.jpg', 183, 16, 0, 18, NULL, '117671937129903037593', NULL),
('ZnmCKVDFlZ4', 'BBOOM BBOOM BY MOMOLAND DANCE CHALLENGE AT THE PUBLIC MALL', 'CHALLENGE ACCEPTED!!\n\nI was challenged by Sir Blaire Bustillo to do the Bboom Bboom by Momoland Dance Challenge and I did it at the public mall! It was so fun and awkward HAHAHA\n\nSo I challenge to do the Bboom Bbomom Challenge:\nMeljean Solon -\nKent The Rockwell -\nDavid Linhof -\n\nAll you have to do is to dance the chorus of the Bboom Bboom song and nominate 3 YouTubers. alrighty!!\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down on your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nMail: foureyedlaagan@gmail.com\nFacebook: https://facebook.com/iamcjestrada\nTwitter: https://twitter.com/iamcjestrada_\nInstagram: https://instagram.com/iamcjestrada\nBlog: https://www.foureyedlaagan.com\n\nGadgets Used:\n\nCamera: Panasonic Lumix G7 - https://bit.ly/CJEstradalumixg7\nMicrophone: Rode Video Micro - https://bit.ly/CJEstradaRodeMicro\nGorilla Pod: Joby Gorillapod 3K Set - http://bit.ly/Joby3KGorillaPod\n\nEditor:\nAdobe Premiere Pro', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/ZnmCKVDFlZ4/default.jpg', 733, 49, 1, 56, NULL, '117671937129903037593', NULL),
('ZpxG1_KALco', 'Miss Universe 2016 Candidates in SM Seaside City Cebu | VLOG 16', '12 candidates of Ms. Universe 2016 visited UNIQLO store at SM Seaside, Cebu City. They showcased their latest denim line for women matched with their top.\n\nGet to know more about UNIQLO''s latest updates and styles at www.uniqlo.com/ph\n\nWatch out Ms. Universe''s Pageant Night on January 30!!!\n\nI hope you had fun and enjoyed the video. Please don''t forget to LIKE and SUBSCRIBE. Also, COMMENT down below your thoughts and questions and I''d be happy to read them all! \n\nLet''s stay connected!\n\nFacebook: facebook.com/foureyedlaagan\nTwitter: twitter.com/foureyedlaagan\nInstagram: instagram.com/foureyedlaagan\nBlog: www.foureyedlaagan.com\n\nTHANK YOU!!!', 'UCQ-kl7ByFq0oP_P1UaTXTkw', 'CJ Estrada', 11, 'https://i.ytimg.com/vi/ZpxG1_KALco/default.jpg', 2494, 22, 2, 7, NULL, '117671937129903037593', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `video_statistics`
--

CREATE TABLE `video_statistics` (
  `video_statistics_id` int(11) NOT NULL,
  `video_id` varchar(11) NOT NULL,
  `views` int(11) NOT NULL,
  `likes` int(11) NOT NULL,
  `dislikes` int(11) NOT NULL,
  `date_added` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `video_statistics`
--

INSERT INTO `video_statistics` (`video_statistics_id`, `video_id`, `views`, `likes`, `dislikes`, `date_added`) VALUES
(78, 'T2R954f1kTk', 1365, 2, 0, '2018-07-12'),
(80, 'T2R954f1kTk', 1369, 2, 0, '2018-07-15'),
(0, 't6rG13XQKRk', 150, 20, 0, '2018-07-30'),
(0, 'DiGvLXeEuMo', 195, 9, 0, '2018-07-31'),
(0, 'zKTYUNnvJb0', 359, 27, 0, '2018-08-23'),
(0, 'Z1Js-SDgHmc', 271, 29, 0, '2018-08-23'),
(0, 'dab4hS_V1ug', 369, 17, 0, '2018-08-30'),
(0, 'D56ikFaZWvA', 783, 23, 0, '2018-08-30'),
(0, 'DYoemNThYJs', 207, 16, 0, '2018-09-04'),
(0, 'SRv48BChB-Y', 207, 8, 0, '2018-09-06'),
(0, '3Eg6HYYme7o', 368, 0, 0, '2018-09-12'),
(0, 'ZnmCKVDFlZ4', 679, 48, 1, '2018-09-13'),
(0, 'rvArJO_a_5s', 377, 27, 1, '2018-09-14'),
(0, '9eyc-RGjFB0', 1625, 31, 0, '2018-09-24'),
(0, 'Z27l4BfLP0k', 1996, 123, 2, '2019-01-28'),
(0, 'Z27l4BfLP0k', 2454, 131, 2, '2019-02-07');

-- --------------------------------------------------------

--
-- Table structure for table `youtuber`
--

CREATE TABLE `youtuber` (
  `youtuber_id` varchar(21) NOT NULL,
  `authToken` text NOT NULL,
  `idToken` text NOT NULL,
  `name` text NOT NULL,
  `email` text NOT NULL,
  `photoUrl` text NOT NULL,
  `date_added` datetime NOT NULL,
  `date_ended` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `youtuber`
--

INSERT INTO `youtuber` (`youtuber_id`, `authToken`, `idToken`, `name`, `email`, `photoUrl`, `date_added`, `date_ended`) VALUES
('107428558023590518907', 'ya29.Gl0sBn8pFYdbiOgopLE5uF7FQOBBcAZoqOPemWV_OLJshNXHwHKJew_Nu6DD6u4dgVXanp2OVqc1IuwtYa8BsWYmC8xUVF_6G8Nt-mN7Icmp3RGGNnDEjw29LyOzdG8', 'eyJhbGciOiJSUzI1NiIsImtpZCI6IjY0MWZjMDUzZWY2OGExNDdkNmUwODQ1YWI2OWI5ZDYxYWE0YmM3ODkifQ.eyJpc3MiOiJhY2NvdW50cy5nb29nbGUuY29tIiwiYXpwIjoiOTczMjM0NDI2NzA0LTRmc2EwNm1vZnEycGRiZTUzbnU5cWh0bjdscXNhNHNhLmFwcHMuZ29vZ2xldXNlcmNvbnRlbnQuY29tIiwiYXVkIjoiOTczMjM0NDI2NzA0LTRmc2EwNm1vZnEycGRiZTUzbnU5cWh0bjdscXNhNHNhLmFwcHMuZ29vZ2xldXNlcmNvbnRlbnQuY29tIiwic3ViIjoiMTA3NDI4NTU4MDIzNTkwNTE4OTA3IiwiZW1haWwiOiJhZ3VyYWFybm9sZEBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiYXRfaGFzaCI6IlF1dkxDYUxINXpmZWxOeUZPczk5UmciLCJuYW1lIjoiQXJub2xkIEFndXJhIiwicGljdHVyZSI6Imh0dHBzOi8vbGg0Lmdvb2dsZXVzZXJjb250ZW50LmNvbS8tdnhuWGd5a1ZmVGsvQUFBQUFBQUFBQUkvQUFBQUFBQUFHMlEvcGtMZ0piLVBYVWsvczk2LWMvcGhvdG8uanBnIiwiZ2l2ZW5fbmFtZSI6IkFybm9sZCIsImZhbWlseV9uYW1lIjoiQWd1cmEiLCJsb2NhbGUiOiJlbiIsImlhdCI6MTUzODYzNjgwNywiZXhwIjoxNTM4NjQwNDA3LCJqdGkiOiI2ZWE0MTA0NTNjNmMxOGFlNDllOWMyZjM3YzFlYzRhZjBjZjNkMzI3In0.C4v6O8ew9Y0kAXSxWXTuuik1dBUI4Wfhpj5SjUK2Zn9GYhgkoebAR05ZFSL8Oi8Pu9Fj4opti4CORBypvsR1oKwMiMWkVNNABEtejMGbzk0wRDVyretbzwqaHMX9gB2SkSV5g7C2G0sUNlamFX1mdS2yWbj8ZfmJK6xfhjDiQDU0-eAKolKJ2DPB4ivhUp7BIXq77gY7ZmQQ_BBvJd1146ekbSeEIvpaUgmEydQ1y0MBRsXOqbYJ1h06HVRxlm4NJjnima3cpqaaBvXm6YuEsabnVphVWaq31l7z6Q2GW0sPYolSq4Q0UvH5303VABQ5QX9faSIkQFIf34rRQ0bcKA', 'Arnold Agura', 'aguraarnold@gmail.com', 'https://lh4.googleusercontent.com/-vxnXgykVfTk/AAAAAAAAAAI/AAAAAAAAG2Q/pkLgJb-PXUk/s96-c/photo.jpg', '2018-10-04 15:06:47', NULL),
('117671937129903037593', 'ya29.Gl0rBvAP9FIOFWb373XhA4vZAzBHZ3tZlrbvxBE07CtE4ppt6E_w5fz9DPoGlpF8Jr5OSBkjt6ApHlHUfcKEYk2E3koKfjOe157m02mrt_huXPc5_kL3gPG6i8lqEtE', 'eyJhbGciOiJSUzI1NiIsImtpZCI6IjY0MWZjMDUzZWY2OGExNDdkNmUwODQ1YWI2OWI5ZDYxYWE0YmM3ODkifQ.eyJpc3MiOiJhY2NvdW50cy5nb29nbGUuY29tIiwiYXpwIjoiOTczMjM0NDI2NzA0LTRmc2EwNm1vZnEycGRiZTUzbnU5cWh0bjdscXNhNHNhLmFwcHMuZ29vZ2xldXNlcmNvbnRlbnQuY29tIiwiYXVkIjoiOTczMjM0NDI2NzA0LTRmc2EwNm1vZnEycGRiZTUzbnU5cWh0bjdscXNhNHNhLmFwcHMuZ29vZ2xldXNlcmNvbnRlbnQuY29tIiwic3ViIjoiMTE3NjcxOTM3MTI5OTAzMDM3NTkzIiwiZW1haWwiOiJhY2VjZXJpbzFAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWQiOnRydWUsImF0X2hhc2giOiJkT3dMc0dLdlZNcW9yXzNVajVsYm5RIiwibmFtZSI6IkFjZSBHbGljZXJpbyIsInBpY3R1cmUiOiJodHRwczovL2xoNC5nb29nbGV1c2VyY29udGVudC5jb20vLWg3ZF83MTdCY1VFL0FBQUFBQUFBQUFJL0FBQUFBQUFBQ1BNL3pJb0R2ZEo3Q084L3M5Ni1jL3Bob3RvLmpwZyIsImdpdmVuX25hbWUiOiJBY2UiLCJmYW1pbHlfbmFtZSI6IkdsaWNlcmlvIiwibG9jYWxlIjoiZW4iLCJpYXQiOjE1Mzg1NjkxODksImV4cCI6MTUzODU3Mjc4OSwianRpIjoiNzE5MjRhYmI5OTY1MGQzZjQ1NmQ1OTYwMTYzZDE3NTIzN2Y4ZmNiNyJ9.PaNnQdn3jZBn8ika4osyKBU-k_v85u3lK3tgrML9DSOkfN2jdkg6pwQ7qGrSQR8XMzZZUTkPGrm59XdvnHTp0w8LrKUNFaSTb2LLNz9RyJ2cunko2PeFAFVIJpPJsqhMz5HWsXRWY74O8-PdGN49Jr9pwduxB3WVw6A38DswFRzqIyjmSBrqPG5kM5IN1sOASTGU8wteSa-2rZjb8Vfc-dIvFLa_fNEvVf9wQKORYHCU3u186SslEKQxQ2mfG5Pxl0mwDzmSadoedflWtkhl_R7PMGICXdend5aNUAUhstngr_SgumW1OcYU27iiwMhS3rvdH7zTgHQH9gObm2RIiA', 'Ace Glicerio', 'acecerio1@gmail.com', 'https://lh4.googleusercontent.com/-h7d_717BcUE/AAAAAAAAAAI/AAAAAAAACPM/zIoDvdJ7CO8/s96-c/photo.jpg', '2018-10-03 20:19:49', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `youtuber_campaign`
--

CREATE TABLE `youtuber_campaign` (
  `youtuber_campaign_id` int(11) NOT NULL,
  `campaign_id` int(11) NOT NULL,
  `youtuber_id` varchar(21) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `youtuber_category`
--

CREATE TABLE `youtuber_category` (
  `youtuber_category_id` int(11) NOT NULL,
  `youtuber_id` varchar(21) NOT NULL,
  `category_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `youtuber_interest`
--

CREATE TABLE `youtuber_interest` (
  `youtuber_interest_id` int(11) NOT NULL,
  `youtuber_id` varchar(21) NOT NULL,
  `campaign_id` int(11) NOT NULL,
  `message` varchar(1000) NOT NULL,
  `date_interested` datetime NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `youtuber_interest`
--

INSERT INTO `youtuber_interest` (`youtuber_interest_id`, `youtuber_id`, `campaign_id`, `message`, `date_interested`) VALUES
(1, '117671937129903037593', 1, 'I''m interested', '2019-01-28 03:32:21'),
(4, '117671937129903037593', 5, 'Lemme join!', '2019-02-07 22:22:04');

-- --------------------------------------------------------

--
-- Table structure for table `youtube_data`
--

CREATE TABLE `youtube_data` (
  `youtube` int(11) NOT NULL,
  `videoId` varchar(25) NOT NULL,
  `category_id` int(11) NOT NULL,
  `likeCount` int(15) NOT NULL,
  `dislikeCount` int(15) NOT NULL,
  `commentCount` int(15) NOT NULL,
  `viewCount` int(15) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=11717 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `youtube_data`
--

INSERT INTO `youtube_data` (`youtube`, `videoId`, `category_id`, `likeCount`, `dislikeCount`, `commentCount`, `viewCount`) VALUES
(9329, '7ISQJ5czYDY', 2, 3, 3, 0, 4403),
(9330, 'kp9_Z7touRQ', 2, 3, 2, 1, 5707),
(9331, 'zTSQfQUcFP8', 1, 547368, 7384, 19655, 32216623),
(9332, 'aKdV5FvXLuI', 1, 1363061, 9673, 54120, 87320566),
(9333, 'R5sO5cx9ifQ', 1, 547991, 8512, 15756, 35529921),
(9334, 'YuOBzWF0Aws', 1, 468086, 7718, 12981, 42043797),
(9335, '1Za8BtLgKv8', 1, 823396, 11083, 28268, 65446023),
(9336, 'U9t-slLl30E', 1, 820253, 18754, 56620, 71422351),
(9337, 'FaLTWW_yEG4', 1, 59407, 709, 3503, 7150130),
(9338, 'f5d8pVg3Qtg', 1, 384918, 4798, 7293, 12330218),
(9339, 'Auh74d_OG8Y', 1, 120776, 2050, 7233, 15928952),
(9340, 'RySHDUU2juM', 1, 413466, 6462, 41238, 35905237),
(9341, 'Dceyy0cX6J4', 1, 259920, 2634, 5086, 11239671),
(9342, 'OrnpSe4OChM', 1, 359209, 11291, 25953, 21132649),
(9343, 'cBTwuF3OcYQ', 1, 129539, 2173, 2458, 16058592),
(9344, 'SKV6h_5XFbk', 1, 292793, 5773, 12048, 13850850),
(9345, 'f4d_GDrpVuw', 1, 228180, 3809, 11290, 10196131),
(9346, 'YkiR1KjIw7k', 1, 208391, 2645, 5125, 20760598),
(9347, '6A8W77m-ZTw', 1, 85121, 1073, 4418, 12181009),
(9348, 'O9YL04v-J5U', 1, 86320, 1021, 5212, 10541453),
(9349, 'j_pC0-Jfsq0', 1, 122799, 1969, 5019, 11439410),
(9350, 't2oVUxTV4WA', 1, 459090, 15457, 18832, 44632400),
(9351, 'MmcaSjFLBCM', 1, 138800, 1492, 4280, 9173516),
(9352, 'eym10GGidQU', 10, 43760, 496, 1948, 1556198),
(9353, 'G5pmYeo60Fs', 10, 8914, 370, 849, 1308302),
(9354, 'qN5W5lMS1aM', 6, 168947, 2919, 16630, 6440595),
(9355, '7m5_lhxTtuY', 6, 333339, 4924, 16808, 12313242),
(9356, 'Q9ctIocIhio', 6, 111401, 2395, 21953, 4398420),
(9357, 'zeGRoIzNFp0', 6, 70506, 1272, 6653, 3829664),
(9358, 'OTqsYAzNTOs', 6, 23366, 129, 1646, 665034),
(9359, 'YOjQOlfBC7Q', 6, 232873, 2418, 25741, 4253523),
(9360, 'HF_yN1Zf6rQ', 6, 61818, 661, 4731, 2085770),
(9361, 'Nw3H8MZLxr4', 6, 62137, 1729, 14004, 5142266),
(9362, '7kPq1PeCz-4', 6, 128065, 2955, 13084, 9204450),
(9363, 'eiDiKwbGfIY', 8, 1765283, 50447, 62641, 139196220),
(9364, 'TgpV5mfrY74', 6, 89846, 3056, 8296, 7827476),
(9365, 'GVLAAMZeraQ', 7, 165984, 1754, 9940, 7718676),
(9366, 'Da8-QfGemgo', 7, 325852, 4736, 27559, 8938665),
(9367, 'bIfUsQRyymU', 7, 58688, 794, 8808, 1872584),
(9368, 'UwrEagOwoBA', 7, 53688, 1464, 4000, 3595323),
(9369, 'rEdl2Uetpvo', 7, 292078, 2466, 7596, 6164888),
(9370, 'VlZ1SWLBfPE', 7, 243764, 2923, 12524, 5949084),
(9371, 'PkHotdob_08', 7, 73702, 1296, 3601, 2859075),
(9372, 'YJB5JWizc4U', 7, 62943, 1255, 2871, 2896440),
(9373, 'EPmZolscz2M', 7, 739342, 9550, 52129, 15227109),
(9374, 'guux3cYYIko', 7, 658533, 6077, 49957, 11929397),
(9375, 'YaLPOLqT49k', 7, 30317, 341, 743, 1448997),
(9376, 'uBJq-XCP27c', 7, 123074, 2262, 13792, 4502031),
(9377, 'KLGSLCaksdY', 7, 114747, 2907, 6489, 7399794),
(9378, 'G-Fg7l7G1zw', 7, 60744, 956, 1215, 2369699),
(9379, 'EOwTPLMhfJY', 7, 41175, 659, 2124, 1634892),
(9380, '7mz9UKbGyzo', 7, 174144, 1318, 6937, 4581597),
(9381, 'eIho2S0ZahI', 7, 264564, 5330, 4645, 17871231),
(9382, 'HxuHo62reRw', 7, 126719, 1151, 4049, 3931966),
(9383, 'ILfqH4FUj_o', 7, 123427, 2412, 12756, 3898001),
(9384, '-Vgn21-miN0', 7, 230162, 2762, 18518, 8569082),
(9385, 'lmd3KZ4subg', 7, 61940, 1570, 5291, 12719511),
(9386, 'RiGFGXd9Xvs', 7, 118677, 2846, 29679, 5178671),
(9387, 'S6enIZ2qxEo', 7, 98944, 2258, 4775, 5295998),
(9388, 'ePN1J_c4ulw', 7, 214143, 2648, 16547, 8345792),
(9389, 'oZAeKfGpd2M', 10, 77718, 2032, 7774, 4307480),
(9390, '1B9cdcjI2_U', 7, 52549, 951, 4267, 3950656),
(9391, 'iMYRjp4h0y0', 7, 60944, 1170, 1869, 2651460),
(9392, 'T1-k7VYwsHg', 7, 115399, 2733, 13700, 4039094),
(9393, 'ey_L_VzPwEI', 10, 5121, 159, 332, 1074494),
(9394, 'DUx1tJTNrno', 7, 774845, 24122, 100223, 11345731),
(9395, 'WxfZkMm3wcg', 10, 294314, 9511, 12503, 28275750),
(9396, 'ROW9F-c0kIQ', 3, 23369, 280, 1584, 2810638),
(9397, 'gauyUvRIPzs', 7, 135135, 2460, 9007, 9338357),
(9398, 'FZrrfGfI3uM', 10, 140272, 4684, 9310, 10375662),
(9399, 'pXf9-xIUA1Q', 10, 25418, 683, 4099, 1068998),
(9400, 'OnRJhj_6k5o', 10, 8444, 317, 883, 385393),
(9401, '3LMtRG4Mc54', 1, 77471, 815, 2562, 8273085),
(9402, 'gDYFPaZjEXc', 10, 7801, 510, 1176, 1095886),
(9403, 'QrCB6y9mYqc', 7, 15342, 179, 467, 1176401),
(9404, 'wJbeMHf387U', 6, 420869, 9894, 19954, 30250335),
(9405, 'f2O6mQkFiiw', 3, 117181, 985, 1610, 3524373),
(9406, 'iNrUpBwU3q0', 3, 4282, 47, 140, 682350),
(9407, 'm_SlH3Uwslc', 3, 59811, 1580, 4101, 4395614),
(9408, 'c18GjbnZXMw', 3, 57318, 1930, 4914, 6060376),
(9409, 'BBJTeNTZtGU', 3, 24573, 1042, 2193, 1635442),
(9410, 'TfE93xON8jk', 4, 66308, 1291, 3300, 5537036),
(9411, 'EJjh19zO1lk', 4, 83946, 1682, 5267, 7095916),
(9412, 'cPRRupAM4DI', 6, 243545, 2993, 35204, 14520135),
(9413, 'q7j2d6YCQbg', 6, 338071, 12773, 62476, 7219946),
(9414, 'snzDwACffzs', 4, 71554, 963, 1704, 6572389),
(9415, '2ihOXaU0I8o', 4, 565419, 15999, 0, 38201422),
(9416, 'IP0t5qZHEC4', 6, 138271, 745, 7902, 2287856),
(9417, 'Nqqc2FHf9Ug', 6, 260077, 3336, 10300, 27242174),
(9418, 'IVBKIXAH06Q', 6, 184074, 3598, 9350, 6224315),
(9419, 'eMnn3Gl9i5I', 6, 51647, 291, 7109, 772481),
(9420, 'Y3qM6j3AceU', 6, 530102, 15470, 45468, 69515036),
(9421, 'to8yh83jlXg', 6, 350833, 4444, 58931, 16928521),
(9422, '2Qnb1GKiAqM', 6, 56092, 1343, 3187, 2349456),
(9423, '4hqqFqcr1K8', 4, 400931, 7336, 26335, 13104088),
(9424, 'RJ2zvTv1oSw', 6, 105794, 1001, 8436, 3608765),
(9425, 'TXEjpp64uFQ', 6, 125637, 1978, 10769, 4626286),
(9426, '-ubyfnNldxk', 6, 155624, 4633, 17792, 13944796),
(9427, 'xj_GVasTJ0g', 6, 26720, 339, 3432, 1046967),
(9428, '_oVwrpfo_QA', 6, 69127, 594, 12751, 12987420),
(9429, 'eZWnIRkk6cU', 6, 75932, 1018, 7969, 4497311),
(9430, 'vzNcSvKCOyA', 6, 191944, 9977, 2368, 12211258),
(9431, 'c7nRTF2SowQ', 6, 2238022, 44645, 381681, 59596564),
(9432, 'OlU4qAh1Hr0', 6, 119232, 2962, 7439, 7987243),
(9433, 'BYunaBkn9Ng', 6, 218436, 6305, 9930, 6219950),
(9434, 'q4GdJVvdxss', 6, 34328, 293, 2944, 874716),
(9435, 'suFxAP-xnEI', 6, 142452, 1358, 15849, 4960875),
(9436, 'i28Dd8jXZxs', 6, 282704, 8108, 36957, 7759996),
(9437, '8tjcm_kI0n0', 6, 393466, 9198, 65326, 10586563),
(9438, 'alcxiiN6xkU', 6, 212673, 5723, 35316, 13041469),
(9439, 'DRepbLikfNA', 6, 821496, 52727, 68217, 82239002),
(9440, '6sBB-gRhfjE', 3, 28686, 675, 1839, 1287617),
(9441, '_q0QGtk_AM0', 6, 205431, 3109, 17904, 6798904),
(9442, 'g_2OPd25FOw', 6, 223294, 3423, 25548, 9419641),
(9443, 'hyg7lcU4g8E', 3, 15326, 122, 399, 308860),
(9444, 'oJ09xdxzIJQ', 6, 443069, 3772, 52891, 26329635),
(9445, 'd0yGdNEWdn0', 3, 197362, 5423, 15783, 13502574),
(9446, 'YeSuQm7KfaE', 3, 6385, 68, 379, 551076),
(9447, 'UF8uR6Z6KLc', 3, 225448, 4112, 20322, 30270215),
(9448, 'tmSrULDVRPc', 10, 101432, 1985, 11166, 9902078),
(9449, 'ckSoDW2-wrc', 3, 128677, 2037, 8080, 6105533),
(9450, '5KLPxDtMqe8', 3, 14682, 131, 1128, 687175),
(9451, 'jNgP6d9HraI', 3, 106801, 2003, 12018, 6277293),
(9452, 'ypF037wlYZg', 3, 14653, 133, 1346, 762566),
(9453, 'nv5IhEZ_JwU', 3, 178995, 1638, 13899, 3731729),
(9454, 'aiUq5xksJy0', 3, 17374, 308, 682, 708676),
(9455, 'WuEuFTc2aJo', 3, 8700, 69, 1018, 224773),
(9456, 'aOfWTscU8YM', 3, 24687, 474, 842, 2203270),
(9457, 'sbGjr_awePE', 3, 16611, 179, 693, 608588),
(9458, 'iG9CE55wbtY', 3, 156092, 2500, 10034, 15627046),
(9459, 'FlUes_NPa6M', 3, 13861, 278, 5742, 836539),
(9460, 'YAxLueEKqmU', 7, 475931, 12666, 144473, 9205435),
(9461, 'V2EMuoM5IX4', 3, 15122, 191, 685, 791605),
(9462, 'W-FqE81rhqA', 3, 38076, 1369, 1800, 1559301),
(9463, '_Nq4Z5i7lcs', 3, 6353, 190, 831, 933411),
(9464, 'xazQRcSCRaY', 3, 4294, 129, 248, 513551),
(9465, 'RwtO04EXgUE', 3, 8551, 243, 888, 828325),
(9466, 'wR3tCFXcbu4', 7, 96710, 2468, 10089, 2868910),
(9467, '5c6C3rHOdf8', 3, 29568, 824, 2117, 2582024),
(9468, 'aymvX-OrlS0', 3, 10686, 124, 1063, 255176),
(9469, 'StrsvKSAbT8', 3, 55653, 2254, 6040, 3213244),
(9470, 'rNu8XDBSn10', 3, 164455, 4996, 37848, 13078656),
(9471, 'ZW3aV7U-aik', 3, 102377, 842, 7014, 5344973),
(9472, 'MvuYATh7Y74', 3, 5926, 128, 273, 495686),
(9473, 'c_Eutci7ack', 3, 37553, 914, 1752, 1539427),
(9474, 'Yocja_N5s1I', 3, 88671, 1938, 11269, 9841499),
(9475, 'r6zIGXun57U', 6, 479503, 9973, 26968, 28567758),
(9476, 'VDf00z8sMFw', 3, 6076, 174, 408, 525239),
(9477, 'FwREAW4SlVY', 3, 5199, 110, 822, 272279),
(9478, 'lRfdMiURV4s', 3, 18624, 659, 2281, 842050),
(9479, 'I8992A5oAWM', 3, 19776, 245, 1275, 972632),
(9480, '-GsVhbmecJA', 3, 10192, 66, 559, 509689),
(9481, 'kF4ju6j6aLE', 3, 18801, 323, 1168, 987098),
(9482, 'rk_qLtk0m2c', 4, 448677, 10398, 28142, 51383551),
(9483, 'wVDtmouV9kM', 4, 306148, 10447, 69678, 20552878),
(9484, 'FRjOSmc01-M', 8, 363575, 8321, 6633, 41685137),
(9485, '3nUKwvFsjA4', 4, 252055, 2982, 8807, 23981312),
(9486, 'rsEne1ZiQrk', 8, 854717, 24422, 31122, 78161038),
(9487, 'naW9U8MiUY0', 4, 485001, 12624, 50859, 26381936),
(9488, 'CwfoyVa980U', 8, 2809542, 82136, 131657, 438091403),
(9489, 'OMbsGBlpP30', 3, 7660, 211, 207, 556154),
(9490, 'w4AF87gInxY', 4, 260077, 5779, 18804, 20510214),
(9491, 'u9Mv98Gr5pY', 4, 1361553, 49833, 147461, 69134955),
(9492, '95ghQs5AmNk', 4, 164548, 4751, 14131, 11016216),
(9493, 'qFy5XyZsUeo', 4, 164212, 3392, 10609, 12298451),
(9494, 'pCjY3ZQY8WY', 4, 327108, 6084, 15044, 18084140),
(9495, 'xLCn88bfW1o', 4, 639702, 24583, 89805, 37333991),
(9496, 'MJEAGd1bQuc', 4, 107095, 3389, 4193, 11783217),
(9497, 'KiBS-dbv_x0', 4, 556357, 14418, 20548, 28452582),
(9498, '6ZfuNTqbHE8', 4, 3362223, 81347, 457473, 209279826),
(9499, 'a7JQzSn8Ptg', 4, 84359, 1239, 4385, 4281207),
(9500, 'pnRNdbqXu1I', 10, 39223, 729, 2073, 1521578),
(9501, 'ZzBHjMYN29Y', 10, 42186, 362, 2433, 1880574),
(9502, 'SDPITj1wlkg', 4, 367211, 12091, 14542, 57647034),
(9503, '7f_d8AVoAjg', 4, 360631, 2521, 11840, 7474392),
(9504, 'gn2933vMylY', 4, 115504, 2529, 3901, 10860575),
(9505, 'CgWHbpMVQ1U', 10, 25902, 1181, 7751, 6908239),
(9506, 'PJNp5UKRtbQ', 10, 62129, 1118, 2442, 8469890),
(9507, 'GJoDRUybisw', 10, 146478, 5816, 11866, 9345414),
(9508, 'pv32BVks0i8', 10, 85230, 3104, 4279, 2678392),
(9509, 'PamvTDPzyKE', 10, 24243, 227, 818, 671579),
(9510, 'r2S79nNOJEQ', 10, 3023, 102, 215, 147701),
(9511, 'ACmt1-ExrwY', 10, 47569, 810, 4764, 2513602),
(9512, 'VwipCNAwrxg', 10, 3941, 139, 436, 206040),
(9513, '2sxuAm569IY', 10, 27150, 887, 1722, 2346026),
(9514, 'vHZ7-D7lCR4', 10, 5360, 175, 615, 488810),
(9515, 'vTBzJNjlNQ8', 10, 631, 14, 98, 47582),
(9516, 'ZKSWXzAnVe0', 4, 504579, 6331, 28808, 29698008),
(9517, '5vIhecm7dYE', 8, 82488, 1742, 5357, 4595180),
(9518, '2s4GMLkTNv0', 4, 627593, 5325, 50653, 8444229),
(9519, 'ud2Q2vAhJLM', 4, 94489, 1192, 1324, 11867593),
(9520, 'JeQ4gaLyIys', 10, 205, 2, 12, 12582),
(9521, 'xxfnKXJ7F2o', 10, 24425, 323, 2580, 837227),
(9522, 'nYDQcBQUDpw', 10, 25260, 316, 1467, 1187096),
(9523, 'DBDPY2yRxbc', 10, 25124, 1241, 8289, 1377674),
(9524, '35MYHybMzh0', 10, 34051, 310, 3031, 442641),
(9525, 'CP6aYDssDSE', 10, 81881, 3455, 10353, 6567801),
(9526, 'zmHjuBvvZZw', 10, 22090, 796, 4917, 1057587),
(9527, 'NdnIqg8WaAo', 10, 1458, 28, 127, 106677),
(9528, 'ZkWTuvdFbJI', 8, 74714, 793, 4092, 5518190),
(9529, 'Y15MOr9saxE', 8, 334586, 5724, 37649, 20573839),
(9530, 'jEo-ykjmHgg', 10, 37629, 1483, 2523, 1847647),
(9531, 'pBuZEGYXA6E', 8, 6472816, 329311, 1510358, 152273488),
(9532, '5Wiio4KoGe8', 8, 1580968, 50472, 36555, 270378044),
(9533, 'igNVdlXhKcI', 8, 2583374, 111419, 93313, 567310409),
(9534, 'BKNZ67SHgFA', 10, 26536, 387, 2502, 1299810),
(9535, 'hMAPyGoqQVw', 8, 659716, 7683, 59161, 18320386),
(9536, 'VSYjs5RnlRo', 1, 309881, 5508, 11929, 30048977),
(9537, '3AtDnEC4zak', 8, 7170897, 276571, 293042, 1922258664),
(9538, 'YYEQqnvFwqQ', 1, 542878, 4563, 29946, 23203231),
(9539, '1z7zaL70btk', 11, 273706, 995, 6034, 6213850),
(9540, 'xG_RLaDVHIo', 11, 288164, 1099, 5358, 4362804),
(9541, '5lczw9F6pTA', 11, 327666, 962, 12806, 4921340),
(9542, 'th42MubluJE', 11, 314299, 1323, 10813, 5162533),
(9543, '-lgcAySBbTA', 11, 343582, 3264, 12153, 10996791),
(9544, 'D3mNAxkkMi8', 11, 360215, 1050, 14236, 4574058),
(9545, '-vuDnPVXFbY', 8, 308107, 6115, 41752, 16637760),
(9546, 'bt90VCye6Vk', 1, 142967, 1469, 8261, 8537957),
(9547, 'ss9ygQqqL2Q', 1, 1288124, 21796, 57027, 120491074),
(9548, '4GihAbGZPwQ', 1, 335429, 3441, 25968, 8554791),
(9549, 'Lc4hUSLN_-M', 7, 92841, 1143, 5875, 4704402),
(9550, 'IgFM_dWv7jE', 1, 44595, 591, 1010, 4059498),
(9551, 'V_yxGsWHx9o', 1, 101719, 1378, 7897, 9623520),
(9552, 'rnU-puAUMbs', 1, 331763, 7740, 0, 20721195),
(9553, 'lJh06MuQWxE', 1, 74700, 612, 5085, 5334891),
(9554, '0uBOtQOO70Y', 1, 265366, 8155, 13261, 52224614),
(9555, 'pU_VoyWfLfY', 7, 161690, 3122, 11836, 9483979),
(9556, 'qtsNbxgPngA', 1, 297351, 4546, 17328, 43374608),
(9557, 'ahSKGi_21xg', 1, 80275, 2226, 4169, 7450114),
(9558, 'PBeakKeMWRY', 1, 80550, 728, 3443, 10342533),
(9559, 'IDJ8tkf_omU', 1, 212742, 3765, 3818, 20564164),
(9560, 'jR4lLJu_-wE', 1, 342027, 5230, 37181, 34488567),
(9561, '8rHaiwKlLik', 7, 53707, 696, 1320, 1596736),
(9562, '3_9v-7rtVDk', 7, 168324, 2143, 7157, 12012381),
(9563, 'eCEG4QyQbF4', 7, 309160, 4518, 22710, 15149641),
(9564, 'kHJnHbjgMZw', 7, 191887, 2972, 42933, 10534044),
(9565, 'MjVgIXccYXA', 7, 95911, 673, 3115, 2180300),
(9566, 'ycVc1jsaAA0', 9, 595795, 13645, 54087, 38277768),
(9567, '6ZCS9trzaCw', 1, 504644, 7166, 52259, 14288749),
(9568, '6BoYfs2I0r8', 10, 57504, 448, 2604, 1295039),
(9569, 'fmI_Ndrxy14', 6, 1457463, 31114, 85499, 160969857),
(9570, 'fngw98RjBEc', 10, 1222, 107, 238, 64589),
(9571, '7TN09IP5JuI', 7, 345623, 3524, 30949, 11729303),
(9572, 'bbQClDH57pk', 7, 81434, 1166, 7803, 1075839),
(9573, 'f3mOQCjL10g', 4, 174973, 4146, 1722, 10526893),
(9574, 'G1wsCworwWk', 4, 291767, 5129, 14686, 15413364),
(9575, 'Xbu1CLFHd04', 10, 7244, 124, 768, 477182),
(9576, 'iu7wJwbLkpo', 3, 524613, 7517, 24708, 18478627),
(9577, 'GZGY0wPAnus', 4, 155642, 2382, 5307, 12470259),
(9578, 'C_FuWbprnmw', 10, 16857, 135, 925, 557470),
(9579, '0xZ52mG1yIo', 4, 46558, 688, 1561, 4119256),
(9580, 'q9Pk_Eq4BUc', 4, 134393, 1376, 8362, 4175427),
(9581, 'zx8pYMkkKXg', 7, 30636, 667, 2248, 1280407),
(9582, 'U8JFxbevCQc', 10, 15036, 294, 1774, 1059557),
(9583, 'zKnpgU-AFqc', 11, 309466, 1856, 9214, 5462653),
(9584, 'dfR_LdA3fPI', 7, 171483, 3421, 3136, 10960207),
(9585, 'UwLAVB-UeWE', 11, 210375, 1446, 10039, 4698426),
(9586, 'j88ja4UyZ5Y', 11, 219872, 972, 4872, 4558796),
(9587, '2XnWqj0y1Rk', 11, 143382, 1738, 6899, 9681598),
(9588, 'T3bKoti8ygI', 11, 391786, 10487, 16666, 9420588),
(9589, 'J2HytHu5VBI', 11, 2258777, 112221, 356351, 42714589),
(9590, 'VK2405H3Hjk', 11, 198614, 1503, 8261, 11655596),
(9591, '4-D2JcrgZYs', 11, 362448, 1962, 10497, 5275800),
(9592, 'V4Uuxg6jmbo', 11, 289754, 5215, 24293, 16348147),
(9593, 'qZHycHI3F1Q', 9, 839125, 14263, 53752, 36282625),
(9594, '1ZXYGxrNWbo', 1, 35672, 370, 1321, 3518589),
(9595, 'vw4gskHRJi4', 7, 64135, 707, 3815, 1093205),
(9596, 'dlogul7XwZg', 1, 122198, 3357, 5869, 18643965),
(9597, 'Rd_BRT6_TPk', 1, 72154, 1189, 3559, 11534465),
(9598, 'Vzv40VWL5ho', 9, 410918, 10132, 26485, 62740325),
(9599, '8YydogFXCPM', 9, 1208172, 31071, 84197, 100343364),
(9600, 'LoaEy7CCC1E', 9, 582955, 11987, 24440, 71594242),
(9601, 'mcC961cWMD0', 9, 98426, 1270, 1715, 8001773),
(9602, 'nRiOw3qGYq4', 9, 348535, 9938, 9722, 48394315),
(9603, 'dlOPwVsI-O4', 9, 355367, 8682, 10075, 51929178),
(9604, 'IlQnGkfskrQ', 9, 470241, 9554, 47376, 65776572),
(9605, 'RdNqmKrRmbU', 9, 573987, 10959, 38752, 38990795),
(9606, 'wSB9JvsBT4M', 9, 452361, 8468, 24198, 17406519),
(9607, 'cqylLiMzk54', 9, 555945, 12802, 6955, 40503353),
(9608, 'TvNTcB6c-V8', 9, 1687779, 30661, 57702, 79275709),
(9609, 'YMvYTUSez_0', 1, 149902, 1738, 6419, 17493158),
(9610, 'VJwoSfTOhyM', 9, 1044478, 32605, 54201, 90780334),
(9611, 'ofyyJWHnEPM', 9, 708632, 13708, 15009, 48053528),
(9612, 'ffVbnPjl86A', 1, 107053, 1477, 4444, 13135337),
(9613, '_zCDvOsdL9Q', 1, 370123, 5047, 15660, 10413269),
(9614, 'uw-VK2URZZQ', 1, 145665, 816, 6395, 2551995),
(9615, '-RmUADCWI4A', 9, 507298, 14585, 36742, 40415292),
(9616, 'cEM3gyoeu4Y', 9, 97612, 1830, 9073, 7797467),
(9617, 'No8-mBek3rs', 9, 391516, 8347, 24852, 15963110),
(9618, '6OLVFa8YRfM', 3, 31267, 798, 1988, 1166582),
(9619, 'rYCODMuoHNI', 10, 108444, 1512, 4631, 5293290),
(9620, 'XVMxZMxkAgM', 4, 317836, 4524, 19913, 30418739),
(9621, 'FaOSCASqLsE', 4, 465400, 7186, 18377, 34609211),
(9622, 'XmOy3sNKkdA', 9, 141512, 3706, 10096, 7238837),
(9623, 'gB1QyJeUFp0', 6, 112228, 1382, 9626, 7585652),
(9624, 'R0JKCYZ8hng', 3, 72965, 692, 2687, 6643227),
(9625, 'mHTR-XF6MXU', 7, 116365, 2522, 9994, 4126441),
(9626, 'CL78eVVW9_M', 3, 236311, 3866, 11415, 21657173),
(9627, 'A-QgGXbDyR0', 3, 91642, 2070, 7102, 4693466),
(9628, 'EeoqYM_--9A', 11, 336221, 1122, 7253, 5169821),
(9629, 'jsF0o5YLwDk', 5, 1, 2, 4, 5767),
(9630, '1u5-BYNkaFU', 11, 275712, 1462, 6988, 6098486),
(9631, 'K1eskPuAxBA', 11, 364429, 2101, 16818, 7647293),
(9632, 'gpohM8B_FqM', 7, 129715, 3226, 12165, 5798578),
(9633, 'iwBWksmRYt4', 11, 338618, 1116, 10042, 6532424),
(9634, 'ehxJ7W5naxk', 11, 304174, 1301, 8322, 4350586),
(9635, 'n0tAXKkfvxk', 11, 224006, 2203, 14224, 15436159),
(9636, 'ygcBEIy1mho', 11, 309961, 1043, 10836, 4382822),
(9637, 'UFEJaAZU3nw', 11, 373365, 882, 15019, 4534347),
(9638, 'ZLM_8BZ4N3U', 11, 304272, 1038, 7207, 4962968),
(9639, 'F_bhETLAMkg', 11, 601571, 3763, 32051, 8888672),
(9640, 'OdY73r5BR7Y', 11, 359668, 3357, 13385, 6176825),
(9641, 'HAm9fxfQdbE', 11, 268353, 1021, 6773, 4233207),
(9642, '_QdPW8JrYzQ', 11, 643783, 17813, 17889, 28017892),
(9643, 'SR38a-m2p5I', 11, 135690, 715, 9602, 5526477),
(9644, 'X5uXcYL-fok', 11, 334728, 1875, 5704, 5641228),
(9645, '-kJIb6ThPpw', 11, 307863, 2231, 9203, 5196328),
(9646, 'dGaw2ArdPFw', 11, 288508, 1070, 4944, 6000143),
(9647, 'JR7p4krjmZk', 11, 260140, 2359, 25923, 11564254),
(9648, 'dF5YID7XjC4', 11, 310665, 1845, 7027, 8205305),
(9649, '7g9Zs2L4l8M', 11, 446955, 5644, 17944, 6530467),
(9650, 'k92jbmxzzIM', 11, 369278, 930, 9720, 5711286),
(9651, '-XjHmlbZpZo', 11, 311528, 1122, 5991, 4949759),
(9652, 'Lafz-gAXu4c', 11, 326374, 1083, 9261, 4746157),
(9653, 'rO7XBQUoAaY', 11, 302102, 1410, 9402, 5266136),
(9654, 'be3xdftLrRc', 11, 330911, 1658, 8253, 4446298),
(9655, 'kuYylDsN6KQ', 11, 78960, 362, 5537, 1815633),
(9656, 'V3RvNiR3QnM', 11, 380931, 2035, 14171, 7516921),
(9657, 'BhKksAjzJis', 11, 434876, 9800, 36506, 25268355),
(9658, 'T3zaiVL5PI8', 11, 299101, 1369, 8340, 6249362),
(9659, 'arj7oStGLkU', 11, 455413, 4465, 24921, 13968006),
(9660, 'HssHyxkc0H0', 11, 561622, 1626, 7409, 7054004),
(9661, 'Nqf15ViHSmQ', 4, 145272, 3918, 3713, 14641415),
(9662, 'ukE5oz3qmgg', 11, 276094, 1162, 5737, 6538656),
(9663, 'ZTKqHEjQ5II', 11, 40507, 247, 1085, 1118149),
(9664, 'ek1ePFp-nBI', 4, 258322, 9883, 46998, 19441104),
(9665, 'kQKAa4wALdo', 11, 292743, 1392, 7540, 7670371),
(9666, 'tRT7DMk7qcw', 4, 58605, 1542, 1256, 6282400),
(9667, 'VioIUfiBl3s', 1, 173853, 2436, 9864, 6939219),
(9668, 'Vcoohsen6t8', 11, 247983, 967, 5003, 4722926),
(9669, 'uJpaQWWgaC8', 1, 79931, 1081, 5086, 6765081),
(9670, 'SOk-KVq-O1I', 9, 416042, 8347, 21413, 27560187),
(9671, 'g693z6yy1rw', 1, 236927, 4561, 6951, 10702227),
(9672, 'wn67XyvePOE', 1, 835132, 14261, 50379, 33362880),
(9673, 'kF8I_r9XT7A', 3, 101345, 2046, 21675, 7744023),
(9674, 'P5e7cl19Ha0', 3, 73597, 2042, 4444, 3489650),
(9675, 'QuncAUHpl-8', 9, 442767, 13466, 13609, 61027622),
(9676, 'muzeGsrYpnQ', 9, 520532, 19101, 33904, 24390163),
(9677, 'dOFTVzsssEA', 8, 279908, 4834, 0, 23279842),
(9678, 'gjvAjrI3mFQ', 9, 104222, 1520, 2357, 8945766),
(9679, 'gA8Gru79DcE', 9, 668269, 13788, 12231, 39939023),
(9680, 'sQfk5HykiEk', 6, 391266, 3331, 48228, 13192716),
(9681, 'iJJSh-eEdRk', 8, 1156033, 6764, 68600, 34364709),
(9682, 'J5zVwTyJg1k', 9, 85697, 1739, 4086, 7365270),
(9683, 'yjmp8CoZBIo', 8, 3689032, 80550, 326596, 318806489),
(9684, 'UjxS9ciNlII', 6, 15333, 206, 1863, 875815),
(9685, 'L3qJFjlDvKY', 9, 42796, 1201, 4246, 6292615),
(9686, '54z8jWNM0bE', 1, 80608, 1174, 2109, 6125979),
(9687, 'TBXQu8ORnBQ', 8, 1033197, 16330, 43424, 94077038),
(9688, 'u3VTKvdAuIY', 8, 1232076, 28729, 40743, 130977890),
(9689, '9Sc-ir2UwGU', 8, 2215650, 62918, 39124, 561910248),
(9690, 'ByfFurjQDb0', 8, 665238, 14446, 12012, 71376640),
(9691, 'GZjt_sA2eso', 8, 3553179, 68658, 286374, 278590379),
(9692, 'Y7ix6RITXM0', 8, 699913, 16919, 18221, 128395626),
(9693, 'pM_IzEAv5d4', 3, 35762, 387, 1300, 1493885),
(9694, 'v-dfygYIfLs', 9, 527586, 12251, 45084, 20659306),
(9695, 'AJUhzQEPCvE', 9, 10377, 99, 977, 465869),
(9696, 'NmugSMBh_iI', 8, 1408088, 47677, 47790, 394181806),
(9697, 'LEL8vvz2tJc', 7, 259582, 5044, 9233, 9433900),
(9698, 'ShZ978fBl6Y', 8, 1597777, 27136, 37789, 178505891),
(9699, 'i_yLpCLMaKk', 8, 1296045, 27853, 54261, 141712180),
(9700, 'kTlv5_Bs8aw', 8, 5642623, 165485, 824587, 335814219),
(9701, '1BYr1br2Ee4', 8, 406805, 4682, 25524, 17583537),
(9702, 'ilw-qmqZ5zY', 8, 987247, 19024, 18316, 185125007),
(9703, 'Bk7RVw3I8eg', 8, 459626, 16954, 37682, 82387722),
(9704, 'ekzHIouo8Q4', 8, 3099255, 96436, 148244, 706167805),
(9705, 'Jwgf3wmiA04', 8, 5835165, 200199, 505663, 733600048),
(9706, '1arz9Q9qBas', 8, 341471, 6048, 30094, 12905355),
(9707, '4uTNVumfm84', 8, 945269, 28988, 31074, 102928202),
(9708, '1KofiHFsBQk', 1, 173633, 12069, 29039, 16232108),
(9709, 'eUsgeGIwjSA', 8, 56376, 3638, 3115, 4461935),
(9710, 'NsrEb1aJxMY', 1, 813364, 7452, 105950, 11608311),
(9711, '4UjNV9Fn76U', 1, 183551, 2436, 19805, 13057885),
(9712, 'w1oM3kQpXRo', 8, 2024907, 49973, 148008, 277085761),
(9713, 'olONgK_CxG4', 1, 257993, 1053, 23809, 3678991),
(9714, 'a0S425nVBng', 1, 538619, 16974, 84011, 12715051),
(9715, 'rBif7EPy610', 1, 81505, 2476, 2488, 3106828),
(9716, '1DYii6npwYc', 11, 370731, 3230, 15984, 5968635),
(9717, 'R9rymEWJX38', 11, 380317, 9070, 11314, 59364235),
(9718, '6TSh9zTHz2k', 11, 0, 0, 5532, 1885182),
(9719, 'zCSkauWVGNQ', 1, 28972, 1300, 1790, 3392588),
(9720, '87ki7-bcpMk', 11, 20562, 363, 2674, 529175),
(9721, 'pZ0lK60WuZ4', 1, 795920, 8967, 101757, 11683265),
(9722, 'Bz4pK8UP4PM', 11, 1059, 63, 0, 125300),
(9723, 'kg1BljLu9YY', 8, 983712, 24286, 58402, 35546247),
(9724, 'OLuMcFqKHi4', 7, 70167, 8649, 11220, 6710920),
(9725, 'jzLlsbdrwQk', 11, 122520, 12841, 14221, 7543792),
(9726, '0nlJuwO0GDs', 6, 858335, 15863, 99184, 74886866),
(9727, 'kyoS1edY5tM', 7, 5927, 230, 493, 332190),
(9728, '4OBLAW7oQYo', 11, 47759, 996, 359, 1738298),
(9729, 'pBkHHoOIIn8', 8, 1561860, 49066, 48386, 177526239),
(9730, '01ZOXady5aQ', 9, 196373, 14861, 18095, 21368848),
(9731, 'LAbXD3sx3fc', 9, 461237, 12159, 29944, 42924312),
(9732, '3PNsMXe170Q', 9, 192578, 4993, 23418, 44874302),
(9733, 'Zvk6lJlpo_E', 9, 1821, 78, 295, 291474),
(9734, 'ze4k0LQUmT0', 10, 20527, 317, 1424, 880518),
(9735, '-_tvJtUHnmU', 10, 87180, 2588, 9100, 4831008),
(9736, 'EKBcZFwSNi8', 7, 53581, 5504, 2222, 5842060),
(9737, '8zhYDFjniTo', 1, 40579, 1895, 4678, 2251454),
(9738, '8RKOXktju_0', 7, 4305, 147, 481, 159189),
(9739, 'tpLLst4-3fw', 7, 304316, 43164, 50485, 26834800),
(9740, 't4JZZhKDyTI', 7, 35473, 3396, 1209, 2467012),
(9741, 'uZTCFiUFIic', 7, 34036, 3348, 1106, 4396261),
(9742, 'eAZrzB7v8IY', 7, 29062, 3009, 1998, 3333210),
(9743, 'FC-NidEODM8', 7, 62259, 689, 12546, 1588569),
(9744, 'R8b1bF44qT0', 7, 173409, 14972, 106184, 11001745),
(9745, 'L1raP46x_5I', 7, 8401, 734, 705, 497218),
(9746, 'NFaHoWtEm10', 7, 525766, 52063, 21307, 75261522),
(9747, 'Ppfe1AfTm78', 7, 5519, 509, 1380, 299772),
(9748, 'z_Nn2qMZXjA', 7, 34440, 1599, 2516, 1518400),
(9749, '7AkXdYrSsFs', 7, 53207, 8841, 24524, 5023983),
(9750, 'M37nylLfjIo', 7, 121423, 1490, 9932, 2609412),
(9751, 'lb_d3bsQZAQ', 7, 18277, 2453, 1895, 1607148),
(9752, 'S1ucmfPOBV8', 11, 10461, 566, 997, 3392441),
(9753, 'klRzWiZ6WrA', 10, 578, 13, 49, 55601),
(9754, '7XOMkCCl-TE', 7, 130943, 14921, 3199, 11231036),
(9755, 'Jt_UPHBoRpI', 11, 15425, 187, 1227, 544409),
(9756, 'li3GYCPv8lo', 10, 3362, 315, 1541, 398832),
(9757, 'udZU4Q84oPk', 7, 68645, 8105, 3021, 10668282),
(9758, 'V2VcEkPaeF4', 10, 6589, 228, 349, 1480540),
(9759, 'jC5MQJ8BZqw', 7, 21786, 2870, 3869, 1950484),
(9760, 'zmOOljY19Q8', 10, 13264, 529, 689, 3745685),
(9761, '3AvoV8GodbU', 10, 16108, 223, 823, 523607),
(9762, 'EOjWDMoxf1U', 7, 234877, 34207, 12272, 35774314),
(9763, 'KI3x6FMWsPQ', 10, 1942, 112, 328, 70674),
(9764, 'XRL8kRjgfFg', 3, 4056, 78, 232, 253275),
(9765, 'YZzydHgojMc', 10, 7069, 82, 461, 453528),
(9766, 'DaHgJP1MbtA', 10, 2504, 96, 894, 311857),
(9767, 'B968p2vNRso', 10, 4321, 132, 417, 228067),
(9768, 'wrQSMcU_IRQ', 10, 23804, 547, 3112, 805584),
(9769, 'L6KHM4HXwQo', 10, 1132, 61, 72, 170286),
(9770, '4TwGid87U8g', 10, 5142, 347, 1353, 276491),
(9771, 'W_2eU1ykV3k', 9, 173066, 3150, 11479, 23602544),
(9772, 'A2FsgKoGD04', 9, 1673444, 33539, 73132, 107480515),
(9773, '555oiY9RWM4', 4, 130477, 1504, 7373, 5292665),
(9774, 'Oo6iAxf4si0', 10, 13953, 606, 1341, 3473634),
(9775, 'Ha8XOntG0nw', 10, 58635, 668, 2625, 2936336),
(9776, 'hPf-zDX6q-U', 10, 27106, 490, 2933, 1186974),
(9777, 'mH4wki8z5oI', 10, 9088, 554, 1561, 435209),
(9778, '8YiWzYsBf4g', 10, 29094, 3622, 1685, 7280758),
(9779, 'UnKJL_ifwkk', 10, 28956, 725, 1877, 2196540),
(9780, 'hbo1unya8ag', 10, 0, 0, 949, 561063),
(9781, 'Ush6tS5Vk-A', 7, 35884, 1761, 4139, 1606417),
(9782, 'HzsxFtlNq7Q', 11, 33789, 2588, 4595, 4592238),
(9783, 'BshKMxCxxFg', 11, 55905, 1299, 2759, 4645964),
(9784, 'ppbr6ryKP2k', 1, 20892, 800, 2996, 1036622),
(9785, 'tiHg5kOAk2Q', 7, 5506, 312, 240, 263516),
(9786, '8c5YY9DcoiE', 11, 439233, 59318, 33278, 28613451),
(9787, 'DiaDblUd-lw', 1, 101371, 7518, 10200, 8333100),
(9788, 'vVsXO9brK7M', 3, 123605, 16507, 11319, 12804297),
(9789, 'a0TQkX_zLt0', 11, 71329, 7405, 4927, 3097430),
(9790, 'mZamCP7v64o', 11, 26686, 1209, 1841, 883699),
(9791, 'CAb_bCtKuXg', 1, 879545, 19193, 196105, 24726423),
(9792, 'o90yH5_fMbY', 7, 40166, 2530, 1289, 1748482),
(9793, '9Hcd6yCHePM', 7, 231685, 12546, 3279, 14221988),
(9794, 'NZgf1VsbsO4', 7, 238291, 20088, 6175, 18407593),
(9795, 'UY7sVKJPTMA', 11, 5913, 66, 204, 235207),
(9796, 'xukGZnD-xDE', 1, 47967, 1772, 5098, 3472307),
(9797, 'OAgFtf7Dmi8', 1, 124780, 6004, 3929, 14526691),
(9798, 'TdyllLZeviY', 8, 705012, 16446, 25565, 60466018),
(9799, 'yiKFYTFJ_kw', 9, 106673, 5791, 5569, 28288384),
(9800, 'UeG1ftTmLAg', 9, 4150825, 95730, 595201, 163429188),
(9801, '98_9AS89R3Y', 10, 4019, 51, 403, 202067),
(9802, 'LmeYxwWE9sY', 10, 23797, 724, 2451, 1139798),
(9803, '3fQfuzB-6to', 9, 103666, 2670, 4144, 8108936),
(9804, 'Hk5dxn5dj2M', 9, 531287, 22557, 38321, 33944897),
(9805, 'QU1byle-nmA', 9, 383391, 8710, 39004, 16939105),
(9806, 'C3DlM19x4RQ', 8, 275064, 3938, 37090, 10584197),
(9807, 'nSbzyEJ8X9E', 4, 90936, 2695, 11581, 7765299),
(9808, '0gWxHFMog9w', 9, 436806, 10828, 59469, 75813285),
(9809, 'OU21H6-Y6Y8', 1, 63628, 1225, 3345, 2231259),
(9810, 'N9FC6PQ6Tyw', 7, 90700, 10637, 8685, 6892232),
(9811, 'JiOXpKU7tWc', 11, 14723, 289, 974, 269701),
(9812, 'icLIdzEJ1Uo', 1, 371285, 2087, 23880, 4488250),
(9813, 'CeuOLUkUpAw', 11, 843649, 147553, 61355, 95361904),
(9814, 'zvcvlMC4cNk', 11, 4026, 64, 319, 116817),
(9815, 'xepmGg1A2hg', 11, 632, 18, 62, 109405),
(9816, 'jC9l0_NClrY', 9, 240661, 5758, 5037, 24073573),
(9817, 'NNcokHEikFI', 1, 28438, 1180, 1472, 1319652),
(9818, 'buRLc2eWGPQ', 1, 44037, 709, 2437, 4909742),
(9819, 'WDiK14qI3pQ', 1, 521559, 26350, 38063, 11828205),
(9820, '9kxL9Cf46VM', 1, 71772, 4914, 4071, 8627512),
(9821, 'op4lmebNo0o', 7, 72729, 5031, 3266, 12939754),
(9822, '5Jtvv7vQxIA', 1, 178774, 3862, 7984, 18827414),
(9823, '3uZzHfwfctc', 11, 73318, 11071, 4003, 15271447),
(9824, 'QaEZD3f7WrI', 11, 21232, 1371, 4534, 3096754),
(9825, '93E_GzvpMA0', 11, 20108, 690, 1679, 1430055),
(9826, 'cgfJMHq3hwo', 11, 8158, 92, 772, 300479),
(9827, 'i2xBbX2WrHk', 11, 2450, 189, 586, 398461),
(9828, '4qY9icExjEw', 11, 1365, 9, 13, 111923),
(9829, '8NonPPdQ7Yw', 11, 317148, 29615, 12569, 67284591),
(9830, 'eXnInOIszGM', 11, 14657, 715, 1890, 972730),
(9831, 'AZl12hJ5lXw', 11, 35679, 879, 4794, 2726310),
(9832, '51afqNT7GLo', 11, 127967, 10205, 25549, 6731003),
(9833, 'rqX8PFcOpxA', 11, 52113, 3743, 6527, 2882443),
(9834, 'zRIDcCLxdRI', 11, 121461, 4092, 15707, 9857285),
(9835, '8ZdzL1w_Q9c', 11, 5836, 451, 270, 978018),
(9836, 'RHGNZMomOro', 11, 241687, 23813, 10039, 47236020),
(9837, 'obPL7xXfdmM', 11, 18932, 1296, 4375, 2559611),
(9838, 'jgnVsuKY3oM', 9, 289916, 9321, 7792, 51164104),
(9839, 'GeyDf4ooPdo', 3, 162393, 7392, 12865, 21409148),
(9840, 'e1CEdPAnj44', 9, 380968, 9030, 12507, 69473161),
(9841, 'SjlM1OpEEPs', 11, 15318, 153, 1209, 154399),
(9842, 'k8GvTgWtR7o', 11, 20311, 624, 572, 1827010),
(9843, 'WgJ7Fe64Qeg', 11, 10093, 292, 2986, 1462868),
(9844, 'liiuDG9MM4M', 3, 43435, 638, 544, 2816607),
(9845, 'VWoIpDVkOH0', 8, 205717, 4624, 6781, 10632653),
(9846, 'unh8kWUuNt4', 8, 716333, 43120, 40772, 71844576),
(9847, 'RbmaLT320hw', 9, 64212, 6343, 16474, 13298421),
(9848, 'DkW87-Z9FAY', 9, 2227149, 37318, 49797, 43094215),
(9849, '09Z9tbJLkCE', 9, 378365, 9222, 20974, 38295890),
(9850, 'lzzBLlCM0hg', 3, 340, 8, 26, 42571),
(9851, 'ggR_SPwP6cw', 9, 937505, 34527, 16517, 83398217),
(9852, 'E39GIysMevQ', 3, 233984, 19259, 21553, 23015582),
(9853, '8m5STEpvKPU', 9, 31598, 2642, 3950, 5936916),
(9854, 'NI71-qySsrE', 7, 29088, 759, 1755, 1937141),
(9855, 'AvuQVi4IinY', 9, 22670, 159, 393, 741364),
(9856, '5bZQzPayuKU', 9, 13794, 445, 761, 1088224),
(9857, 'PCWgBHt86mE', 11, 61278, 2449, 3145, 3589537),
(9858, '6re9XAwo4b4', 9, 449607, 11776, 23927, 21256995),
(9859, 'FgpF6YodTG4', 11, 316425, 6768, 21747, 38230081),
(9860, 'BhIEIO0vaBE', 11, 0, 0, 0, 74169858),
(9861, 'inlr2T_9jkY', 11, 11498, 480, 2391, 1308007),
(9862, 'QELrxLxEnnc', 9, 183347, 7033, 5648, 23802424),
(9863, 'gm2_6DX_0Bw', 9, 1126639, 27728, 37676, 81958195),
(9864, 'In01Q8jFlJw', 11, 182509, 6283, 35711, 10252625),
(9865, 'ygtvRzTLPNo', 9, 428907, 8005, 26920, 19980666),
(9866, 'S9KxqRUcnCU', 9, 1218021, 23116, 43660, 42042740),
(9867, 'o08ykAqLOxk', 11, 4992, 293, 537, 380707),
(9868, 'UCgERDCYii8', 7, 124163, 19003, 21174, 10764001),
(9869, '0aNNYEUARAk', 7, 56057, 994, 2892, 2756421),
(9870, '3PFaiC5rH6w', 7, 79621, 9091, 4540, 9650861),
(9871, 'Iw7FvRjeDX0', 11, 4203, 339, 817, 497941),
(9872, '-LOBoVjLclg', 7, 205873, 22793, 6731, 22388249),
(9873, '-TyJlHVGeJ0', 7, 21765, 3378, 8359, 2473781),
(9874, 'p4hMMmnANSM', 7, 123678, 14939, 26390, 10641937),
(9875, 'qvxkON4obLE', 7, 32389, 2703, 731, 2819713),
(9876, '67WflNLk6tg', 7, 150804, 4296, 9537, 3717106),
(9877, 'zTyvoh0WF2g', 7, 16505, 1372, 661, 1298481),
(9878, 'Kt8RupLIkBQ', 7, 158113, 25909, 42937, 14056365),
(9879, 'OFPwDe22CoY', 3, 83646, 5081, 10797, 12805901),
(9880, 'He-Rn-JKOmY', 7, 18329, 1851, 1287, 1811036),
(9881, 'q_rEqcO7hMY', 3, 708, 9, 18, 45219),
(9882, '5Q91R_Hq6jk', 11, 255, 18, 0, 25819),
(9883, 'ZqhwLRrszUU', 7, 254756, 33303, 56851, 36445043),
(9884, '9m9oO84Q2fk', 9, 487147, 13185, 31961, 25574385),
(9885, 'URUJD5NEXC8', 3, 88744, 2537, 3860, 8023781),
(9886, '8IQbF0IK-f4', 9, 2569246, 40336, 60260, 73777105),
(9887, 'zSGoJk-D1LQ', 3, 35902, 1473, 1239, 2134620),
(9888, 'ifuE2uIt0T4', 9, 232553, 4939, 6605, 31504208),
(9889, 'XOzTsb4vDK0', 7, 7946, 730, 1146, 634276),
(9890, 'WpqUOW19aJQ', 9, 694247, 10334, 53753, 35725018),
(9891, 'BEMaH9Sm3lQ', 8, 2465005, 35571, 319050, 72543271),
(9892, 'Og5-Pm4HNlI', 6, 306323, 4013, 43276, 17313064),
(9893, 'kr0lqEKMo4A', 3, 72989, 2620, 17391, 6853687),
(9894, '7rm1iP5CzuE', 7, 23933, 2008, 2823, 1603395),
(9895, 'ZCvle-Loc50', 7, 95529, 10173, 8350, 9009257),
(9896, 'tMG5O61K2-s', 7, 31621, 3074, 3866, 4398516),
(9897, 'vu-_XMeo1tk', 3, 1154, 14, 93, 134583),
(9898, '1w5txYHsW2A', 7, 3056, 45, 196, 180723),
(9899, 'wv3X5uHGKKs', 7, 269948, 39326, 13521, 11891584),
(9900, 'qKBubKO-798', 3, 5162, 270, 0, 1461796),
(9901, '0I7RL1Xls2Y', 11, 174248, 22233, 0, 29085463),
(9902, 'a2-6F2zOk30', 7, 65903, 6396, 6152, 9396149),
(9903, 'aJOTlE1K90k', 8, 6823163, 247902, 320745, 834438927),
(9904, '8c08Oz8AovU', 8, 48583, 4231, 1642, 10637594),
(9905, 'tWSBCiZY-Mo', 7, 48127, 6006, 5869, 7912529),
(9906, 'c6rP-YP4c5I', 8, 2372538, 163863, 139233, 545299057),
(9907, 'z61GFxVD8K4', 8, 735086, 51344, 27690, 96731246),
(9908, 'hHW1oY26kxQ', 8, 83650, 2120, 59, 5669300),
(9909, 'irEIoJEM6bU', 9, 7780, 211, 445, 833711),
(9910, 'ZLbo3ily4M0', 7, 25197, 640, 229, 953955),
(9911, 'Jr7bRw0NxQ4', 4, 223345, 2001, 4949, 16684413),
(9912, 'on3bh57jsXU', 8, 2019, 97, 67, 43546),
(9913, '6ZtjUYRnxhQ', 9, 4914, 96, 282, 357960),
(9914, 'kYIf8I1dvdo', 9, 110483, 10472, 20829, 20050892),
(9915, 'kBdfcR-8hEY', 3, 51355, 1747, 7826, 8924431),
(9916, 'LsBrT6vbQa8', 8, 177698, 3723, 158, 10920721),
(9917, 'rmCA3qQkqso', 8, 372252, 23946, 16895, 57901363),
(9918, 'kx533GIKhZU', 8, 10384, 477, 1580, 3705788),
(9919, 'oWFXoxRu9L0', 8, 337, 4, 56, 15705),
(9920, 'GMWFieBGR7c', 3, 14750, 1012, 1163, 2279178),
(9921, 'bkUHaz5lY3I', 8, 17012, 237, 1000, 551282),
(9922, '9-QIE-xaueo', 9, 35989, 3262, 7418, 10089911),
(9923, '4Q46xYqUwZQ', 6, 618760, 13286, 38002, 61581370),
(9924, 'U130wnpi-C0', 6, 133715, 1324, 13548, 9322674),
(9925, 'kWgy4hWF0gQ', 10, 62, 1, 24, 6420),
(9926, 'dc89yyOS0Z8', 4, 1154052, 30436, 148599, 65281719),
(9927, 'BJPc49z57bU', 8, 1152193, 15753, 317533, 71562072),
(9928, 'p3o6A49QABM', 9, 23668, 583, 618, 5633083),
(9929, 'ntQsMSuEbyg', 9, 92754, 9197, 22015, 16415032),
(9930, 'kkLk2XWMBf8', 8, 213783, 11778, 8969, 9633237),
(9931, 'Vttb424e3QQ', 9, 5913, 92, 495, 360347),
(9932, 'auqyXFLZ_zw', 9, 107275, 10882, 15880, 23465648),
(9933, 'XfJuw5EfXAE', 9, 161465, 12715, 22784, 16668873),
(9934, 'AiHP603v4qo', 9, 12501, 374, 4139, 1159907),
(9935, '1AS-dCdYZbo', 9, 109935, 4736, 9229, 20339972),
(9936, 'rvEI1kJjS6Q', 9, 2030, 117, 278, 393947),
(9937, 'BtW7s1WcIjI', 9, 3117, 158, 683, 533717),
(9938, 'O4odLCih0Os', 9, 28254, 2794, 6309, 8488962),
(9939, 'Ahr2tgaPv50', 9, 26194, 493, 3833, 945295),
(9940, 'oOhJTq3uYnk', 9, 74159, 5430, 5461, 11198438),
(9941, 'rdfC6XwXTW0', 9, 574355, 13091, 11931, 59910998),
(9942, 'PfPdYYsEfAE', 4, 186133, 4051, 6165, 30660909),
(9943, 'VRJmcxCrAOA', 9, 1868091, 40777, 85456, 103579944),
(9944, '6rzlfG6Xkg0', 9, 75819, 7047, 6670, 12656677),
(9945, '4e9a3KptfC0', 9, 114947, 6936, 17337, 17717587),
(9946, 'Dsn7lgFN4oE', 9, 9695, 316, 925, 4729443),
(9947, 'GrsEAvRerTg', 9, 176693, 18342, 54877, 23713012),
(9948, 'FepIkIILumA', 9, 583653, 26750, 39081, 29877856),
(9949, '0fLqHxm90mM', 9, 21413, 1990, 6967, 2281323),
(9950, 'r12XzpnSxCI', 9, 1506, 63, 425, 197109),
(9951, 'rrNCIfc_a5M', 11, 1167, 60, 70, 61601),
(9952, 'KdNsc5dwujQ', 9, 2424, 128, 973, 286415),
(9953, 'FTQbiNvZqaY', 8, 1696727, 71670, 117133, 379278041),
(9954, 'EMIrhvEcdYo', 3, 688, 13, 59, 57348),
(9955, 'fJeJuc27ggE', 9, 111668, 6904, 20298, 20721360),
(9956, 'dzA8_7X9uLQ', 9, 331424, 6052, 24083, 24136929),
(9957, 'TLS1JQ7qtpI', 9, 36932, 1616, 5511, 6893216),
(9958, 'ym9E1YG3_QQ', 9, 533689, 15147, 21230, 56701057),
(9959, '1NODi0GZIJU', 9, 100930, 3612, 5972, 5800134),
(9960, 'SmxBEiw6khA', 9, 97798, 4666, 2699, 12692263),
(9961, 'Gm1jFODEsNc', 6, 77354, 3566, 8517, 8081652),
(9962, 'dJxQdqNb658', 6, 83177, 3272, 9670, 6031802),
(9963, 'cPNVNqn4T9I', 4, 106409, 4322, 9486, 15042946),
(9964, 'lBK7lHMdGI0', 6, 108042, 5580, 18760, 10905341),
(9965, 'h5-2GUZ2UDc', 10, 1844, 102, 108, 87148),
(9966, 'SIMQbWudYjk', 10, 3598, 145, 917, 299512),
(9967, 'cMaQsmWR6-c', 10, 1493, 15, 82, 55106),
(9968, 'xHUTACt84n0', 10, 2039, 106, 163, 332478),
(9969, 'hWQiXv0sn9Y', 4, 82903, 2162, 7019, 4844731),
(9970, 'RNc3Af8j0Xo', 9, 65206, 602, 2756, 3006352),
(9971, 'T-3BdoP1cpU', 9, 150195, 7069, 15644, 8382241),
(9972, 'o0tRfsxZpJA', 6, 68680, 1934, 7947, 2358622),
(9973, 'ZqCKYqke-UI', 10, 13450, 115, 1846, 230531),
(9974, 'rQPobWCmRQ4', 10, 269931, 6765, 63826, 9142311),
(9975, 'Q_57RkRvzKk', 10, 4283, 351, 1631, 886078),
(9976, 'UV25wR3oa3g', 10, 367, 15, 46, 79668),
(9977, 'PY9xcbfMhn8', 4, 18684, 397, 1056, 325782),
(9978, '0JHBaM0dZNY', 9, 2234, 292, 1631, 300733),
(9979, 'rZ4MkxFDfTA', 9, 200, 1, 4, 7826),
(9980, 'HfcckBSy-4c', 10, 3314, 90, 345, 302880),
(9981, 'DAtvupNKzEU', 10, 2902, 50, 143, 228514),
(9982, 'f5jwTft6654', 4, 80565, 2443, 30096, 2303977),
(9983, 'OPeuAL-hUDw', 10, 18125, 392, 878, 1173289),
(9984, 'N5sOT-i9sUE', 9, 16051, 1220, 2414, 4995956),
(9985, 'bBsh6iztmJI', 4, 11338, 209, 1300, 507405),
(9986, 'h5NedP6qFw4', 4, 73231, 10747, 11156, 3658427),
(9987, '8uehNdpaU0w', 4, 6656, 181, 489, 310258),
(9988, 'XfuTGjgDapw', 4, 242925, 2546, 7681, 20438186),
(9989, 'VD6Iy2G4S1s', 9, 3072, 314, 2092, 386355),
(9990, 'enlH4wbN-p8', 9, 8798, 625, 4225, 1009191),
(9991, 'M8R1GS-d6zI', 10, 435, 14, 164, 121273),
(9992, 'qrky6mkFTvY', 9, 92, 2, 19, 12413),
(9993, 's8OfDDBs87g', 9, 13793, 574, 832, 2055953),
(9994, 'AFC5RaH4xMg', 9, 81543, 4935, 2039, 15579527),
(9995, 'aaI4GUXWIhE', 9, 25434, 889, 5864, 997239),
(9996, 'tDConbd-P4Y', 9, 14470, 1060, 2798, 1198588),
(9997, '2dTYs8xc-Tk', 9, 37, 0, 10, 6181),
(9998, '8E8AoiZTq-g', 9, 1065, 136, 750, 277003),
(9999, '26XoeKq3Ics', 4, 56866, 2525, 6426, 3441818),
(10000, '2OaTwR8vXcc', 6, 221987, 4548, 39255, 11384770),
(10001, 'jLM2ibaRbrk', 4, 575656, 5682, 41858, 13344797),
(10002, 'lHhq8CGR1is', 9, 8778, 248, 686, 838899),
(10003, 'MpTodVRR73E', 4, 171322, 3038, 5746, 21962247),
(10004, 'y4SeAfCg7-o', 9, 62516, 4049, 8583, 13052394),
(10005, 'xaRdlaA1hKM', 9, 73996, 2664, 4481, 5256446),
(10006, 'YK6l5A8uvkc', 8, 58489, 1991, 884, 5079148),
(10007, '6YNZlXfW6Ho', 8, 1530903, 103916, 64937, 219017065),
(10008, 'pAyKJAtDNCw', 8, 957313, 27410, 50888, 156226304),
(10009, 'J1BBHP9kIuA', 8, 32776, 1282, 1243, 2298459),
(10010, 'psp96L4C5Dg', 8, 37646, 296, 1323, 683561),
(10011, 'zxtl5ExJmag', 8, 997838, 60398, 69389, 46652193),
(10012, 'ZdJ6FO9HAcc', 8, 15437, 741, 882, 589689),
(10013, '6NPHk-Yd4VU', 9, 302687, 13197, 98687, 10402074),
(10014, 'Z7QL6hjeNDA', 8, 74867, 2642, 4041, 4792363),
(10015, 'PvPgYLhOq24', 9, 15451, 475, 2598, 2704660),
(10016, '1fztBp0T8dE', 8, 28654, 4061, 717, 2331790),
(10017, 'CevxZvSJLk8', 8, 8556651, 713205, 650628, 2147483647),
(10018, 'sinoGp6w4fc', 10, 4567, 138, 215, 312078),
(10019, 'IZbN_nmxAGk', 8, 508256, 25082, 27663, 87407093),
(10020, '3axl6JVrdNs', 9, 9468, 1292, 1609, 2266260),
(10021, 'PciexvxxLWg', 10, 9756, 754, 3981, 696720),
(10022, 'lalloLAN9MU', 9, 16502, 707, 1219, 3211543),
(10023, '3WSgJCYIewM', 8, 2016019, 85219, 51073, 200324943),
(10024, 'btrzs54s1Rc', 8, 908090, 24741, 15059, 131786327),
(10025, 'ScdQQfAjFTk', 8, 565369, 18354, 13398, 48704459),
(10026, 'au2n7VVGv_c', 8, 2711899, 119591, 85158, 371192836),
(10027, 'nuusAVJCyOA', 8, 522432, 71434, 48018, 36074109),
(10028, '44oWstYPMps', 9, 1323, 29, 224, 72782),
(10029, '0BFw1B1pwPQ', 9, 14707, 300, 3107, 1086052),
(10030, 'SweagQ9sAAk', 8, 41255, 1563, 1037, 4956366),
(10031, 'l1ZawWcya0Q', 4, 164107, 1587, 2272, 7600559),
(10032, 'OKjV2SQfKrw', 9, 203069, 16297, 58191, 28294475),
(10033, 'ObBiYbyai0Y', 9, 110926, 4188, 6503, 6311171),
(10034, 'oxeMz73sqts', 10, 1396, 45, 204, 135629),
(10035, 'xbrCpUFEwG4', 9, 3356, 35, 132, 141461),
(10036, 'Q4-jOuHO-z4', 8, 385371, 13682, 15088, 11575408),
(10037, '8CP6i04ztho', 9, 7488, 531, 1823, 814018),
(10038, '36C167gzVck', 9, 2984, 182, 157, 494107),
(10039, 'Lr02KT8hOAw', 9, 10982, 972, 984, 2073570),
(10040, 'sp1bI8MNN0I', 10, 3126, 203, 842, 550417),
(10041, '9Z4lQ4k_BQ8', 1, 26195, 879, 1524, 3156504),
(10042, 'kqO5NHgrhwA', 9, 1079, 20, 108, 35418),
(10043, 'nvNZKjhS0s4', 10, 7659, 550, 1722, 508121),
(10044, 'eVBWF55tW_o', 9, 4881, 191, 984, 714211),
(10045, 'j0pjHZddQW0', 7, 764934, 7302, 82390, 7839813),
(10046, 'S2NEKpRhnxY', 9, 964, 24, 468, 59919),
(10047, 'uvh3QmReQDI', 1, 151622, 7472, 14191, 11526338),
(10048, 'TJSYxPN5q4Q', 1, 19561, 676, 1907, 1943473),
(10049, 'ryJrPfiDXIs', 10, 2803, 122, 270, 541205),
(10050, 'aWKV8nr9TCg', 1, 72254, 2354, 37587, 6663871),
(10051, 'gtdcQtqdybg', 1, 58665, 2919, 4136, 4420598),
(10052, '_53cGxAUuDk', 1, 962474, 14761, 224720, 18278616),
(10053, 'PmZjaYdS3fA', 1, 129920, 13469, 35695, 7135950),
(10054, '_Y4E8XC70x0', 1, 215773, 1067, 9895, 3886709),
(10055, 'fpNrF_jTUTc', 1, 123239, 1484, 17449, 3918430),
(10056, 'oSQZ9NiLoxg', 1, 48164, 4921, 4800, 4697302),
(10057, 'zoIo-GvL1zc', 7, 247594, 28592, 11977, 45620038),
(10058, 'r7cEGgOsbkc', 10, 166, 4, 107, 39332),
(10059, 'fiNTJfBO5Y0', 1, 333865, 6210, 25791, 4823802),
(10060, 'mVqJe_1hYy0', 1, 472864, 2738, 62333, 9440781),
(10061, 'yEPSJF7BYOo', 1, 96207, 6774, 6910, 13899119),
(10062, 'U1MzkfRLveA', 1, 15064, 809, 1613, 1622766),
(10063, 'imHUmZeAaqQ', 1, 255251, 11851, 17824, 33922004),
(10064, 'kPAIcIBtCtE', 9, 41031, 2541, 5214, 8710834),
(10065, '0NHoWejGE4o', 9, 24184, 1074, 1664, 6010313),
(10066, 'p5HFfvkR9t4', 9, 65927, 2215, 3924, 3223620),
(10067, 'OoI57NeMwCc', 1, 263314, 40680, 11141, 95497652),
(10068, 'b_JolrQC5mE', 9, 11843, 1090, 1071, 2239253),
(10069, 'zorlhoLcEmo', 9, 946, 68, 520, 195227),
(10070, '_A9di3JH3pM', 7, 130046, 28201, 58431, 15956949),
(10071, 'FJNNE_ilUiw', 7, 4248, 324, 287, 424570),
(10072, 'a5ZwNfzusLQ', 9, 19361, 2701, 1001, 7510447),
(10073, '-Czj9crvlKU', 9, 12945, 246, 839, 1610210),
(10074, 'pbFHvwAjKyI', 7, 25369, 349, 2030, 1006683),
(10075, 'x_5SJPKMHAA', 9, 68397, 4389, 10568, 9988064),
(10076, 'Xk4iLoGpr7A', 7, 37819, 7369, 9189, 2509546),
(10077, 'fd5UeL6wEmI', 8, 2979, 136, 983, 1296296),
(10078, 'UeJm1yCz2sg', 7, 58037, 7846, 3697, 14088805),
(10079, 'xfXMPBnE4L0', 7, 3065, 65, 650, 239265),
(10080, '4QsS3EK52T8', 7, 33526, 4553, 1486, 5132872),
(10081, 'lCOF9LN_Zxs', 8, 216812, 7885, 7357, 21238384),
(10082, 'GTW8IplsKmM', 7, 207147, 6266, 12802, 16952446),
(10083, 'cJDDBK_aQ0Q', 1, 19356, 1091, 2457, 1940041),
(10084, 'BKorP55Aqvg', 1, 205562, 4116, 9190, 20696089),
(10085, '5MH1bJVLQCE', 7, 407267, 9357, 36595, 30085064),
(10086, 'Vw34wMAqWzc', 9, 247767, 16706, 32709, 14921406),
(10087, 'gi_2GELMwfY', 9, 123182, 8337, 30400, 17707556),
(10088, 'YpUDblEURdY', 7, 97100, 3433, 4789, 5587606),
(10089, 'XOyXN9SgTl4', 7, 638282, 17389, 75510, 15919698),
(10090, 'bR3Jdpv2Qco', 7, 305285, 38022, 14515, 57422573),
(10091, 'rLJFCj9fJsQ', 7, 2726, 139, 621, 71085),
(10092, 'JaY1PoKjDOc', 7, 3359, 131, 1080, 176838),
(10093, 'xEAOvFG1AmM', 7, 393266, 27553, 10444, 43706873),
(10094, 'RRjRgT8QQ3c', 7, 81808, 5213, 4867, 6197497),
(10095, 'WWRAhhcTYgQ', 7, 41561, 4840, 3841, 5621825),
(10096, 'Otmmjxx40Uk', 7, 12916, 103, 637, 372964),
(10097, '-KCQayHcj_Y', 6, 459, 35, 58, 44911),
(10098, 'Bzx2bFpNuK4', 7, 131019, 22367, 7429, 30748730),
(10099, '04hZyCsl1TQ', 6, 136276, 5067, 7112, 8141389),
(10100, '-ukNDmmTOLM', 11, 228980, 19344, 47939, 10881916),
(10101, 'UtcIAOMSGnM', 6, 91258, 9341, 33976, 19660704),
(10102, 'Q1v6bCG1quw', 6, 44211, 530, 13428, 1591325),
(10103, 'sAD1nayZ9dk', 7, 33456, 818, 3303, 1476010),
(10104, 'z2VZ_OGz0RU', 4, 327968, 4262, 8502, 18090485),
(10105, 'sIaT8Jl2zpI', 8, 223243, 6202, 11804, 20055260),
(10106, 'LHCob76kigA', 8, 4483090, 152074, 219168, 708228324),
(10107, 'enOHraf3LEk', 1, 363611, 9392, 22377, 41138876),
(10108, 'qXH1dVI8Jic', 1, 136507, 3183, 6291, 10933481),
(10109, 'YevRIiFQ3lQ', 6, 66329, 2123, 17325, 4729841),
(10110, 'matdZFkS0TM', 7, 23210, 2895, 2419, 3585102),
(10111, 'eN0DybfwQZM', 6, 13496, 503, 613, 367144),
(10112, 'mmJ_LT8bUj0', 6, 119037, 2303, 8380, 3564186),
(10113, 'z-H8vCycP6k', 6, 3039, 110, 162, 225498),
(10114, 'BTaeBwdHYWo', 6, 34271, 540, 2000, 1252174),
(10115, 'S0T7hAn-hp4', 11, 51154, 7673, 4813, 14928887),
(10116, 'kOem5-zMgAM', 11, 25800, 1426, 4951, 1948759),
(10117, 'LRby14XBDog', 6, 758, 37, 123, 34883),
(10118, 'VEJp8CuHDxE', 11, 9976, 897, 697, 1559022),
(10119, 'jdNDYBt9e_U', 3, 37394, 947, 3158, 1721473),
(10120, '9ebJlcZMx3c', 3, 87288, 3585, 4232, 7969372),
(10121, '2Zf6LE0HcFo', 3, 16677, 329, 2331, 919094),
(10122, 'xeKGgmURfXw', 9, 36425, 1176, 1320, 2535390),
(10123, 'nIjVuRTm-dc', 8, 1359549, 43298, 53567, 445504005),
(10124, 'p8npDG2ulKQ', 8, 3156286, 38339, 437085, 58766706),
(10125, 'hm3WSXPN8FM', 11, 17980, 340, 1847, 258818),
(10126, '9XagIqI1ik0', 6, 27691, 601, 6924, 888062),
(10127, '2WCmD4-oyT8', 11, 1547, 139, 133, 106535),
(10128, 'M9Ei2h_aiFY', 6, 11944, 424, 3601, 939646),
(10129, 'fUXdrl9ch_Q', 6, 13569, 1146, 314, 6519484),
(10130, 'zVjJQunl4ow', 6, 36916, 919, 3436, 1748444),
(10131, 'i1KQsm3IYH8', 11, 35162, 2674, 9863, 2841501),
(10132, 'AP5VIhbJwFs', 11, 13391, 785, 4010, 5217043),
(10133, '2X-QSU6-hPU', 11, 3592, 174, 0, 641287),
(10134, 'Ct6BUPvE2sM', 8, 1894949, 366427, 173145, 217730597),
(10135, 'yGqP54lv9q4', 11, 73266, 6725, 2891, 13599634),
(10136, 'tb4QWfXUvWk', 11, 53799, 6576, 21521, 1946576),
(10137, 'E5pZ7uR6v8c', 11, 116839, 11977, 20649, 10796110),
(10138, 'flZOTL_eOoc', 11, 31893, 3084, 1770, 3165447),
(10139, 'Kqx9CE0HRD0', 11, 48677, 1940, 14163, 2742892),
(10140, 'VUV77-5ERxA', 11, 22195, 1654, 9973, 3177327),
(10141, 'b29K8m9C2g0', 11, 3491, 298, 290, 420420),
(10142, 'kT_KMsh1ARs', 11, 426134, 43145, 16760, 82432294),
(10143, 'GmvM6syadl0', 11, 54007, 840, 1850, 3911211),
(10144, 'fCb_5PbsiJA', 6, 166320, 3976, 19660, 12791544),
(10145, 'T7qvWrbXKG8', 11, 6020, 565, 269, 1634827),
(10146, 'YV_SA_6oMZU', 11, 43683, 532, 5866, 748377),
(10147, 'KDOvd_kc6z8', 11, 246, 8, 5, 30822),
(10148, 'wWZhOd-WrYw', 11, 37, 0, 0, 5481),
(10149, 'v-MwLvo0dxA', 11, 2807, 252, 193, 611185),
(10150, '-9nh1rBDnO4', 11, 236, 3, 23, 30321),
(10151, 'PEEhL9LaX4E', 8, 151653, 2319, 4429, 6783615),
(10152, 'Kbj2Zss-5GY', 8, 716535, 16452, 25267, 67601709),
(10153, 'LQPwKehOf3E', 6, 67202, 3032, 15343, 5925257),
(10154, 'GBc6oUlWxzE', 6, 8004, 130, 883, 284082),
(10155, 'rwDSa4ZgKmo', 6, 47690, 510, 8140, 1013330),
(10156, 'Hfzg8Hy7tuY', 7, 23539, 763, 322, 1167004),
(10157, '7zAr1902BM0', 7, 4262, 270, 310, 105032),
(10158, 'vRKf9jFZsIY', 7, 81604, 16661, 31313, 10753364),
(10159, 'f89pdcm2VTE', 7, 22816, 2899, 1708, 3810402),
(10160, 'DNe0ZUD19EE', 11, 120321, 4927, 8994, 18491712),
(10161, 'yURRmWtbTbo', 8, 735578, 21085, 32517, 173647998),
(10162, 'int3lFioTtU', 1, 29875, 1451, 4100, 2075779),
(10163, 'IydZOlx2yrc', 1, 240139, 7564, 15444, 9803429),
(10164, 'f9somyEzpaY', 7, 48339, 9354, 7994, 5173171),
(10165, 'Bd-er0k1YQo', 1, 21027, 1342, 3416, 8503196),
(10166, 'vuWcljJLFAQ', 1, 15554, 660, 1306, 1730249),
(10167, '_P_qo0zVZZQ', 6, 253752, 5284, 19048, 6487225),
(10168, 'RmlkAOwJ1gI', 9, 129040, 9951, 14580, 20076657),
(10169, '-JBA2965jN8', 9, 87177, 3367, 2900, 12185155),
(10170, 'iyg7sbbz_cI', 9, 4056, 155, 1797, 925944),
(10171, '3dXl28y7BIA', 4, 153889, 3024, 4671, 13392352),
(10172, 'QVoleJYgdM8', 4, 134767, 2646, 5728, 6988346),
(10173, '5ORUW0Pc-pw', 8, 279, 12, 24, 22838),
(10174, 'eExAkGrcoQ8', 1, 675039, 7697, 116398, 11178756),
(10175, 'ZV5MuIjK9Dc', 10, 5470, 511, 1345, 524070),
(10176, 'Lacveb5bS8c', 1, 23464, 226, 469, 349913),
(10177, 'XvtFzNCYf7U', 7, 26933, 3286, 1439, 5937825),
(10178, 'phk9-peZjh0', 1, 33836, 1075, 4410, 3974516),
(10179, 'R8Dy-V7NnYw', 7, 73012, 7926, 2392, 6299711),
(10180, 'VoLZXXQL-YY', 7, 136009, 15636, 11617, 20454884),
(10181, 'iTJM6TsPQ1I', 1, 5746, 134, 84, 1153677),
(10182, 'BEKCet0yknU', 1, 2899, 69, 163, 60152),
(10183, '7OihpIHUYYU', 1, 69171, 4964, 4646, 18363528),
(10184, 'sRBuse8yIRU', 1, 167387, 5411, 8209, 4839639),
(10185, 'NaSutmYmQ8c', 9, 6024, 138, 1196, 737747),
(10186, '0BgoKuKw7HI', 11, 1932, 84, 134, 208616),
(10187, 'bh9CRHu8yD0', 3, 610, 27, 0, 153984),
(10188, 'Fbr1DcGhLqQ', 3, 6478, 193, 475, 550626),
(10189, 'CfW845LNObM', 3, 32271, 565, 2061, 1024237),
(10190, 'vsMydMDi3rI', 11, 36443, 1094, 3346, 2199310),
(10191, 'i0Ma4Kw3kCQ', 3, 35992, 1836, 8528, 1210068),
(10192, 'Wh1L0rOaa88', 9, 363370, 12970, 28199, 27666063),
(10193, '_xYJhkM9BdI', 9, 4258, 145, 1323, 633891),
(10194, '9oFQzvPUzeU', 4, 554012, 7103, 23342, 19789221),
(10195, 'SR6iYWJxHqs', 8, 2869345, 93750, 265418, 802196304),
(10196, '8COaMKbNrX0', 9, 61925, 1580, 3123, 2827051),
(10197, 'dfQqEhH5Fo0', 4, 53367, 4189, 40702, 6970667),
(10198, 'ycWPnmUQ7cU', 4, 29434, 1926, 3378, 3165994),
(10199, 'ET_b78GSBUs', 4, 67971, 1993, 5899, 3968421),
(10200, 'VhYQnF0fW1g', 4, 19249, 1176, 810, 4713356),
(10201, 'vyJXg_e5u-k', 4, 114680, 9292, 111578, 12464304),
(10202, '0_9fyL_vD4M', 4, 126588, 2126, 6474, 5799852),
(10203, 'f01URP4x7ac', 4, 431932, 13393, 21529, 46138600),
(10204, 'QimXMefjqb8', 4, 20622, 903, 1168, 863478),
(10205, '4k4pMTsa1Kw', 4, 71273, 3732, 17787, 7806900),
(10206, 'RAnPQO70Rlc', 4, 21327, 716, 1746, 1213044),
(10207, 'OubM8bD9kck', 4, 94966, 4877, 13366, 5522025),
(10208, '0-9A11lwbRI', 4, 9417, 694, 812, 548862),
(10209, '3kaJaDx51iw', 4, 42195, 1992, 6901, 4414767),
(10210, 'EtAG3e3JLNI', 4, 72253, 2010, 2161, 4834680),
(10211, '4z7gDsSKUmU', 4, 21929, 1009, 2496, 3057069),
(10212, 'tiYkQIQsM6w', 4, 18828, 1212, 3136, 805969),
(10213, 'boK9z1hSasQ', 4, 1295075, 59768, 50063, 154721114),
(10214, 'H6D81MEXEEw', 4, 74987, 2560, 2403, 2340030),
(10215, '04-nRwd9p_E', 4, 1963059, 30141, 212342, 45298779),
(10216, 'B4PS1glBgKk', 4, 11887, 332, 1684, 361562),
(10217, 'PVzljDmoPVs', 8, 2010241, 63272, 136891, 499557769),
(10218, 'AYAHkql75qM', 3, 3513, 78, 0, 323257),
(10219, 'oXfY-fTZn1s', 3, 4811, 76, 309, 111968),
(10220, 'MX3Hu8loXTE', 3, 62904, 1888, 9027, 4547003),
(10221, 'a1bWKZFP2Tc', 3, 12325, 346, 2455, 1248081),
(10222, 'TGgcC5xg9YI', 3, 605794, 10920, 27442, 15788023),
(10223, 'gpyLCr59ixs', 9, 12848, 1074, 1377, 1856817),
(10224, '89aTDByJTz4', 4, 526819, 32969, 41221, 32863551),
(10225, 'IGbfJv1ia7c', 4, 56940, 4500, 8325, 6592260),
(10226, 'm-kI08vnr9k', 9, 337, 4, 16, 13643),
(10227, 'r9lNOyeOl5A', 11, 1249, 64, 132, 52832),
(10228, 'hRp3ND-fBNw', 11, 6029, 196, 1495, 649210),
(10229, 'OqUOnkag8Ao', 4, 19675, 1662, 17164, 2342985),
(10230, '88iKZQ7D6Mo', 11, 122898, 23400, 7683, 28814193),
(10231, 'E-UHBgVqM4o', 3, 10416, 484, 3264, 226427),
(10232, 'e-P5IFTqB98', 3, 161401, 1665, 10958, 9152249),
(10233, 'TXNtwqDV4iY', 4, 30630, 3462, 1301, 5977978),
(10234, 'uhkndzWeG9o', 11, 6528, 332, 338, 371104),
(10235, 'nWDy5f5s2XQ', 4, 13336, 204, 3614, 940568),
(10236, '71Qipu3aKgY', 10, 11830, 157, 2146, 362651),
(10237, 'yNLdblFQqsw', 3, 132421, 2506, 21059, 7557095),
(10238, '-MTRxRO5SRA', 3, 31904, 253, 1710, 1035707),
(10239, '4uRZoRYpx7Y', 11, 21877, 1243, 638, 906976),
(10240, 'VVuqUq7xL78', 4, 196595, 5040, 11588, 7803415),
(10241, '2MCK3eVwTw4', 11, 5917, 203, 536, 527534),
(10242, '3M0TmN2TsK4', 10, 754, 25, 76, 61515),
(10243, 'KrYmyFhLiKU', 8, 39482, 1462, 988, 8652631),
(10244, 'vkhOnPaKZ8U', 10, 36887, 1237, 2814, 2842244),
(10245, '0ndu54A7Mcc', 10, 963, 35, 74, 175964),
(10246, 'sAYJwKU81Iw', 8, 18249, 725, 689, 1731049),
(10247, 'BxY_eJLBflk', 3, 271917, 5783, 8516, 10058173),
(10248, 'gd9JbbI5zuM', 8, 722, 49, 141, 52620),
(10249, 'DRS_PpOrUZ4', 8, 2949730, 129529, 233705, 121869828),
(10250, 'o2kb5Horuxc', 8, 5951, 167, 215, 156032),
(10251, 'QFFdSR6U_kc', 8, 94398, 3578, 3362, 5557115),
(10252, 'jdLAvOMHpqo', 8, 96008, 4644, 7246, 21422620),
(10253, 'wJbxIBYVntU', 8, 86880, 2170, 3091, 9993222),
(10254, 'BiqlZZddZEo', 8, 121409, 6092, 7385, 14343945),
(10255, 'NuIAYHVeFYs', 8, 165803, 8518, 171, 16823092),
(10256, 'kHLHSlExFis', 8, 2698121, 331451, 384675, 117855325),
(10257, 'uFK0t9DHu1Q', 3, 16477, 869, 2816, 1306697),
(10258, 'iKcWu0tsiZM', 8, 404543, 24297, 58561, 11665190),
(10259, 'ELPOCJvDz3w', 8, 51983, 1635, 1646, 4127811),
(10260, '2U_xrTmL9No', 8, 3748, 216, 112, 810625),
(10261, '-QgvP8K1b4I', 8, 62451, 1217, 3116, 4460380),
(10262, 'zBziknSXtRY', 8, 2266, 210, 85, 64697),
(10263, 'y7e-GC6oGhg', 8, 228625, 14488, 428, 28841147),
(10264, 'Fm5iP0S1z9w', 8, 1601079, 148628, 371814, 103709853),
(10265, 'CwKp6Xhy3_4', 8, 25271, 1861, 496, 8084315),
(10266, 'e5cKwku2Yro', 8, 36537, 1427, 976, 3745233),
(10267, 'P1O4FGK0WT8', 8, 13121, 621, 766, 1060857),
(10268, '459G-8RtOa4', 8, 516277, 67698, 62031, 26879938),
(10269, 'wrclNtn8X8I', 8, 4961, 278, 155, 162637),
(10270, '1ZYbU82GVz4', 8, 519155, 42774, 34837, 89195291);
INSERT INTO `youtube_data` (`youtube`, `videoId`, `category_id`, `likeCount`, `dislikeCount`, `commentCount`, `viewCount`) VALUES
(10271, 'mIYzp5rcTvU', 8, 32277, 873, 840, 3135937),
(10272, '_kQl6BnDRQg', 9, 17320, 787, 2128, 1925194),
(10273, 'SzB715HPw2U', 8, 52599, 698, 3229, 1968330),
(10274, 'kLBDuWvcy7U', 9, 35197, 1324, 3106, 5668540),
(10275, 'FzG4uDgje3M', 8, 3888061, 1037618, 280387, 772765879),
(10276, 'qooWnw5rEcI', 8, 33903, 1237, 1713, 1369537),
(10277, 'XHeLr1kHNB8', 8, 110030, 7709, 3218, 15463465),
(10278, 'JV_PfGcPewY', 8, 16220, 330, 540, 2157048),
(10279, 'jO01kemz1kY', 8, 69859, 3310, 3247, 7525993),
(10280, 'kbMqWXnpXcA', 8, 1703305, 197600, 177482, 114729656),
(10281, 'd-JBBNg8YKs', 8, 605759, 30370, 31025, 57344976),
(10282, 'uAs0cXpWrhY', 8, 373, 26, 25, 46923),
(10283, '-Blsz2JbdgM', 3, 48119, 5704, 7782, 3174587),
(10284, 'lshzZhHAYIs', 3, 39585, 2054, 4425, 1162807),
(10285, 'l0i7zVhxx9k', 3, 7047, 61, 473, 153654),
(10286, '9P6rdqiybaw', 3, 169468, 1608, 13180, 3378675),
(10287, 'yWO-cvGETRQ', 3, 253212, 4373, 25003, 8909735),
(10288, 'AByoc2YxZgw', 9, 875, 37, 111, 128288),
(10289, 'YQEJyjKTH9g', 9, 110214, 4436, 22292, 10620706),
(10290, '3NXC4Q_4JVg', 3, 63748, 5206, 14041, 4023182),
(10291, '0bXCbVGb04A', 6, 249241, 8194, 64791, 8053574),
(10292, 'bgyrWLwvbug', 6, 247520, 7354, 58397, 17908129),
(10293, '5CrqezIwnKQ', 6, 233339, 4152, 68809, 10983087),
(10294, 'ajB8jOWcBtI', 6, 15944, 92, 926, 515690),
(10295, 'z1c0w5cYm18', 6, 190645, 3404, 22863, 12022886),
(10296, 'df7PZIVe1lw', 9, 164631, 16545, 80025, 17265784),
(10297, 'FVJE47TKtsI', 9, 30540, 3301, 5648, 10799786),
(10298, '4g6NzEYS12E', 1, 43018, 1165, 13503, 1946699),
(10299, '05OanI7Fr4I', 9, 5580, 384, 1607, 727279),
(10300, '3dWrKNrWbWQ', 9, 82901, 12203, 9879, 22087185),
(10301, 'lXNKMoBQ0Uk', 9, 4797, 440, 396, 1077687),
(10302, 'wqudXE4tF4M', 1, 60654, 2474, 18350, 2131536),
(10303, 'Bvkq-etmBII', 1, 60120, 367, 3312, 1002628),
(10304, 'Fq2CvmgoO7I', 9, 114307, 18539, 18416, 25331806),
(10305, '1-rCUH1zn1o', 9, 19959, 1307, 5659, 1945464),
(10306, 'CfGZadkO4CY', 1, 89099, 2884, 4494, 7729387),
(10307, 'GfGN7bfohms', 1, 68285, 2224, 1733, 10465937),
(10308, 'PDRWQUUUCF0', 4, 305488, 12355, 26113, 31812499),
(10309, '3nso_KfY6AQ', 1, 37318, 3142, 9470, 3566766),
(10310, 'di3zE-4nTLE', 4, 12781, 406, 1523, 560023),
(10311, 'qgGGkHUAOTI', 4, 4375, 423, 634, 328329),
(10312, '6YH-K-cj6TY', 4, 353266, 37633, 29861, 40537909),
(10313, 'IQ34jeVFCEU', 4, 190691, 34809, 45241, 15639702),
(10314, 'PTsQ-ryesCU', 1, 21139, 1199, 2095, 2249393),
(10315, '999s3cmPDIw', 4, 32878, 931, 2934, 888905),
(10316, 'Q5vxC5ir010', 4, 28737, 5074, 2320, 8597329),
(10317, 'j4KvrAUjn6c', 4, 191862, 22519, 27382, 12537787),
(10318, '5Ypl6N4biH0', 4, 333458, 59614, 15801, 98194472),
(10319, 'Eucf0WLfuqA', 4, 19448, 2067, 3010, 2405386),
(10320, 'dg7g0FLv_PM', 4, 33714, 4147, 2547, 6839405),
(10321, 'VFTQ762YtPM', 6, 78661, 1366, 9422, 4087980),
(10322, 'okDoKPOCiLg', 6, 48344, 502, 3615, 1355566),
(10323, 'E6sncBzVQnA', 6, 152608, 2495, 15188, 5716675),
(10324, 'Z789GZnFkwk', 6, 179566, 7772, 14265, 15381766),
(10325, 'nYHDj2sB-rc', 11, 124258, 1420, 10733, 2634331),
(10326, 'QQMr9Kd-oSw', 6, 369404, 10743, 14614, 31202500),
(10327, 'nLUU6wcA3qE', 3, 10987, 82, 939, 205178),
(10328, 'SVick42IZAk', 4, 97068, 11637, 45063, 6259770),
(10329, 'sWA7remfais', 7, 3424, 139, 589, 173834),
(10330, 'AAr3kIJqQlk', 4, 25160, 2062, 7203, 4341893),
(10331, 'MdcuaeYV9oM', 4, 845401, 52342, 58064, 167389277),
(10332, 'GxqR6p8r6z0', 4, 3017, 36, 376, 362465),
(10333, 'jZDS6BHFoB4', 4, 7296, 748, 1263, 767037),
(10334, 'm1_zLGFTSZ0', 3, 19865, 544, 3918, 682996),
(10335, 'fzVUrWC3cyY', 11, 511611, 3969, 56771, 6217287),
(10336, 'NOPZjQ6rmRc', 11, 84104, 4072, 1584, 10398016),
(10337, 'g95EtDLSK3I', 7, 75319, 10330, 8345, 11965868),
(10338, 'a-v32egDkCM', 3, 42889, 2263, 2433, 4765876),
(10339, 'aBi8M3DehQ0', 3, 26069, 868, 1116, 943423),
(10340, '2ePf9rue1Ao', 3, 4663, 97, 172, 297404),
(10341, 'vPFCn3itBFE', 1, 20706, 944, 308, 14925103),
(10342, '4vPrTC5qMh0', 1, 129589, 7163, 2658, 25645405),
(10343, 'z4yCSdazQsI', 3, 2965, 85, 114, 235145),
(10344, 'Y-QOF-qUAUw', 11, 147909, 2382, 4130, 11591305),
(10345, 'qTk6EMl6GR8', 11, 22026, 322, 636, 714601),
(10346, 'NwxdGrpXtu8', 11, 103585, 3510, 7744, 6952998),
(10347, 'F6ePs-5UY_Q', 11, 279275, 1068, 6258, 7398261),
(10348, '3AhSNsBs2Y0', 3, 10372, 460, 1293, 729554),
(10349, 'PmEDAzqswh8', 3, 71751, 1778, 8065, 2750267),
(10350, 'yaYwGJuIwT4', 1, 32176, 1524, 2348, 3486943),
(10351, '1LnI4NkOC2E', 1, 41483, 2847, 9433, 7877485),
(10352, 'v2LjkWV7gFs', 1, 66335, 1195, 11077, 1078859),
(10353, 'n4Arlam70bI', 3, 20021, 1750, 6129, 6395635),
(10354, '1MwN5nDajWs', 1, 66487, 5647, 27401, 5705833),
(10355, '5fTn3lxLEDY', 3, 124, 9, 9, 29148),
(10356, 'jlg_oGHX7e0', 3, 3501, 60, 169, 252522),
(10357, 'pMRO2dl9z3w', 3, 77734, 1446, 1233, 2366970),
(10358, 'u086rr7SRso', 3, 13738, 406, 1095, 1531210),
(10359, 'UeDG8XDt2mc', 3, 652, 18, 25, 75221),
(10360, 'f7cJicu5cLg', 3, 1344, 12, 65, 131212),
(10361, '1wo2TLlMhiw', 3, 75142, 8065, 31921, 5590487),
(10362, 'NG4n4jbyEBU', 3, 634, 12, 39, 119360),
(10363, 'eERe0-E4Zpg', 3, 1846, 35, 330, 391727),
(10364, 'jyLhnFkBCeo', 3, 867, 23, 81, 63936),
(10365, 'P6Ddb63JQxc', 1, 136326, 3030, 17333, 4091775),
(10366, 'daQcqPHx9uw', 3, 30184, 1758, 6969, 2128848),
(10367, 'os2K6pilr7k', 3, 7394, 82, 1023, 221552),
(10368, 'hQW_9ws8OhA', 1, 92667, 6928, 26998, 5235258),
(10369, 'm-mvuBVbj4w', 1, 63023, 2397, 21511, 2721485),
(10370, 'V7OsEFGjMTM', 1, 335775, 36556, 9028, 52746218),
(10371, 'dsjXKxUNv-4', 1, 6288, 486, 1051, 2452604),
(10372, 'x_joMJBrT34', 1, 156035, 8643, 22866, 5684805),
(10373, 'da2JXr2hbXA', 1, 12451, 251, 1005, 458828),
(10374, 'fVF5v0RbGjo', 1, 350866, 52663, 19114, 37973627),
(10375, 'VudNBFiBwiY', 1, 74567, 10881, 4399, 29750397),
(10376, '2GZrPR5Ajrs', 11, 314528, 13104, 17708, 28624118),
(10377, '49SG2ZLpMRs', 11, 79618, 2279, 5369, 6029605),
(10378, 'uia5mqvTeh4', 11, 311417, 6107, 36350, 7975208),
(10379, '1iYFY2lUfW4', 11, 257373, 1271, 5387, 6445368),
(10380, 'SsuWS6yE478', 11, 76665, 870, 12272, 1486172),
(10381, 'QEaa9sYY6WE', 1, 3942, 395, 329, 789287),
(10382, 'fs_eF49kaok', 1, 7283, 525, 307, 1186430),
(10383, '-hCHx0EPhK4', 11, 3430, 487, 442, 711182),
(10384, 'B1w0c0qRq6s', 4, 123729, 8419, 13013, 1793686),
(10385, 'ELKDng0U5S8', 9, 2347, 159, 300, 526786),
(10386, 'jCm3BemDlj8', 9, 27505, 4260, 22827, 4650116),
(10387, '_zXvl88i4Hw', 9, 3859, 126, 464, 276610),
(10388, 'qdhtfwrRAkM', 9, 22297, 1482, 7067, 3908942),
(10389, 'I_zG1IAAOIM', 9, 12447, 821, 1047, 1871022),
(10390, 'DMOsxQkj9uY', 4, 77536, 3761, 33332, 5549378),
(10391, '9AThycGCakk', 4, 342716, 3476, 18569, 9310447),
(10392, 'KJq2iYdXBG8', 11, 1911, 161, 167, 158503),
(10393, 'xCU6AXuXsRM', 11, 5366, 329, 3205, 225703),
(10394, 'waR3xBDHMqw', 11, 26618, 1034, 2264, 1034860),
(10395, 'JuIa7sD6sGM', 4, 26459, 2065, 592, 2377741),
(10396, 'b5ojUxof0tY', 11, 86747, 3465, 2559, 3120766),
(10397, 'scBN3FWXCck', 4, 104363, 12210, 6453, 14880657),
(10398, 'Fags1X798UE', 4, 277845, 4705, 25698, 5780017),
(10399, 'YlaWGd1cUms', 4, 955125, 45092, 41298, 98421124),
(10400, 'abKIKVFYY08', 4, 138665, 4931, 5648, 8343839),
(10401, 'UGk88P8oTAI', 4, 16783, 822, 678, 1154731),
(10402, 'xqWa8wkWGlI', 11, 6228, 245, 523, 455678),
(10403, 'DnN6YdsqCRU', 4, 347700, 24971, 14549, 43935220),
(10404, 'dOUV2rwMr1g', 4, 196639, 5715, 10047, 9552920),
(10405, 'hsxGaj7PSoI', 11, 161513, 23218, 23118, 6358872),
(10406, 'LYRyqoGH7yI', 8, 12626, 747, 605, 1734270),
(10407, 'ecU1FxGRyqY', 11, 4385, 36, 636, 113262),
(10408, 'KqFNbCcyFkk', 11, 121418, 8142, 18733, 3754454),
(10409, 'HbuZlTBpC7I', 11, 36521, 2836, 6100, 2482839),
(10410, 'c1SVcjYY6TE', 11, 0, 0, 5150, 36645766),
(10411, 'fWeR6UhHRAM', 1, 50665, 1128, 2385, 2408484),
(10412, 'QsAy00VRCWg', 7, 31162, 4884, 1950, 5281696),
(10413, 'x3O7b6lqo-I', 1, 33873, 896, 7045, 3812583),
(10414, 'dMH0bHeiRNg', 1, 1262916, 96519, 237286, 303706713),
(10415, 'xe1gGlX1bcc', 3, 4073, 196, 221, 120062),
(10416, 'GY6bFGzazcs', 7, 55543, 3532, 4752, 7011001),
(10417, '6nMDVApYL78', 1, 280, 8, 32, 53184),
(10418, '5ad6grll-ak', 3, 55856, 741, 2428, 2207789),
(10419, 'rSlCVtsx3-I', 3, 54696, 7373, 7928, 8858762),
(10420, 'EWCp-0tG3zo', 11, 51258, 948, 1852, 2240848),
(10421, 'qzR62JJCMBQ', 11, 31064, 605, 1133, 2260664),
(10422, 'LjLdSxZTn1U', 11, 251107, 3191, 9861, 5406717),
(10423, '9F-WPOCOLpI', 6, 436304, 5553, 49857, 7252241),
(10424, 'LYUdnsIn5OU', 11, 82450, 745, 10073, 2395420),
(10425, 'imPQz9VYkCw', 11, 14627, 1620, 3985, 576980),
(10426, 'UXaX4hGRb7Y', 11, 662, 35, 22, 95909),
(10427, 'j72Z_Df5YRQ', 11, 2976, 85, 208, 146456),
(10428, '6xQilJiEcM0', 11, 21644, 1571, 1934, 2735386),
(10429, 'Ld77398EOdQ', 11, 169, 7, 34, 10072),
(10430, '4DEfoQQ9hTU', 11, 56, 1, 11, 13821),
(10431, 'E7CIuMbEGlo', 11, 1369, 75, 97, 77107),
(10432, '0rvAw4Sz4fU', 11, 1129, 32, 127, 166781),
(10433, 'hZ92_xPKSq8', 8, 51598, 4614, 2059, 8312805),
(10434, 'rIhx2wZ8jnA', 8, 820680, 80726, 99125, 75281557),
(10435, 'D91liF_Ml-M', 8, 343642, 21825, 11670, 17817461),
(10436, 'CzorX6tU-Vc', 11, 172371, 706, 3806, 5839267),
(10437, 'sOnqjkJTMaA', 8, 2700752, 165616, 278314, 540249169),
(10438, 'jA-dDnbOTOo', 1, 116265, 2159, 14039, 2899264),
(10439, 'R7ghDhpCLKM', 1, 177185, 6733, 20712, 38353015),
(10440, 'sqVwFG-KwMw', 1, 26209, 844, 3655, 1370123),
(10441, 'QX_oy9614HQ', 1, 25130, 1536, 0, 6813011),
(10442, 'vwP1-KwiBhw', 1, 2292, 4, 218, 43190),
(10443, 'xOZzMMSJ1yI', 1, 2123, 1, 276, 44010),
(10444, 'bkzCoHEt2rU', 1, 231765, 4585, 26818, 5160561),
(10445, '6ak9Ac1MZGs', 1, 2749, 289, 410, 638971),
(10446, 'btaEDH775ko', 1, 25657, 1915, 4868, 2639642),
(10447, 'q5_V9RT8aR8', 1, 35285, 1235, 3601, 12128339),
(10448, 'Bu18YNn28Ho', 1, 70868, 710, 16404, 2304346),
(10449, 'eay4QxTYzEw', 1, 295460, 9489, 183896, 5112820),
(10450, 'tc31uZ9wK98', 1, 131837, 641, 23823, 1742384),
(10451, 'mOy7Mm5bth4', 1, 368724, 1552, 35431, 6358489),
(10452, 'o1ZfBFyrskY', 1, 25856, 1576, 6108, 2537611),
(10453, 'FsdWNU--qsU', 1, 371372, 6613, 48844, 12404174),
(10454, '5Aoa7B42GHk', 1, 27372, 1510, 3435, 3183825),
(10455, 'z4ZKAqitJUk', 1, 56292, 1194, 11572, 1908527),
(10456, 'Io7tAhpUptk', 1, 2706, 8, 286, 40892),
(10457, 'CtbftHbrMMk', 1, 2461, 58, 542, 113144),
(10458, 'XwOkmpNBmWo', 1, 116927, 2060, 17078, 3769975),
(10459, '7juAsEC-reQ', 1, 69026, 812, 5269, 1766872),
(10460, 'wqks_R90ykI', 1, 105413, 6561, 6653, 19055062),
(10461, 'NA3mD0-oNVQ', 1, 320928, 6564, 19715, 27355107),
(10462, 'M1F0lBnsnkE', 1, 160073, 3921, 10066, 41822861),
(10463, 'E0DUAnFwz8Y', 1, 22363, 494, 970, 4098982),
(10464, 'KzCicJ8pMcU', 1, 105144, 3554, 15180, 8484972),
(10465, 'TOwsbh-vwkg', 1, 49870, 5360, 2149, 12872160),
(10466, 'tpUVgh_c_jM', 7, 76813, 6619, 2715, 11674108),
(10467, 'wnhIPmXdyyA', 1, 138838, 2360, 12140, 4194359),
(10468, '8cOeWTxePxk', 1, 157493, 1071, 11056, 4160577),
(10469, 'L5PwHGWg1Mg', 11, 48407, 982, 3182, 1577344),
(10470, 'Vj-nHs1qTHM', 11, 52394, 1410, 3747, 3029716),
(10471, '7KwzVus9xds', 11, 87155, 1796, 8314, 1843352),
(10472, 'AAeRZX6ann8', 11, 177399, 4178, 12655, 13258639),
(10473, 'eNQlttROQbw', 11, 145179, 1099, 11058, 2702807),
(10474, 'uSPEELypmbI', 7, 80800, 10757, 4625, 8398286),
(10475, 'IpxB_-fL_HM', 7, 3386, 60, 310, 127605),
(10476, 'fphcNuJG8Kc', 7, 40154, 2258, 2046, 1848415),
(10477, 't1muWUIZE8c', 7, 41502, 512, 2849, 1722451),
(10478, 'm-EsN6faeWw', 9, 300, 9, 16, 14856),
(10479, 'IvT2o7gDrbQ', 9, 111885, 5690, 4759, 17357265),
(10480, 'vXtIJdOSCWI', 9, 86084, 9053, 24331, 6512163),
(10481, 'NoGK1lE1K6I', 11, 29984, 704, 3770, 2235458),
(10482, 'HYIuOtr4EGs', 9, 353, 3, 12, 15886),
(10483, 'MihNaNohHZg', 9, 237, 2, 15, 17616),
(10484, 'BN9iFX9BLSA', 11, 52144, 1028, 2444, 2342751),
(10485, 'zklbZR9025Y', 11, 6228, 89, 427, 176328),
(10486, 'MBgyP97mih0', 7, 5995, 445, 529, 343653),
(10487, 'mn1DEeyqaT4', 11, 1022542, 63832, 81675, 87809824),
(10488, 'lM_HPAXwJFw', 11, 32284, 1601, 6346, 2084375),
(10489, '74KTOpJXY_o', 11, 216791, 4161, 14934, 8521230),
(10490, 'gllksyjhOz8', 9, 131516, 14299, 13749, 24246239),
(10491, 'I_-TRxF5Heo', 11, 6272, 63, 435, 242223),
(10492, '4wDVzjn9s9E', 9, 75959, 4347, 2802, 9261574),
(10493, 'SauIuZR5PZ8', 9, 18699, 1287, 6191, 3747664),
(10494, 'Wofmtc4gyv0', 1, 25099, 535, 6801, 1145899),
(10495, 'XnEFeOCf_7s', 1, 36529, 2926, 2072, 8624929),
(10496, 'EG9mREdJ79E', 7, 51060, 7878, 1963, 9092329),
(10497, 'HrVq6x5v-Tw', 1, 82048, 1207, 12302, 2741446),
(10498, 'xXggafOP230', 3, 8374, 141, 452, 796921),
(10499, 'VPPpP2gioX8', 1, 69965, 5018, 842, 9366432),
(10500, '1GaMGdOQLvg', 1, 17397, 180, 2054, 606045),
(10501, 'V0pNpDR2o6o', 1, 39244, 2762, 9885, 1992926),
(10502, 'oJHySMdXjxE', 3, 1692, 249, 161, 837945),
(10503, 'Vb3IMTJjzfo', 1, 113885, 5174, 31009, 14778625),
(10504, 'oHSehKtDyoI', 11, 164496, 3655, 18185, 8523275),
(10505, 'lvrDWhZDEfo', 6, 87918, 1858, 17325, 5575816),
(10506, 'AhzjBhqOPd0', 11, 49055, 561, 3622, 1458766),
(10507, 'diw82rtJu2c', 7, 9825, 1175, 2955, 366595),
(10508, 'Jr4LC1q1N_g', 3, 1341, 41, 97, 95091),
(10509, 'KE0-kLhHKTg', 1, 281470, 1986, 22010, 6326178),
(10510, 'Wcnq-BgwXPw', 3, 7938, 224, 659, 811223),
(10511, 'd-o3eB9sfls', 3, 24489, 351, 1850, 801069),
(10512, 'w82a1FT5o88', 3, 28482, 1800, 1296, 4711880),
(10513, 'PSwItM6ojYI', 3, 883, 28, 98, 210117),
(10514, 'n36VU8zqCP4', 1, 116770, 8809, 7443, 17593511),
(10515, '670ZGMBjrPI', 3, 125583, 4325, 4262, 4144876),
(10516, 'TyYI7eaJ0nE', 3, 1037, 26, 231, 71997),
(10517, 'vAPmqbY6Omw', 3, 37548, 5220, 2920, 8686784),
(10518, '5zfZhskSmp0', 11, 62638, 469, 6145, 1908660),
(10519, 'pMb1f7m5JoM', 11, 117561, 2074, 8712, 3969302),
(10520, 'ZMByI4s-D-Y', 3, 242598, 9028, 35072, 25692821),
(10521, 'Zp70pCiqcwk', 3, 526, 11, 12, 77641),
(10522, '788pU7FsDBA', 1, 77143, 5571, 3111, 11374643),
(10523, 'c4z6RZXv5p8', 3, 26698, 1305, 4213, 2251782),
(10524, 'jrFgD9-l390', 1, 29932, 2003, 3291, 6396472),
(10525, 'PgkvwG971hw', 8, 30952, 2865, 2072, 4406696),
(10526, '9Q634rbsypE', 8, 141572, 7550, 8826, 17380601),
(10527, 'WI1xExDWVF0', 8, 29776, 2436, 1687, 5354147),
(10528, 'acBU6rV8CZc', 11, 30574, 3717, 6517, 2787285),
(10529, 'OKdvyiuJLes', 8, 2983, 187, 205, 308075),
(10530, 'jPyKU4iqT9M', 1, 4846, 419, 324, 1036489),
(10531, 'BbkPv3BTE_k', 8, 48, 3, 5, 14613),
(10532, '3Hyzfq8km-U', 11, 31181, 3586, 673, 5545139),
(10533, '7s8GH0IhHYA', 3, 374, 12, 13, 73512),
(10534, 'kJzSzGbfc0k', 3, 99498, 4097, 10385, 3346152),
(10535, 'eVeuDS0n3XI', 8, 153, 1, 39, 20913),
(10536, 'Ro51SuLyh8A', 8, 126079, 2026, 6311, 4469512),
(10537, 'cNpVqf8gALc', 8, 103535, 12842, 13104, 3142950),
(10538, 'v-BCmzplpqY', 8, 1245, 38, 49, 124807),
(10539, 'Lp6XlsBm_Lw', 8, 12967, 600, 859, 1066189),
(10540, '1IteB_N1Vhw', 9, 144126, 10419, 3056, 27305757),
(10541, 'zUeqZnFzgig', 9, 1437, 118, 166, 323623),
(10542, 't5StUMU0vbc', 9, 18404, 3510, 3594, 5293933),
(10543, 'B5VDL7cMsE8', 9, 11891, 1921, 716, 4815497),
(10544, 'M34LX9ss5mQ', 9, 952, 150, 891, 147676),
(10545, 'mP0ObLMXJT0', 9, 98948, 11136, 5250, 13833425),
(10546, 'fI8Y5QPbcp4', 9, 63100, 7472, 2594, 15611680),
(10547, '5NXj4A01U7E', 9, 801, 11, 117, 48147),
(10548, 'VktLY8R8px0', 9, 515, 2, 31, 22272),
(10549, 'x77Z8n4Vv7c', 6, 54739, 1311, 8294, 4910128),
(10550, 'fDa0HpoXES4', 9, 3919, 137, 875, 428506),
(10551, '2rATfT60dM0', 9, 16319, 1362, 3778, 4018093),
(10552, 'dHQKHFanye4', 9, 5218, 824, 315, 1458021),
(10553, 'pynDvIsLoU0', 9, 84462, 5728, 4691, 11635177),
(10554, 'FnEW6dX_BmU', 6, 212034, 3587, 11013, 4631760),
(10555, 'jMEJ9tgzybs', 6, 43620, 788, 16810, 2241671),
(10556, 'Z-VxGSCfRQ0', 9, 38582, 6901, 4963, 7170119),
(10557, 'eWUSMzmqkWE', 6, 87617, 1178, 5764, 4263376),
(10558, 'JBe7EGzeUuM', 6, 130486, 3921, 12859, 6647668),
(10559, 'sdyhG5PLHwg', 6, 79605, 2422, 3267, 5718867),
(10560, 'tPwuLLL64HM', 1, 81579, 2313, 3499, 6934678),
(10561, 'Z6iFvGyae28', 1, 96420, 1531, 3074, 2093239),
(10562, 'R5s-MKAPmcg', 1, 46404, 302, 2510, 3879137),
(10563, '_TM3lnF58Hc', 1, 162039, 1034, 9123, 2725749),
(10564, '31i2H-uO2oU', 3, 1541, 15, 74, 71941),
(10565, '8sw6yo0jbiY', 9, 221, 14, 10, 16598),
(10566, 'cc38YJoMI90', 4, 36550, 5833, 4630, 18508402),
(10567, 'XzHRiaAxm00', 1, 38375, 560, 1426, 2323762),
(10568, 'cbPgLYeDzu4', 6, 40076, 907, 6939, 2521218),
(10569, '07QofA2GgpA', 4, 247177, 18803, 15004, 25477234),
(10570, 'lAuZw-ZFSjc', 9, 34039, 2187, 1869, 9163743),
(10571, 'IEIpM4muFbk', 4, 28651, 752, 3463, 1500502),
(10572, 'Sx-TwIKZWZ0', 4, 9350, 158, 2771, 557954),
(10573, 'eK_Z1_Eyw9U', 4, 26009, 4354, 3226, 7322436),
(10574, 'yiaDW55Mpd8', 4, 1382, 37, 66, 127215),
(10575, '1O55kFMD_dc', 4, 65952, 6272, 4132, 12410527),
(10576, 'U9czKztZK1I', 3, 277, 4, 2, 51231),
(10577, 'ddFvjfvPnqk', 4, 347970, 21697, 458, 21318000),
(10578, 'VBDoT8o4q00', 3, 16776, 293, 1555, 1026113),
(10579, 'vFvuIJ0qf7Q', 1, 147937, 845, 5101, 3054591),
(10580, 'd1mbbYKPpHY', 1, 72290, 784, 5343, 1301197),
(10581, '5jU6E1Yn7F0', 6, 46943, 912, 4265, 2424004),
(10582, 'zeOKBklM_5s', 6, 191834, 5952, 32706, 10075407),
(10583, 'Nd4MScADY94', 3, 138316, 5893, 6268, 15881420),
(10584, 'fVyJDV6igLk', 3, 2489, 78, 638, 468804),
(10585, 'Oyj2PCWHPHc', 3, 10044, 804, 314, 2619544),
(10586, 'LKGwE0F85OQ', 7, 163703, 35548, 6974, 34699789),
(10587, 'U95vCwmytcE', 7, 24311, 3427, 1555, 4257141),
(10588, 'uB4XYFTxb7M', 7, 44287, 7277, 2661, 6929227),
(10589, 'Csl2ccBpo4g', 7, 21987, 1613, 853, 2942924),
(10590, '_ZsvrnrbPq4', 7, 33492, 4253, 6022, 2438966),
(10591, 'lHjJd4tkvSU', 7, 375928, 6296, 22630, 14793111),
(10592, '2qDGBM7sjAI', 7, 1839, 64, 256, 45152),
(10593, 'r8iUoIuk7rU', 6, 140443, 1237, 14130, 4454788),
(10594, 'be9RJp4f4Pc', 7, 69474, 12350, 15582, 8956098),
(10595, 'IgiqlpDXtuU', 11, 18338, 808, 1848, 1575281),
(10596, 'WvtvQemdRao', 7, 23150, 1789, 818, 3583274),
(10597, '9XZjxx_pmOs', 7, 130123, 16570, 8221, 22650071),
(10598, '4N-f_7Xzfsw', 7, 45117, 7918, 9140, 4968731),
(10599, 'DHJfpfNeGmE', 11, 2982, 218, 206, 335874),
(10600, 'ZMyKOkyAjUQ', 3, 15629, 421, 849, 1158112),
(10601, 'I-ABDqMUr6g', 11, 24116, 495, 1877, 713065),
(10602, 'HbJaMWw4-2Q', 4, 6065, 453, 1872, 1772489),
(10603, '8eNPAH46oI8', 11, 27207, 585, 9036, 2654843),
(10604, 'itQVuZearm0', 11, 200399, 9477, 13494, 10957432),
(10605, 'SkVtw0vG5X0', 1, 169014, 900, 7354, 3579311),
(10606, 'PYGbFvSfgmY', 6, 49135, 1116, 8819, 1747264),
(10607, 'JNDAgaflfEc', 7, 127292, 15242, 6107, 19366798),
(10608, 'h2V5LejYVW8', 7, 689982, 24249, 58145, 72488270),
(10609, 'F35x5Kx5tDU', 11, 649, 24, 58, 12454),
(10610, '5VcSwejU2D0', 11, 0, 0, 0, 7275758),
(10611, 'QunK-36aELw', 11, 31530, 2529, 15858, 5529634),
(10612, 'DdXLlJV6kM4', 11, 9548, 596, 763, 985071),
(10613, 'ryXOW1QS0ZM', 11, 2299, 71, 284, 227366),
(10614, 'E3-pfjB5we0', 7, 18492, 2043, 840, 3865142),
(10615, 'ziGD7vQOwl8', 11, 19351, 3774, 4883, 1622596),
(10616, 'qhV4lsrvMNI', 11, 14507, 388, 1297, 322575),
(10617, 'j75oP-jeoHc', 10, 1664, 171, 719, 266116),
(10618, 'oZRBUBbfIJ8', 10, 4996, 367, 404, 983194),
(10619, 'aZsYdesxVCg', 11, 19457, 664, 4865, 1977484),
(10620, '0zMSMJZc9EA', 11, 79589, 1900, 5760, 2294223),
(10621, 'ABrjdyavqkI', 10, 31887, 4089, 8577, 3728277),
(10622, 'ton42cZ6ZYU', 1, 267995, 2516, 20783, 6904913),
(10623, 'OPzVzJFq0ZQ', 10, 2649, 54, 302, 248116),
(10624, 'PIOXABoz-34', 4, 528219, 28475, 16900, 53335088),
(10625, '-hZ5gTYMk8Y', 1, 46129, 787, 2094, 5305116),
(10626, 'dFnN2toxFaY', 4, 43439, 973, 1466, 2314886),
(10627, '5XVCf-CAEPk', 1, 196754, 8173, 11568, 9890874),
(10628, 'q3iXrayrsHk', 4, 734784, 58618, 88040, 29899779),
(10629, '8YFTJuJkrts', 4, 6683, 91, 99, 408363),
(10630, 'VKvkBQukTgU', 4, 112034, 1482, 4010, 6006325),
(10631, 'tjKGnAHkhEM', 9, 990, 8, 35, 60639),
(10632, '6PiyUjVxukI', 3, 11120, 320, 1084, 272923),
(10633, '08vIy0y1N9I', 1, 127553, 1997, 7525, 5379021),
(10634, 'TFYODtDvPfw', 6, 22411, 552, 3724, 1435550),
(10635, 'AVt8iHzRb_Q', 6, 159033, 2386, 30883, 6828042),
(10636, 'Tcxm2KpaH-M', 6, 219276, 1141, 3966, 2897174),
(10637, 'E9XVVW7G_Fg', 6, 283092, 4279, 28725, 4158845),
(10638, 'OPgJwxb73Js', 6, 18466, 322, 1673, 1220560),
(10639, 'tQFpzOpH1qE', 6, 21916, 782, 5529, 1315151),
(10640, 'nIcvnU9t7S0', 1, 61447, 958, 1232, 6642639),
(10641, '0qHWub21h5c', 3, 2662, 45, 213, 384665),
(10642, 'VAIh9y4FNR4', 6, 5767, 271, 910, 531331),
(10643, '_tAUu9tNNIM', 1, 42301, 441, 2042, 2537644),
(10644, '0CdsXezSEc0', 6, 10866, 1228, 1200, 1287327),
(10645, 'H6cFpbn0DNI', 3, 398084, 2377, 35052, 6033114),
(10646, 'MQ4NKVurnO0', 6, 346657, 7421, 27393, 5263925),
(10647, 'eHtjytqVXlw', 6, 107306, 6718, 20607, 5205987),
(10648, 'o7XfaVkIlqo', 6, 41376, 3626, 21429, 7309739),
(10649, 'WBv-bSyEDZ4', 6, 210886, 27275, 14527, 5731425),
(10650, 'S-myJdkVKAk', 4, 49888, 3553, 8684, 1737492),
(10651, 'd_wwV4ww3dA', 6, 51133, 5999, 8089, 1352912),
(10652, 'leBsSGhxJ1s', 6, 18006, 836, 1650, 887398),
(10653, '29Ht7_IPebc', 4, 109546, 13881, 14467, 19695684),
(10654, 'zkpAwKM7PMw', 6, 32601, 1601, 2616, 3175890),
(10655, '8uGtMd81X0c', 6, 44797, 2182, 12315, 2136305),
(10656, '9tbxDgcv74c', 3, 235580, 4581, 17345, 6273651),
(10657, 'BquoZoAOQXM', 3, 6025, 53, 605, 125195),
(10658, 'HERbsT5BKmk', 4, 14982, 1664, 5673, 2442753),
(10659, 'qrIh-ZHN4-E', 4, 232553, 31265, 30353, 13777699),
(10660, 'HWVpPer4vtg', 4, 32161, 4948, 2483, 11872010),
(10661, 'abO5HPo9l_c', 4, 166626, 9859, 34474, 9679984),
(10662, 'pkinJsfWmQo', 4, 45462, 9292, 17612, 5258984),
(10663, 'nMM4l3cjd4w', 4, 114153, 18035, 81356, 13446525),
(10664, '1BgWM5LE_i8', 4, 38693, 3105, 5703, 2128938),
(10665, 'sOyMlOba6yA', 4, 66205, 13653, 3838, 16301492),
(10666, 'GE-lAftuQgc', 3, 198377, 3962, 24238, 13770309),
(10667, 'YI3tsmFsrOg', 3, 274267, 2475, 27081, 6008270),
(10668, '-uSgYcXug_U', 4, 33561, 4022, 5856, 3092539),
(10669, 'p5eX25gbisQ', 7, 27484, 167, 1183, 514822),
(10670, 'ia8CKDIur3s', 7, 125949, 3919, 4014, 28243743),
(10671, 'Zn1sY8zB87E', 4, 313248, 84008, 57243, 71773540),
(10672, 'KNHrqoUjtzI', 4, 12694, 1352, 1528, 1866319),
(10673, 'XyuXBYWZegY', 4, 81686, 4012, 7234, 5273669),
(10674, 'MfnCFMBp2bw', 4, 155865, 31111, 82632, 19743963),
(10675, 'o3XS_5L--Qg', 4, 240, 4, 12, 27888),
(10676, 'tBfZmYhY07I', 4, 16962, 1994, 3156, 3053413),
(10677, 'i1AHCaokqhg', 6, 77053, 3261, 6466, 3448259),
(10678, 'bNj7sf3zjhE', 6, 59358, 7724, 13119, 12532925),
(10679, 'iY7vvDoY84U', 6, 105085, 4389, 5577, 6792395),
(10680, 'DnKu46WGajo', 4, 2165, 67, 157, 115285),
(10681, '33MTlC3dLoQ', 6, 104016, 2462, 13021, 5663595),
(10682, 'lxMd18REhkA', 6, 19542, 943, 4650, 1620842),
(10683, 'bw-_iPIcGIU', 3, 14972, 301, 847, 270337),
(10684, 'A3mszC06Vj4', 6, 76495, 4787, 4921, 8568699),
(10685, 'nqlldpGVR4g', 6, 250553, 11575, 12116, 29054484),
(10686, 'xwKGZS3EE7Q', 7, 139000, 1717, 5243, 4417787),
(10687, 'cOfiRFMfsqo', 6, 20003, 956, 583, 1858903),
(10688, '6WoEGi8vK9c', 6, 8941, 405, 1668, 579528),
(10689, 'd28NBKfC0bY', 6, 79618, 1122, 10819, 2295178),
(10690, 'RpHsg2vZ5bc', 9, 65610, 4147, 2657, 6772584),
(10691, '81VcLx7iczg', 6, 1798, 172, 280, 210626),
(10692, 'UNupzy5bVt8', 4, 2590, 400, 311, 183006),
(10693, 'hgRJoIUJLgg', 6, 30830, 1728, 2042, 3154349),
(10694, 'yNhC8iir6i4', 9, 751, 26, 28, 110322),
(10695, '6yEewqyHnqo', 4, 81191, 7831, 5767, 14166863),
(10696, 'HJgKjHnzKbs', 6, 28247, 660, 5885, 1632775),
(10697, 'kstHgDYFiA4', 9, 40044, 3995, 9486, 10808242),
(10698, 'gY8exXZgyqc', 9, 18513, 1573, 3613, 3304679),
(10699, 'eLLaAxuz91c', 9, 78851, 3116, 7695, 5510912),
(10700, 'xPnN8Sg0SpQ', 4, 39178, 4063, 22829, 3802924),
(10701, '_nSToXsCiW0', 6, 132675, 15123, 22341, 10967676),
(10702, 'sAwHdOa6gyI', 9, 512, 19, 143, 57338),
(10703, 'JDkI0vv0SpM', 9, 7222, 163, 766, 724422),
(10704, 'EbQQ8s2V-CI', 9, 45784, 1221, 3323, 2323148),
(10705, 'NLgIQfWKTjI', 9, 12388, 873, 1389, 2462261),
(10706, 'RKr-U1r1AlM', 9, 304840, 8579, 10843, 32052082),
(10707, 'QJhnghKpgd8', 9, 5984, 346, 1050, 555868),
(10708, 'QQ8l83uqYcs', 9, 11957, 1148, 830, 4702109),
(10709, '4HyXiu927WU', 1, 16174, 2670, 6522, 1379534),
(10710, '04tRk6ZWIcA', 9, 826, 57, 263, 193609),
(10711, 'tqiTaq5S5IQ', 4, 39365, 3451, 18401, 6709153),
(10712, '24N0AVB5xX0', 9, 31643, 2043, 1200, 3694274),
(10713, 'MuPL-PSMX0Q', 9, 589196, 27139, 50159, 33781089),
(10714, 'ylNgT9ZQqj8', 4, 29450, 2731, 0, 4255551),
(10715, 'KsOzvmwwju0', 7, 18546, 337, 1240, 611457),
(10716, 'T6GmeOnoZec', 7, 77191, 552, 4494, 1392832),
(10717, 'TudhYwBrgYg', 7, 148944, 4322, 12136, 7191182),
(10718, 'EjuRDHhrdKM', 7, 141814, 5685, 13566, 4868054),
(10719, 'yTnFeDXO6J4', 4, 153926, 14338, 17968, 9478736),
(10720, 'I2O7blSSzpI', 4, 229817, 3541, 23535, 6474108),
(10721, '8S0FDjFBj8o', 1, 147450, 2887, 3950, 6913648),
(10722, 'pxBQLFLei70', 4, 61198, 1510, 2353, 6883342),
(10723, 'IrmsHzNTSZ0', 7, 254238, 10299, 47848, 9151187),
(10724, '75DHx3Z-FbM', 4, 362550, 22126, 24922, 39105746),
(10725, '9JkXCpYPcjY', 4, 242949, 17631, 5505, 17454804),
(10726, 'cWiPROxS2HA', 4, 271258, 22849, 20407, 39161961),
(10727, 'yw8f-wc7Z3Q', 4, 118113, 10221, 6137, 12042862),
(10728, 'MfVetou0ERY', 4, 59517, 2452, 4465, 1997812),
(10729, 'Zghe7SNmhOs', 4, 37265, 1453, 3735, 1503485),
(10730, 'foLlul8Tl3E', 4, 633429, 29876, 55503, 24570491),
(10731, 'P7YrN8Q2PDU', 4, 64529, 1469, 2122, 4194771),
(10732, 'GksOc136NQU', 4, 98504, 6813, 10335, 12169170),
(10733, '0GCuvcTI090', 4, 173255, 7301, 20547, 8036355),
(10734, 'ZE6y5BJBIQE', 4, 8387, 581, 2420, 360707),
(10735, 'q2c0EshA8aY', 4, 4481, 98, 1164, 85201),
(10736, 'w846-fPXaME', 4, 42162, 3393, 2305, 10054105),
(10737, 'Sye5R6NMN08', 4, 40207, 3167, 4025, 3174791),
(10738, 'FXsklMeNzyQ', 4, 27445, 1820, 5417, 2899997),
(10739, 'UM-Q_zpuJGU', 4, 192958, 10643, 22545, 19209456),
(10740, 'OHAWwaYu2H0', 4, 18069, 905, 1772, 1930160),
(10741, 'EUYF9qRxyZ0', 4, 55100, 5684, 5438, 15036398),
(10742, 'sOhhtQTNoiU', 11, 96183, 18618, 3566, 32504788),
(10743, 'RlP9N29iQCY', 11, 1773, 252, 102, 491474),
(10744, 'tY3ZVmkAKyM', 11, 29262, 4631, 10997, 1695517),
(10745, '-9-6259glPE', 11, 55280, 5232, 5715, 4833897),
(10746, 'vNik5OpX0UQ', 11, 82, 6, 11, 1691),
(10747, 'L7FoY03_9FY', 11, 32740, 4866, 3582, 2399515),
(10748, 'wCUIkH8UP4w', 11, 16426, 1663, 5456, 3797271),
(10749, 'HNuojsHO7xI', 11, 975, 77, 110, 38973),
(10750, 'JIyPbIC826U', 7, 32962, 531, 4047, 1677988),
(10751, 'KM4Xe6Dlp0Y', 7, 222847, 8918, 13299, 15381946),
(10752, 'zgsJbod8WNM', 7, 22825, 262, 2199, 816054),
(10753, 'r21JqtL53DI', 7, 26225, 714, 3570, 882351),
(10754, '_wKSHwm8AY0', 11, 20044, 1174, 2927, 1641791),
(10755, 'dWA5b5aPjyU', 11, 16181, 2572, 2211, 1756732),
(10756, 'hUXIoZfVy9U', 4, 62, 2, 25, 14203),
(10757, '8-hahRWhFvg', 4, 81391, 6659, 12209, 5278541),
(10758, '5M1Crar5akI', 11, 21647, 2524, 8722, 819500),
(10759, '4ZJPoDvEezA', 11, 2532, 210, 354, 197663),
(10760, 'u2SnFHZXiA4', 11, 16513, 1633, 3491, 3326476),
(10761, 'EMZvam-EMTE', 11, 829, 9, 93, 35082),
(10762, '0SD5YAeM8Lw', 7, 53436, 2743, 2025, 2911190),
(10763, 'I99NXMv1dqc', 11, 41, 1, 0, 5427),
(10764, '2m7-Sk8YZOw', 7, 133403, 5055, 16670, 4849310),
(10765, 'YZuGI9mLLUk', 11, 8987, 1284, 923, 1593140),
(10766, 'wK37rF62_7g', 11, 734, 28, 229, 24285),
(10767, 'giCy3cuvZDY', 8, 98, 5, 7, 6636),
(10768, '8rGJIEYsSDo', 8, 41, 0, 8, 756),
(10769, 'cjkFG6bHGNc', 8, 5709, 291, 351, 364482),
(10770, 'wqHHRcuJ3OU', 8, 2172, 105, 134, 128780),
(10771, 'n3McD-676Jw', 8, 16257, 1205, 575, 3378480),
(10772, 'FSWWI2Tnems', 11, 10, 0, 5, 409),
(10773, '0F-70rBorFs', 11, 17222, 3453, 8822, 2868200),
(10774, 'scVEgUdZFg0', 7, 15169, 381, 1430, 605129),
(10775, 'TOLfRTrQ8Pk', 11, 5328, 755, 1112, 960431),
(10776, 'c8rdbI3nqZQ', 11, 100, 9, 30, 35062),
(10777, 'rFAddL8g8mw', 7, 277894, 4126, 15415, 10721846),
(10778, '9DbvSl_C_kY', 7, 135659, 7902, 5803, 6630484),
(10779, 'dVzPHzULU48', 11, 524, 32, 149, 52128),
(10780, 'YW7Crd_pSgE', 11, 1802, 192, 236, 122798),
(10781, 'm3MgAOe2zSs', 7, 115766, 1894, 9224, 5668892),
(10782, 'OPAupvN9YQo', 11, 471337, 189927, 7439, 181243078),
(10783, 'EPuqGi_JpsU', 11, 40, 3, 2, 6409),
(10784, 'qJigAdmbDqQ', 11, 6038, 353, 245, 1356445),
(10785, '0G31tQJdnTQ', 7, 14557, 725, 1321, 1592393),
(10786, 'KNStujHAjQA', 4, 85693, 7599, 37860, 4214636),
(10787, 'Dx_-u7p5Rjs', 7, 25916, 497, 1622, 936908),
(10788, '5nJ9b0Xve7k', 11, 338, 13, 38, 53765),
(10789, 'UXneS6fHvb0', 4, 5052, 136, 596, 280063),
(10790, 'X6SC37kMlkI', 4, 150223, 16536, 5627, 25833263),
(10791, 'l9o33uBi40U', 4, 155012, 15130, 5244, 12809676),
(10792, 'APJbmdQnMjM', 4, 2444, 25, 201, 42062),
(10793, 'x7jI0XvV7Fo', 4, 170052, 46869, 22102, 30201971),
(10794, 'OBzYZIPJ3wM', 4, 34461, 3541, 3794, 2392432),
(10795, 'fUetP0PYav8', 4, 77774, 16771, 39543, 5456397),
(10796, 'jcHx2e-6Wy0', 4, 204, 15, 22, 15719),
(10797, 'couXQ-oeyRc', 4, 4179, 54, 0, 243699),
(10798, 'CCaT-yqZrsw', 4, 17680, 988, 3677, 1105990),
(10799, 'CDgJf5ztpnc', 4, 3081, 282, 143, 247386),
(10800, 'Q8QlNuTUe4M', 1, 161105, 5496, 17116, 2540268),
(10801, 'y1cdhzGXWY0', 1, 69406, 5062, 15086, 6094795),
(10802, 'JUizXmMtODg', 1, 15143, 708, 492, 1751764),
(10803, 'D4BmnRnbzII', 1, 978, 4, 123, 15763),
(10804, '5ir1hhpkwbo', 1, 30241, 4662, 7282, 5143329),
(10805, 'Vq1zuBZBDFQ', 4, 50888, 1712, 6413, 3498234),
(10806, 'ad-Kp4Lu6UI', 4, 35439, 6741, 5833, 20619564),
(10807, 'BU2d5av-k6Q', 4, 179090, 28688, 31086, 29178225),
(10808, 'Y5D_n2EkQzk', 4, 40862, 5779, 3428, 11128141),
(10809, 'GVC5adzPpiE', 4, 115840, 5277, 161, 7246592),
(10810, 'dY2uEdgua1s', 4, 89361, 9749, 73752, 9430163),
(10811, '6mjtoE3kLR0', 4, 17577, 3203, 0, 5770838),
(10812, 'sv3TXMSv6Lw', 7, 133640, 4392, 8256, 4887950),
(10813, '4awKvTfgKfU', 7, 387709, 6426, 39193, 8540173),
(10814, '5sXkgTJULHg', 7, 3193, 64, 130, 134266),
(10815, '9-XqOsYkmvQ', 4, 3700, 67, 356, 92573),
(10816, 'SynzKC4fWp0', 8, 198937, 12973, 12429, 29406554),
(10817, 'Sg-ucNFd_0s', 8, 34642, 2437, 1559, 7349182),
(10818, 'QQ3ki1dCcnw', 7, 209221, 5544, 7021, 8392653),
(10819, 'LGEtgMY1VHM', 1, 81022, 5323, 2200, 13691628),
(10820, 'b5-KuJxRsWM', 8, 1027, 38, 130, 211597),
(10821, '4FdEOxKpk70', 1, 76730, 4078, 8741, 12002190),
(10822, 'gylQDLc6-0Y', 7, 21286, 184, 7516, 582871),
(10823, 'ltowHALDWV4', 1, 6463, 715, 1033, 1209519),
(10824, 'Np8nR5oyfQA', 1, 1198, 10, 154, 20522),
(10825, '3SlG3sE8Ytg', 7, 53182, 562, 6226, 1361356),
(10826, '4XTSKXD7e3A', 7, 83345, 2183, 7223, 2680908),
(10827, 'FqCpOo9O8bs', 1, 399594, 39153, 34184, 19952951),
(10828, 'G5Bc2cXz5Hc', 7, 106278, 1735, 27147, 4181297),
(10829, 'KcFTp4jl-TI', 7, 34785, 537, 1339, 1634075),
(10830, 'LvtMfUyA8XA', 10, 875, 90, 124, 165725),
(10831, 'dXnBw6THJfU', 1, 132800, 14178, 24992, 3567836),
(10832, 'RT4j6bX9geM', 1, 47379, 9896, 4228, 19987498),
(10833, '7DB_7YK4m-8', 7, 81038, 1508, 8356, 2950330),
(10834, 'h_ZnxnLp13U', 7, 10045, 124, 352, 200309),
(10835, '3pmu-cTT-Ak', 7, 98208, 4587, 11277, 4720589),
(10836, 'smmeWUo6VAE', 7, 59265, 754, 2050, 1371701),
(10837, 'SA7bKo4HRTg', 1, 14778, 1878, 1430, 5287206),
(10838, 'xw2RHuf64RA', 10, 4938, 352, 1250, 304242),
(10839, 'zHDl2dvQb1s', 1, 47558, 4434, 7576, 6033664),
(10840, 'QA_SY4b1tNI', 10, 4845, 298, 0, 1223468),
(10841, 'cLYBbi07gnQ', 10, 26603, 1515, 2002, 2357642),
(10842, 'Cdg5DGVi_Yw', 10, 2356, 237, 129, 217262),
(10843, '2cTtVxwP-CY', 10, 6190, 389, 1131, 824419),
(10844, '5cIvH-iZZfA', 1, 78320, 4736, 17776, 5293411),
(10845, 'KYh4SiuFvsc', 10, 4472, 289, 748, 1090626),
(10846, 'chygmkn4Vu8', 10, 1509, 57, 206, 147240),
(10847, 'ryol9sVk704', 7, 80692, 2804, 3175, 5108137),
(10848, '4WGmQo1fGao', 10, 3330, 487, 327, 466955),
(10849, '237F1_aLXZ8', 10, 40798, 5462, 8895, 8907916),
(10850, 'RxImqv7LNDc', 10, 1126, 143, 551, 209091),
(10851, '1R2sOr6vZqo', 10, 109920, 10161, 15127, 16319843),
(10852, 'MkQoi7eHm58', 10, 1767, 41, 242, 96413),
(10853, 'lcYSDMavuvo', 10, 7945, 250, 475, 274344),
(10854, '5F5265jEl28', 10, 75361, 6860, 7064, 5301388),
(10855, 'ufcvcesZalI', 10, 1649, 55, 147, 159430),
(10856, 'nwiBOYYBMMc', 10, 3299, 294, 906, 662734),
(10857, 'WV47slMgGGA', 7, 209132, 5234, 15032, 6760502),
(10858, 'rrz1wiSSe_8', 10, 26316, 1117, 3902, 1682097),
(10859, 'Wu-8PMZRul4', 10, 173, 7, 14, 29417),
(10860, 'hl23PfGOWoY', 10, 11002, 391, 1390, 1583603),
(10861, '8nGYkEBDjX8', 10, 26484, 4890, 20076, 6256436),
(10862, 'pYoq7htD_zE', 4, 66101, 21677, 4885, 26243606),
(10863, '5GI1kh0zPhQ', 10, 8067, 518, 1706, 442362),
(10864, 'opBfHXePM2Y', 4, 2798, 367, 6878, 804886),
(10865, '4FaRP12ck7k', 4, 87925, 19216, 13224, 11971416),
(10866, '06Ugwdo42EQ', 4, 159246, 10092, 28872, 2167567),
(10867, 'Y51LGEjXzrI', 9, 6339, 982, 279, 2411314),
(10868, '32_TTf50uVM', 11, 6106, 806, 373, 919978),
(10869, 'SPDGrgGknOE', 11, 39222, 6523, 8255, 3889316),
(10870, '6lmxCnuNMVU', 11, 70722, 9271, 17811, 2917266),
(10871, 'k0XPlsoDRE4', 4, 12772, 456, 1647, 744022),
(10872, '9hpV_xvfNCg', 11, 330945, 72308, 63435, 8543366),
(10873, 'YRfd-rn_b_4', 4, 40485, 7017, 4158, 12919847),
(10874, 'ezfwtmKLed0', 4, 68, 2, 18, 1747),
(10875, 'tV-wgZBGfCo', 11, 16952, 3097, 7846, 4490611),
(10876, 'nHb234yycKI', 11, 3504, 111, 612, 77344),
(10877, 'NcOhD2_VqB4', 11, 97664, 13426, 4011, 30266651),
(10878, 'R9gUEx4O-4U', 11, 723, 76, 275, 117783),
(10879, 'k85mRPqvMbE', 8, 4916042, 908558, 352972, 1381887593),
(10880, 'XaImZUM3GAQ', 11, 144494, 35280, 92625, 7877169),
(10881, 'uXSrsX3-oPg', 11, 18829, 1455, 2196, 1073741),
(10882, 'zHRKHWe8YTw', 7, 16004, 447, 395, 1136948),
(10883, 'sL3rz13Goic', 7, 7296, 216, 609, 239105),
(10884, '7TO_oHxuk6c', 8, 91668, 6203, 5256, 16618676),
(10885, 'cXH1ugjl8-o', 8, 8602, 482, 286, 947447),
(10886, 'cpUsWFhmRNI', 8, 38024, 2128, 1741, 1818551),
(10887, '77ZozI0rw7w', 8, 137101, 14012, 8685, 32140850),
(10888, 'tGn3-RW8Ajk', 8, 0, 0, 0, 1965935),
(10889, 'EOXInBJQg1A', 10, 5212, 174, 489, 266224),
(10890, 'GRn5xcgLnrI', 10, 12663, 278, 1274, 685770),
(10891, '2ccaHpy5Ewo', 8, 262000, 9545, 221, 35392281),
(10892, 'YGpK6U56oHM', 7, 38002, 1625, 3558, 1397886),
(10893, 'ioI4UqBLrNI', 11, 914, 16, 117, 31360),
(10894, 'xLkHEZTSeoU', 7, 172333, 6305, 14368, 5114232),
(10895, 'HcBFyVnf-_o', 8, 40305, 837, 1706, 991743),
(10896, 'v5o8GJ3npTw', 8, 9434, 583, 769, 1149190),
(10897, '2_O-fn64Y5k', 10, 3678, 217, 439, 681716),
(10898, 'bqWDLQVpHzk', 8, 47943, 4643, 4003, 6542963),
(10899, 'AdZpDrdIEU0', 7, 217862, 39439, 9166, 56321114),
(10900, 'aXYtJB7Qslk', 8, 86146, 6611, 6254, 17120525),
(10901, 'YV-5SqpjBII', 8, 37938, 3047, 2882, 5985435),
(10902, 'R32Ln7YZ6ig', 1, 18522, 1142, 782, 12097021),
(10903, '3NycM9lYdRI', 8, 37456, 3013, 2284, 6120291),
(10904, 'MN_JP4gyBNI', 8, 33055, 3532, 2784, 5849593),
(10905, 'QvsQ9hYKq7c', 1, 166906, 14013, 12218, 39361666),
(10906, 'FeiFyXGIH4U', 1, 52004, 1758, 5634, 1626060),
(10907, '5MgBikgcWnY', 7, 224719, 5300, 6979, 12376937),
(10908, 'tE3UZipr7jU', 8, 87, 1, 25, 8315),
(10909, 'pezG75UHecY', 8, 4124, 213, 608, 802188),
(10910, '2aK8hy50fS4', 1, 40184, 6870, 2157, 20081549),
(10911, 'zuzMkcBZrII', 1, 109095, 14188, 18486, 7196790),
(10912, '-ep_54vn5QE', 1, 402, 2, 45, 36860),
(10913, '7pQyiWUT628', 1, 370, 31, 30, 15426),
(10914, 'vxoVx6tgHmc', 1, 92296, 1184, 6154, 682368),
(10915, '0kAiDXPRaw0', 7, 43070, 10077, 2054, 6773272),
(10916, '0c2Ipzah-tk', 7, 6075, 573, 1083, 469530),
(10917, 'Z8IKn2cFTpU', 7, 8044, 517, 689, 628972),
(10918, 'KDs-FCiar7M', 1, 371764, 24320, 18918, 34501989),
(10919, '6Ib-bdko5cE', 3, 1139, 63, 75, 554125),
(10920, '9zwh4h4Jv9k', 7, 4118, 167, 521, 275358),
(10921, 'O88iXYOsyZg', 1, 1408, 79, 65, 90063),
(10922, 'mhlc7peGlGg', 7, 37837, 4632, 25199, 7126226),
(10923, 'iXKV2jaRkeY', 1, 436, 16, 59, 42711),
(10924, 'L_SEmdFNT0w', 7, 112766, 18208, 5284, 20096886),
(10925, 'c_-4B_AZHoA', 7, 135211, 23293, 9252, 24556553),
(10926, 'WpbcqKvk7k8', 7, 3738, 280, 319, 169764),
(10927, 'Gq3mW43kpkU', 8, 17217, 1015, 949, 2370012),
(10928, 'IvrOjbF7n9c', 7, 22570, 2972, 2894, 2142865),
(10929, 'KaRY8W6yl0g', 7, 30808, 5899, 7976, 3895217),
(10930, '4kfI6S2CR-0', 7, 70840, 7019, 1897, 4845209),
(10931, 'r05ZW4tJk0o', 7, 1835, 52, 532, 175331),
(10932, 'QqVcGnsfMpw', 7, 3216, 131, 459, 324470),
(10933, 'dAtJzZpApf8', 7, 3630, 46, 310, 75510),
(10934, '5aZI-jukT5E', 7, 151109, 40781, 26521, 23099835),
(10935, 'AmuoFM4afMk', 7, 159150, 27593, 7549, 26679122),
(10936, 'fmB95Bu-D3Q', 7, 589894, 81600, 26723, 101292309),
(10937, 'tq4RjCV2-qY', 7, 359, 21, 43, 4852),
(10938, 'GMzpeG_H5AE', 7, 3141, 116, 293, 107191),
(10939, 'MDL85fzdc1g', 3, 4274, 51, 133, 292815),
(10940, 'BAhHZ1Gi9Kk', 7, 13374, 2483, 2151, 1754772),
(10941, 'O8TttxvDaws', 7, 41773, 6627, 3038, 4864275),
(10942, '_BaxCNXXd98', 7, 40695, 3704, 1740, 6028820),
(10943, 'Usgp1mgwOio', 7, 10819, 2098, 862, 4488871),
(10944, 'rStL7niR7gs', 3, 228806, 4075, 21658, 6692321),
(10945, 'cwteFOCBalg', 3, 6121, 176, 0, 500351),
(10946, 'RS7IzU2VJIQ', 3, 157081, 1453, 12437, 2566416),
(10947, 'Xhkoqq3IZAo', 3, 53014, 1273, 7453, 1428472),
(10948, '0MM-psvqiG8', 3, 10384, 277, 457, 1314368),
(10949, 'xj_t8LGv-jY', 7, 61501, 7406, 3347, 9193137),
(10950, 'rF3ixuORPaw', 7, 49590, 1962, 5410, 4830100),
(10951, 'iGXYZwZEZa0', 7, 141328, 20115, 27609, 17057327),
(10952, 'uHsGqC9UTdI', 7, 45436, 4663, 2287, 8151695),
(10953, 'ZfERvm2YfLQ', 7, 1651, 23, 315, 42900),
(10954, 'T0m8APaW5u8', 7, 103418, 30007, 11794, 38045303),
(10955, 'jEp9AjZQe8Y', 7, 241399, 61475, 21073, 42497911),
(10956, 'xn8JSRAScmc', 7, 19439, 4178, 3237, 1728351),
(10957, '3XtXgH4YSrU', 3, 82325, 1407, 2136, 3117297),
(10958, '-RFUNt_d_-A', 7, 106781, 5008, 7799, 5591092),
(10959, 'ulCdoCfw-bY', 3, 221991, 2430, 15619, 5545605),
(10960, 'LoJ1uLhctRY', 3, 84554, 3375, 5158, 6697859),
(10961, 'C4Uc-cztsJo', 3, 372581, 4717, 9623, 14882503),
(10962, 'BpH9Lv8QYjc', 3, 21543, 1335, 4261, 1506067),
(10963, '4o3NVOQp4jo', 7, 92357, 9050, 7275, 2872975),
(10964, 'kPu7_3IWjkY', 7, 183222, 35778, 19420, 41588675),
(10965, '5yzDKDlGtk4', 7, 666, 11, 79, 12982),
(10966, 'Z5DcTdVqqTI', 7, 91871, 11031, 6473, 16112198),
(10967, 'mGxpw4K5Tq4', 7, 204417, 35189, 14110, 21012534),
(10968, 'mj5eEsU6Kbg', 3, 32502, 1685, 1973, 1760456),
(10969, '6N13ejCtxg0', 7, 1366, 100, 44, 218698),
(10970, 'HjrlnyFKVKU', 3, 41898, 1958, 1602, 3109561),
(10971, 'zQGOcOUBi6s', 3, 193758, 2360, 20789, 11959010),
(10972, 'Fj0cn2weBjs', 6, 0, 0, 0, 2537844),
(10973, 'MTY1Kje0yLg', 3, 413432, 29127, 40272, 49059960),
(10974, '4ojt3xzKTfI', 7, 359, 2, 56, 19007),
(10975, 'mfjGmBVAL-o', 3, 21428, 1145, 1963, 2799841),
(10976, 'Jy-RQEK5bXo', 7, 97, 2, 19, 2474),
(10977, 'DTGxzYo_YyY', 3, 138157, 1822, 12823, 3189656),
(10978, 's5BhiKZAfp8', 7, 4448, 54, 298, 146613),
(10979, 'n3J9OKTsCSU', 3, 343, 6, 10, 61341),
(10980, '5r90DYjZ76g', 3, 27308, 825, 3316, 1201818),
(10981, 'jQNazsWnQKU', 3, 442150, 8754, 20611, 17628575),
(10982, 'piUQRMkYV5Y', 3, 3442, 119, 272, 169708),
(10983, '-X8Xfl0JdTQ', 3, 23338, 264, 3238, 1085860),
(10984, 'dUwN6GI-0EQ', 3, 10781, 166, 361, 832856),
(10985, 'wJe40l2waxs', 3, 1942, 58, 80, 162410),
(10986, 'uvK_18kL4nM', 3, 574, 16, 18, 32904),
(10987, 'kVQslGva0bc', 6, 61905, 9759, 12527, 3221162),
(10988, '7oa9aIGwKus', 6, 18481, 1281, 2083, 2317198),
(10989, 'PraUjsClgDM', 6, 84085, 7905, 16566, 2278540),
(10990, 'sUP_jZYK8Sk', 6, 23086, 1162, 8756, 2149550),
(10991, 'vBpxhfBlVLU', 3, 50163, 5658, 6344, 3182309),
(10992, 'WDPYa5IsXEQ', 6, 3858, 68, 1109, 81940),
(10993, 'pp4YlyXjcKI', 3, 2815, 112, 0, 211432),
(10994, 'JudhnD_BZ90', 3, 756, 46, 58, 134209),
(10995, '2AhxAd1MBw8', 6, 13183, 542, 3257, 1718668),
(10996, 'w-dUbi2NTDM', 6, 74564, 7382, 3491, 11675123),
(10997, 'umNIxWOVVKE', 6, 26009, 1838, 4807, 1625768),
(10998, '9jRtpMKLsts', 6, 256923, 29817, 65237, 14626757),
(10999, 'nHctn1Nf8lU', 6, 59578, 2346, 4829, 4038130),
(11000, 'VwsHBx4ueHo', 6, 9870, 545, 1758, 435339),
(11001, 'wnO3pX_FTNU', 6, 28844, 831, 3387, 1473034),
(11002, 'As8XkJNaHbs', 3, 149895, 9159, 15716, 5620555),
(11003, 'LcuvxJNIgfE', 3, 1130, 71, 432, 27131),
(11004, 'zmvbSoO0Qq4', 3, 28826, 1449, 7359, 2063699),
(11005, '-FEgeuGsmzQ', 6, 188536, 47038, 45644, 5905951),
(11006, 'GrP4rDI5gBk', 6, 23372, 748, 8715, 2254720),
(11007, '4nJiR-AW-3c', 6, 2936, 314, 422, 106766),
(11008, 'NRTmVr4pU8Y', 6, 4155, 184, 1025, 875085),
(11009, 'ZCUXu4qEEfk', 3, 127, 0, 1, 16369),
(11010, 'DT3OHVCuFQQ', 7, 51742, 3964, 2899, 4915117),
(11011, 'wSkDzTyKxTg', 6, 42183, 2114, 6870, 3484187),
(11012, 'aH93gTBjGXM', 6, 126932, 10583, 11871, 10067100),
(11013, 'w1J7dxP8Vo8', 6, 6020, 199, 2898, 427673),
(11014, 'oIjI78yfh24', 6, 137048, 8084, 24460, 10562132),
(11015, 'speacW8GT_k', 6, 19021, 538, 3343, 1202681),
(11016, 'OHzfmVtFOFQ', 3, 792, 11, 36, 47558),
(11017, '41pnjsxXFfM', 6, 11875, 468, 2823, 1118486),
(11018, 'Kf0EpG-xsyU', 6, 43389, 976, 9740, 1284416),
(11019, 'F0o_fMuz_bE', 6, 2785, 108, 552, 75349),
(11020, 'Edf62jl8z40', 6, 8819, 565, 1770, 599456),
(11021, '0O_0ijJHsgk', 3, 1214, 27, 61, 71161),
(11022, 'o9lQ57VJQ8o', 3, 527, 17, 13, 83401),
(11023, 'KSQDSgWdksQ', 6, 6856, 452, 2544, 840959),
(11024, 'EOHYT5q5lhQ', 3, 21910, 1735, 3304, 1107306),
(11025, 'IuJ5ZaI6b_o', 6, 1273, 68, 123, 91212),
(11026, '_FQJEzJ_cQw', 6, 73817, 3408, 5837, 4608976),
(11027, 'Vk99lgmAOLE', 6, 158662, 2321, 25959, 5495460),
(11028, 'D47eih4TUrI', 6, 9088, 461, 907, 1015057),
(11029, 'nKd2QVrQVIM', 3, 228175, 7327, 17213, 11427255),
(11030, 'QPvLA-egmWA', 7, 25793, 349, 2135, 1312141),
(11031, 'umqRthM2KK4', 3, 139502, 5227, 16603, 10695935),
(11032, 'jb-To6qJcxU', 7, 111752, 4693, 4449, 6732501),
(11033, 'KkUKVrpAlb8', 3, 16853, 173, 970, 723964),
(11034, 'KrB-ASnFMVQ', 9, 26930, 4015, 1406, 5324945),
(11035, 'IIjPj1zD3GI', 7, 146592, 2172, 12540, 2972032),
(11036, 'IAM9mkDHyr8', 9, 2050, 71, 55, 323034),
(11037, 'sEqJt7Pj700', 9, 329, 10, 58, 36817),
(11038, '_TX8dExPIWc', 9, 103627, 13530, 7852, 20316894),
(11039, '6M0MbrjXmxI', 4, 19078, 1411, 4738, 733224),
(11040, 'u7HRxiIT_gs', 9, 5130, 250, 301, 1125746),
(11041, 'w7o1nFSaqbQ', 9, 110, 13, 101, 13424),
(11042, '88ZuNZDZEvw', 9, 122021, 18884, 4996, 40906903),
(11043, 'kMQ7eso_a8A', 9, 8178, 393, 1179, 957544),
(11044, 'McMrIAii0Xw', 4, 44963, 2574, 13088, 4295988),
(11045, '0p2cEQCsBuY', 9, 412, 59, 85, 450666),
(11046, 'lSz8tSThon4', 4, 56035, 11156, 8767, 14335087),
(11047, 'KhvC0xbcbc8', 9, 701, 52, 121, 128950),
(11048, 'nr9yRkqYNOs', 3, 183, 3, 5, 31110),
(11049, '0eUJSXx5MfY', 3, 132, 3, 0, 29000),
(11050, 'EtJy69cEOtQ', 3, 22532, 920, 1243, 1600354),
(11051, 'RcehZ3CjedU', 3, 4367, 99, 262, 343811),
(11052, 'dIramnkAU2o', 8, 5456, 332, 244, 790163),
(11053, 'OVct34NUk3U', 8, 4752, 299, 462, 368703),
(11054, 'vCQTiI_ESl0', 8, 6201, 582, 524, 734268),
(11055, 'KvRVky0r7YM', 8, 43772, 1519, 33, 4184604),
(11056, 'rLMHGjoxJdQ', 8, 65352, 2134, 117, 6615186),
(11057, 'pRAezlFcDwc', 8, 21412, 1379, 1409, 3289046),
(11058, 'oiKS7_tevbM', 10, 774, 8, 146, 38067),
(11059, '58GQx4xEdlY', 8, 21355, 1682, 665, 4052211),
(11060, 'XQL2niY7sfM', 8, 3815, 291, 311, 454381),
(11061, 'eGv9GIKNJKI', 8, 6643, 352, 456, 444829),
(11062, 'xaYvIgJp4u0', 10, 41639, 3520, 8987, 6619759),
(11063, 'Ern8qUpJzVk', 8, 3566, 230, 212, 403036),
(11064, 'lfe1wEQzSzM', 3, 41093, 3749, 7598, 2864123),
(11065, 'HqmZP0ISkfU', 10, 10325, 343, 1117, 846654),
(11066, 'E9HVA2NLEFg', 3, 35007, 497, 572, 1159628),
(11067, 'zBCUd55U2mA', 6, 167562, 5123, 58207, 4138312),
(11068, 'tPE4wv7ob8Q', 8, 38123, 1767, 26, 5882476),
(11069, 'WHE3fFgTr2U', 11, 9716, 424, 824, 624151),
(11070, 'cC0fSA7SNQ8', 8, 2358, 130, 228, 162465),
(11071, 'OwfgW0gplRc', 8, 152, 1, 26, 6397),
(11072, 'xoOaI4wbxCI', 8, 14323, 978, 996, 2993900),
(11073, 'wC4wECRuA-U', 8, 12605, 1011, 693, 1996324),
(11074, '3wxb6kYaUYU', 8, 6607, 417, 531, 730102),
(11075, 'QGwQ5ia4VYY', 8, 4107, 272, 336, 477460),
(11076, 'KSn9kYluxOw', 8, 1257, 87, 91, 128939),
(11077, 's-OFsGeiCpo', 8, 15839, 1394, 1311, 2484026),
(11078, 'tfN_I7Sj2x4', 8, 4882, 315, 144, 763501),
(11079, 'HoXatYjoos8', 8, 31403, 1351, 30, 3109685),
(11080, 'ZR38JWEsSD0', 8, 34322, 2514, 2288, 6167728),
(11081, 'De38KIayYY4', 8, 6661, 536, 414, 968083),
(11082, 'Ri3WsPDi4MY', 8, 45043, 3412, 2493, 9387265),
(11083, 'WxlS79Q3EXk', 8, 25309, 2977, 34695, 4007033),
(11084, 'RmtbbRG9mwU', 11, 2798, 394, 891, 428653),
(11085, 'lPBuAuIlZNk', 9, 117, 4, 30, 7316),
(11086, 'R9Z9Y-kq-Rg', 9, 1487, 51, 225, 299360),
(11087, 'sMRxmy9UOpQ', 11, 551, 37, 30, 54843),
(11088, '86jRi9goYLQ', 11, 69556, 2527, 144, 4473277),
(11089, '2AB-5dCFQrs', 11, 1192, 35, 59, 359974),
(11090, 'd1olVLyHNkk', 11, 320, 20, 31, 24026),
(11091, 'PSLfE6ld5dU', 11, 3314, 838, 466, 393272),
(11092, 'xUj9cuAQ6V8', 11, 401163, 118975, 17903, 126069415),
(11093, 'fadFf_HyoFE', 9, 84, 0, 12, 4263),
(11094, 'PTQJ3BQT5fg', 9, 80, 0, 4, 11734),
(11095, 'PNhf_PCAlPM', 11, 124, 10, 43, 5572),
(11096, '3VD2BfSwjnE', 11, 66, 2, 2, 3058),
(11097, 'NYdy9TjRzPc', 10, 3619, 92, 328, 897719),
(11098, 'sAHE5cdOwXA', 11, 16042, 2998, 2255, 972928),
(11099, 'QKSCaldyk8I', 6, 64274, 1067, 5280, 3712169),
(11100, 'QuTE12qGmz8', 10, 62819, 2446, 8991, 3686981),
(11101, '6BfwzGUp2po', 11, 33276, 6983, 2235, 17267561),
(11102, 'EGuEJJw2KWI', 10, 2346, 34, 154, 129368),
(11103, 'iK6JR9oT_J4', 6, 51647, 1481, 18911, 1998050),
(11104, 'qOw44VFNk8Y', 10, 150395, 4594, 5294, 19425417),
(11105, 'SBljWDJFe7c', 11, 126681, 22429, 7568, 22300965),
(11106, 'nlJ4WIj3j24', 7, 180588, 29822, 26576, 11762446),
(11107, 'aFCCxA39RzM', 7, 2853, 292, 151, 372891),
(11108, 'qbPd7e623Cw', 7, 1885, 77, 197, 452588),
(11109, '8zRm5Gg81OQ', 6, 23144, 1342, 7337, 2533224),
(11110, 'yxviTLVjvDQ', 7, 62823, 12094, 2709, 14313053),
(11111, '_9YMpuLDnwo', 7, 1266726, 247289, 71935, 240500380),
(11112, 'E_IZHRHXoaE', 7, 7804, 831, 929, 609590),
(11113, 'gayO_edX5UU', 6, 8741, 202, 810, 334766),
(11114, 'JdvFSQFZfK8', 6, 87380, 7345, 7834, 7244565),
(11115, '1cXoGfyqyX4', 6, 9122, 493, 1390, 1026810),
(11116, 'ZPgFC2HkYfg', 6, 217193, 10976, 17100, 12684487),
(11117, 'O259NYVexMg', 6, 48445, 3864, 3498, 5837039),
(11118, 'OPVZrTzWOto', 6, 16772, 1176, 3395, 1711939),
(11119, 'bV_nCfuxaMI', 7, 193505, 30267, 10095, 42182067),
(11120, '4Ve2-kin8t4', 6, 181777, 15519, 4219, 10026093),
(11121, '6DTROKNbcDU', 6, 5447, 659, 2181, 709479),
(11122, 'LW6S74J4kA8', 6, 46782, 646, 10482, 1312478),
(11123, 'I3MQ7t7m-3s', 6, 4677, 760, 4534, 557814),
(11124, 'CbftQTBHSlA', 6, 13455, 181, 630, 765508),
(11125, 'RRRugYwS7xE', 10, 8393, 490, 1331, 354259),
(11126, 'dXi4YZunkNI', 6, 90869, 1757, 12019, 4232436),
(11127, 'GciUPmkuAp4', 10, 15162, 188, 1485, 916086),
(11128, 'MRI8ffYKA8c', 10, 6704, 197, 464, 1362128),
(11129, 'gLQG3sORAJQ', 10, 97732, 3010, 8692, 7225179),
(11130, 'q_T9K3IfBvo', 10, 21776, 453, 2980, 1060418),
(11131, 'wHuY5GEY34o', 6, 33, 0, 11, 2153),
(11132, 'tevQjpTIWDM', 6, 6074, 146, 851, 294224),
(11133, 'gzOqeaur4MU', 10, 4262, 112, 220, 330266),
(11134, 'CMYs7DNu7No', 6, 54787, 7192, 11254, 2687648),
(11135, 'jhq2Cw9y1AE', 10, 4380, 469, 660, 644382),
(11136, 'D1HwTGUZUrU', 6, 16452, 223, 955, 557413),
(11137, 'AUY9Vwv2GK4', 6, 33416, 1967, 4645, 3181206),
(11138, 'nTFKEC5PM0Q', 6, 48789, 3922, 7967, 5722171),
(11139, 'jySrwZc4sZo', 7, 455737, 86031, 16967, 146887159),
(11140, 'yLgabRiUWhs', 6, 13898, 636, 2649, 2068612),
(11141, 'NGxcr_Z8Dmw', 10, 23902, 1592, 1373, 2676405),
(11142, 'Y5o3Wg-INTU', 10, 7926, 428, 774, 831303),
(11143, 'RLLX9LS_Y8g', 10, 8596, 76, 683, 341179),
(11144, 'Q57N8HMaIxk', 10, 31, 1, 0, 7153),
(11145, 'tF_QCYOv8Ew', 3, 2369, 57, 153, 212123),
(11146, 'YlR7lMDidEc', 3, 3884, 118, 0, 140737),
(11147, 'EMKX0Gurr3c', 10, 38, 3, 5, 14931),
(11148, '79Tm7oyIDNo', 3, 5997, 229, 294, 658617),
(11149, 'cOPoROA2Iio', 3, 5283, 109, 271, 462059),
(11150, 'UpGTWVstwSg', 3, 2011, 40, 89, 262714),
(11151, 'TUSxq7KoTsM', 3, 8436, 239, 272, 403641),
(11152, 'yY_-NUW8ZXk', 10, 511, 12, 49, 54330),
(11153, '4b8ZsFszE8I', 3, 51096, 4941, 9116, 4396496),
(11154, 'MqY-o3uuemo', 1, 68451, 3288, 6676, 7110982),
(11155, '1AvFNXJiMy8', 1, 24785, 5096, 775, 11197534),
(11156, 'COD9hcTpGWQ', 1, 110616, 26817, 36808, 4024563),
(11157, 'TQX6p6GRpGs', 1, 112679, 13289, 33458, 5861601),
(11158, '1FMUysy5fss', 3, 17719, 873, 720, 979210),
(11159, 'mrNi5mwntk0', 1, 78602, 6495, 16665, 13458868),
(11160, 'nn6zXn-adhw', 1, 16619, 416, 2405, 851486),
(11161, 'tK2BXbzYm1Y', 1, 3980, 523, 815, 923306),
(11162, 'sqPYJkKnVNc', 1, 46529, 3421, 1398, 5132919),
(11163, 'Rh57s_oT8wI', 1, 45691, 461, 3793, 1205200),
(11164, 'mqthVWzQOAY', 1, 1665, 125, 184, 78618),
(11165, '5a6DyjNZ9KA', 1, 47, 2, 0, 30352),
(11166, 'qCXhQBWwdAM', 1, 62742, 7777, 13129, 23770215),
(11167, 'uPcSYrPx3Ao', 1, 1285, 109, 1434, 183306),
(11168, 'sMdFuJtiuzI', 1, 107, 2, 26, 9085),
(11169, 'uelHwf8o7_U', 8, 6479194, 247944, 530776, 1593972025),
(11170, 'VTVLcK2zybM', 8, 148073, 1847, 19851, 6459202),
(11171, 'NVPU7Lpv4Gg', 8, 89379, 2188, 11657, 7103617),
(11172, 'fwK7ggA3-bU', 8, 2567273, 86486, 110273, 747964626),
(11173, '4QKreWPyPwc', 8, 707262, 16076, 52287, 45018466),
(11174, '1W5BA0lDVLM', 8, 619581, 23871, 18369, 97180403),
(11175, 'V9NUJNNLano', 3, 3329, 333, 701, 871517),
(11176, 'akmGOZagH7E', 3, 494, 16, 44, 110381),
(11177, 'QHydkEARVKE', 3, 51409, 4527, 3220, 4010348),
(11178, 'wJB90G-tsgo', 3, 56037, 3337, 1545, 3052364),
(11179, 'zPx5N6Lh3sw', 3, 7721, 352, 0, 1189489),
(11180, 'YPye9vPAOoA', 11, 168010, 1136, 9625, 4413206),
(11181, 'XJ5b7CuK3RA', 11, 132713, 1854, 7970, 6123753),
(11182, 'T_k8ixGVMb0', 11, 28506, 527, 742, 1175004),
(11183, 'hhBQ-sHYEtc', 11, 82377, 548, 5682, 1686987),
(11184, 'fT7LTaGzcok', 3, 4751, 226, 370, 325252),
(11185, '7GANxCKKRkE', 3, 637, 15, 35, 78165),
(11186, 'eA5R41F7d9Q', 3, 2030, 75, 139, 560073),
(11187, '7H2-BawRLGw', 3, 14403, 956, 2079, 862928),
(11188, 'A_vpfBJZ7JI', 3, 32561, 1575, 4913, 1699309),
(11189, 'VyJ-ksaAsFo', 3, 985, 64, 0, 135903),
(11190, 'NY0yH9PaGx4', 1, 824, 12, 80, 61473),
(11191, '50oCoHprGVQ', 1, 1248, 49, 205, 17052),
(11192, '9ru-VO0j0xE', 10, 1513, 111, 227, 350132),
(11193, 'XInVK7_cTuY', 3, 122, 3, 5, 34977),
(11194, 'LdhC4ziAhgY', 3, 1772, 94, 34, 470864),
(11195, 'PV9jdolesMI', 6, 289053, 9195, 59298, 7649617),
(11196, 'ZEzP7VcAyfM', 3, 429, 10, 5, 68037),
(11197, 'Z8XP7UjzvnU', 10, 1106, 57, 86, 110155),
(11198, 'RFDTyam_Ijc', 10, 1579, 192, 244, 704601),
(11199, 'GnEWOYKgI4o', 3, 39363, 3579, 3970, 2757309),
(11200, 'dBJM5yV7T-M', 10, 11711, 1285, 1044, 5479265),
(11201, 'kO6-S4VGRDw', 10, 1057, 78, 144, 316041),
(11202, 'Qa0lNfaU4Bc', 10, 586, 23, 40, 73270),
(11203, 'Z0FW2Pqd35E', 1, 1515, 31, 0, 229151),
(11204, 'r-iqZDdXevY', 10, 680, 45, 52, 108986),
(11205, 'oRM4oYc6U4U', 1, 1124, 8, 108, 25592),
(11206, '-twyhRPFKm8', 4, 21977, 6727, 12306, 2291195),
(11207, 'DvqFG-C9RvY', 3, 2303, 32, 300, 150594),
(11208, 'o9aVjBHEEbU', 3, 38568, 1068, 1960, 2769251),
(11209, 'OiMx0W_XI90', 4, 307, 48, 1, 46675),
(11210, 'vPVqo3MvfVo', 10, 18257, 579, 1953, 1275623),
(11211, 'W-5a8AIV_90', 1, 5368, 332, 295, 936301),
(11212, 'HJAIRO53zOs', 4, 18048, 1152, 3103, 666703),
(11213, 'BjiaMBk6rHk', 6, 195636, 10150, 39214, 3668644),
(11214, 'Rx-Mh-oXK5k', 10, 324, 6, 15, 60355),
(11215, 'hBZAv-a7crQ', 10, 3547, 62, 261, 162548),
(11216, '2N7l6SSKeds', 10, 1511, 122, 103, 305494),
(11217, 'zv8flmS9zTE', 4, 5698, 743, 649, 746427),
(11218, '2WqFtiR4-F4', 10, 1485, 193, 234, 306268),
(11219, 'LvYNbSaOTkY', 10, 3278, 220, 1739, 153957),
(11220, 'OAdnl2fzUfg', 4, 3192, 546, 194, 1377110),
(11221, '1fLb7fXmYtc', 10, 3719, 223, 507, 498586),
(11222, 'oBw51j-JouM', 10, 1569, 126, 61, 188403),
(11223, 'YZ5gk7X1uTE', 4, 25826, 5006, 7402, 9973944),
(11224, 'xdWurpnXuH8', 10, 130, 2, 17, 16468),
(11225, 'kNk8OtqhHBc', 10, 3185, 203, 1567, 246790),
(11226, 'TxYWv8WN_gU', 10, 22271, 1008, 7974, 1145639),
(11227, 'hKCHgwzMjhw', 10, 30359, 954, 1801, 8347715),
(11228, '1XS7c3Vpz_A', 10, 17839, 126, 1951, 223999),
(11229, 'IdGIZjVWrzY', 8, 1293210, 59945, 31881, 199135343),
(11230, 'eQN4QHiRNk8', 11, 251558, 1216, 4958, 6538974);
INSERT INTO `youtube_data` (`youtube`, `videoId`, `category_id`, `likeCount`, `dislikeCount`, `commentCount`, `viewCount`) VALUES
(11231, '9bza8Uzoh9Y', 10, 7143, 698, 521, 428941),
(11232, 'w-HYZv6HzAs', 11, 205001, 3474, 4726, 14174484),
(11233, 'BQTwvbWAx8A', 11, 154039, 3949, 16939, 3334957),
(11234, 'RUj76CVRruU', 11, 246847, 1071, 4327, 7420821),
(11235, '2DIl3Hfh9tY', 3, 9307, 502, 2362, 994118),
(11236, 'Q5hFW1wAiZM', 9, 36372, 4774, 1051, 10545910),
(11237, 'nXnf916o-14', 9, 183, 11, 55, 17169),
(11238, 'qDexMfs7Hiw', 9, 259, 13, 21, 28481),
(11239, 'd6HKyx0etKg', 9, 5258, 853, 390, 2181167),
(11240, 'qnTsIVYxYkc', 3, 16077, 749, 28, 751543),
(11241, 'vIomxD-5kNg', 9, 84, 0, 36, 2773),
(11242, 'I7a_K0fP5KY', 9, 623, 24, 58, 71938),
(11243, 'QwwBvLoBScU', 9, 3825, 39, 217, 126203),
(11244, 'TXDWEJG3AFw', 9, 1141, 74, 184, 189541),
(11245, 'tcEq7xhxD4g', 9, 3252, 532, 1626, 904222),
(11246, '_G-k6TQYUek', 8, 273991, 8568, 5561, 31210040),
(11247, 'fvOmqxGh6os', 9, 1446, 115, 117, 426464),
(11248, 'eVXOhnH488g', 9, 170, 3, 6, 4035),
(11249, '0m3vMZlNyw0', 9, 24496, 7735, 1503, 15847887),
(11250, '-yilSud7GdE', 9, 34, 1, 1, 5388),
(11251, 'UDRHDArMXQY', 9, 165018, 21507, 6347, 24265873),
(11252, '4nzBR8OEjV8', 9, 77, 2, 27, 4781),
(11253, 'gem_9kfSqsk', 9, 78, 1, 38, 3151),
(11254, 'Fj8G9dGuNkU', 9, 119255, 21137, 11114, 50716020),
(11255, 'Vuy2nrJz0Zw', 7, 56993, 7388, 6953, 8566169),
(11256, 'JUvOWchu11E', 9, 3020, 316, 199, 506863),
(11257, 'wtbXPdCEhPk', 7, 57554, 14587, 36239, 10166123),
(11258, '-i2QvJQ-Mg8', 9, 11, 0, 1, 791),
(11259, 'GoGPjeCAwMo', 7, 3100, 33, 250, 57633),
(11260, 'zzDKeeZxd0Y', 7, 68013, 13683, 4710, 16961536),
(11261, 'mJVWX0vud-g', 7, 102832, 29792, 14997, 5669541),
(11262, 'A1sgVb3YBAI', 7, 144794, 30699, 23577, 9825917),
(11263, 'd_Z2dE-9fKc', 7, 2245, 56, 122, 97258),
(11264, 'xKwKLX8L0Ow', 7, 19953, 5581, 4139, 3040245),
(11265, 't8mxT7lnCuo', 7, 74981, 20806, 9309, 13027348),
(11266, 'y6AYXg-4ezI', 7, 9758, 158, 410, 219276),
(11267, 'N3K-SH7dGW0', 7, 43676, 14307, 5104, 3946616),
(11268, 'cr-7rw7qbY8', 7, 6026, 205, 791, 248180),
(11269, 'cC0fSA7SNQ8', 8, 2358, 130, 228, 162465),
(11270, 't4G6l9ni7qc', 9, 10, 0, 0, 662),
(11271, 'aul8K8_763w', 7, 4430, 85, 167, 230019),
(11272, 'iNlCiLdNl4Y', 7, 0, 0, 4, 1841),
(11273, 'ymKNSlP7qeM', 9, 69, 5, 3, 11304),
(11274, 'eZx35wSAMzE', 7, 212, 14, 46, 6178),
(11275, 'LiP1UwdIpMI', 7, 242, 4, 52, 6741),
(11276, 'W6FCHqBaCy8', 9, 44, 3, 3, 2064),
(11277, 'sONLWHuYo7w', 7, 285454, 100002, 24796, 14958399),
(11278, 'slAEddjiI8o', 7, 195, 15, 27, 2361),
(11279, 'YAjzcignrLU', 7, 408850, 74375, 17268, 63872520),
(11280, 'yI74W6edg90', 7, 2286, 66, 93, 98285),
(11281, '12zt1JRleJg', 7, 349, 18, 52, 19076),
(11282, 'Ah7jZI_pzUE', 7, 60187, 12649, 2911, 8636622),
(11283, 'N8WK9HmF53w', 8, 31739, 394, 1167, 1152478),
(11284, '04idB4XzaGQ', 11, 241755, 1323, 5838, 5610035),
(11285, 'AhRWyFQdNho', 11, 100922, 2593, 8520, 7260160),
(11286, 'qr4MSVxfYBE', 11, 103026, 1207, 9686, 3294065),
(11287, 'mABIIQahEyc', 11, 476877, 1274, 19915, 5871586),
(11288, 'iuEG92S6IaA', 7, 50737, 8812, 3135, 10412369),
(11289, 'bJAyhmibRNw', 7, 113, 7, 2, 161055),
(11290, 'UuqNVOG2q_Q', 7, 14, 0, 1, 1534),
(11291, 'vP2ypwvsLrE', 6, 46214, 5422, 4606, 12695896),
(11292, '-6XR9zxIVyA', 7, 1165, 152, 258, 39269),
(11293, 'meGRF2lLzbc', 6, 6737, 254, 1506, 391971),
(11294, 'LTZzz53kcLM', 6, 637, 101, 53, 92290),
(11295, '6oWr9KezQt0', 6, 1096, 57, 521, 386396),
(11296, '1VIJnwtpDcI', 7, 159605, 40698, 27797, 33423998),
(11297, 'O4Kqw45079Y', 6, 1214, 112, 198, 245696),
(11298, 'xwFUc80ReW0', 6, 6259, 607, 2687, 833706),
(11299, 'wFYCPXytUZ4', 7, 4840, 483, 463, 236484),
(11300, 'M_R18LXwSQ4', 7, 2726, 100, 969, 163984),
(11301, '0U83LYQxUpM', 6, 4494, 219, 395, 314191),
(11302, 'cMOITPdSu9w', 7, 51, 0, 2, 2109),
(11303, 'NwckBnHQpY8', 7, 20361, 6946, 2388, 3464479),
(11304, '5LhRVkceaSw', 7, 3595, 651, 1359, 133917),
(11305, 'fEaTMekrcz0', 6, 71476, 9404, 6125, 9678748),
(11306, 'b1dUfB0N8J0', 6, 1101, 152, 63, 290546),
(11307, '-0fO0-SliYg', 6, 100, 1, 38, 3052),
(11308, 'WzEF4kfG6uE', 6, 288, 39, 37, 49219),
(11309, 'E-dPJF5AiF0', 6, 62370, 13796, 53016, 7653574),
(11310, 'DzuOaJ9f8qI', 7, 25717, 8143, 7242, 3142307),
(11311, '-424RTXky1c', 6, 5263, 571, 0, 470441),
(11312, 'kgt8nFOXCpc', 6, 12695, 2357, 9285, 2385303),
(11313, 'J75enyWdbBM', 8, 583229, 27280, 14227, 95250727),
(11314, 'YWIhwplfx4Q', 8, 49313, 1135, 6300, 12594185),
(11315, 'K0ibBPhiaG0', 8, 2074508, 63950, 72727, 340809275),
(11316, 'JzWtoP1Xhc0', 11, 163845, 1453, 7655, 5313981),
(11317, 'zDo0H8Fm7d0', 8, 2593124, 149533, 69375, 571240763),
(11318, 'nmHSouDefdI', 8, 59613, 1279, 5351, 3205463),
(11319, 'gAtS4L_lhv4', 7, 190375, 44299, 9824, 60304828),
(11320, 'pucn-P8pLXg', 7, 4092, 14, 262, 66791),
(11321, 'pPk4W7fMfm4', 7, 149, 11, 26, 2201),
(11322, 'KKCimdX6zj8', 7, 7724, 805, 483, 495950),
(11323, '6G7V4w9bqJY', 7, 67590, 30536, 27333, 9950053),
(11324, 'sjiQ-xdEzyc', 7, 32126, 7379, 2351, 7256876),
(11325, 'N8Bb52GP6Qg', 7, 374, 35, 35, 3283902),
(11326, 'VsfEIAYFfig', 7, 2130, 53, 206, 66919),
(11327, 'kttVCbTrDLw', 4, 66808, 20227, 37399, 11076161),
(11328, 'Li-gBHFBkIo', 7, 34, 2, 0, 2723),
(11329, 'clv36Gzjv3s', 7, 21, 4, 0, 37461),
(11330, 'WShss20bz4U', 7, 108984, 49150, 17377, 17112719),
(11331, 'v8xjjJXM338', 7, 8, 0, 1, 1951),
(11332, 'kYfeBK92Wo4', 7, 1571, 16, 99, 76506),
(11333, 'vgoOfJQsZCg', 7, 285, 21, 65, 47169),
(11334, 'UL2BY0NR0Eo', 9, 21623, 1349, 1715, 2850840),
(11335, '4KK0zKUbwV8', 9, 13943, 456, 735, 786642),
(11336, 'yZxUlZ3mMYg', 9, 13541, 1817, 1327, 4987291),
(11337, 'wguFY0DDoAU', 9, 7412, 812, 1376, 3497355),
(11338, 'YJyZze3P_0Y', 9, 30401, 4113, 4915, 5800623),
(11339, 'cIxzmr9sid4', 9, 18829, 2406, 4197, 2984093),
(11340, 'tZaFW-zrhFI', 9, 35, 1, 3, 4223),
(11341, 'kyBwmPRxtIA', 9, 34, 2, 5, 7022),
(11342, 'JOXdORyTqVY', 9, 10912, 143, 999, 472921),
(11343, 'Zb9dJeV4vg0', 9, 9304, 587, 931, 2776333),
(11344, 'jARfKuOCyEk', 9, 22, 1, 1, 2052),
(11345, 'WBpVPpc-Uus', 9, 27286, 1735, 1064, 5755383),
(11346, '57SKk9kwqrQ', 9, 250, 27, 35, 26612),
(11347, '7KMwCXsZkIg', 9, 13142, 515, 1097, 658356),
(11348, 'SE4zuIX-Wos', 9, 676, 6, 23, 55845),
(11349, '-zLuX9eVmyM', 9, 134, 3, 10, 8037),
(11350, 'RafMJd3uIR0', 9, 259, 3, 9, 8444),
(11351, 'YeXFYL5FUaY', 9, 71, 0, 70, 46326),
(11352, 'nLoJJvJhXzk', 4, 329, 3, 37, 13149),
(11353, 'dA42vievwZk', 4, 86661, 49743, 6995, 64555035),
(11354, 'r7Gsy5y2cjE', 4, 490, 41, 88, 39401),
(11355, 'mEO8QwhTRNA', 4, 2325, 275, 346, 304075),
(11356, '48PYCaRdqis', 4, 58, 2, 10, 1214),
(11357, 'd5qnkFw4z2c', 4, 23485, 5440, 3098, 7665245),
(11358, 'QX3M8Ka9vUA', 4, 33143, 2588, 5588, 2640190),
(11359, '5CVli8rDdu8', 9, 212, 2, 19, 6158),
(11360, 'd0SlVpMDJNM', 4, 47662, 10512, 6490, 6102739),
(11361, 'qJby9vVjits', 4, 207, 53, 27, 59622),
(11362, 'ufXjza2-Rww', 4, 85677, 17892, 6587, 20450420),
(11363, 'rrhbmtGvlyg', 4, 70951, 28413, 21153, 13542881),
(11364, 'OxDoFWvEbuM', 11, 35457, 639, 2585, 1648851),
(11365, 'uUzVUrFTqfQ', 11, 68516, 1194, 2797, 3493580),
(11366, 'TJPbM22KUXI', 6, 139198, 1178, 4102, 4933799),
(11367, 'y03jYbBGvdg', 6, 20829, 299, 2079, 476262),
(11368, 'YuHX7BJ6xzM', 10, 24762, 522, 2537, 1263675),
(11369, 'zAB5vNOHuOE', 4, 11, 0, 2, 1094),
(11370, '3O56g8KC6CM', 6, 6601, 85, 775, 648473),
(11371, 'PWl49b7tKzI', 4, 574, 68, 121, 88998),
(11372, 'w9apEUApJgQ', 4, 40664, 23559, 3858, 34698408),
(11373, 'YF-wXbBdiOU', 4, 2505, 88, 77, 41765),
(11374, 'NNCIFGBuRAQ', 4, 165674, 70599, 2314, 50147482),
(11375, 'kOVMtb4ZEP4', 9, 73, 0, 9, 6018),
(11376, 'FkWHg3lvZXw', 8, 3431, 257, 283, 295620),
(11377, 'rm9UdMdKiZE', 8, 5780, 530, 261, 753962),
(11378, 'f7kFhJJTjvY', 8, 1077, 68, 55, 219690),
(11379, 'r3_V4ZN6Ypc', 8, 152, 1, 8, 4537),
(11380, 'O1bMy2I0PGA', 8, 438, 6, 41, 44887),
(11381, 'H8mWdF-UJiI', 8, 9368, 707, 438, 1046163),
(11382, 'UFLyhzlG8FQ', 8, 8403, 601, 356, 1192851),
(11383, 'j7ZuygpYD4k', 8, 2189, 129, 228, 173613),
(11384, 'w-Rpa9TeKGc', 8, 11524, 1023, 686, 1980819),
(11385, 'HhEB7UpYbyw', 8, 12592, 1170, 858, 1969362),
(11386, 'EQ205a0P10Y', 8, 6290, 609, 467, 1015179),
(11387, '3IQAcJhZxHE', 8, 433, 25, 155, 81606),
(11388, 'xxueH1QaRMM', 8, 3016, 133, 120, 372076),
(11389, 'L6VBHflOeuY', 8, 5324, 397, 330, 613895),
(11390, 'AF2zRNnPTo4', 4, 4691, 743, 558, 639567),
(11391, '90XqVvc1QuM', 8, 3309, 15, 318, 52230),
(11392, 'UQnLBxnkt3Q', 8, 5665, 477, 328, 616263),
(11393, 'lW_vT5h-WK4', 8, 3078, 159, 86, 420726),
(11394, 'FceZV0yaTOU', 8, 8442, 711, 636, 1239409),
(11395, 'WoqbN-G_i4U', 8, 1365, 76, 46, 205841),
(11396, 'IJOJm7rbNtw', 8, 685, 64, 68, 53551),
(11397, '80offJcbjP0', 8, 9878, 1125, 767, 1746033),
(11398, '4wtG01ymIjE', 8, 43043, 2856, 2483, 5434109),
(11399, 'ghu4IlMgiWU', 8, 46364, 10251, 2301, 11890630),
(11400, 'UmPwiYbXgcw', 8, 948, 57, 93, 175273),
(11401, 'm4KnpxdbwrY', 8, 1634, 108, 201, 161096),
(11402, 'EjFRulacSCs', 8, 9344, 554, 233, 1407082),
(11403, 'St3wrs0ZGN4', 8, 3684, 269, 198, 317852),
(11404, 'sqzCu8SJKOs', 8, 1585, 131, 41, 62502),
(11405, 'U3I3nsbmzQE', 8, 6202, 461, 534, 766682),
(11406, 'C3SNrVTe2Ps', 8, 56, 1, 17, 32417),
(11407, '6-1ujoYPNVk', 8, 85, 2, 26, 18101),
(11408, 'hllwWuz4agQ', 8, 2446, 44, 181, 103195),
(11409, '6WZdMKYzWnk', 8, 3301, 258, 335, 423008),
(11410, 'yUK_kVwqrtI', 8, 6986, 264, 416, 509876),
(11411, 'hqjEDPikgAs', 8, 1842, 135, 628, 202056),
(11412, '9WMA_LEqWHw', 8, 1198, 56, 32, 171957),
(11413, '1MhTsz5xKqw', 6, 58258, 628, 3863, 1953399),
(11414, '4lmLwhfPQ9Y', 6, 193168, 3820, 26437, 5549633),
(11415, 'jzy2dgEUOhY', 8, 471640, 11631, 32802, 99068460),
(11416, 'f_OGytLp6Ng', 6, 61239, 2054, 4731, 3150088),
(11417, '-fFTZNYR884', 6, 89777, 1999, 10432, 4998821),
(11418, 'it91X8evJLE', 8, 8956, 852, 334, 1354756),
(11419, 'd-mZwL4Bh6E', 8, 234793, 7279, 7332, 16677019),
(11420, 'M0bGJd0p7_M', 8, 6625, 660, 584, 1092770),
(11421, '7CrgjcQsoYo', 8, 3263, 293, 203, 410849),
(11422, 'C2-h0Iza2hQ', 4, 1463, 340, 88, 748908),
(11423, 'r6KnUmrA0d8', 8, 3985, 256, 244, 428531),
(11424, 'jksJ9T8z7po', 8, 31, 2, 0, 1605),
(11425, 'PKp6McAd0t8', 4, 8, 1, 0, 2507),
(11426, 'ccZk_e3Tc5s', 4, 67503, 18713, 42071, 3724389),
(11427, 'iAP1LLvXWJA', 4, 63, 1, 3, 9018),
(11428, 'RuGeeGRdYlQ', 4, 1041, 209, 67, 205445),
(11429, 'q4oPuLP-a1A', 4, 141, 6, 18, 5244),
(11430, '-rQXX3Gxytg', 4, 89130, 32276, 7075, 32691941),
(11431, 'gIDDuiGCJNc', 6, 1434, 142, 82, 147630),
(11432, '50eBMwgR_uA', 4, 222, 8, 62, 39579),
(11433, 'AWtxtz5BnUU', 4, 12, 1, 0, 558),
(11434, '7OvMXwjEpIk', 8, 4298, 389, 279, 698793),
(11435, 'wpBul1nHaiw', 8, 330, 23, 11, 17726),
(11436, 'HG0vRxxlcFM', 6, 11513, 485, 2599, 489883),
(11437, '1KKvLMQ_jjg', 6, 2348, 127, 736, 179689),
(11438, 'QgdczxoJjug', 6, 10354, 507, 1671, 1198836),
(11439, 'IeDOUTQljoY', 6, 33578, 4075, 4012, 4940283),
(11440, 'cljEvSVd-0M', 6, 2574, 112, 761, 95448),
(11441, 'UkM-FjfN6Mc', 8, 95258, 7490, 5934, 15610142),
(11442, 'gVsmWnDCpKE', 6, 6223, 157, 1410, 149181),
(11443, 'VtNlrzOm3Mg', 6, 20449, 1948, 1756, 1744156),
(11444, '20jRhOTNg40', 6, 73511, 6727, 3924, 12320749),
(11445, 'spkQIqmEQwI', 6, 328, 8, 96, 19039),
(11446, '8sNJ4spEgXg', 6, 49611, 2490, 2651, 5400544),
(11447, 'DuE5mW7bgMk', 6, 243955, 4707, 15398, 10985633),
(11448, 'gNhBiw9pgUo', 10, 254230, 10920, 12784, 19599052),
(11449, 'WGUdOu8r5c0', 6, 90991, 2600, 8918, 5385724),
(11450, '7401A3k7OYc', 6, 105890, 3386, 22112, 5134473),
(11451, 'oacaq_1TkMU', 8, 243838, 10095, 7952, 52083839),
(11452, '551bqIgcEHw', 6, 69875, 1689, 9222, 6081010),
(11453, 'i2d5eVLybCs', 6, 86, 0, 34, 1911),
(11454, 'mPcvo3VdaKc', 6, 1266, 196, 727, 225911),
(11455, 'J-aJsoJl_q0', 6, 160, 7, 9, 5091),
(11456, 'G6Na95tN86Q', 6, 9921, 584, 2439, 1118344),
(11457, 'BFwATxPpufQ', 6, 23522, 3497, 3670, 1070948),
(11458, 'AcLY_YcciZw', 6, 218, 23, 41, 65350),
(11459, 'wHOyY9-bckw', 6, 131944, 14811, 48209, 13250980),
(11460, 'gcrDrlwRNKk', 6, 11161, 1130, 1851, 1915029),
(11461, 'A0tPmfWIqRs', 6, 151049, 20165, 40695, 12725180),
(11462, 'oCZ0KXWxbmY', 6, 27, 2, 4, 1223),
(11463, 'y4ujY-fvA1M', 4, 99085, 32533, 9273, 31605789),
(11464, 'hGHv-PuZwLc', 4, 102, 2, 21, 2386),
(11465, 'qPhVZExcGXg', 4, 127685, 32593, 14837, 37855993),
(11466, 'M3CayJDMTeQ', 4, 19, 0, 0, 465),
(11467, 'mMXvMf_2EKs', 3, 3766, 148, 154, 238240),
(11468, 's2jWVbX7sPk', 4, 125772, 44474, 9970, 33855021),
(11469, '82O2nE3wit4', 3, 3421, 361, 231, 670514),
(11470, 'Yl_FJAOcFgQ', 3, 10857, 545, 204, 2442655),
(11471, 'QB8OXhvtOMY', 4, 43290, 11616, 7509, 8932524),
(11472, 'M_pIK7ghGw4', 3, 3651, 127, 184, 613223),
(11473, '9-4V3HR696k', 3, 0, 0, 0, 4106519),
(11474, 'PX5-XyBNi00', 3, 25459, 1457, 1222, 2603289),
(11475, 'xCp4at6LE0A', 4, 839, 103, 57, 380096),
(11476, '1Z5UeCRFwu4', 3, 46, 0, 1, 11764),
(11477, '5P_I6cld6Ag', 3, 15414, 580, 632, 810699),
(11478, '6DlrqeWrczs', 3, 33123, 1047, 0, 3183504),
(11479, 'ZK3O402wf1c', 3, 16011, 338, 1663, 3003019),
(11480, 'AUIt0JmferQ', 3, 1673, 78, 436, 86776),
(11481, 'vj-cK_KfjsI', 3, 3637, 189, 224, 456777),
(11482, 'hbmf0bB38h0', 3, 15775, 485, 3522, 2475256),
(11483, 'HAx7E3Bu7gA', 3, 5617, 145, 198, 340975),
(11484, 'baK3X5Oozh4', 10, 1886, 48, 257, 57706),
(11485, 'lOlrbe2OQCU', 10, 11278, 510, 1136, 855544),
(11486, 'ozAOnjI23uw', 6, 162159, 6388, 64889, 11595180),
(11487, 'ZVNGtB0NMy8', 10, 2903, 162, 745, 421425),
(11488, 'vDYtbo45YgE', 10, 893, 12, 94, 58210),
(11489, 'NndCoYzHe8k', 10, 15547, 526, 1034, 694626),
(11490, 'lcZEIqm8bWI', 3, 570, 2, 93, 54115),
(11491, 'lPNrtjboISg', 3, 171684, 26827, 32010, 12494467),
(11492, 'gZQbQohCEW0', 3, 107334, 11309, 16853, 9638843),
(11493, 'QlQ31YTo5y8', 3, 424, 7, 7, 63065),
(11494, 'ZKII4AwLKkU', 3, 2132, 217, 0, 373866),
(11495, 'ODZgSAeLlEQ', 3, 7441, 394, 445, 717294),
(11496, 'mTHtn0FRMWw', 3, 1305, 227, 165, 523669),
(11497, 'xsamBVZc5Lo', 3, 217, 11, 12, 26388),
(11498, 'coQ2tllkGms', 3, 53754, 4184, 4531, 4419101),
(11499, 'Ma0NQyk7tHM', 9, 128, 3, 20, 5572),
(11500, 'DkwedgEH3gs', 9, 3430, 142, 335, 747886),
(11501, 'WwkBUxidScM', 9, 163, 2, 24, 9579),
(11502, 'qjChBd3uPBM', 1, 164665, 15273, 24441, 23003511),
(11503, 'DHLRj1LaPiQ', 1, 100778, 12562, 10319, 6117075),
(11504, 'CiHGmJo5xh4', 10, 65643, 1462, 5767, 4974336),
(11505, 'Rn6gmSDCGHo', 10, 2695, 72, 615, 97272),
(11506, '9fJEFi3ccwI', 10, 9713, 269, 585, 2118521),
(11507, 'qtwKlLrmVfY', 9, 266, 8, 154, 24118),
(11508, 'aA0IHkeQjrw', 10, 9589, 507, 4588, 694676),
(11509, 'NZR_vMTLfIk', 9, 26299, 3627, 6449, 2509544),
(11510, 'sJFDBkvuFbc', 9, 143935, 13505, 5987, 27055162),
(11511, 'sKju1Jw-GnM', 6, 52333, 1027, 7619, 1380733),
(11512, 'FOse4_orCqE', 9, 231, 2, 8, 8149),
(11513, 'gA0bi-bFEYs', 1, 363940, 67430, 92605, 12172806),
(11514, 'Ve5XpUB3nqg', 10, 6683, 385, 3782, 523194),
(11515, 'fm0pDJz-Zpg', 1, 19107, 1398, 975, 3818721),
(11516, 'jMeKLXDDsD8', 6, 11816, 1444, 0, 2455752),
(11517, 'LucO1D5ZsUc', 6, 2245, 177, 174, 194618),
(11518, 'qS87WBZgG6Y', 10, 247, 22, 15, 62526),
(11519, 'DZAiRufPx9A', 1, 98768, 4617, 8322, 1758932),
(11520, 'g4D6oRaow9g', 1, 7710, 1438, 724, 4222483),
(11521, 'HMXb88UkL6Q', 6, 4952, 204, 15, 399432),
(11522, 'mAAW0dQjPCk', 1, 20593, 3272, 1049, 5079313),
(11523, 'O9SZaTeZ3MM', 1, 111, 3, 11, 2294),
(11524, '7GV_OEo-W7g', 1, 371, 2, 27, 4072),
(11525, 'TEDxWQA5Exo', 1, 787, 18, 71, 28316),
(11526, 'GQooP4IScV0', 1, 3009, 16, 234, 53121),
(11527, 'CWLQ69FPBkA', 1, 759, 37, 139, 16401),
(11528, 'sCI1Tb1bFTk', 1, 47, 1, 3, 10125),
(11529, 'Td9yK_ZgB0o', 1, 261293, 38086, 40596, 17501661),
(11530, 'g_xst_Jpl9E', 1, 171624, 38576, 0, 22397364),
(11531, 'hWVTt_V_A4I', 1, 1056, 44, 73, 53934),
(11532, 'op8BA4t1zdU', 1, 103, 7, 17, 16878),
(11533, 'UMWl_1Uz1Rc', 1, 910, 6, 81, 12845),
(11534, '-HQ40NVbzII', 1, 639, 8, 86, 44990),
(11535, 'DPByN1li7eA', 1, 1211, 80, 137, 160665),
(11536, 'OqQPv78AMw0', 1, 115982, 20474, 10248, 46331376),
(11537, 'qYVQpw_jTWs', 1, 987, 72, 1024, 180525),
(11538, 'nBMPlan1qYc', 1, 92, 6, 22, 11028),
(11539, 'GOahvC_uMG0', 1, 3457, 66, 676, 163497),
(11540, 'SzYfCYrI1lw', 1, 708, 87, 99, 189566),
(11541, '3xjWAWj_dic', 1, 1331, 7, 136, 17590),
(11542, 'JRy29v_mLVA', 1, 537, 14, 53, 12198),
(11543, 'rWWNajG_cNs', 1, 742, 5, 96, 8436),
(11544, 'il05NjIDJFY', 1, 158, 5, 15, 15314),
(11545, 'hCBX28p-4JY', 8, 570861, 13755, 8328, 55408354),
(11546, 'uFg_GmqBsME', 10, 19681, 283, 1885, 855957),
(11547, 'kzIBbF-8lAU', 10, 40990, 2117, 5390, 2148213),
(11548, 'qYQaJUfPRNU', 10, 9981, 346, 1120, 865200),
(11549, 'rZizVUKe4sQ', 11, 90036, 1256, 8214, 1762252),
(11550, 'Xuw33mzknqY', 8, 21584, 1068, 50, 2355186),
(11551, 'w1sFPqO9tRQ', 10, 94396, 3399, 4929, 11731061),
(11552, 'ZlFQJXTxFlE', 8, 89, 2, 20, 13385),
(11553, 'QmvC60bxjrk', 8, 1268, 52, 65, 170181),
(11554, 'gpB4mBE94nE', 8, 6876, 933, 306, 1371859),
(11555, '1UcozXB5Pg0', 8, 4567, 314, 268, 476122),
(11556, 'tXg47E-jUZk', 6, 63181, 7569, 11640, 16472804),
(11557, '0b5CmbvCBf0', 9, 57744, 6381, 3506, 9671358),
(11558, 'Y7ceiohNbqI', 6, 108650, 13564, 11698, 12056439),
(11559, '3sUrNb3mqvA', 6, 302167, 21618, 12670, 49904665),
(11560, 'P8bP_Us63s4', 6, 86490, 4114, 7392, 9558406),
(11561, '0VwMiLjrHWA', 6, 379, 10, 92, 40655),
(11562, 'HsyDpKD0OOA', 6, 18884, 1599, 4269, 1533775),
(11563, 'JUJGY3_mBnA', 6, 4255, 123, 113, 176910),
(11564, 'eSvVY6KfO0I', 6, 10822, 596, 2047, 1053241),
(11565, 'zhRx-FHiIvc', 6, 22496, 2058, 6257, 800753),
(11566, 'M4ZoCHID9GI', 8, 2311076, 81996, 79981, 328508892),
(11567, 'OflWdkI09qA', 10, 1750, 126, 403, 260711),
(11568, 'n7G7p1MPWlM', 10, 58041, 2151, 6142, 2703210),
(11569, 'rbZ_82BkH_c', 11, 319752, 1545, 9307, 5755024),
(11570, 'u2XfhqBjka0', 10, 1405, 64, 341, 1658862),
(11571, 'FnGpHf4DqKM', 1, 95, 5, 36, 9687),
(11572, 'PZYEs0DOMv8', 1, 44, 2, 1, 4684),
(11573, 'yUJKdPIBLrw', 6, 143, 4, 7, 5107),
(11574, 'rmR8eaZMpIw', 1, 387, 19, 51, 248225),
(11575, 'c3W1XXOoNQY', 1, 651, 10, 64, 9814),
(11576, 'voeuUtjBxdE', 10, 8, 0, 1, 7593),
(11577, 'gesm2CiVbuo', 1, 51844, 10381, 8996, 34792937),
(11578, 'ryhcwfVoKFo', 11, 753, 22, 23, 57020),
(11579, '8H6Hm0yFH70', 1, 23, 1, 9, 12153),
(11580, 'QLAQ9d4JXog', 11, 51325, 768, 1718, 3107070),
(11581, 'XcfVMpXphzo', 1, 68, 8, 13, 5236),
(11582, '0J_va_xuUTQ', 6, 766, 80, 50, 98433),
(11583, 'aCnoZTDxQCc', 1, 999, 4, 110, 26729),
(11584, '6JcY9crDuX4', 1, 79823, 14199, 2548, 24538143),
(11585, '0-TSGSPXN7U', 1, 72, 2, 9, 19928),
(11586, 'kCPjif6E03g', 9, 26706, 4025, 2105, 11357682),
(11587, '6lzfMorV6GI', 1, 28, 1, 2, 1236),
(11588, 'QDMquUQE0aU', 1, 247, 18, 30, 413503),
(11589, 'cDFzuiLOztc', 1, 26690, 5852, 5052, 4554765),
(11590, 'W27PnUuXR_A', 10, 53269, 6959, 32430, 6907066),
(11591, '7SOrcvIOnZU', 1, 20, 1, 8, 1960),
(11592, '6OjjBB-baY0', 1, 871, 36, 124, 151879),
(11593, 'NBB2QLrWq90', 1, 6771, 1155, 493, 1762693),
(11594, 'Wdb7KEc7xJI', 9, 29654, 3326, 4377, 5467238),
(11595, 'q3gjT7XVycg', 9, 37, 0, 3, 2890),
(11596, 'qp3ZVumMc98', 9, 16347, 1878, 5939, 2952244),
(11597, 'mzHmguySu-w', 9, 64339, 7978, 3835, 14053302),
(11598, 'EgkYLtEDWIo', 9, 5017, 646, 652, 945513),
(11599, 'ZGSh14wSuDI', 9, 25535, 2580, 3715, 9101907),
(11600, 'KcpUywMM3sk', 9, 68, 10, 2, 29058),
(11601, 'Rv3v7ZfYp-g', 9, 77088, 26889, 4313, 46479012),
(11602, '2-gmYKVZno4', 9, 8126, 1217, 960, 3371107),
(11603, 'MEuaGyqLKls', 9, 216, 8, 35, 30724),
(11604, 'XNvcvheNdIs', 9, 5386, 438, 339, 1537833),
(11605, 'YjZHx7RrDFc', 9, 423, 6, 22, 17224),
(11606, '6Adj8ixHleE', 9, 4177, 835, 424, 989011),
(11607, 'SJ3LKBkxMZE', 9, 496, 26, 90, 275962),
(11608, 'gsSWL4E_seA', 9, 82, 0, 8, 7886),
(11609, '55AasOJZzDE', 9, 85741, 11317, 18200, 27601643),
(11610, 'RD8aCPLTWLs', 9, 73, 17, 2, 14279),
(11611, 'Vw5xcrPifXQ', 9, 193, 2, 6, 6078),
(11612, 'O-Zb5SsV7xY', 9, 114636, 23354, 8264, 17921460),
(11613, 'aQXI7OTnNiI', 9, 129, 1, 31, 5352),
(11614, 'XciVFRW-W3M', 9, 85, 1, 3, 2643),
(11615, 'LspOh-os6s8', 3, 33957, 2715, 6396, 4533407),
(11616, 'bRa8kp_1zvI', 9, 8219, 6168, 11670, 2005317),
(11617, 'Q6bzTXjITAo', 9, 383, 7, 61, 11201),
(11618, 'of1KYsVs3u4', 9, 342058, 128822, 239506, 15153879),
(11619, 'r-i6XpcL1Fs', 9, 272473, 92678, 43362, 28620365),
(11620, 'W1dOV5d9WDs', 9, 1767, 534, 1283, 190591),
(11621, 'vgqJiOjxOCg', 9, 8589, 4050, 280, 6074368),
(11622, 'ZiPkCGZAipA', 9, 139, 0, 27, 2327),
(11623, 'rzPSqNkl8H8', 11, 130869, 1713, 12243, 5862545),
(11624, 'V_ZC5MsknwM', 11, 78336, 266, 1332, 3103172),
(11625, 'lCN6FjqDcHg', 3, 103346, 14557, 6520, 14851233),
(11626, 'PYG-lP8u85E', 10, 476, 18, 91, 17657),
(11627, '1Q1iTlpG3R0', 10, 295768, 13795, 51140, 6521149),
(11628, 'fOmhbMXY52o', 8, 404244, 6689, 36750, 28156820),
(11629, 'OG61GKdr31Y', 9, 43, 12, 2, 11180),
(11630, '7H0oUTeKa0E', 9, 8, 0, 0, 578),
(11631, 'MZGWqbxBuec', 9, 6708, 692, 17, 1677625),
(11632, '-cg3MuCE5ac', 9, 10, 0, 0, 363),
(11633, 'wzKL-bQKcgA', 8, 2606041, 97516, 119471, 242668634),
(11634, 'FplmvpBrfco', 3, 9885, 1462, 2225, 962809),
(11635, 'EFPxsrqgbQA', 3, 5900, 478, 375, 634220),
(11636, '3ORsUGVNxGs', 3, 55, 6, 5, 28528),
(11637, '6Kzsk489i1s', 10, 273, 32, 61, 29065),
(11638, 'cpo18aNlV9M', 10, 34337, 2027, 5259, 1920551),
(11639, 'q7q_LcqbvKI', 10, 18905, 2044, 8232, 2067883),
(11640, 'AF6aY73y_6I', 10, 17, 0, 0, 2054),
(11641, 'BxuY9FET9Y4', 8, 2918998, 94722, 115533, 570225122),
(11642, 'vLgzFCifhaY', 10, 7650, 1279, 4174, 225956),
(11643, 'uspa5bYs5s0', 10, 1974, 40, 217, 118669),
(11644, 'XQwcCdKGjPQ', 10, 1238, 116, 76, 152375),
(11645, 'U15Fwo9tbJ4', 10, 2142, 121, 232, 639549),
(11646, 'rs2843G6qcU', 10, 564, 50, 118, 130174),
(11647, 'y04xG7qCEh0', 10, 5954, 234, 0, 1393499),
(11648, '98H5AN_vfOY', 10, 615, 58, 70, 175141),
(11649, 'YKUd8QbLp3U', 10, 2267, 99, 169, 521584),
(11650, 'pqEfx0fUwMA', 10, 480, 7, 49, 33964),
(11651, 'o9ZJEx-t2z0', 10, 4847, 289, 1058, 306887),
(11652, 'LBK2GO0c0wQ', 10, 187, 7, 27, 40937),
(11653, 'yG5r2gQn7LE', 10, 2042, 233, 345, 830323),
(11654, 'exVUMClsiKY', 10, 25922, 6677, 7492, 19014687),
(11655, '9689o_lhkbc', 10, 6, 0, 2, 4670),
(11656, 'VjHMDlAPMUw', 8, 1183245, 26937, 25525, 256868220),
(11657, 'JlPIrEKFCeo', 9, 55544, 4010, 10161, 12532103),
(11658, 'SDY1N-IJOA8', 9, 110879, 7732, 16682, 15033611),
(11659, 'hWjrMTWXH28', 8, 551031, 16096, 0, 184443083),
(11660, 'JuCNh8U4G1I', 10, 1083, 138, 164, 178720),
(11661, 'eUFKDlhE_xQ', 9, 29, 5, 1, 8154),
(11662, 'kiI8e7xN9QU', 9, 691, 74, 149, 136891),
(11663, 'cSR162GlNvM', 10, 4591, 153, 485, 365952),
(11664, 'eaE7RL3CR0A', 9, 164, 8, 18, 14200),
(11665, 'Czrm1CdOnho', 10, 2809, 91, 295, 205456),
(11666, 'f3UqeGVbqno', 10, 2590, 24, 237, 120402),
(11667, 'g4a7_HH9Wbg', 3, 29454, 2465, 3099, 1169681),
(11668, 'btwVta8OlWc', 9, 18511, 11927, 2025, 8114157),
(11669, 'zH0xUAb3Yws', 11, 120, 7, 36, 41139),
(11670, 'b2I-FcX8lzw', 11, 2244, 319, 606, 237960),
(11671, 'dmO5dP4UTDo', 9, 48038, 1208, 2540, 3835055),
(11672, '_CSwd6Hjhkc', 11, 288, 12, 38, 256371),
(11673, 'u9qvgWKcMqQ', 11, 181, 18, 18, 44952),
(11674, 'yK02aNIoCsM', 11, 6323, 1374, 319, 2014917),
(11675, 'M2Hl-lkupcc', 11, 102492, 27175, 6308, 34287730),
(11676, '62kFbOqx3jM', 11, 108, 8, 35, 16995),
(11677, '__GomEgP40w', 9, 45913, 2415, 2366, 5800129),
(11678, '0JWGnevOTEk', 11, 2956, 208, 337, 514705),
(11679, 'iAMz25R-knk', 11, 2372, 375, 180, 390846),
(11680, 'jXeO5q0PE3Q', 11, 102, 9, 8, 8641),
(11681, 'Iromfn-LT5s', 11, 10, 0, 6, 637),
(11682, 'xlSMME-Cl5g', 11, 218, 15, 61, 22516),
(11683, 'i0Hzp70ip2U', 11, 40537, 27500, 11373, 13751442),
(11684, 'bRyZlcU_TVc', 11, 13, 2, 2, 1222),
(11685, 'qSoeHcoxkl8', 11, 17, 2, 12, 4259),
(11686, 'baimGHLHq5E', 11, 32834, 5162, 4171, 15070870),
(11687, 'WYKCzN465jY', 11, 54412, 17157, 5951, 9440641),
(11688, 'YT_KXE-g8To', 11, 24961, 5213, 2402, 5003760),
(11689, 'EcojyBV4QJ4', 11, 16595, 3826, 2677, 991183),
(11690, 'xdnbYZH4GRs', 11, 30689, 6965, 2212, 7916498),
(11691, 'vICFah-aDFY', 11, 10150, 1627, 2382, 4814808),
(11692, 'WBhFmNE-QZk', 11, 113, 10, 34, 24534),
(11693, '7l-3URrSzAc', 11, 3677, 1036, 452, 1296259),
(11694, 'bmCHBfrN5H0', 11, 1644, 28, 277, 33608),
(11695, '79dERkX957M', 11, 1, 0, 0, 2967),
(11696, 'yAOf6egFKHk', 11, 38, 2, 6, 1457),
(11697, 'uBLvA7Sr3NA', 4, 135474, 63576, 4679, 52647370),
(11698, 'NO9rb7Fd3lE', 4, 1591, 36, 227, 60039),
(11699, 'rUMOfz7dwHs', 11, 572, 25, 34, 28274),
(11700, 'VpUu49FU9Lo', 10, 96, 4, 11, 14683),
(11701, 'FkLGbnCFhhg', 11, 120, 17, 64, 4640),
(11702, 'p8QYo8aJ9HE', 11, 29986, 21593, 2880, 20650894),
(11703, '7-erQMrCc6Y', 11, 20, 0, 0, 2516),
(11704, 'PiL2iCFifp0', 9, 93234, 2665, 13755, 4591322),
(11705, 'WXwxEfh6-Fc', 4, 20740, 6715, 2623, 2087730),
(11706, 'NATQgOsX5P8', 4, 27946, 313, 1129, 2093799),
(11707, 'Y6F8__Qa0mU', 11, 49, 2, 1, 3219),
(11708, '1vy8OGWEPwc', 9, 12569, 291, 1182, 1500169),
(11709, 'jA0xR2Ho9UU', 4, 755405, 10680, 70880, 21509680),
(11710, 'Y73jjPOiePc', 4, 288210, 96103, 0, 131786313),
(11711, 'wptc0r9zVfg', 9, 40801, 1185, 2232, 2454855),
(11712, '6C6oOcDFmLY', 9, 142713, 11697, 24250, 28943464),
(11713, '22SGPb7NFJk', 4, 29211, 11553, 11377, 6488807),
(11714, '3f9CAMoj3Ec', 4, 74, 13, 11, 13703),
(11715, 'OTN9mCsrRR8', 4, 40203, 15789, 7108, 8803406),
(11716, 'Cpn_OZXNWcg', 9, 34, 2, 3, 1382);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accepted_interest`
--
ALTER TABLE `accepted_interest`
  ADD PRIMARY KEY (`accepted_interest_id`),
  ADD KEY `youtuber_id` (`youtuber_id`),
  ADD KEY `campaign_id` (`campaign_id`),
  ADD KEY `submission_status_id` (`submission_status_id`);

--
-- Indexes for table `activity_log_businessman`
--
ALTER TABLE `activity_log_businessman`
  ADD PRIMARY KEY (`activity_log_id`),
  ADD KEY `businessman_id` (`businessman_id`);

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`admin_id`);

--
-- Indexes for table `advertising_details`
--
ALTER TABLE `advertising_details`
  ADD PRIMARY KEY (`advertising_details_id`),
  ADD KEY `campaign_id` (`campaign_id`),
  ADD KEY `campaign_id_2` (`campaign_id`);

--
-- Indexes for table `businessman`
--
ALTER TABLE `businessman`
  ADD PRIMARY KEY (`businessman_id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `businessman_rating`
--
ALTER TABLE `businessman_rating`
  ADD PRIMARY KEY (`businessman_rating_id`),
  ADD KEY `accepted_interest_id` (`accepted_interest_id`);

--
-- Indexes for table `campaign`
--
ALTER TABLE `campaign`
  ADD PRIMARY KEY (`campaign_id`),
  ADD KEY `businessman_id` (`businessman_id`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `campaign_status_id` (`campaign_status_id`);

--
-- Indexes for table `campaign_photo`
--
ALTER TABLE `campaign_photo`
  ADD PRIMARY KEY (`campaign_photo_id`),
  ADD KEY `campaign_id` (`campaign_id`);

--
-- Indexes for table `campaign_status`
--
ALTER TABLE `campaign_status`
  ADD PRIMARY KEY (`campaign_status_id`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`category_id`),
  ADD UNIQUE KEY `category_name` (`category_name`);

--
-- Indexes for table `criteria`
--
ALTER TABLE `criteria`
  ADD PRIMARY KEY (`criteria_id`);

--
-- Indexes for table `mediakit`
--
ALTER TABLE `mediakit`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `youtubeCh` (`youtubeCh`),
  ADD KEY `youtuber_id` (`youtuber_id`);

--
-- Indexes for table `mediakit_interest`
--
ALTER TABLE `mediakit_interest`
  ADD PRIMARY KEY (`mediakit_interest_id`),
  ADD KEY `id` (`id`);

--
-- Indexes for table `notification`
--
ALTER TABLE `notification`
  ADD PRIMARY KEY (`notif_id`);

--
-- Indexes for table `recommendation`
--
ALTER TABLE `recommendation`
  ADD PRIMARY KEY (`recommendation_id`),
  ADD KEY `youtuber_id` (`youtuber_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `submission_status`
--
ALTER TABLE `submission_status`
  ADD PRIMARY KEY (`submission_status_id`);

--
-- Indexes for table `v2_accepted_interest`
--
ALTER TABLE `v2_accepted_interest`
  ADD PRIMARY KEY (`accepted_interest_id`);

--
-- Indexes for table `v2_businessman_rating`
--
ALTER TABLE `v2_businessman_rating`
  ADD PRIMARY KEY (`businessman_rating_id`);

--
-- Indexes for table `v2_video`
--
ALTER TABLE `v2_video`
  ADD PRIMARY KEY (`video_id`);

--
-- Indexes for table `v2_youtube_data`
--
ALTER TABLE `v2_youtube_data`
  ADD PRIMARY KEY (`youtube`);

--
-- Indexes for table `video`
--
ALTER TABLE `video`
  ADD PRIMARY KEY (`video_id`),
  ADD KEY `accepted_interest_id` (`accepted_interest_id`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `youtuber_id` (`youtuber_id`);

--
-- Indexes for table `youtuber`
--
ALTER TABLE `youtuber`
  ADD PRIMARY KEY (`youtuber_id`);

--
-- Indexes for table `youtuber_campaign`
--
ALTER TABLE `youtuber_campaign`
  ADD PRIMARY KEY (`youtuber_campaign_id`),
  ADD KEY `campaign_id` (`campaign_id`),
  ADD KEY `youtuber_id` (`youtuber_id`);

--
-- Indexes for table `youtuber_category`
--
ALTER TABLE `youtuber_category`
  ADD PRIMARY KEY (`youtuber_category_id`),
  ADD KEY `youtuber_id` (`youtuber_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `youtuber_interest`
--
ALTER TABLE `youtuber_interest`
  ADD PRIMARY KEY (`youtuber_interest_id`),
  ADD KEY `youtuber_id` (`youtuber_id`),
  ADD KEY `campaign_id` (`campaign_id`);

--
-- Indexes for table `youtube_data`
--
ALTER TABLE `youtube_data`
  ADD PRIMARY KEY (`youtube`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accepted_interest`
--
ALTER TABLE `accepted_interest`
  MODIFY `accepted_interest_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `activity_log_businessman`
--
ALTER TABLE `activity_log_businessman`
  MODIFY `activity_log_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `admin_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `advertising_details`
--
ALTER TABLE `advertising_details`
  MODIFY `advertising_details_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=17;
--
-- AUTO_INCREMENT for table `businessman`
--
ALTER TABLE `businessman`
  MODIFY `businessman_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=38;
--
-- AUTO_INCREMENT for table `businessman_rating`
--
ALTER TABLE `businessman_rating`
  MODIFY `businessman_rating_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `campaign`
--
ALTER TABLE `campaign`
  MODIFY `campaign_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `campaign_photo`
--
ALTER TABLE `campaign_photo`
  MODIFY `campaign_photo_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `criteria`
--
ALTER TABLE `criteria`
  MODIFY `criteria_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `mediakit`
--
ALTER TABLE `mediakit`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `mediakit_interest`
--
ALTER TABLE `mediakit_interest`
  MODIFY `mediakit_interest_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `notification`
--
ALTER TABLE `notification`
  MODIFY `notif_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=16;
--
-- AUTO_INCREMENT for table `recommendation`
--
ALTER TABLE `recommendation`
  MODIFY `recommendation_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=23;
--
-- AUTO_INCREMENT for table `v2_accepted_interest`
--
ALTER TABLE `v2_accepted_interest`
  MODIFY `accepted_interest_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `v2_businessman_rating`
--
ALTER TABLE `v2_businessman_rating`
  MODIFY `businessman_rating_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `v2_youtube_data`
--
ALTER TABLE `v2_youtube_data`
  MODIFY `youtube` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=23;
--
-- AUTO_INCREMENT for table `youtuber_campaign`
--
ALTER TABLE `youtuber_campaign`
  MODIFY `youtuber_campaign_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `youtuber_category`
--
ALTER TABLE `youtuber_category`
  MODIFY `youtuber_category_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `youtuber_interest`
--
ALTER TABLE `youtuber_interest`
  MODIFY `youtuber_interest_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `youtube_data`
--
ALTER TABLE `youtube_data`
  MODIFY `youtube` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=11717;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `accepted_interest`
--
ALTER TABLE `accepted_interest`
  ADD CONSTRAINT `accepted_interest_ibfk_1` FOREIGN KEY (`youtuber_id`) REFERENCES `youtuber` (`youtuber_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `accepted_interest_ibfk_2` FOREIGN KEY (`campaign_id`) REFERENCES `campaign` (`campaign_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `accepted_interest_ibfk_3` FOREIGN KEY (`submission_status_id`) REFERENCES `submission_status` (`submission_status_id`) ON DELETE CASCADE;

--
-- Constraints for table `activity_log_businessman`
--
ALTER TABLE `activity_log_businessman`
  ADD CONSTRAINT `activity_log_businessman_ibfk_1` FOREIGN KEY (`businessman_id`) REFERENCES `businessman` (`businessman_id`) ON DELETE CASCADE;

--
-- Constraints for table `advertising_details`
--
ALTER TABLE `advertising_details`
  ADD CONSTRAINT `advertising_details_ibfk_1` FOREIGN KEY (`campaign_id`) REFERENCES `campaign` (`campaign_id`) ON DELETE CASCADE;

--
-- Constraints for table `businessman_rating`
--
ALTER TABLE `businessman_rating`
  ADD CONSTRAINT `businessman_rating_ibfk_1` FOREIGN KEY (`accepted_interest_id`) REFERENCES `accepted_interest` (`accepted_interest_id`) ON DELETE CASCADE;

--
-- Constraints for table `campaign`
--
ALTER TABLE `campaign`
  ADD CONSTRAINT `campaign_ibfk_1` FOREIGN KEY (`businessman_id`) REFERENCES `businessman` (`businessman_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `campaign_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON DELETE NO ACTION,
  ADD CONSTRAINT `campaign_ibfk_3` FOREIGN KEY (`campaign_status_id`) REFERENCES `campaign_status` (`campaign_status_id`);

--
-- Constraints for table `campaign_photo`
--
ALTER TABLE `campaign_photo`
  ADD CONSTRAINT `campaign_photo_ibfk_1` FOREIGN KEY (`campaign_id`) REFERENCES `campaign` (`campaign_id`) ON DELETE CASCADE;

--
-- Constraints for table `mediakit`
--
ALTER TABLE `mediakit`
  ADD CONSTRAINT `mediakit_ibfk_1` FOREIGN KEY (`youtuber_id`) REFERENCES `youtuber` (`youtuber_id`) ON DELETE CASCADE;

--
-- Constraints for table `mediakit_interest`
--
ALTER TABLE `mediakit_interest`
  ADD CONSTRAINT `mediakit_interest_ibfk_1` FOREIGN KEY (`id`) REFERENCES `mediakit` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `recommendation`
--
ALTER TABLE `recommendation`
  ADD CONSTRAINT `recommendation_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `recommendation_ibfk_2` FOREIGN KEY (`youtuber_id`) REFERENCES `youtuber` (`youtuber_id`) ON DELETE CASCADE;

--
-- Constraints for table `video`
--
ALTER TABLE `video`
  ADD CONSTRAINT `video_ibfk_1` FOREIGN KEY (`accepted_interest_id`) REFERENCES `accepted_interest` (`accepted_interest_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `video_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `video_ibfk_3` FOREIGN KEY (`youtuber_id`) REFERENCES `youtuber` (`youtuber_id`) ON DELETE CASCADE;

--
-- Constraints for table `youtuber_campaign`
--
ALTER TABLE `youtuber_campaign`
  ADD CONSTRAINT `youtuber_campaign_ibfk_1` FOREIGN KEY (`campaign_id`) REFERENCES `campaign` (`campaign_id`),
  ADD CONSTRAINT `youtuber_campaign_ibfk_2` FOREIGN KEY (`youtuber_id`) REFERENCES `youtuber` (`youtuber_id`);

--
-- Constraints for table `youtuber_category`
--
ALTER TABLE `youtuber_category`
  ADD CONSTRAINT `youtuber_category_ibfk_1` FOREIGN KEY (`youtuber_id`) REFERENCES `youtuber` (`youtuber_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `youtuber_category_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON DELETE CASCADE;

--
-- Constraints for table `youtuber_interest`
--
ALTER TABLE `youtuber_interest`
  ADD CONSTRAINT `youtuber_interest_ibfk_1` FOREIGN KEY (`youtuber_id`) REFERENCES `youtuber` (`youtuber_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `youtuber_interest_ibfk_2` FOREIGN KEY (`campaign_id`) REFERENCES `campaign` (`campaign_id`) ON DELETE CASCADE;

DELIMITER $$
--
-- Events
--
CREATE DEFINER=`root`@`localhost` EVENT `update_campaign_deadline` ON SCHEDULE EVERY 1 MINUTE STARTS '2018-08-05 07:00:00' ENDS '2029-08-05 07:00:00' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE campaign
SET campaign.campaign_status_id = 2
WHERE campaign.campaign_deadline < CURRENT_DATE()$$

CREATE DEFINER=`root`@`localhost` EVENT `update_production_deadline` ON SCHEDULE EVERY 1 MINUTE STARTS '2018-08-05 07:00:00' ENDS '2029-08-05 07:00:00' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE accepted_interest
SET accepted_interest.submission_status_id = 3
WHERE accepted_interest.submission_status_id != 1 AND CURRENT_DATE() > (SELECT campaign.production_deadline FROM campaign WHERE accepted_interest.campaign_id = campaign.campaign_id)$$

CREATE DEFINER=`root`@`localhost` EVENT `update_on_going_production_done` ON SCHEDULE EVERY 1 MINUTE STARTS '2018-08-23 16:45:00' ENDS '2029-08-05 07:00:00' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE campaign
SET campaign.campaign_status_id = 3
WHERE campaign.production_deadline < CURRENT_DATE()$$

DELIMITER ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
