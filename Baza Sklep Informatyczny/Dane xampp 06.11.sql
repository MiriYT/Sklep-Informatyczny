-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Lis 06, 2025 at 01:14 PM
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

--
-- Dumping data for table `klienci`
--

INSERT INTO `klienci` (`idklienta`, `imie`, `nazwisko`, `telefon`) VALUES
(1, 'Jan', 'Kowalski', '123456789'),
(2, 'Anna', 'Nowak', '987654321'),
(3, 'Piotr', 'Zielinski', '456789123'),
(4, 'Maria', 'Wiśniewska', '321654987'),
(5, 'Tomasz', 'Szymański', '741258963'),
(6, 'Karolina', 'Lewandowska', '852963741'),
(7, 'Marek', 'Kamiński', '369258147');

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `klienci_ktorzy_dali_ocene_5`
-- (See below for the actual view)
--
CREATE TABLE `klienci_ktorzy_dali_ocene_5` (
`idklienta` int(11)
,`imie` varchar(25)
,`nazwisko` varchar(25)
,`telefon` varchar(25)
,`nazwa` varchar(100)
,`cena` float
,`komentarz` varchar(255)
);

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

--
-- Dumping data for table `pracownicy`
--

INSERT INTO `pracownicy` (`idpracownika`, `imie`, `nazwisko`, `specjalizacja`, `login`) VALUES
(1, 'Piotr', 'Wiśniewski', 'telefony', 'p.wisniewski'),
(2, 'Katarzyna', 'Zalewska', 'komputery', 'k.zalewska'),
(3, 'Marek', 'Nowakowski', 'rtv', 'm.nowakowski'),
(4, 'Adam', 'Szczepan', 'konsole', 'a.szczepan'),
(5, 'Ewa', 'Stolarz', 'telefony', 'e.stolarz'),
(6, 'Tomasz', 'Kowalczyk', 'komputery', 't.kowalczyk'),
(7, 'Barbara', 'Wójcik', 'rtv', 'b.wojcik');

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `pracownik_od_komputerow`
-- (See below for the actual view)
--
CREATE TABLE `pracownik_od_komputerow` (
`idpracownika` int(11)
,`imie` varchar(25)
,`nazwisko` varchar(25)
,`nazwa_produktu` varchar(255)
);

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

--
-- Dumping data for table `produkty`
--

INSERT INTO `produkty` (`idproduktu`, `nazwa`, `rok_produkcji`, `cena`, `dostepnosc`) VALUES
(1, 'iPhone 13', '2021', 4999.99, 'dostępne'),
(2, 'Dell XPS 13', '2022', 5499, 'dostępne'),
(3, 'Samsung QLED TV', '2023', 3499.99, 'dostępne'),
(4, 'PS5', '2021', 2499, 'dostępne'),
(5, 'Samsung Galaxy S21', '2021', 3799.99, 'dostępne'),
(6, 'Lenovo ThinkPad', '2023', 4999, 'dostępne'),
(7, 'LG OLED TV', '2023', 4999.99, 'niedostępne');

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

--
-- Dumping data for table `recenzje`
--

INSERT INTO `recenzje` (`idklienta`, `idproduktu`, `ocena`, `komentarz`) VALUES
(1, 1, '5', 'Świetny telefon, bardzo szybki!'),
(2, 2, '4', 'Bardzo dobra jakość, ale mógłby być tańszy'),
(3, 3, '5', 'Fantastyczny obraz, uwielbiam ten telewizor!'),
(4, 4, '3', 'Działa dobrze, ale trochę za głośno w trybie gamingowym'),
(5, 5, '5', 'Bardzo zadowolony, szybki i niezawodny!'),
(6, 6, '4', 'Dobry laptop, ale ma mało portów USB'),
(7, 7, '5', 'Jakość obrazu jest niesamowita, polecam!');

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

--
-- Dumping data for table `serwis`
--

INSERT INTO `serwis` (`idpracownika`, `idproduktu`, `nazwa_produktu`, `rozpoczecie`, `zakonczenie`, `kwota_brutto_PLN`) VALUES
(1, 1, 'iPhone 13', '2025-10-01', '2025-10-05', 150),
(2, 2, 'Dell XPS 13', '2025-10-02', '2025-10-06', 200),
(3, 3, 'Samsung QLED TV', '2025-10-03', '2025-10-07', 300),
(4, 4, 'PS5', '2025-10-04', '2025-10-08', 100),
(5, 5, 'Samsung Galaxy S21', '2025-10-05', '2025-10-09', 120),
(6, 6, 'Lenovo ThinkPad', '2025-10-06', '2025-10-10', 250),
(7, 7, 'LG OLED TV', '2025-10-07', '2025-10-11', 400);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `slabe_opinie`
-- (See below for the actual view)
--
CREATE TABLE `slabe_opinie` (
`idklienta` int(11)
,`idproduktu` int(11)
,`ocena` char(1)
,`komentarz` varchar(255)
);

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
-- Dumping data for table `zamowienia`
--

INSERT INTO `zamowienia` (`idzamowienia`, `idklienta`, `idproduktu`, `data_zamowienia`) VALUES
(1, 1, 1, '2025-11-01'),
(2, 2, 2, '2025-11-02'),
(3, 3, 3, '2025-11-03'),
(4, 4, 4, '2025-11-04'),
(5, 5, 5, '2025-11-05'),
(6, 6, 6, '2025-11-06'),
(7, 7, 7, '2025-11-07');

-- --------------------------------------------------------

--
-- Struktura widoku `klienci_ktorzy_dali_ocene_5`
--
DROP TABLE IF EXISTS `klienci_ktorzy_dali_ocene_5`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `klienci_ktorzy_dali_ocene_5`  AS SELECT `klienci`.`idklienta` AS `idklienta`, `klienci`.`imie` AS `imie`, `klienci`.`nazwisko` AS `nazwisko`, `klienci`.`telefon` AS `telefon`, `produkty`.`nazwa` AS `nazwa`, `produkty`.`cena` AS `cena`, `recenzje`.`komentarz` AS `komentarz` FROM ((`klienci` join `produkty`) join `recenzje`) WHERE `recenzje`.`ocena` = '5' AND `klienci`.`idklienta` = `recenzje`.`idklienta` AND `produkty`.`idproduktu` = `recenzje`.`idproduktu` ;

-- --------------------------------------------------------

--
-- Struktura widoku `pracownik_od_komputerow`
--
DROP TABLE IF EXISTS `pracownik_od_komputerow`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `pracownik_od_komputerow`  AS SELECT `pracownicy`.`idpracownika` AS `idpracownika`, `pracownicy`.`imie` AS `imie`, `pracownicy`.`nazwisko` AS `nazwisko`, `serwis`.`nazwa_produktu` AS `nazwa_produktu` FROM (`serwis` join `pracownicy`) WHERE `pracownicy`.`specjalizacja` like 'komputery' AND `pracownicy`.`idpracownika` = `serwis`.`idpracownika` ;

-- --------------------------------------------------------

--
-- Struktura widoku `slabe_opinie`
--
DROP TABLE IF EXISTS `slabe_opinie`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `slabe_opinie`  AS SELECT `recenzje`.`idklienta` AS `idklienta`, `recenzje`.`idproduktu` AS `idproduktu`, `recenzje`.`ocena` AS `ocena`, `recenzje`.`komentarz` AS `komentarz` FROM `recenzje` WHERE `recenzje`.`ocena` <= 3 ;

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

--
-- Constraints for dumped tables
--

--
-- Constraints for table `recenzje`
--
ALTER TABLE `recenzje`
  ADD CONSTRAINT `recenzje_ibfk_1` FOREIGN KEY (`idklienta`) REFERENCES `klienci` (`idklienta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `recenzje_ibfk_2` FOREIGN KEY (`idproduktu`) REFERENCES `produkty` (`idproduktu`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `serwis`
--
ALTER TABLE `serwis`
  ADD CONSTRAINT `serwis_ibfk_1` FOREIGN KEY (`idpracownika`) REFERENCES `pracownicy` (`idpracownika`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `serwis_ibfk_2` FOREIGN KEY (`idproduktu`) REFERENCES `produkty` (`idproduktu`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `zamowienia`
--
ALTER TABLE `zamowienia`
  ADD CONSTRAINT `zamowienia_ibfk_1` FOREIGN KEY (`idklienta`) REFERENCES `klienci` (`idklienta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `zamowienia_ibfk_2` FOREIGN KEY (`idproduktu`) REFERENCES `produkty` (`idproduktu`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
