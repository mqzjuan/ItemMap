-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 31-03-2026 a las 19:20:44
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `estantes_db`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `articulos`
--

CREATE TABLE `articulos` (
  `id` int(11) NOT NULL,
  `codigo` varchar(100) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `medida` varchar(50) DEFAULT '',
  `ubicacion_id` int(11) DEFAULT NULL,
  `notas` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `articulos`
--

INSERT INTO `articulos` (`id`, `codigo`, `descripcion`, `medida`, `ubicacion_id`, `notas`, `created_at`, `updated_at`) VALUES
(2, 'MX', 'MELOXICAM 4 MG', 'Blister', 20, '', '2026-03-31 16:54:09', '2026-03-31 17:19:01');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ubicaciones`
--

CREATE TABLE `ubicaciones` (
  `id` int(11) NOT NULL,
  `codigo` varchar(50) NOT NULL,
  `descripcion` varchar(255) DEFAULT '',
  `color` varchar(7) DEFAULT '#3b82f6',
  `fila` int(11) DEFAULT NULL,
  `columna` int(11) DEFAULT NULL,
  `pos_x` int(11) DEFAULT NULL,
  `pos_y` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ubicaciones`
--

INSERT INTO `ubicaciones` (`id`, `codigo`, `descripcion`, `color`, `fila`, `columna`, `pos_x`, `pos_y`, `created_at`) VALUES
(12, 'A1', '', '#93c5fd', 1, 1, NULL, NULL, '2026-03-31 16:51:51'),
(13, 'A2', '', '#93c5fd', 1, 2, NULL, NULL, '2026-03-31 16:51:57'),
(14, 'A3', '', '#93c5fd', 1, 3, NULL, NULL, '2026-03-31 16:52:04'),
(15, 'A4', '', '#93c5fd', 1, 4, NULL, NULL, '2026-03-31 16:52:07'),
(16, 'A5', '', '#93c5fd', 1, 5, NULL, NULL, '2026-03-31 16:52:11'),
(17, 'B1', '', '#fca5a5', 2, 1, NULL, NULL, '2026-03-31 16:52:20'),
(18, 'B2', '', '#fca5a5', 2, 2, NULL, NULL, '2026-03-31 16:52:48'),
(19, 'B3', '', '#fca5a5', 2, 3, NULL, NULL, '2026-03-31 16:52:57'),
(20, 'B4', '', '#fca5a5', 2, 4, NULL, NULL, '2026-03-31 16:53:03'),
(21, 'B5', '', '#fca5a5', 2, 5, NULL, NULL, '2026-03-31 16:53:15'),
(22, 'C1', '', '#f3f4f6', 3, 1, NULL, NULL, '2026-03-31 16:55:06'),
(23, 'C2', '', '#f3f4f6', 3, 2, NULL, NULL, '2026-03-31 16:55:18'),
(24, 'C3', '', '#f3f4f6', 3, 3, NULL, NULL, '2026-03-31 16:59:30'),
(25, 'C4', '', '#f3f4f6', 3, 4, NULL, NULL, '2026-03-31 16:59:42'),
(26, 'C5', '', '#f3f4f6', 3, 5, NULL, NULL, '2026-03-31 16:59:52'),
(27, 'D1', '', '#86efac', 4, 1, NULL, NULL, '2026-03-31 17:00:24'),
(28, 'D2', '', '#86efac', 4, 2, NULL, NULL, '2026-03-31 17:00:38'),
(29, 'D3', '', '#86efac', 4, 3, NULL, NULL, '2026-03-31 17:00:49'),
(30, 'D4', '', '#86efac', 4, 4, NULL, NULL, '2026-03-31 17:00:56'),
(31, 'D5', '', '#86efac', 4, 5, NULL, NULL, '2026-03-31 17:01:00'),
(32, 'E1', '', '#fde68a', 5, 1, NULL, NULL, '2026-03-31 17:03:53'),
(33, 'E2', '', '#fde68a', 5, 2, NULL, NULL, '2026-03-31 17:03:53'),
(34, 'E3', '', '#fde68a', 5, 3, NULL, NULL, '2026-03-31 17:03:53'),
(35, 'E4', '', '#fde68a', 5, 4, NULL, NULL, '2026-03-31 17:03:53'),
(36, 'E5', '', '#fde68a', 5, 5, NULL, NULL, '2026-03-31 17:03:53'),
(37, 'CAJON', 'PRIMER CAJON', '#3b82f6', NULL, NULL, NULL, NULL, '2026-03-31 17:04:20');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `articulos`
--
ALTER TABLE `articulos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `codigo` (`codigo`),
  ADD KEY `ubicacion_id` (`ubicacion_id`);

--
-- Indices de la tabla `ubicaciones`
--
ALTER TABLE `ubicaciones`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `codigo` (`codigo`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `articulos`
--
ALTER TABLE `articulos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `ubicaciones`
--
ALTER TABLE `ubicaciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `articulos`
--
ALTER TABLE `articulos`
  ADD CONSTRAINT `articulos_ibfk_1` FOREIGN KEY (`ubicacion_id`) REFERENCES `ubicaciones` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
