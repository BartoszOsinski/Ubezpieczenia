-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Czas generowania: 31 Maj 2022, 00:36
-- Wersja serwera: 10.4.22-MariaDB
-- Wersja PHP: 8.1.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Baza danych: `ubezpieczenia`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `katalog_user_role`
--

CREATE TABLE `katalog_user_role` (
  `Id_Osoby_Role` int(11) NOT NULL,
  `Id_Roli` int(11) NOT NULL,
  `Id_Osoby` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `logs`
--

CREATE TABLE `logs` (
  `logs` int(11) NOT NULL,
  `Id_Osoby` int(11) NOT NULL,
  `Akcja` varchar(20) COLLATE utf8mb4_polish_ci NOT NULL,
  `Data_Akcji` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

--
-- Zrzut danych tabeli `logs`
--

INSERT INTO `logs` (`logs`, `Id_Osoby`, `Akcja`, `Data_Akcji`) VALUES
(16, 8, 'Utworzono', '2022-05-30'),
(17, 8, 'Utworzono', '2022-05-30'),
(18, 9, 'Utworzono', '2022-05-30'),
(19, 9, 'Utworzono', '2022-05-30'),
(20, 10, 'Utworzono', '2022-05-30');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `polisy`
--

CREATE TABLE `polisy` (
  `Id_Polisy` int(11) NOT NULL,
  `Id_Klienta` int(11) NOT NULL,
  `Id_Agenta` int(11) NOT NULL,
  `Id_Samochodu` int(11) NOT NULL,
  `Liczba_Szkód_W_3_Ostatnich_Latach` int(11) NOT NULL,
  `Prawo_Jazdy_Dluzej_Niz_3_Lata` tinyint(1) NOT NULL,
  `Data_Początku_Ubezpieczenia` date NOT NULL,
  `Data_Końca_Ubezpieczenia` date NOT NULL,
  `OC` tinyint(1) NOT NULL,
  `AC` tinyint(1) NOT NULL,
  `NNW` tinyint(1) NOT NULL,
  `Assistance` tinyint(1) NOT NULL,
  `Wartość_Pojazdu` int(11) NOT NULL,
  `Cena_Ubezpieczenia` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `role`
--

CREATE TABLE `role` (
  `Id_Roli` int(11) NOT NULL,
  `Nazwa_Roli` varchar(30) COLLATE utf8mb4_polish_ci NOT NULL,
  `Aktywny` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

--
-- Zrzut danych tabeli `role`
--

INSERT INTO `role` (`Id_Roli`, `Nazwa_Roli`, `Aktywny`) VALUES
(1, 'GUEST', 1),
(2, 'CLIENT', 1),
(3, 'AGENT', 1),
(4, 'ADMIN', 1);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `samochody`
--

CREATE TABLE `samochody` (
  `Id_Samochodu` int(11) NOT NULL,
  `Numer_Rejestracyjny` varchar(10) COLLATE utf8mb4_polish_ci NOT NULL,
  `VIN` varchar(20) COLLATE utf8mb4_polish_ci DEFAULT NULL,
  `Data_Pierwszej_Rejestracji` date NOT NULL,
  `Marka` varchar(30) COLLATE utf8mb4_polish_ci NOT NULL,
  `Model` varchar(30) COLLATE utf8mb4_polish_ci NOT NULL,
  `Rok_Produkcji` int(11) NOT NULL,
  `Przebieg` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `samochod_klient`
--

CREATE TABLE `samochod_klient` (
  `Id_Samochod_Klient` int(11) NOT NULL,
  `Id_Osoby` int(11) NOT NULL,
  `Id_Samochodu` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `user`
--

CREATE TABLE `user` (
  `Id_Osoby` int(11) NOT NULL,
  `Imię` varchar(30) COLLATE utf8mb4_polish_ci NOT NULL,
  `Nazwisko` varchar(30) COLLATE utf8mb4_polish_ci NOT NULL,
  `PESEL` varchar(11) COLLATE utf8mb4_polish_ci NOT NULL,
  `Login` varchar(30) COLLATE utf8mb4_polish_ci NOT NULL,
  `Hasło` varchar(30) COLLATE utf8mb4_polish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

--
-- Zrzut danych tabeli `user`
--

INSERT INTO `user` (`Id_Osoby`, `Imię`, `Nazwisko`, `PESEL`, `Login`, `Hasło`) VALUES
(10, 'Bartosz', 'Osiński', '00292805653', 'Floowil', 'Haslo');

--
-- Wyzwalacze `user`
--
DELIMITER $$
CREATE TRIGGER `deleteLog` BEFORE DELETE ON `user` FOR EACH ROW INSERT INTO logs VALUES(null, OLD.Id_Osoby, "Utworzono", NOW())
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `insertLog` AFTER INSERT ON `user` FOR EACH ROW INSERT INTO logs VALUES(null, NEW.Id_Osoby, "Utworzono", NOW())
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `updateLog` AFTER UPDATE ON `user` FOR EACH ROW INSERT INTO logs VALUES(null, NEW.Id_Osoby, "Zmieniono", NOW())
$$
DELIMITER ;

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `katalog_user_role`
--
ALTER TABLE `katalog_user_role`
  ADD PRIMARY KEY (`Id_Osoby_Role`),
  ADD KEY `Id_Osoby` (`Id_Osoby`),
  ADD KEY `Id_Roli` (`Id_Roli`);

--
-- Indeksy dla tabeli `logs`
--
ALTER TABLE `logs`
  ADD PRIMARY KEY (`logs`),
  ADD KEY `Id_Osoby` (`Id_Osoby`);

--
-- Indeksy dla tabeli `polisy`
--
ALTER TABLE `polisy`
  ADD PRIMARY KEY (`Id_Polisy`),
  ADD KEY `Id_Osoby` (`Id_Klienta`),
  ADD KEY `Id_Samochodu` (`Id_Samochodu`),
  ADD KEY `Id_Agenta` (`Id_Agenta`);

--
-- Indeksy dla tabeli `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`Id_Roli`);

--
-- Indeksy dla tabeli `samochody`
--
ALTER TABLE `samochody`
  ADD PRIMARY KEY (`Id_Samochodu`);

--
-- Indeksy dla tabeli `samochod_klient`
--
ALTER TABLE `samochod_klient`
  ADD PRIMARY KEY (`Id_Samochod_Klient`),
  ADD KEY `Id_Osoby` (`Id_Osoby`),
  ADD KEY `Id_Samochodu` (`Id_Samochodu`);

--
-- Indeksy dla tabeli `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`Id_Osoby`);

--
-- AUTO_INCREMENT dla zrzuconych tabel
--

--
-- AUTO_INCREMENT dla tabeli `katalog_user_role`
--
ALTER TABLE `katalog_user_role`
  MODIFY `Id_Osoby_Role` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `logs`
--
ALTER TABLE `logs`
  MODIFY `logs` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT dla tabeli `polisy`
--
ALTER TABLE `polisy`
  MODIFY `Id_Polisy` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `role`
--
ALTER TABLE `role`
  MODIFY `Id_Roli` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT dla tabeli `samochody`
--
ALTER TABLE `samochody`
  MODIFY `Id_Samochodu` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `samochod_klient`
--
ALTER TABLE `samochod_klient`
  MODIFY `Id_Samochod_Klient` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `user`
--
ALTER TABLE `user`
  MODIFY `Id_Osoby` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Ograniczenia dla zrzutów tabel
--

--
-- Ograniczenia dla tabeli `katalog_user_role`
--
ALTER TABLE `katalog_user_role`
  ADD CONSTRAINT `katalog_user_role_ibfk_1` FOREIGN KEY (`Id_Osoby`) REFERENCES `user` (`Id_Osoby`),
  ADD CONSTRAINT `katalog_user_role_ibfk_2` FOREIGN KEY (`Id_Roli`) REFERENCES `role` (`Id_Roli`);

--
-- Ograniczenia dla tabeli `polisy`
--
ALTER TABLE `polisy`
  ADD CONSTRAINT `polisy_ibfk_1` FOREIGN KEY (`Id_Klienta`) REFERENCES `user` (`Id_Osoby`),
  ADD CONSTRAINT `polisy_ibfk_2` FOREIGN KEY (`Id_Samochodu`) REFERENCES `samochody` (`Id_Samochodu`),
  ADD CONSTRAINT `polisy_ibfk_3` FOREIGN KEY (`Id_Agenta`) REFERENCES `user` (`Id_Osoby`);

--
-- Ograniczenia dla tabeli `samochod_klient`
--
ALTER TABLE `samochod_klient`
  ADD CONSTRAINT `samochod_klient_ibfk_1` FOREIGN KEY (`Id_Osoby`) REFERENCES `user` (`Id_Osoby`),
  ADD CONSTRAINT `samochod_klient_ibfk_2` FOREIGN KEY (`Id_Samochodu`) REFERENCES `samochody` (`Id_Samochodu`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
