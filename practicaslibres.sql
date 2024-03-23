-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 12, 2024 at 03:00 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.1.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `practicaslibres`
--
CREATE DATABASE IF NOT EXISTS `practicaslibres` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `practicaslibres`;

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_BuscarEstudiante` (IN `p_Carnet` VARCHAR(20))   BEGIN
    SET p_Carnet = REPLACE(p_Carnet, '-', '');
    
    SELECT *
    FROM Estudiantes
    WHERE REPLACE(Carnet, '-', '') = p_Carnet OR Carnet = p_Carnet;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_BuscarUsuario` (IN `IdUsuario` INT, IN `Nombres` VARCHAR(255), IN `Apellidos` VARCHAR(255), IN `Email` VARCHAR(255), IN `Estado` BIT, IN `IdPrivilegio` INT, IN `NoLaboratorio` INT)   BEGIN
    IF (IdUsuario > 0) THEN
        SELECT *
        FROM Usuarios
        WHERE Id_Usuario = IdUsuario;
    ELSEIF (LENGTH(Nombres) > 0) THEN
        SELECT *
        FROM Usuarios
        WHERE Nombres LIKE CONCAT('%', Nombres, '%');
    ELSEIF (LENGTH(Apellidos) > 0) THEN
        SELECT *
        FROM Usuarios
        WHERE Apellidos LIKE CONCAT('%', Apellidos, '%');
    ELSEIF (LENGTH(Email) > 0) THEN
        SELECT *
        FROM Usuarios
        WHERE Email = Email;
    ELSEIF (IdPrivilegio > 0) THEN
        SELECT *
        FROM Usuarios
        WHERE id_Privilegio = IdPrivilegio;
    ELSEIF (NoLaboratorio > 0) THEN
        SELECT *
        FROM Usuarios
        WHERE No_Laboratorio = NoLaboratorio;
    ELSE
        SELECT *
        FROM Usuarios
        WHERE Estado = Estado;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_InsertarLaboratorio` (IN `No_Laboratorio` INT, IN `No_pc` INT, IN `Descripcion` VARCHAR(255), IN `Programas` VARCHAR(255))   BEGIN
    INSERT INTO Laboratorios (No_Laboratorio, No_pc, Descripcion, Programas)
    VALUES (No_Laboratorio, No_pc, Descripcion, Programas);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_InsertarTiempoEstudiantes` (IN `Observacion` VARCHAR(255), IN `No_Laboratorio` INT, IN `No_pc` INT, IN `Carnet` VARCHAR(20))   BEGIN
    INSERT INTO RegistroTiempoEstudiantes (Observacion, No_Laboratorio, No_pc, Carnet)
    VALUES (Observacion, No_Laboratorio, No_pc, Carnet);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_InsertarUsuario` (IN `Nombres` VARCHAR(255), IN `Apellidos` VARCHAR(255), IN `Email` VARCHAR(255), IN `Password` VARCHAR(255), IN `Telefono` VARCHAR(20), IN `Estado` BIT, IN `id_Privilegio` INT, IN `No_Laboratorio` INT)   BEGIN
    INSERT INTO usuarios (Nombres, Apellidos, Email, Password, Telefono, Estado, id_Privilegio, No_Laboratorio)
    VALUES (Nombres, Apellidos, Email, AES_ENCRYPT(Password, 'Ut3c'), Telefono, Estado, id_Privilegio, No_Laboratorio);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Laboratorios` ()   BEGIN
    SELECT * FROM Laboratorios;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ModificarLaboratorio` (IN `Nuevo_No_Laboratorio` INT, IN `No_pc` INT, IN `Descripcion` VARCHAR(255), IN `Programas` VARCHAR(255))   BEGIN
    UPDATE Laboratorios
    SET No_Laboratorio = Nuevo_No_Laboratorio,
        No_pc = No_pc,
        Descripcion = Descripcion,
        Programas = Programas
    WHERE No_Laboratorio = Nuevo_No_Laboratorio; -- Cambié la referencia al campo No_Laboratorio
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ModificarUsuario` (IN `Nuevo_Id_Usuario` INT, IN `Nombres` VARCHAR(255), IN `Apellidos` VARCHAR(255), IN `Email` VARCHAR(255), IN `Password` VARCHAR(255), IN `Telefono` VARCHAR(20), IN `Estado` BIT, IN `id_Privilegio` INT, IN `No_Laboratorio` INT)   BEGIN
    UPDATE Usuarios
    SET
        Nombres = Nombres,
        Apellidos = Apellidos,
        Email = Email,
        Password = AES_ENCRYPT(Password, 'Ut3c'),
        Telefono = Telefono,
        Estado = Estado,
        id_Privilegio = id_Privilegio,
        No_Laboratorio = No_Laboratorio
    WHERE Id_Usuario = Nuevo_Id_Usuario; -- Cambié la referencia al campo Id_Usuario
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Usuarios` ()   BEGIN
    SELECT * FROM Usuarios;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ValidarUsuario` (IN `p_Email` VARCHAR(255), IN `p_Password` VARCHAR(255))   BEGIN
    DECLARE decrypted_password VARCHAR(255);
    DECLARE patron VARCHAR(255);

    -- Asignar el patrón fijo
    SET patron = 'Ut3c';

    -- Resto del procedimiento almacenado
    SELECT *
    FROM Usuarios
    WHERE Email = p_Email AND CONVERT(AES_DECRYPT(Password, patron) USING utf8) = p_Password;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `estudiantes`
--

CREATE TABLE `estudiantes` (
  `Carnet` varchar(20) NOT NULL,
  `Nombres` varchar(255) NOT NULL,
  `Apellidos` varchar(255) NOT NULL,
  `Carrera` varchar(255) NOT NULL,
  `Facultad` varchar(255) NOT NULL,
  `Telefono` varchar(20) NOT NULL,
  `Email` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `estudiantes`
--

INSERT INTO `estudiantes` (`Carnet`, `Nombres`, `Apellidos`, `Carrera`, `Facultad`, `Telefono`, `Email`) VALUES
('27-1770-2022', 'Cristian Martinez', 'Echeverria', 'Tecnico informatica', 'Ciencias Aplicadas', '79979583', 'cm34@gmail.com'),
('27-8080-00', 'Rosauro Marvin', 'Morales quintanilla', 'Tecnico Software', 'Ciencias Aplicadas', '6179-9000', 'Marvin@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `laboratorios`
--

CREATE TABLE `laboratorios` (
  `No_Laboratorio` int(11) NOT NULL,
  `No_pc` int(11) NOT NULL,
  `Descripcion` varchar(255) NOT NULL,
  `Programas` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `laboratorios`
--

INSERT INTO `laboratorios` (`No_Laboratorio`, `No_pc`, `Descripcion`, `Programas`) VALUES
(1, 56, '56', '56'),
(2, 10, '.', '.'),
(3, 67, '67', '67'),
(4, 40, 'si', 'si');

-- --------------------------------------------------------

--
-- Table structure for table `privilegios`
--

CREATE TABLE `privilegios` (
  `id_Privilegio` int(11) NOT NULL,
  `Privilegio` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `privilegios`
--

INSERT INTO `privilegios` (`id_Privilegio`, `Privilegio`) VALUES
(1, 'Administrador');

-- --------------------------------------------------------

--
-- Table structure for table `registrotiempoestudiantes`
--

CREATE TABLE `registrotiempoestudiantes` (
  `IdRegistro` int(11) NOT NULL,
  `FechaHora` datetime NOT NULL DEFAULT current_timestamp(),
  `Tiempo` time NOT NULL,
  `Observacion` varchar(255) DEFAULT NULL,
  `No_Laboratorio` int(11) DEFAULT NULL,
  `No_pc` int(11) DEFAULT NULL,
  `Carnet` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `registrotiempoestudiantes`
--

INSERT INTO `registrotiempoestudiantes` (`IdRegistro`, `FechaHora`, `Tiempo`, `Observacion`, `No_Laboratorio`, `No_pc`, `Carnet`) VALUES
(1, '2024-03-11 19:39:12', '00:20:00', 'Estudiante uso solo Word', 1, 1, '27-1770-2022'),
(2, '2024-03-11 19:39:53', '00:20:00', 'Estudiante uso mysql', 2, 2, '27-8080-00');

-- --------------------------------------------------------

--
-- Table structure for table `usuarios`
--

CREATE TABLE `usuarios` (
  `Id_Usuario` int(11) NOT NULL,
  `Nombres` varchar(255) NOT NULL,
  `Apellidos` varchar(255) NOT NULL,
  `Email` varchar(255) NOT NULL,
  `Password` varbinary(255) NOT NULL,
  `Telefono` varchar(20) DEFAULT NULL,
  `Estado` bit(1) DEFAULT NULL,
  `id_Privilegio` int(11) DEFAULT NULL,
  `No_Laboratorio` int(11) DEFAULT NULL,
  `fecha` date DEFAULT curdate()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `usuarios`
--

INSERT INTO `usuarios` (`Id_Usuario`, `Nombres`, `Apellidos`, `Email`, `Password`, `Telefono`, `Estado`, `id_Privilegio`, `No_Laboratorio`, `fecha`) VALUES
(1, 'Cristian', 'Martinez', 'Cristian@gmail.com', 0x4947af3ac44b50156edbe309b72d4d36, '1234667756', b'1', 1, 1, '2024-03-01'),
(9, 'zxcfsd', 'zxzxc', '', 0xc8d059b08e6df9230729356880e46007, '', b'1', 1, 1, '2024-03-02'),
(10, 'Rafa', 'Rafa', 'Rafa@gmail.com', 0x4947af3ac44b50156edbe309b72d4d36, '124234534', b'1', 1, 3, '2024-03-02'),
(11, 'prueba', 'prueba', 'prueba@gmail.com', 0x4947af3ac44b50156edbe309b72d4d36, '123', b'1', 1, 4, '2024-03-02');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `estudiantes`
--
ALTER TABLE `estudiantes`
  ADD PRIMARY KEY (`Carnet`);

--
-- Indexes for table `laboratorios`
--
ALTER TABLE `laboratorios`
  ADD PRIMARY KEY (`No_Laboratorio`);

--
-- Indexes for table `privilegios`
--
ALTER TABLE `privilegios`
  ADD PRIMARY KEY (`id_Privilegio`);

--
-- Indexes for table `registrotiempoestudiantes`
--
ALTER TABLE `registrotiempoestudiantes`
  ADD PRIMARY KEY (`IdRegistro`),
  ADD KEY `No_Laboratorio` (`No_Laboratorio`),
  ADD KEY `Carnet` (`Carnet`);

--
-- Indexes for table `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`Id_Usuario`),
  ADD KEY `FK_id_Privilegio` (`id_Privilegio`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `privilegios`
--
ALTER TABLE `privilegios`
  MODIFY `id_Privilegio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `registrotiempoestudiantes`
--
ALTER TABLE `registrotiempoestudiantes`
  MODIFY `IdRegistro` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `Id_Usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `registrotiempoestudiantes`
--
ALTER TABLE `registrotiempoestudiantes`
  ADD CONSTRAINT `registrotiempoestudiantes_ibfk_1` FOREIGN KEY (`No_Laboratorio`) REFERENCES `laboratorios` (`No_Laboratorio`),
  ADD CONSTRAINT `registrotiempoestudiantes_ibfk_2` FOREIGN KEY (`Carnet`) REFERENCES `estudiantes` (`Carnet`);

--
-- Constraints for table `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `FK_id_Privilegio` FOREIGN KEY (`id_Privilegio`) REFERENCES `privilegios` (`id_Privilegio`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
