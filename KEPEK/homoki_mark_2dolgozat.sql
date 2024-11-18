-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2024. Nov 12. 12:26
-- Kiszolgáló verziója: 10.4.20-MariaDB
-- PHP verzió: 8.0.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `homoki_mark_2dolgozat`
--
CREATE DATABASE IF NOT EXISTS `homoki_mark_2dolgozat` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `homoki_mark_2dolgozat`;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `iskola`
--

CREATE TABLE `iskola` (
  `azonosító` int(11) NOT NULL,
  `név` varchar(50) DEFAULT NULL,
  `cím` varchar(100) DEFAULT NULL,
  `létszám` int(11) DEFAULT NULL,
  `tanulo_azonosito` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `osztály`
--

CREATE TABLE `osztály` (
  `azonosító` int(11) NOT NULL,
  `létszám` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `tanuló`
--

CREATE TABLE `tanuló` (
  `azonosító` int(11) NOT NULL,
  `név` varchar(50) DEFAULT NULL,
  `átlag` decimal(4,2) DEFAULT NULL,
  `születésiDátum` date DEFAULT NULL,
  `születésiHely` varchar(50) DEFAULT NULL,
  `nem` enum('férfi','nő') DEFAULT NULL,
  `osztaly_azonosito` int(11) NOT NULL,
  `tanulo_azonosito` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `tanár`
--

CREATE TABLE `tanár` (
  `szigSzám` int(11) NOT NULL,
  `név` varchar(50) DEFAULT NULL,
  `nem` enum('férfi','nő') DEFAULT NULL,
  `születésiDátum` date DEFAULT NULL,
  `fizetés` decimal(10,2) DEFAULT NULL,
  `osztaly_azonosito` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `tanít`
--

CREATE TABLE `tanít` (
  `tanárSzigSzám` int(11) NOT NULL,
  `iskolaAzonosító` int(11) NOT NULL,
  `kezdés` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `iskola`
--
ALTER TABLE `iskola`
  ADD PRIMARY KEY (`azonosító`),
  ADD KEY `tanulo_azonosito` (`tanulo_azonosito`);

--
-- A tábla indexei `osztály`
--
ALTER TABLE `osztály`
  ADD PRIMARY KEY (`azonosító`);

--
-- A tábla indexei `tanuló`
--
ALTER TABLE `tanuló`
  ADD PRIMARY KEY (`azonosító`),
  ADD KEY `osztaly_azonosito` (`osztaly_azonosito`),
  ADD KEY `tanulo_azonosito` (`tanulo_azonosito`);

--
-- A tábla indexei `tanár`
--
ALTER TABLE `tanár`
  ADD PRIMARY KEY (`szigSzám`),
  ADD KEY `osztaly_azonosito` (`osztaly_azonosito`);

--
-- A tábla indexei `tanít`
--
ALTER TABLE `tanít`
  ADD PRIMARY KEY (`tanárSzigSzám`,`iskolaAzonosító`),
  ADD KEY `iskolaAzonosító` (`iskolaAzonosító`);

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `osztály`
--
ALTER TABLE `osztály`
  ADD CONSTRAINT `osztály_ibfk_1` FOREIGN KEY (`azonosító`) REFERENCES `tanuló` (`osztaly_azonosito`);

--
-- Megkötések a táblához `tanuló`
--
ALTER TABLE `tanuló`
  ADD CONSTRAINT `tanuló_ibfk_1` FOREIGN KEY (`azonosító`) REFERENCES `iskola` (`tanulo_azonosito`);

--
-- Megkötések a táblához `tanár`
--
ALTER TABLE `tanár`
  ADD CONSTRAINT `tanár_ibfk_1` FOREIGN KEY (`osztaly_azonosito`) REFERENCES `osztály` (`azonosító`);

--
-- Megkötések a táblához `tanít`
--
ALTER TABLE `tanít`
  ADD CONSTRAINT `tanít_ibfk_1` FOREIGN KEY (`tanárSzigSzám`) REFERENCES `tanár` (`szigSzám`),
  ADD CONSTRAINT `tanít_ibfk_2` FOREIGN KEY (`iskolaAzonosító`) REFERENCES `iskola` (`azonosító`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;


ALTER TABLE tanuló
ADD CONSTRAINT átlag_pozitív CHECK (átlag >= 0);


ALTER TABLE tanuló
ADD CONSTRAINT születésiDátum_ellenőrzés_tanuló CHECK (születésiDátum >= '1900-01-01');

ALTER TABLE tanár
ADD CONSTRAINT születésiDátum_ellenőrzés_tanár CHECK (születésiDátum >= '1900-01-01');