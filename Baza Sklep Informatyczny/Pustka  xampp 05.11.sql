-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Lis 05, 2025 at 02:15 PM
-- Wersja serwera: 10.4.32-MariaDB
-- Wersja PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sklep_informatyczny`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `klienci`
--

CREATE TABLE `klienci` (
  `idklienta` int(11) NOT NULL,
  `imie` varchar(25) DEFAULT NULL,
  `nazwisko` varchar(25) DEFAULT NULL,
  `telefon` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `pracownicy`
--

CREATE TABLE `pracownicy` (
  `idpracownika` int(11) NOT NULL,
  `imie` varchar(25) DEFAULT NULL,
  `nazwisko` varchar(25) DEFAULT NULL,
  `specjalizacja` varchar(50) DEFAULT NULL,
  `login` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `produkty`
--

CREATE TABLE `produkty` (
  `idproduktu` int(11) NOT NULL,
  `nazwa` varchar(100) DEFAULT NULL,
  `rok_produkcji` char(4) DEFAULT NULL,
  `cena` float DEFAULT NULL,
  `dostepnosc` enum('dostępne','niedostępne') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `recenzje`
--

CREATE TABLE `recenzje` (
  `idklienta` int(11) DEFAULT NULL,
  `idproduktu` int(11) DEFAULT NULL,
  `ocena` char(1) DEFAULT NULL,
  `komentarz` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `serwis`
--

CREATE TABLE `serwis` (
  `idpracownika` int(11) DEFAULT NULL,
  `idproduktu` int(11) DEFAULT NULL,
  `nazwa_produktu` varchar(255) DEFAULT NULL,
  `rozpoczecie` date DEFAULT NULL,
  `zakonczenie` date DEFAULT NULL,
  `kwota_brutto_PLN` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `zamowienia`
--

CREATE TABLE `zamowienia` (
  `idzamowienia` int(11) NOT NULL,
  `idklienta` int(11) DEFAULT NULL,
  `idproduktu` int(11) DEFAULT NULL,
  `data_zamowienia` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `klienci`
--
ALTER TABLE `klienci`
  ADD PRIMARY KEY (`idklienta`);

--
-- Indeksy dla tabeli `pracownicy`
--
ALTER TABLE `pracownicy`
  ADD PRIMARY KEY (`idpracownika`);

--
-- Indeksy dla tabeli `produkty`
--
ALTER TABLE `produkty`
  ADD PRIMARY KEY (`idproduktu`);

--
-- Indeksy dla tabeli `recenzje`
--
ALTER TABLE `recenzje`
  ADD KEY `klienci_recenzje` (`idklienta`),
  ADD KEY `produkt_recenzja` (`idproduktu`);

--
-- Indeksy dla tabeli `serwis`
--
ALTER TABLE `serwis`
  ADD KEY `pracownik_serwis` (`idpracownika`),
  ADD KEY `produkt_serwis` (`idproduktu`);

--
-- Indeksy dla tabeli `zamowienia`
--
ALTER TABLE `zamowienia`
  ADD PRIMARY KEY (`idzamowienia`),
  ADD KEY `klienci_zamowienia` (`idklienta`),
  ADD KEY `produkt_zamowienia` (`idproduktu`);

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
