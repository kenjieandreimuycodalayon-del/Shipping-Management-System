-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 04, 2026 at 11:08 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `lodestar_shipping`
--

-- --------------------------------------------------------

--
-- Table structure for table `cargo`
--

CREATE TABLE `cargo` (
  `id` int(11) NOT NULL,
  `cargo_code` varchar(30) NOT NULL,
  `direction` enum('INBOUND','OUTBOUND') NOT NULL,
  `origin_port_id` int(11) NOT NULL,
  `destination_port_id` int(11) NOT NULL,
  `vessel_id` int(11) DEFAULT NULL,
  `weight_kg` decimal(12,2) DEFAULT NULL,
  `priority` varchar(20) DEFAULT 'Normal',
  `status` enum('PREPARED','DISPATCHED','RECEIVED','RETURNED','CANCELLED') NOT NULL DEFAULT 'PREPARED',
  `date_prepared` date DEFAULT NULL,
  `departure_date` date DEFAULT NULL,
  `estimated_eta` date DEFAULT NULL,
  `date_ended` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cargo_products`
--

CREATE TABLE `cargo_products` (
  `id` int(11) NOT NULL,
  `cargo_id` int(11) NOT NULL,
  `product_name` varchar(150) NOT NULL,
  `quantity` decimal(12,2) DEFAULT NULL,
  `unit` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `partnerships`
--

CREATE TABLE `partnerships` (
  `id` int(11) NOT NULL,
  `port_a_id` int(11) NOT NULL,
  `port_b_id` int(11) NOT NULL,
  `request_type` varchar(50) DEFAULT NULL,
  `status` enum('PENDING','ACTIVE','REJECTED','TERMINATED','EXPIRED') NOT NULL DEFAULT 'PENDING',
  `connected_since` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `start_date` date DEFAULT NULL,
  `expiry_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permit_applications`
--

CREATE TABLE `permit_applications` (
  `id` int(11) NOT NULL,
  `port_id` int(11) NOT NULL,
  `permit_no` varchar(50) DEFAULT NULL,
  `date_submitted` date DEFAULT NULL,
  `date_approved` date DEFAULT NULL,
  `status` enum('PENDING','APPROVED','REJECTED') NOT NULL DEFAULT 'PENDING',
  `admin_remarks` text DEFAULT NULL,
  `document_name` varchar(255) DEFAULT NULL,
  `document_data` longblob DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permit_applications`
--

INSERT INTO `permit_applications` (`id`, `port_id`, `permit_no`, `date_submitted`, `date_approved`, `status`, `admin_remarks`, `document_name`, `document_data`) VALUES
(1, 2, 'LSC-PMT-2026-00001', '2026-09-27', '2026-10-04', 'REJECTED', 'You need a permit picture', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `ports`
--

CREATE TABLE `ports` (
  `id` int(11) NOT NULL,
  `port_code` varchar(30) DEFAULT NULL,
  `port_name` varchar(150) NOT NULL,
  `registered_name` varchar(150) DEFAULT NULL,
  `primary_capability` varchar(150) DEFAULT NULL,
  `status` enum('PENDING','ACTIVE','SUSPENDED','TERMINATED','EXPIRED') NOT NULL DEFAULT 'PENDING',
  `dispatch_limit` int(11) DEFAULT 0,
  `cargo_item_limit` int(11) DEFAULT 0,
  `permit_authority` varchar(150) DEFAULT NULL,
  `permit_no` varchar(50) DEFAULT NULL,
  `submitted_date` date DEFAULT NULL,
  `approved_date` date DEFAULT NULL,
  `expiration_date` date DEFAULT NULL,
  `last_renewal` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ports`
--

INSERT INTO `ports` (`id`, `port_code`, `port_name`, `registered_name`, `primary_capability`, `status`, `dispatch_limit`, `cargo_item_limit`, `permit_authority`, `permit_no`, `submitted_date`, `approved_date`, `expiration_date`, `last_renewal`, `created_at`, `updated_at`) VALUES
(1, 'LSP-XXX-00001', 'Demo Port', 'Demo Port Authority', 'Container Handling', 'ACTIVE', 0, 0, 'Philippine Ports Authority', NULL, NULL, NULL, '2027-12-31', '2026-01-15', '2026-09-27 08:33:43', '2026-10-04 08:40:21'),
(2, 'LSP-DCP-00002', 'Davao City Port', 'Davao City Port', 'Container Handling', 'SUSPENDED', 5, 10, NULL, NULL, '2026-09-27', NULL, NULL, NULL, '2026-09-27 11:59:46', '2026-09-27 12:00:07');

-- --------------------------------------------------------

--
-- Table structure for table `system_settings`
--

CREATE TABLE `system_settings` (
  `id` int(11) NOT NULL DEFAULT 1,
  `sys_role` varchar(100) DEFAULT NULL,
  `max_queue_per_port` int(11) DEFAULT 0,
  `max_cargo_per_item` int(11) DEFAULT 0,
  `network_status` varchar(50) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `system_settings`
--

INSERT INTO `system_settings` (`id`, `sys_role`, `max_queue_per_port`, `max_cargo_per_item`, `network_status`, `updated_at`) VALUES
(1, 'Administrator', 10, 5, 'Online', '2026-09-27 08:33:43');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `full_name` varchar(150) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `role` enum('ADMIN','PORT') NOT NULL,
  `port_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `terms_accepted_at` datetime DEFAULT NULL,
  `terms_version` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password_hash`, `full_name`, `email`, `role`, `port_id`, `created_at`, `updated_at`, `terms_accepted_at`, `terms_version`) VALUES
(1, 'admin', 'admin123', 'System Administrator', NULL, 'ADMIN', NULL, '2026-09-27 08:33:43', '2026-09-27 08:33:43', NULL, NULL),
(2, 'port', 'port123', 'Demo Port Manager', NULL, 'PORT', 1, '2026-09-27 08:33:43', '2026-09-27 08:33:43', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `vessels`
--

CREATE TABLE `vessels` (
  `id` int(11) NOT NULL,
  `imo_number` varchar(20) NOT NULL,
  `vessel_name` varchar(150) NOT NULL,
  `carrier_line` varchar(150) DEFAULT NULL,
  `max_capacity_tons` decimal(12,2) DEFAULT NULL,
  `status` enum('PENDING','APPROVED','REJECTED','ACTIVE','INACTIVE') NOT NULL DEFAULT 'PENDING',
  `requested_by` varchar(150) DEFAULT NULL,
  `port_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `document_name` varchar(255) DEFAULT NULL,
  `document_data` longblob DEFAULT NULL,
  `admin_remarks` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `vessels`
--

INSERT INTO `vessels` (`id`, `imo_number`, `vessel_name`, `carrier_line`, `max_capacity_tons`, `status`, `requested_by`, `port_id`, `created_at`, `document_name`, `document_data`, `admin_remarks`) VALUES
(1, '9123456', 'MV Lodestar One', 'Lodestar Lines', 5000.00, 'ACTIVE', 'Admin', NULL, '2026-10-04 04:12:03', NULL, NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cargo`
--
ALTER TABLE `cargo`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `cargo_code` (`cargo_code`),
  ADD KEY `fk_cargo_vessel` (`vessel_id`),
  ADD KEY `idx_cargo_status` (`status`),
  ADD KEY `idx_cargo_origin` (`origin_port_id`),
  ADD KEY `idx_cargo_destination` (`destination_port_id`);

--
-- Indexes for table `cargo_products`
--
ALTER TABLE `cargo_products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_cargoproduct_cargo` (`cargo_id`);

--
-- Indexes for table `partnerships`
--
ALTER TABLE `partnerships`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_partnership_a` (`port_a_id`),
  ADD KEY `fk_partnership_b` (`port_b_id`),
  ADD KEY `idx_partnership_status` (`status`);

--
-- Indexes for table `permit_applications`
--
ALTER TABLE `permit_applications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_permit_port` (`port_id`);

--
-- Indexes for table `ports`
--
ALTER TABLE `ports`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `port_code` (`port_code`);

--
-- Indexes for table `system_settings`
--
ALTER TABLE `system_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD KEY `fk_users_port` (`port_id`);

--
-- Indexes for table `vessels`
--
ALTER TABLE `vessels`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `imo_number` (`imo_number`),
  ADD KEY `fk_vessel_port` (`port_id`),
  ADD KEY `idx_vessel_status` (`status`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cargo`
--
ALTER TABLE `cargo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cargo_products`
--
ALTER TABLE `cargo_products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `partnerships`
--
ALTER TABLE `partnerships`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `permit_applications`
--
ALTER TABLE `permit_applications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `ports`
--
ALTER TABLE `ports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `vessels`
--
ALTER TABLE `vessels`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cargo`
--
ALTER TABLE `cargo`
  ADD CONSTRAINT `fk_cargo_destination` FOREIGN KEY (`destination_port_id`) REFERENCES `ports` (`id`),
  ADD CONSTRAINT `fk_cargo_origin` FOREIGN KEY (`origin_port_id`) REFERENCES `ports` (`id`),
  ADD CONSTRAINT `fk_cargo_vessel` FOREIGN KEY (`vessel_id`) REFERENCES `vessels` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `cargo_products`
--
ALTER TABLE `cargo_products`
  ADD CONSTRAINT `fk_cargoproduct_cargo` FOREIGN KEY (`cargo_id`) REFERENCES `cargo` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `partnerships`
--
ALTER TABLE `partnerships`
  ADD CONSTRAINT `fk_partnership_a` FOREIGN KEY (`port_a_id`) REFERENCES `ports` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_partnership_b` FOREIGN KEY (`port_b_id`) REFERENCES `ports` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `permit_applications`
--
ALTER TABLE `permit_applications`
  ADD CONSTRAINT `fk_permit_port` FOREIGN KEY (`port_id`) REFERENCES `ports` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `fk_users_port` FOREIGN KEY (`port_id`) REFERENCES `ports` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `vessels`
--
ALTER TABLE `vessels`
  ADD CONSTRAINT `fk_vessel_port` FOREIGN KEY (`port_id`) REFERENCES `ports` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
