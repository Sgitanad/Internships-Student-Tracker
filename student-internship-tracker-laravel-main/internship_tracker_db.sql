-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : mar. 19 mai 2026 à 00:12
-- Version du serveur : 8.4.7
-- Version de PHP : 8.3.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `internship_tracker_db`
--

-- --------------------------------------------------------

--
-- Structure de la table `cache`
--

DROP TABLE IF EXISTS `cache`;
CREATE TABLE IF NOT EXISTS `cache` (
  `key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` bigint NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_expiration_index` (`expiration`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
CREATE TABLE IF NOT EXISTS `cache_locks` (
  `key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` bigint NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_locks_expiration_index` (`expiration`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `commentaires`
--

DROP TABLE IF EXISTS `commentaires`;
CREATE TABLE IF NOT EXISTS `commentaires` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `contenu` varchar(255) DEFAULT NULL,
  `date_creation` datetime(6) DEFAULT NULL,
  `auteur_id` bigint DEFAULT NULL,
  `rapport_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK9ln3ltemfs8wge22nx61vns9t` (`auteur_id`),
  KEY `FKrnmdn2emgdpggcfcybvpl49wg` (`rapport_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `commentaires`
--

INSERT INTO `commentaires` (`id`, `contenu`, `date_creation`, `auteur_id`, `rapport_id`) VALUES
(1, 'hii', '2026-05-18 23:11:20.000000', 34, 3);

-- --------------------------------------------------------

--
-- Structure de la table `deadlines`
--

DROP TABLE IF EXISTS `deadlines`;
CREATE TABLE IF NOT EXISTS `deadlines` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `date_limite` date DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `deadlines`
--

INSERT INTO `deadlines` (`id`, `date_limite`, `type`) VALUES
(9, '2026-05-19', 'dvsfvx'),
(12, '2026-05-21', 'sdvdsfv'),
(13, '2026-05-20', 'sfdsd'),
(17, '2026-05-17', 'efsdffesg');

-- --------------------------------------------------------

--
-- Structure de la table `demandes_encadrement`
--

DROP TABLE IF EXISTS `demandes_encadrement`;
CREATE TABLE IF NOT EXISTS `demandes_encadrement` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `date_demande` datetime(6) DEFAULT NULL,
  `date_reponse` datetime(6) DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `statut` enum('ACCEPTE','EN_ATTENTE','REFUSE') DEFAULT NULL,
  `encadrant_id` bigint DEFAULT NULL,
  `etudiant_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKcfhby01mwy6goygmhnnvwe5w` (`encadrant_id`),
  KEY `FKbo5kcrk4yudthps40upk7929k` (`etudiant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `demandes_encadrement`
--

INSERT INTO `demandes_encadrement` (`id`, `date_demande`, `date_reponse`, `message`, `statut`, `encadrant_id`, `etudiant_id`) VALUES
(3, '2026-04-27 23:35:43.359648', '2026-04-27 23:38:32.780414', 'Bonjour, je souhaite être encadré par vous pour mon stage.', 'ACCEPTE', 3, 1),
(4, '2026-04-29 19:04:46.806445', '2026-04-30 00:25:40.179580', 'bonjour monsieur ..........', 'REFUSE', 3, 1),
(5, '2026-05-05 16:33:08.000000', '2026-05-05 16:35:12.000000', 'efskbvrdjhfvs', 'ACCEPTE', 18, 19),
(6, '2026-05-18 14:54:56.000000', NULL, NULL, 'EN_ATTENTE', 16, 24),
(7, '2026-05-18 14:55:17.000000', NULL, NULL, 'EN_ATTENTE', 8, 24),
(8, '2026-05-18 18:45:19.000000', '2026-05-18 18:53:43.000000', NULL, 'ACCEPTE', 33, 34),
(9, '2026-05-18 18:51:07.000000', '2026-05-18 18:53:43.000000', NULL, 'REFUSE', 32, 34),
(10, '2026-05-18 18:55:16.000000', '2026-05-18 18:56:11.000000', NULL, 'REFUSE', 33, 35),
(11, '2026-05-18 19:55:46.000000', '2026-05-18 19:59:01.000000', NULL, 'REFUSE', 33, 36);

-- --------------------------------------------------------

--
-- Structure de la table `documents`
--

DROP TABLE IF EXISTS `documents`;
CREATE TABLE IF NOT EXISTS `documents` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint UNSIGNED NOT NULL,
  `supervisor_id` bigint UNSIGNED DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `original_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `size` bigint UNSIGNED DEFAULT NULL,
  `mime_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `documents_user_id_index` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `documents`
--

INSERT INTO `documents` (`id`, `user_id`, `supervisor_id`, `name`, `original_name`, `size`, `mime_type`, `created_at`, `updated_at`) VALUES
(2, 33, NULL, 'documents/33/ToBIM63F9ba3Y4pLR6tE1P5RmNIcrLrp5lhIrkB0.pdf', 'python_cheatsheet_compact (1).pdf', 2646, 'application/pdf', '2026-05-18 19:23:29', '2026-05-18 19:23:29'),
(3, 33, NULL, 'documents/33/liczRwPRBHpzDnqTd9bwBdkGgFCKKKLbNHsT0KX9.docx', 'Cahier_des_Charges_Student_Internship_Tracker-1 (Réparé).docx', 27821, 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', '2026-05-18 19:51:38', '2026-05-18 19:51:38'),
(7, 33, NULL, 'documents/33/YRn7pI9nCdwUZ4iMlXYW94l1j55aq0nedPCDYcAG.pdf', 'python_cheatsheet.pdf', 2934, 'application/pdf', '2026-05-18 22:18:58', '2026-05-18 22:18:58');

-- --------------------------------------------------------

--
-- Structure de la table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `uuid` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
CREATE TABLE IF NOT EXISTS `jobs` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `queue` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` smallint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
CREATE TABLE IF NOT EXISTS `job_batches` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `messages`
--

DROP TABLE IF EXISTS `messages`;
CREATE TABLE IF NOT EXISTS `messages` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `sender_id` bigint UNSIGNED NOT NULL,
  `receiver_id` bigint UNSIGNED NOT NULL,
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `messages_sender_id_foreign` (`sender_id`),
  KEY `messages_receiver_id_foreign` (`receiver_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `messages`
--

INSERT INTO `messages` (`id`, `sender_id`, `receiver_id`, `content`, `is_read`, `created_at`, `updated_at`) VALUES
(1, 33, 34, 'hi', 1, '2026-05-18 20:43:22', '2026-05-18 20:43:52'),
(2, 34, 33, 'hello', 1, '2026-05-18 20:43:55', '2026-05-18 20:44:25'),
(3, 33, 34, 'adem', 1, '2026-05-18 21:32:40', '2026-05-18 21:33:18'),
(4, 34, 33, '😍', 0, '2026-05-18 21:33:31', '2026-05-18 21:33:31');

-- --------------------------------------------------------

--
-- Structure de la table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000001_create_cache_table', 1),
(2, '0001_01_01_000002_create_jobs_table', 1),
(3, '2026_05_04_153840_add_role_to_users_table', 1),
(4, '2026_05_18_220000_create_messages_table', 2),
(5, '2026_05_18_230000_add_fichier_path_to_rapports_table', 3);

-- --------------------------------------------------------

--
-- Structure de la table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
CREATE TABLE IF NOT EXISTS `notifications` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `date_envoi` datetime(6) DEFAULT NULL,
  `est_lue` bit(1) NOT NULL,
  `message` varchar(255) DEFAULT NULL,
  `titre` varchar(255) DEFAULT NULL,
  `deadline_id` bigint DEFAULT NULL,
  `rapport_id` bigint DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  `type` varchar(191) DEFAULT 'general',
  PRIMARY KEY (`id`),
  KEY `FKpysrkkgc4tktp2ar7g4cmpk2x` (`deadline_id`),
  KEY `FKljibtv9iqbctg9m4eps4dravn` (`rapport_id`),
  KEY `FK9y21adhxn0ayjhfocscqox7bh` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `notifications`
--

INSERT INTO `notifications` (`id`, `date_envoi`, `est_lue`, `message`, `titre`, `deadline_id`, `rapport_id`, `user_id`, `type`) VALUES
(1, '2026-04-27 23:31:40.725763', b'0', 'Test Etudiant vous a envoyé une demande d\'encadrement', 'Nouvelle demande d\'encadrement', NULL, NULL, 2, 'general'),
(2, '2026-04-27 23:34:57.929848', b'0', 'Test Etudiant vous a envoyé une demande d\'encadrement', 'Nouvelle demande d\'encadrement', NULL, NULL, 2, 'general'),
(7, '2026-05-18 18:37:56.000000', b'0', 'A new student (tesssssttt) has registered with email notif@example.com.', 'New student registered', NULL, NULL, 2, 'user_registered'),
(8, '2026-05-18 18:37:56.000000', b'0', 'A new student (tesssssttt) has registered with email notif@example.com.', 'New student registered', NULL, NULL, 7, 'user_registered'),
(9, '2026-05-18 18:37:56.000000', b'0', 'A new student (tesssssttt) has registered with email notif@example.com.', 'New student registered', NULL, NULL, 15, 'user_registered'),
(10, '2026-05-18 18:37:56.000000', b'1', 'A new student (tesssssttt) has registered with email notif@example.com.', 'New student registered', NULL, NULL, 17, 'user_registered'),
(11, '2026-05-18 18:37:56.000000', b'1', 'A new student (tesssssttt) has registered with email notif@example.com.', 'New student registered', NULL, NULL, 20, 'user_registered'),
(12, '2026-05-18 18:39:03.000000', b'1', 'A new ENCADRANT account was created for sarah (sarah@example.com).', 'New user created', NULL, NULL, 17, 'user_created'),
(13, '2026-05-18 18:44:07.000000', b'0', 'A new ENCADRANT account was created for alasup (alasup@example.com).', 'New user created', NULL, NULL, 17, 'user_created'),
(14, '2026-05-18 18:44:32.000000', b'0', 'A new ETUDIANT account was created for alastu (alastu@example.com).', 'New user created', NULL, NULL, 17, 'user_created'),
(15, '2026-05-18 18:51:07.000000', b'0', 'alastu has requested your supervision.', 'New supervision request', NULL, NULL, 32, 'supervision_request'),
(16, '2026-05-18 18:53:43.000000', b'1', 'Your supervision request has been accepted by alasup.', 'Supervision request accepted', NULL, NULL, 34, 'supervision_accepted'),
(17, '2026-05-18 18:55:06.000000', b'0', 'A new student (stu) has registered with email stu@example.com.', 'New student registered', NULL, NULL, 2, 'user_registered'),
(18, '2026-05-18 18:55:06.000000', b'0', 'A new student (stu) has registered with email stu@example.com.', 'New student registered', NULL, NULL, 7, 'user_registered'),
(19, '2026-05-18 18:55:06.000000', b'0', 'A new student (stu) has registered with email stu@example.com.', 'New student registered', NULL, NULL, 15, 'user_registered'),
(20, '2026-05-18 18:55:06.000000', b'0', 'A new student (stu) has registered with email stu@example.com.', 'New student registered', NULL, NULL, 17, 'user_registered'),
(21, '2026-05-18 18:55:06.000000', b'1', 'A new student (stu) has registered with email stu@example.com.', 'New student registered', NULL, NULL, 20, 'user_registered'),
(22, '2026-05-18 18:55:16.000000', b'1', 'stu has requested your supervision.', 'New supervision request', NULL, NULL, 33, 'supervision_request'),
(23, '2026-05-18 18:56:11.000000', b'1', 'Your supervision request has been rejected by alasup.', 'Supervision request rejected', NULL, NULL, 35, 'supervision_rejected'),
(24, '2026-05-18 19:55:36.000000', b'0', 'A new student (fadistu) has registered with email fadistu@example.com.', 'New student registered', NULL, NULL, 2, 'user_registered'),
(25, '2026-05-18 19:55:36.000000', b'0', 'A new student (fadistu) has registered with email fadistu@example.com.', 'New student registered', NULL, NULL, 7, 'user_registered'),
(26, '2026-05-18 19:55:36.000000', b'0', 'A new student (fadistu) has registered with email fadistu@example.com.', 'New student registered', NULL, NULL, 15, 'user_registered'),
(27, '2026-05-18 19:55:36.000000', b'0', 'A new student (fadistu) has registered with email fadistu@example.com.', 'New student registered', NULL, NULL, 17, 'user_registered'),
(28, '2026-05-18 19:55:36.000000', b'1', 'A new student (fadistu) has registered with email fadistu@example.com.', 'New student registered', NULL, NULL, 20, 'user_registered'),
(29, '2026-05-18 19:55:46.000000', b'0', 'fadistu has requested your supervision.', 'New supervision request', NULL, NULL, 33, 'supervision_request'),
(30, '2026-05-18 19:59:01.000000', b'0', 'Your supervision request has been rejected by alasup.', 'Supervision request rejected', NULL, NULL, 36, 'supervision_rejected');

-- --------------------------------------------------------

--
-- Structure de la table `rapports`
--

DROP TABLE IF EXISTS `rapports`;
CREATE TABLE IF NOT EXISTS `rapports` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `contenu` varchar(255) DEFAULT NULL,
  `fichier_path` varchar(191) DEFAULT NULL,
  `date_depot` datetime(6) DEFAULT NULL,
  `statut` varchar(255) DEFAULT NULL,
  `titre` varchar(255) DEFAULT NULL,
  `auteur_id` bigint DEFAULT NULL,
  `encadrant_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKs4lpq2u42dqj59pm32okgn1tl` (`auteur_id`),
  KEY `FK3i1magfs9vnqdhxkw2k6q3chv` (`encadrant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `rapports`
--

INSERT INTO `rapports` (`id`, `contenu`, `fichier_path`, `date_depot`, `statut`, `titre`, `auteur_id`, `encadrant_id`) VALUES
(1, 'Contenu du rapport de stage', NULL, '2026-04-26 18:54:58.618884', 'SOUMIS', 'Mon premier rapport', NULL, NULL),
(2, 'sdfghj', NULL, '2026-05-14 14:23:10.000000', 'SOUMIS', 'wfdghj', 19, NULL),
(3, NULL, NULL, '2026-05-18 23:07:26.000000', 'VALIDE', 'zeafzreg', 34, 33),
(4, NULL, NULL, '2026-05-19 00:10:12.000000', 'SOUMIS', 'zqdqfqsf', 19, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `email` varchar(255) DEFAULT NULL,
  `mot_de_passe` varchar(255) DEFAULT NULL,
  `nom` varchar(255) DEFAULT NULL,
  `role` enum('ADMIN','ENCADRANT','ETUDIANT') DEFAULT NULL,
  `notifications_enabled` tinyint(1) DEFAULT '1',
  `profile_picture` varchar(255) DEFAULT NULL,
  `encadrant_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKdud2hnw7j29v4c0ai25cr2pim` (`encadrant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `email`, `mot_de_passe`, `nom`, `role`, `notifications_enabled`, `profile_picture`, `encadrant_id`) VALUES
(2, 'admin@test.com', '$2a$10$.8WwCBUE/.oAu/scI5pGOu.IeXa.M5Kdoe7M4BO1Cfy7jgOhAivbS', 'Admin Principal', 'ADMIN', 1, NULL, NULL),
(7, 'test@gmail.com', '$2y$12$6nm4nyjQxRCch.A6zCVtJejVXJdRJ6k0RsXaTDITc7PtxlK9Ns9h6', 'test user', 'ADMIN', 1, NULL, NULL),
(9, 'test@example.com', '$2y$12$otQX/POQBm7c2OmTPcmANedcaOKuNucJJKcyJyq5y5I1tcG0EYrRa', 'Test User', 'ETUDIANT', 1, NULL, NULL),
(10, 'newtest@example.com', '$2y$12$UfY4kjUgBazyLPJUlRkIweLvH7o5.WA16AnYs8Z/AM58Tk0jAxMpq', 'NewTest', 'ETUDIANT', 1, NULL, NULL),
(11, 'anothertest@example.com', '$2y$12$.d2MRUHtAPMF8veGjqf4Nur6V7N4gwt1z2wQHMALBcYP94MHHKcpm', 'AnotherTest', 'ETUDIANT', 1, NULL, NULL),
(12, 'finaltest@example.com', '$2y$12$IQq.zcT4LF.NqOZ7U1RA6O29N3OLT5IhDjY.Mk4V3oIvYk7CHX8y.', 'FinalTest', 'ETUDIANT', 1, NULL, NULL),
(14, 'test1@gmail.com', '$2y$12$/2CppOum8a2Wrmj1cgvKpeViwrm8ozwrlUYT7y6Tw/GGTdhciMe16', 'test', 'ENCADRANT', 1, NULL, NULL),
(15, 'fedi@gmail.com', '$2y$12$n4Ypq3zecNUaOX1qYfbW2uCPkXW0SxC2hzenWnUhHfiLJJ78ulRli', 'fedi', 'ADMIN', 1, NULL, NULL),
(16, 'sanad@gmail.com', '$2y$12$S0XVemSLxKx3/8LKBOnYPOgoDMcAj14Q7zH9ktwWQtvcEfe/VbUlu', 'sanad', 'ENCADRANT', 1, NULL, NULL),
(17, 'admin1@example.com', '$2y$12$GM3ikTinijdd1hbUbATSc.g7FQSBa3I1C2cmcBXW6UqcGqR3DqHEy', 'Admin User', 'ADMIN', 1, NULL, NULL),
(18, 'supervisor@example.com', '$2y$12$FVgSOAlvAT.2ziR8h9VNHODhRhoG3VFnOtui6rWUp6Ibf9pF.zWNO', 'Supervisor User', 'ENCADRANT', 1, NULL, NULL),
(19, 'student@example.com', '$2y$12$s6XiVgoSTdCeYmZ6K/Eu/ugVLBbS9AhdhhYr/S/.ovZnE1sG2AFsu', 'Student User', 'ETUDIANT', 1, NULL, NULL),
(20, 'admin@example.com', '$2y$12$VS7teF7Z6v.IhedH3vEgw.VbDvl0OZ.O.CmWV3MwMdt3z5WdCQ//y', 'Admin User Principale', 'ADMIN', 1, NULL, NULL),
(21, 'supervisor@example.com', '$2y$12$Tf0mWMoGflk12Bx17Qhvt.R4LwVFim4QpucDslKKAP3Q1zXLJb71i', 'Supervisor User', 'ENCADRANT', 1, NULL, NULL),
(22, 'student@example.com', '$2y$12$4xY3SLIW1aGKskyqH0rk1.EM3w4K6kwyG6Hq11Y9kL0hrSeeWnXNK', 'Student User', 'ETUDIANT', 1, NULL, NULL),
(29, 'aziz@example.com', '$2y$12$x8ao72bQn1r5mw2jN/3Jk.rVCxgDKBflg/Yu6YGKtVTzanGvWN5.6', 'aziz', 'ETUDIANT', 1, NULL, NULL),
(30, 'testnotif@example.com', '$2y$12$ItNum9ysqCocSlJ8MqzQv.rxBGsMi.NQvHgRLpevduUOTk3SYPBN6', 'testnotif', 'ETUDIANT', 1, NULL, NULL),
(31, 'notif@example.com', '$2y$12$hOvePOg6msCamBWi3gq15e5V1l6VzrOC28wRk2UjDeBwBxgQznDuS', 'tesssssttt', 'ETUDIANT', 1, NULL, NULL),
(32, 'sarah@example.com', '$2y$12$25xvXM/QHulALqTUioFes.sRcG0lggxjlb4rh23yGxIvxGFWrPk5m', 'sarah', 'ENCADRANT', 1, NULL, NULL),
(33, 'alasup@example.com', '$2y$12$njtP1/OTwhl10kNsLL6MlOmuwv/BkXq5DPcP/Ao0BbCjuQHWByOES', 'alasup', 'ENCADRANT', 1, NULL, NULL),
(34, 'alastud@example.com', '$2y$12$aBU5bnmV/ZVf/p8p1X7NFOEarF4VbaGK4rT1H3n.bVlgHZ4nOmiyK', 'alastud', 'ETUDIANT', 1, NULL, 33),
(35, 'stu@example.com', '$2y$12$b6j7FDGau3v5SlvqBz3mpOHRlBcL/AwKtIpFfdYPLfVGdBbJ9wy3e', 'stu', 'ETUDIANT', 1, NULL, NULL),
(36, 'fadistu@example.com', '$2y$12$LrMh4RWeUj7BTnDFsZsx7.9pZupLv10Zh/TY7EYjXJe7l9RdX5Wja', 'fadistu', 'ETUDIANT', 1, NULL, NULL);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `commentaires`
--
ALTER TABLE `commentaires`
  ADD CONSTRAINT `FK9ln3ltemfs8wge22nx61vns9t` FOREIGN KEY (`auteur_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `FKrnmdn2emgdpggcfcybvpl49wg` FOREIGN KEY (`rapport_id`) REFERENCES `rapports` (`id`);

--
-- Contraintes pour la table `demandes_encadrement`
--
ALTER TABLE `demandes_encadrement`
  ADD CONSTRAINT `FKbo5kcrk4yudthps40upk7929k` FOREIGN KEY (`etudiant_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `FKcfhby01mwy6goygmhnnvwe5w` FOREIGN KEY (`encadrant_id`) REFERENCES `users` (`id`);

--
-- Contraintes pour la table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `FK9y21adhxn0ayjhfocscqox7bh` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `FKljibtv9iqbctg9m4eps4dravn` FOREIGN KEY (`rapport_id`) REFERENCES `rapports` (`id`),
  ADD CONSTRAINT `FKpysrkkgc4tktp2ar7g4cmpk2x` FOREIGN KEY (`deadline_id`) REFERENCES `deadlines` (`id`);

--
-- Contraintes pour la table `rapports`
--
ALTER TABLE `rapports`
  ADD CONSTRAINT `FK3i1magfs9vnqdhxkw2k6q3chv` FOREIGN KEY (`encadrant_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `FKs4lpq2u42dqj59pm32okgn1tl` FOREIGN KEY (`auteur_id`) REFERENCES `users` (`id`);

--
-- Contraintes pour la table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `FKdud2hnw7j29v4c0ai25cr2pim` FOREIGN KEY (`encadrant_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
