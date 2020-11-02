-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 02-11-2020 a las 13:03:33
-- Versión del servidor: 8.0.18
-- Versión de PHP: 7.3.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `projectdb`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cities`
--

CREATE TABLE `cities` (
  `id` int(11) NOT NULL,
  `Nombre` varchar(64) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `Cantidad_habitantes` int(11) DEFAULT NULL,
  `Sitio_turistico` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `Hotel_visitado` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `cities`
--

INSERT INTO `cities` (`id`, `Nombre`, `Cantidad_habitantes`, `Sitio_turistico`, `Hotel_visitado`) VALUES
(1, 'Bogotá', 8000000, 'Monserrate', 'Hilton'),
(2, 'San Andres', 10000, 'Islas', 'DeCameron'),
(3, 'Cali', 3000000, 'Valle', 'IDK'),
(4, 'Medellín', 4000000, 'IDK', 'IDK'),
(5, 'New York', 10000000, 'IDK', 'IDK');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tourist`
--

CREATE TABLE `tourist` (
  `Nombre` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Fecha_Nacimiento` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `id` varchar(32) COLLATE utf8mb4_general_ci NOT NULL,
  `tipo_id` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Frecuencia_viaje` int(11) DEFAULT NULL,
  `Presupuesto_viaje` double DEFAULT NULL,
  `Destino` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Tcredito` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tourist`
--

INSERT INTO `tourist` (`Nombre`, `Fecha_Nacimiento`, `id`, `tipo_id`, `Frecuencia_viaje`, `Presupuesto_viaje`, `Destino`, `Tcredito`) VALUES
('Brayan', '02/21/1997', '1', 'CC', 3, 50000, 'San Andres', 0),
('<h1>troll</h1>', '01/02/2020', '2', 'TI', 26, 120000, 'Medellín', 1),
('El Pepe', '01/01/2000', '3', 'CE', 1, 10000, 'Bogotá', 0),
('nóháytíldés', '01/02/2003', '4', 'CC', 36, 500000, 'Cali', 1),
('NosoyUnaprueba', '01/02/1950', '5', 'TI', 12, 100, 'Medellín', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `travelregister`
--

CREATE TABLE `travelregister` (
  `IdViaje` int(11) NOT NULL,
  `idCiudad` int(11) NOT NULL,
  `Ciudad` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `IdTurista` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Fecha` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `travelregister`
--

INSERT INTO `travelregister` (`IdViaje`, `idCiudad`, `Ciudad`, `IdTurista`, `Fecha`) VALUES
(1, 2, 'San Andres', '1', '01/01/2020'),
(2, 2, 'San Andres', '2', '01/01/2020'),
(3, 2, 'San Andres', '3', '01/01/2020'),
(4, 2, 'San Andres', '4', '01/01/2020'),
(5, 1, 'Bogotá', '5', '01/01/2020'),
(6, 4, 'Medellín', '5', '01/01/2020'),
(7, 5, 'New York', '1', '01/03/1985'),
(8, 4, 'Medellín', '2', '01/03/2020'),
(9, 3, 'Cali', '5', '01/02/1952'),
(10, 3, 'Cali', '2', '01/02/2022');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cities`
--
ALTER TABLE `cities`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tourist`
--
ALTER TABLE `tourist`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `travelregister`
--
ALTER TABLE `travelregister`
  ADD PRIMARY KEY (`IdViaje`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `cities`
--
ALTER TABLE `cities`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `travelregister`
--
ALTER TABLE `travelregister`
  MODIFY `IdViaje` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
