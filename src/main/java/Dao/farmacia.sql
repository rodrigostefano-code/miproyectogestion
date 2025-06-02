-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 02-06-2025 a las 11:49:26
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.1.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `farmacia`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categoria`
--

INSERT INTO `categoria` (`id`, `nombre`) VALUES
(1, 'Analgésicos'),
(2, 'Analgésicos'),
(3, 'Antibióticos'),
(4, 'Antiinflamatorios'),
(5, 'Vitaminas'),
(6, 'Antidepresivos'),
(7, 'Antihistamínicos'),
(8, 'Antifúngicos'),
(9, 'Antipiréticos'),
(10, 'Broncodilatadores'),
(11, 'Antidiabéticos');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `medicamentos`
--

CREATE TABLE `medicamentos` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `stock` int(11) DEFAULT NULL,
  `precio` decimal(10,2) DEFAULT NULL,
  `idCategoria` int(11) DEFAULT NULL,
  `fecha_vencimiento` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `medicamentos`
--

INSERT INTO `medicamentos` (`id`, `nombre`, `descripcion`, `stock`, `precio`, `idCategoria`, `fecha_vencimiento`) VALUES
(2, 'ada', 'adad', 90, 5.80, 1, '2025-09-10'),
(4, 'Ibuprofeno', 'Antiinflamatorio y analgésico', 70, 8.25, 3, '2025-11-30'),
(5, 'Vitamina C', 'Suplemento vitamínico', 200, 15.00, 4, '2027-01-15'),
(6, 'Fluoxetina', 'Antidepresivo', 30, 20.00, 5, '2026-08-20'),
(7, 'Loratadina', 'Antihistamínico', 80, 7.10, 6, '2027-03-05'),
(8, 'Clotrimazol', 'Antifúngico tópico', 40, 9.50, 7, '2025-09-10'),
(9, 'Paracetamol 500mg', 'Antipirético', 120, 6.00, 8, '2026-10-12'),
(10, 'Salbutamol', 'Broncodilatador inhalado', 60, 18.75, 9, '2026-07-25'),
(11, 'Metformina', 'Tratamiento para diabetes tipo 2', 90, 22.40, 10, '2027-04-30'),
(23, 'hg', 'asdsadqwe', 23, 213.00, 1, '2025-09-10'),
(123, 'fijas gay', 'asdasd', 12, 23.00, 1, '2025-09-10');

--
-- Disparadores `medicamentos`
--
DELIMITER $$
CREATE TRIGGER `trg_delete_medicamento` AFTER DELETE ON `medicamentos` FOR EACH ROW BEGIN
    INSERT INTO movimientos (
        operacion, id_medicamento, nombre, descripcion, stock,
        precio, idCategoria, fecha_vencimiento
    )
    VALUES (
        'DELETE', OLD.id, OLD.nombre, OLD.descripcion, OLD.stock,
        OLD.precio, OLD.idCategoria, OLD.fecha_vencimiento
    );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_insert_medicamento` AFTER INSERT ON `medicamentos` FOR EACH ROW BEGIN
    INSERT INTO movimientos (
        operacion, id_medicamento, nombre, descripcion, stock,
        precio, idCategoria, fecha_vencimiento
    )
    VALUES (
        'INSERT', NEW.id, NEW.nombre, NEW.descripcion, NEW.stock,
        NEW.precio, NEW.idCategoria, NEW.fecha_vencimiento
    );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_update_medicamento` AFTER UPDATE ON `medicamentos` FOR EACH ROW BEGIN
    INSERT INTO movimientos (
        operacion, id_medicamento, nombre, descripcion, stock,
        precio, idCategoria, fecha_vencimiento
    )
    VALUES (
        'UPDATE', NEW.id, NEW.nombre, NEW.descripcion, NEW.stock,
        NEW.precio, NEW.idCategoria, NEW.fecha_vencimiento
    );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `medicos`
--

CREATE TABLE `medicos` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `especialidad` varchar(100) DEFAULT NULL,
  `dni` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `medicos`
--

INSERT INTO `medicos` (`id`, `nombre`, `especialidad`, `dni`) VALUES
(1, 'Dr. Juan Pérez', 'Cardiología', '12345678'),
(2, 'Dr. Juan Pérez', 'Cardiología', '12345678A'),
(3, 'Dra. Ana Gómez', 'Pediatría', '23456789B'),
(4, 'Dr. Luis Martínez', 'Neurología', '34567890C'),
(5, 'Dra. María Ruiz', 'Dermatología', '45678901D'),
(6, 'Dr. Carlos Díaz', 'Psiquiatría', '56789012E'),
(7, 'Dra. Laura Sánchez', 'Ginecología', '67890123F'),
(8, 'Dr. Pedro López', 'Endocrinología', '78901234G'),
(9, 'Dra. Isabel Torres', 'Oftalmología', '89012345H'),
(10, 'Dr. Miguel Fernández', 'Traumatología', '90123456I'),
(11, 'Dra. Carmen Morales', 'Medicina General', '01234567J');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `movimientos`
--

CREATE TABLE `movimientos` (
  `id` int(11) NOT NULL,
  `operacion` varchar(10) DEFAULT NULL,
  `id_medicamento` int(11) DEFAULT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `stock` int(11) DEFAULT NULL,
  `precio` decimal(10,2) DEFAULT NULL,
  `idCategoria` int(11) DEFAULT NULL,
  `fecha_vencimiento` date DEFAULT NULL,
  `fecha_operacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `movimientos`
--

INSERT INTO `movimientos` (`id`, `operacion`, `id_medicamento`, `nombre`, `descripcion`, `stock`, `precio`, `idCategoria`, `fecha_vencimiento`, `fecha_operacion`) VALUES
(1, 'INSERT', 1, 'Paracetamol', 'Para el dolor y fiebre', 100, 5.50, 1, '2026-12-31', '2025-06-02 08:47:32'),
(2, 'UPDATE', 1, 'Paracetamol', 'Para el dolor y fiebre', 90, 5.50, 1, '2026-12-31', '2025-06-02 08:47:45'),
(3, 'DELETE', 1, 'Paracetamol', 'Para el dolor y fiebre', 90, 5.50, 1, '2026-12-31', '2025-06-02 08:47:45'),
(4, 'INSERT', 2, 'Paracetamol', 'Analgésico común', 100, 5.50, 1, '2026-12-31', '2025-06-02 08:49:35'),
(5, 'INSERT', 3, 'Amoxicilina', 'Antibiótico de amplio espectro', 50, 12.30, 2, '2026-06-30', '2025-06-02 08:49:35'),
(6, 'INSERT', 4, 'Ibuprofeno', 'Antiinflamatorio y analgésico', 70, 8.25, 3, '2025-11-30', '2025-06-02 08:49:35'),
(7, 'INSERT', 5, 'Vitamina C', 'Suplemento vitamínico', 200, 15.00, 4, '2027-01-15', '2025-06-02 08:49:35'),
(8, 'INSERT', 6, 'Fluoxetina', 'Antidepresivo', 30, 20.00, 5, '2026-08-20', '2025-06-02 08:49:35'),
(9, 'INSERT', 7, 'Loratadina', 'Antihistamínico', 80, 7.10, 6, '2027-03-05', '2025-06-02 08:49:35'),
(10, 'INSERT', 8, 'Clotrimazol', 'Antifúngico tópico', 40, 9.50, 7, '2025-09-10', '2025-06-02 08:49:35'),
(11, 'INSERT', 9, 'Paracetamol 500mg', 'Antipirético', 120, 6.00, 8, '2026-10-12', '2025-06-02 08:49:35'),
(12, 'INSERT', 10, 'Salbutamol', 'Broncodilatador inhalado', 60, 18.75, 9, '2026-07-25', '2025-06-02 08:49:35'),
(13, 'INSERT', 11, 'Metformina', 'Tratamiento para diabetes tipo 2', 90, 22.40, 10, '2027-04-30', '2025-06-02 08:49:35'),
(14, 'DELETE', 3, 'Amoxicilina', 'Antibiótico de amplio espectro', 50, 12.30, 2, '2026-06-30', '2025-06-02 09:00:02'),
(15, 'UPDATE', 2, 'ada', 'adad', 90, 5.80, 1, '2025-09-10', '2025-06-02 09:00:36'),
(16, 'INSERT', 23, 'hg', 'asdas', 23, 213.00, 1, '2025-09-10', '2025-06-02 09:27:39'),
(17, 'DELETE', 23, 'hg', 'asdas', 23, 213.00, 1, '2025-09-10', '2025-06-02 09:27:46'),
(18, 'INSERT', 23, 'hg', 'asdas', 23, 213.00, 1, '2025-09-10', '2025-06-02 09:27:50'),
(19, 'UPDATE', 23, 'hg', 'asdsadqwe', 23, 213.00, 1, '2025-09-10', '2025-06-02 09:27:54'),
(20, 'INSERT', 123, 'fijas gay', 'asdasd', 12, 23.00, 1, '2025-09-10', '2025-06-02 09:45:13'),
(21, 'UPDATE', 123, 'fijas gay', 'asdasd', 12, 23.00, 1, '2025-09-10', '2025-06-02 09:45:15');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `paciente`
--

CREATE TABLE `paciente` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `apellido` varchar(100) DEFAULT NULL,
  `dni` varchar(20) DEFAULT NULL,
  `direccion` varchar(200) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `paciente`
--

INSERT INTO `paciente` (`id`, `nombre`, `apellido`, `dni`, `direccion`, `telefono`, `correo`) VALUES
(1, 'María', 'López', '98765432', 'Calle Falsa 123', '555-1234', 'maria@correo.com'),
(2, 'María', 'López', '98765432A', 'Calle Falsa 123', '555-1234', 'maria@example.com'),
(3, 'José', 'Martínez', '87654321B', 'Av. Siempre Viva 742', '555-5678', 'jose@example.com'),
(4, 'Lucía', 'García', '76543210C', 'Calle Luna 45', '555-8765', 'lucia@example.com'),
(5, 'Carlos', 'Rodríguez', '65432109D', 'Av. Sol 12', '555-4321', 'carlos@example.com'),
(6, 'Ana', 'Fernández', '54321098E', 'Calle Estrella 78', '555-6789', 'ana@example.com'),
(7, 'Miguel', 'Gómez', '43210987F', 'Av. Mar 33', '555-9876', 'miguel@example.com'),
(8, 'Laura', 'Vargas', '32109876G', 'Calle Nube 5', '555-3456', 'laura@example.com'),
(9, 'Pedro', 'Castillo', '21098765H', 'Av. Río 99', '555-6543', 'pedro@example.com'),
(10, 'Isabel', 'Mendoza', '10987654I', 'Calle Campo 23', '555-7890', 'isabel@example.com'),
(11, 'Sofía', 'Ramírez', '09876543J', 'Av. Bosque 44', '555-0987', 'sofia@example.com'),
(13, 'rodrigo', 'especial', '7788', 'asdas', '777888999', 'asdad@gmialñ.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `receta`
--

CREATE TABLE `receta` (
  `id` int(11) NOT NULL,
  `idPaciente` int(11) DEFAULT NULL,
  `idMedico` int(11) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `indicaciones` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `receta`
--

INSERT INTO `receta` (`id`, `idPaciente`, `idMedico`, `fecha`, `indicaciones`) VALUES
(1, 1, 1, '2025-06-02', 'Tomar 1 cada 8 horas'),
(2, 1, 1, '2025-05-01', 'Tomar 1 cada 8 horas'),
(3, 2, 2, '2025-05-02', 'Aplicar en la piel 2 veces al día'),
(4, 3, 3, '2025-05-03', 'Tomar antes de dormir'),
(5, 4, 4, '2025-05-04', 'Dosis única por la mañana'),
(6, 5, 5, '2025-05-05', 'Tomar después de las comidas'),
(7, 6, 6, '2025-05-06', 'Aplicar gotas 3 veces al día'),
(8, 7, 7, '2025-05-07', 'Tomar con agua'),
(9, 8, 8, '2025-05-08', 'Evitar exposición al sol'),
(10, 9, 9, '2025-05-09', 'Dosis dividida en dos'),
(11, 10, 10, '2025-05-10', 'Tomar en ayunas');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `medicamentos`
--
ALTER TABLE `medicamentos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idCategoria` (`idCategoria`);

--
-- Indices de la tabla `medicos`
--
ALTER TABLE `medicos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `movimientos`
--
ALTER TABLE `movimientos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `paciente`
--
ALTER TABLE `paciente`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `receta`
--
ALTER TABLE `receta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idPaciente` (`idPaciente`),
  ADD KEY `idMedico` (`idMedico`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `medicamentos`
--
ALTER TABLE `medicamentos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=124;

--
-- AUTO_INCREMENT de la tabla `medicos`
--
ALTER TABLE `medicos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `movimientos`
--
ALTER TABLE `movimientos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de la tabla `paciente`
--
ALTER TABLE `paciente`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `receta`
--
ALTER TABLE `receta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `medicamentos`
--
ALTER TABLE `medicamentos`
  ADD CONSTRAINT `medicamentos_ibfk_1` FOREIGN KEY (`idCategoria`) REFERENCES `categoria` (`id`);

--
-- Filtros para la tabla `receta`
--
ALTER TABLE `receta`
  ADD CONSTRAINT `receta_ibfk_1` FOREIGN KEY (`idPaciente`) REFERENCES `paciente` (`id`),
  ADD CONSTRAINT `receta_ibfk_2` FOREIGN KEY (`idMedico`) REFERENCES `medicos` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
