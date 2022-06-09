-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jun 09, 2022 at 10:45 AM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 8.1.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `discord`
--

-- --------------------------------------------------------

--
-- Table structure for table `customcmnd`
--

CREATE TABLE `customcmnd` (
  `id` int(11) NOT NULL,
  `guild` bigint(100) NOT NULL,
  `cmnd_name` varchar(255) NOT NULL,
  `cmnd_reply` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `customcmnd`
--

INSERT INTO `customcmnd` (`id`, `guild`, `cmnd_name`, `cmnd_reply`) VALUES
(4, 850188671839764530, 'facebook', 'https://www.facebook.com/mhrzn.juman/'),
(7, 850188671839764530, 'instagram', 'https://www.instagram.com/juman.mhj/');

-- --------------------------------------------------------

--
-- Table structure for table `guildmutelevel`
--

CREATE TABLE `guildmutelevel` (
  `id` int(11) NOT NULL,
  `guild` bigint(100) NOT NULL,
  `lmt` int(11) NOT NULL,
  `time` int(11) NOT NULL,
  `action` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `guildmutelevel`
--



-- --------------------------------------------------------

--
-- Table structure for table `guilds`
--

CREATE TABLE `guilds` (
  `id` int(11) NOT NULL,
  `welcomechannel` varchar(100) NOT NULL,
  `defaultrole` varchar(100) NOT NULL,
  `defaultrolename` varchar(100) NOT NULL,
  `guildId` bigint(100) NOT NULL,
  `chatchannelId` varchar(100) NOT NULL,
  `rolenormal` varchar(100) NOT NULL,
  `rolemute` varchar(100) NOT NULL,
  `rulesid` varchar(100) NOT NULL,
  `prefix` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `guilds`
--


-- --------------------------------------------------------

--
-- Table structure for table `mute`
--

CREATE TABLE `mute` (
  `id` int(11) NOT NULL,
  `guild` bigint(100) NOT NULL,
  `user` varchar(100) NOT NULL,
  `count` int(11) NOT NULL,
  `action` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `mute`
--


-- --------------------------------------------------------

--
-- Table structure for table `spam`
--

CREATE TABLE `spam` (
  `id` int(11) NOT NULL,
  `guildId` bigint(100) NOT NULL,
  `lmt` int(11) NOT NULL,
  `time` int(11) NOT NULL,
  `diff` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `spam`
--


-- --------------------------------------------------------

--
-- Table structure for table `tutorials`
--

CREATE TABLE `tutorials` (
  `id` int(11) NOT NULL,
  `question` varchar(255) NOT NULL,
  `answer` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `userlevel`
--

CREATE TABLE `userlevel` (
  `id` int(11) NOT NULL,
  `userid` varchar(255) NOT NULL,
  `guildid` bigint(255) NOT NULL,
  `count` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `userlevel`
--


--
-- Indexes for dumped tables
--

--
-- Indexes for table `customcmnd`
--
ALTER TABLE `customcmnd`
  ADD PRIMARY KEY (`id`),
  ADD KEY `kf_guild_cmnd` (`guild`);

--
-- Indexes for table `guildmutelevel`
--
ALTER TABLE `guildmutelevel`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_guild_level` (`guild`);

--
-- Indexes for table `guilds`
--
ALTER TABLE `guilds`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `guildId` (`guildId`);

--
-- Indexes for table `mute`
--
ALTER TABLE `mute`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_guild_mute` (`guild`);

--
-- Indexes for table `spam`
--
ALTER TABLE `spam`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_guild_spam` (`guildId`);

--
-- Indexes for table `tutorials`
--
ALTER TABLE `tutorials`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `userlevel`
--
ALTER TABLE `userlevel`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_guild_userlvl` (`guildid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `customcmnd`
--
ALTER TABLE `customcmnd`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `guildmutelevel`
--
ALTER TABLE `guildmutelevel`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `guilds`
--
ALTER TABLE `guilds`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `mute`
--
ALTER TABLE `mute`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `spam`
--
ALTER TABLE `spam`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tutorials`
--
ALTER TABLE `tutorials`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `userlevel`
--
ALTER TABLE `userlevel`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `customcmnd`
--
ALTER TABLE `customcmnd`
  ADD CONSTRAINT `kf_guild_cmnd` FOREIGN KEY (`guild`) REFERENCES `guilds` (`guildId`);

--
-- Constraints for table `guildmutelevel`
--
ALTER TABLE `guildmutelevel`
  ADD CONSTRAINT `fk_guild_level` FOREIGN KEY (`guild`) REFERENCES `guilds` (`guildId`);

--
-- Constraints for table `mute`
--
ALTER TABLE `mute`
  ADD CONSTRAINT `fk_guild_mute` FOREIGN KEY (`guild`) REFERENCES `guilds` (`guildId`);

--
-- Constraints for table `spam`
--
ALTER TABLE `spam`
  ADD CONSTRAINT `fk_guild_spam` FOREIGN KEY (`guildId`) REFERENCES `guilds` (`guildId`);

--
-- Constraints for table `userlevel`
--
ALTER TABLE `userlevel`
  ADD CONSTRAINT `fk_guild_userlvl` FOREIGN KEY (`guildid`) REFERENCES `guilds` (`guildId`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
