-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Počítač: 127.0.0.1
-- Vytvořeno: Pon 04. led 2021, 12:43
-- Verze serveru: 10.4.17-MariaDB
-- Verze PHP: 8.0.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Databáze: `sql_strzelecki`
--

DELIMITER $$
--
-- Procedury
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `nova_objednavka` (IN `id_zakaznika_objednavky` INT, IN `datum_objednani_objednavky` DATE, IN `id_produktu_objednavky` INT, IN `mnozstvi_produktu` INT, IN `celkova_cena_objednavky` INT)  NO SQL
BEGIN
INSERT INTO objednavky(id_zakaznika, datum_objednani) VALUES (id_zakaznika_objednavky, datum_objednani_objednavky); INSERT INTO objednane_zbozi (id_produktu, mnozstvi, cena_celkem) VALUES (id_produktu_objednavky, mnozstvi_produktu, celkova_cena_objednavky);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `odebrat_zakaznika` (IN `id_zakaznika_na_smazani` INT, IN `krestni_jmeno_zakaznika` VARCHAR(45), IN `prijmeni_zakaznika` VARCHAR(45), IN `datum_narozeni_zakaznika` DATE)  NO SQL
BEGIN SET FOREIGN_KEY_CHECKS=0;DELETE FROM zakaznici WHERE id_zakaznika = id_zakaznika_na_smazani AND krestni_jmeno = krestni_jmeno_zakaznika AND prijmeni = prijmeni_zakaznika AND datum_narozeni = datum_narozeni_zakaznika;SET FOREIGN_KEY_CHECKS=1;END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pridat_zakaznika` (IN `krestni_jmeno` VARCHAR(45), IN `prijmeni` VARCHAR(45), IN `datum_narozeni` DATE, IN `email` VARCHAR(45), IN `adresa` VARCHAR(45), IN `mesto` VARCHAR(45))  NO SQL
BEGIN INSERT INTO zakaznici(krestni_jmeno, prijmeni, datum_narozeni, email, adresa, město) VALUES (krestni_jmeno, prijmeni, datum_narozeni, email, adresa, mesto); END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `uprav_mnozstvi_produktu` (IN `id_produktu_na_zmeneni` INT, IN `novy_pocet_skladem` INT)  NO SQL
BEGIN UPDATE produkty SET skladem = novy_pocet_skladem WHERE id_produktu = id_produktu_na_zmeneni; END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `uprav_stav_objednavky` (IN `id_objednavky_na_zmenu` INT, IN `novy_status_objednavky` INT, IN `odeslano` DATE, IN `id_dopravce` INT)  NO SQL
BEGIN UPDATE objednavky SET status_objednavky = novy_status_objednavky, odeslano = odeslano, id_dopravce = id_dopravce WHERE id_objednavky = id_objednavky_na_zmenu; END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Zástupná struktura pro pohled `dochazejici_produkty`
-- (Vlastní pohled viz níže)
--
CREATE TABLE `dochazejici_produkty` (
`id_produktu` int(11)
,`jmeno` varchar(45)
,`skladem` int(11)
);

-- --------------------------------------------------------

--
-- Struktura tabulky `dopravci`
--

CREATE TABLE `dopravci` (
  `id_dopravce` int(11) NOT NULL,
  `nazev` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Vypisuji data pro tabulku `dopravci`
--

INSERT INTO `dopravci` (`id_dopravce`, `nazev`) VALUES
(1, 'Česká pošta'),
(2, 'DHL Express'),
(3, 'UPS'),
(4, 'TNT Express'),
(5, 'DPD Group');

-- --------------------------------------------------------

--
-- Zástupná struktura pro pohled `dospeli_zakaznici`
-- (Vlastní pohled viz níže)
--
CREATE TABLE `dospeli_zakaznici` (
`id_zakaznika` int(11)
,`krestni_jmeno` varchar(45)
,`prijmeni` varchar(45)
,`datum_narozeni` date
,`email` varchar(45)
,`adresa` varchar(45)
,`město` varchar(45)
,`vek_zakaznika` int(8)
);

-- --------------------------------------------------------

--
-- Zástupná struktura pro pohled `mladi_zakaznici`
-- (Vlastní pohled viz níže)
--
CREATE TABLE `mladi_zakaznici` (
`id_zakaznika` int(11)
,`krestni_jmeno` varchar(45)
,`prijmeni` varchar(45)
,`datum_narozeni` date
,`email` varchar(45)
,`adresa` varchar(45)
,`město` varchar(45)
,`vek_zakaznika` int(8)
);

-- --------------------------------------------------------

--
-- Zástupná struktura pro pohled `nejdrazsi_objednavka`
-- (Vlastní pohled viz níže)
--
CREATE TABLE `nejdrazsi_objednavka` (
`id_objednavky` int(11)
,`krestni_jmeno` varchar(45)
,`prijmeni` varchar(45)
,`cena_objednávky` int(11)
,`Product` varchar(45)
);

-- --------------------------------------------------------

--
-- Zástupná struktura pro pohled `nejlevnejsi_objednavka`
-- (Vlastní pohled viz níže)
--
CREATE TABLE `nejlevnejsi_objednavka` (
`id_objednavky` int(11)
,`krestni_jmeno` varchar(45)
,`prijmeni` varchar(45)
,`Cena_objednávky` int(11)
,`Product` varchar(45)
);

-- --------------------------------------------------------

--
-- Struktura tabulky `objednane_zbozi`
--

CREATE TABLE `objednane_zbozi` (
  `id_objednavky` int(11) NOT NULL,
  `id_produktu` int(11) NOT NULL,
  `mnozstvi` int(11) NOT NULL,
  `cena_celkem` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Vypisuji data pro tabulku `objednane_zbozi`
--

INSERT INTO `objednane_zbozi` (`id_objednavky`, `id_produktu`, `mnozstvi`, `cena_celkem`) VALUES
(1, 7, 3, 447),
(2, 2, 2, 998),
(3, 4, 1, 299),
(4, 3, 1, 7999),
(5, 6, 4, 2396),
(6, 1, 2, 10998);

--
-- Spouště `objednane_zbozi`
--
DELIMITER $$
CREATE TRIGGER `upravit_skladem` AFTER INSERT ON `objednane_zbozi` FOR EACH ROW BEGIN UPDATE produkty SET produkty.skladem = produkty.skladem - NEW.mnozstvi WHERE produkty.id_produktu = NEW.id_produktu; END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktura tabulky `objednavky`
--

CREATE TABLE `objednavky` (
  `id_objednavky` int(11) NOT NULL,
  `id_zakaznika` int(11) NOT NULL,
  `datum_objednani` date NOT NULL,
  `status_objednavky` int(11) NOT NULL DEFAULT 1,
  `odeslano` date DEFAULT NULL,
  `id_dopravce` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Vypisuji data pro tabulku `objednavky`
--

INSERT INTO `objednavky` (`id_objednavky`, `id_zakaznika`, `datum_objednani`, `status_objednavky`, `odeslano`, `id_dopravce`) VALUES
(1, 2, '2019-05-05', 3, '2019-05-10', 4),
(2, 8, '2019-05-12', 4, '2019-05-13', 3),
(3, 5, '2019-10-10', 1, NULL, NULL),
(4, 3, '2019-12-18', 5, '2019-12-19', 5),
(5, 7, '2020-01-05', 4, '2020-01-07', 2),
(6, 1, '2020-02-15', 2, NULL, NULL);

-- --------------------------------------------------------

--
-- Zástupná struktura pro pohled `objednavky_k_odeslani`
-- (Vlastní pohled viz níže)
--
CREATE TABLE `objednavky_k_odeslani` (
`id_objednavky` int(11)
,`id_zakaznika` int(11)
,`datum_objednani` date
,`status_objednavky` int(11)
,`odeslano` date
,`id_dopravce` int(11)
);

-- --------------------------------------------------------

--
-- Zástupná struktura pro pohled `odeslane_objednavky`
-- (Vlastní pohled viz níže)
--
CREATE TABLE `odeslane_objednavky` (
`id_objednavky` int(11)
,`id_zakaznika` int(11)
,`datum_objednani` date
,`status_objednavky` int(11)
,`odeslano` date
,`id_dopravce` int(11)
);

-- --------------------------------------------------------

--
-- Zástupná struktura pro pohled `posledni_objednavka`
-- (Vlastní pohled viz níže)
--
CREATE TABLE `posledni_objednavka` (
`id_objednavky` int(11)
,`id_zakaznika` int(11)
,`datum_objednani` date
,`status_objednavky` int(11)
,`odeslano` date
,`id_dopravce` int(11)
);

-- --------------------------------------------------------

--
-- Struktura tabulky `produkty`
--

CREATE TABLE `produkty` (
  `id_produktu` int(11) NOT NULL,
  `jmeno` varchar(45) NOT NULL,
  `znacka` varchar(45) NOT NULL,
  `skladem` int(11) NOT NULL,
  `cena_kus` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Vypisuji data pro tabulku `produkty`
--

INSERT INTO `produkty` (`id_produktu`, `jmeno`, `znacka`, `skladem`, `cena_kus`) VALUES
(1, 'Stůl dřevěný', 'Adelstem', 7, 5499),
(2, 'Židle dřevěná', 'Bolmer', 15, 499),
(3, 'Pohovka látková', 'Mammut', 4, 7999),
(4, 'Lampa stolní', 'Isfjorden', 34, 299),
(5, 'Skříň šatní dřěvěná', 'Krakskar', 2, 7799),
(6, 'Koberec', 'Rumtumtugger', 28, 599),
(7, 'Deka látková', 'Metbjall', 16, 149);

-- --------------------------------------------------------

--
-- Struktura tabulky `statusy_objednavek`
--

CREATE TABLE `statusy_objednavek` (
  `id_statusu_objednavky` int(11) NOT NULL,
  `popis` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Vypisuji data pro tabulku `statusy_objednavek`
--

INSERT INTO `statusy_objednavek` (`id_statusu_objednavky`, `popis`) VALUES
(1, 'Připravuje se'),
(2, 'Zabaleno'),
(3, 'Expedováno'),
(4, 'Doručeno'),
(5, 'Vyzvednuto');

-- --------------------------------------------------------

--
-- Zástupná struktura pro pohled `trzby`
-- (Vlastní pohled viz níže)
--
CREATE TABLE `trzby` (
`Celkem_prodanych_produktu` decimal(32,0)
,`Celkove_trzby` decimal(32,0)
);

-- --------------------------------------------------------

--
-- Struktura tabulky `zakaznici`
--

CREATE TABLE `zakaznici` (
  `id_zakaznika` int(11) NOT NULL,
  `krestni_jmeno` varchar(45) NOT NULL,
  `prijmeni` varchar(45) NOT NULL,
  `datum_narozeni` date DEFAULT NULL,
  `email` varchar(45) NOT NULL,
  `adresa` varchar(45) NOT NULL,
  `město` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Vypisuji data pro tabulku `zakaznici`
--

INSERT INTO `zakaznici` (`id_zakaznika`, `krestni_jmeno`, `prijmeni`, `datum_narozeni`, `email`, `adresa`, `město`) VALUES
(1, 'Jan', 'Novotný', '1970-10-10', 'novotny@gmail.com', 'Jiráskova 260', 'Brno'),
(2, 'Adam', 'Vysoký', '2000-05-21', 'adamv@seznam.cz', 'Školní 111', 'Třemblat'),
(3, 'Veronika', 'Chytrá', '1985-01-15', 'chytra@gmail.com', 'Pod Mostem 313', 'Spytihněv'),
(4, 'Sára', 'Nováková', '2005-08-04', 'sarinka@gmail.com', 'Rodičovská 251', 'Praha'),
(5, 'Tomáš', 'Černý', '1920-11-23', 'nesmrtelny@centrum.cz', 'Válečná 914', 'Plzeň'),
(6, 'Tereza', 'Hladová', '2003-10-15', 'terkater@seznam.cz', 'Bramborová 111', 'Ostrava'),
(7, 'Lukáš', 'Provázek', '1999-05-04', 'lukasprovazek@email.cz', 'Hluboká 741', 'Zlín'),
(8, 'Eva', 'Kaprová', '1998-08-24', 'kaprkaprkapr@gmail.com', 'Pod vodou 414', 'Rybník');

--
-- Spouště `zakaznici`
--
DELIMITER $$
CREATE TRIGGER `email_lowercase` BEFORE INSERT ON `zakaznici` FOR EACH ROW BEGIN SET NEW.email = LOWER(NEW.email); END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `format_name` BEFORE INSERT ON `zakaznici` FOR EACH ROW BEGIN SET NEW.krestni_jmeno = CONCAT(UPPER(SUBSTRING(NEW.krestni_jmeno,1,1)), LOWER(SUBSTRING(NEW.krestni_jmeno,2))); END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `format_surname` BEFORE INSERT ON `zakaznici` FOR EACH ROW BEGIN SET NEW.prijmeni = CONCAT(UPPER(SUBSTRING(NEW.prijmeni,1,1)), LOWER(SUBSTRING(NEW.prijmeni,2))); END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `remove_customer_id` AFTER DELETE ON `zakaznici` FOR EACH ROW BEGIN SET FOREIGN_KEY_CHECKS=0;UPDATE objednavky SET id_zakaznika = 0 WHERE id_zakaznika = OLD.id_zakaznika; SET FOREIGN_KEY_CHECKS=1; END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Zástupná struktura pro pohled `zakaznici_a_zbozi`
-- (Vlastní pohled viz níže)
--
CREATE TABLE `zakaznici_a_zbozi` (
`id_objednavky` int(11)
,`krestni_jmeno` varchar(45)
,`prijmeni` varchar(45)
,`produkt` varchar(45)
,`popis` varchar(45)
);

-- --------------------------------------------------------

--
-- Struktura pro pohled `dochazejici_produkty`
--
DROP TABLE IF EXISTS `dochazejici_produkty`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `dochazejici_produkty`  AS SELECT `produkty`.`id_produktu` AS `id_produktu`, `produkty`.`jmeno` AS `jmeno`, `produkty`.`skladem` AS `skladem` FROM `produkty` WHERE `produkty`.`skladem` < 5 ORDER BY `produkty`.`skladem` ASC ;

-- --------------------------------------------------------

--
-- Struktura pro pohled `dospeli_zakaznici`
--
DROP TABLE IF EXISTS `dospeli_zakaznici`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `dospeli_zakaznici`  AS SELECT `zakaznici`.`id_zakaznika` AS `id_zakaznika`, `zakaznici`.`krestni_jmeno` AS `krestni_jmeno`, `zakaznici`.`prijmeni` AS `prijmeni`, `zakaznici`.`datum_narozeni` AS `datum_narozeni`, `zakaznici`.`email` AS `email`, `zakaznici`.`adresa` AS `adresa`, `zakaznici`.`město` AS `město`, floor((to_days(`zakaznici`.`datum_narozeni`) - to_days(curdate())) / -365) AS `vek_zakaznika` FROM `zakaznici` WHERE (to_days(`zakaznici`.`datum_narozeni`) - to_days(curdate())) / -365 > 18 ;

-- --------------------------------------------------------

--
-- Struktura pro pohled `mladi_zakaznici`
--
DROP TABLE IF EXISTS `mladi_zakaznici`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `mladi_zakaznici`  AS SELECT `zakaznici`.`id_zakaznika` AS `id_zakaznika`, `zakaznici`.`krestni_jmeno` AS `krestni_jmeno`, `zakaznici`.`prijmeni` AS `prijmeni`, `zakaznici`.`datum_narozeni` AS `datum_narozeni`, `zakaznici`.`email` AS `email`, `zakaznici`.`adresa` AS `adresa`, `zakaznici`.`město` AS `město`, floor((to_days(`zakaznici`.`datum_narozeni`) - to_days(curdate())) / -365) AS `vek_zakaznika` FROM `zakaznici` WHERE (to_days(`zakaznici`.`datum_narozeni`) - to_days(curdate())) / -365 < 18 ;

-- --------------------------------------------------------

--
-- Struktura pro pohled `nejdrazsi_objednavka`
--
DROP TABLE IF EXISTS `nejdrazsi_objednavka`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `nejdrazsi_objednavka`  AS SELECT `o`.`id_objednavky` AS `id_objednavky`, `z`.`krestni_jmeno` AS `krestni_jmeno`, `z`.`prijmeni` AS `prijmeni`, `oz`.`cena_celkem` AS `cena_objednávky`, `p`.`jmeno` AS `Product` FROM (((`objednavky` `o` join `zakaznici` `z` on(`o`.`id_zakaznika` = `z`.`id_zakaznika`)) join `objednane_zbozi` `oz` on(`o`.`id_objednavky` = `oz`.`id_objednavky`)) join `produkty` `p` on(`oz`.`id_produktu` = `p`.`id_produktu`)) HAVING `oz`.`cena_celkem` = (select max(`objednane_zbozi`.`cena_celkem`) from `objednane_zbozi`) ;

-- --------------------------------------------------------

--
-- Struktura pro pohled `nejlevnejsi_objednavka`
--
DROP TABLE IF EXISTS `nejlevnejsi_objednavka`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `nejlevnejsi_objednavka`  AS SELECT `o`.`id_objednavky` AS `id_objednavky`, `z`.`krestni_jmeno` AS `krestni_jmeno`, `z`.`prijmeni` AS `prijmeni`, min(`oz`.`cena_celkem`) AS `Cena_objednávky`, `p`.`jmeno` AS `Product` FROM (((`objednavky` `o` join `zakaznici` `z` on(`o`.`id_zakaznika` = `z`.`id_zakaznika`)) join `objednane_zbozi` `oz` on(`o`.`id_objednavky` = `oz`.`id_objednavky`)) join `produkty` `p` on(`oz`.`id_produktu` = `p`.`id_produktu`)) GROUP BY `o`.`id_objednavky`, `z`.`krestni_jmeno`, `z`.`prijmeni`, `p`.`jmeno` ORDER BY `oz`.`cena_celkem` ASC LIMIT 0, 1 ;

-- --------------------------------------------------------

--
-- Struktura pro pohled `objednavky_k_odeslani`
--
DROP TABLE IF EXISTS `objednavky_k_odeslani`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `objednavky_k_odeslani`  AS SELECT `objednavky`.`id_objednavky` AS `id_objednavky`, `objednavky`.`id_zakaznika` AS `id_zakaznika`, `objednavky`.`datum_objednani` AS `datum_objednani`, `objednavky`.`status_objednavky` AS `status_objednavky`, `objednavky`.`odeslano` AS `odeslano`, `objednavky`.`id_dopravce` AS `id_dopravce` FROM `objednavky` WHERE `objednavky`.`odeslano` is null ;

-- --------------------------------------------------------

--
-- Struktura pro pohled `odeslane_objednavky`
--
DROP TABLE IF EXISTS `odeslane_objednavky`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `odeslane_objednavky`  AS SELECT `objednavky`.`id_objednavky` AS `id_objednavky`, `objednavky`.`id_zakaznika` AS `id_zakaznika`, `objednavky`.`datum_objednani` AS `datum_objednani`, `objednavky`.`status_objednavky` AS `status_objednavky`, `objednavky`.`odeslano` AS `odeslano`, `objednavky`.`id_dopravce` AS `id_dopravce` FROM `objednavky` WHERE `objednavky`.`odeslano` is not null ;

-- --------------------------------------------------------

--
-- Struktura pro pohled `posledni_objednavka`
--
DROP TABLE IF EXISTS `posledni_objednavka`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `posledni_objednavka`  AS SELECT `objednavky`.`id_objednavky` AS `id_objednavky`, `objednavky`.`id_zakaznika` AS `id_zakaznika`, `objednavky`.`datum_objednani` AS `datum_objednani`, `objednavky`.`status_objednavky` AS `status_objednavky`, `objednavky`.`odeslano` AS `odeslano`, `objednavky`.`id_dopravce` AS `id_dopravce` FROM `objednavky` ORDER BY `objednavky`.`datum_objednani` DESC LIMIT 0, 1 ;

-- --------------------------------------------------------

--
-- Struktura pro pohled `trzby`
--
DROP TABLE IF EXISTS `trzby`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `trzby`  AS SELECT sum(`objednane_zbozi`.`mnozstvi`) AS `Celkem_prodanych_produktu`, sum(`objednane_zbozi`.`cena_celkem`) AS `Celkove_trzby` FROM `objednane_zbozi` ;

-- --------------------------------------------------------

--
-- Struktura pro pohled `zakaznici_a_zbozi`
--
DROP TABLE IF EXISTS `zakaznici_a_zbozi`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `zakaznici_a_zbozi`  AS SELECT `o`.`id_objednavky` AS `id_objednavky`, `z`.`krestni_jmeno` AS `krestni_jmeno`, `z`.`prijmeni` AS `prijmeni`, `p`.`jmeno` AS `produkt`, `s`.`popis` AS `popis` FROM ((((`objednavky` `o` join `zakaznici` `z` on(`o`.`id_zakaznika` = `z`.`id_zakaznika`)) join `objednane_zbozi` `oz` on(`o`.`id_objednavky` = `oz`.`id_objednavky`)) join `produkty` `p` on(`oz`.`id_produktu` = `p`.`id_produktu`)) join `statusy_objednavek` `s` on(`o`.`status_objednavky` = `s`.`id_statusu_objednavky`)) ;

--
-- Klíče pro exportované tabulky
--

--
-- Klíče pro tabulku `dopravci`
--
ALTER TABLE `dopravci`
  ADD PRIMARY KEY (`id_dopravce`);

--
-- Klíče pro tabulku `objednane_zbozi`
--
ALTER TABLE `objednane_zbozi`
  ADD PRIMARY KEY (`id_objednavky`,`id_produktu`),
  ADD KEY `id_produktu` (`id_produktu`);

--
-- Klíče pro tabulku `objednavky`
--
ALTER TABLE `objednavky`
  ADD PRIMARY KEY (`id_objednavky`),
  ADD KEY `id_zakaznika` (`id_zakaznika`),
  ADD KEY `id_dopravce` (`id_dopravce`),
  ADD KEY `status_objednavky` (`status_objednavky`);

--
-- Klíče pro tabulku `produkty`
--
ALTER TABLE `produkty`
  ADD PRIMARY KEY (`id_produktu`);

--
-- Klíče pro tabulku `statusy_objednavek`
--
ALTER TABLE `statusy_objednavek`
  ADD PRIMARY KEY (`id_statusu_objednavky`);

--
-- Klíče pro tabulku `zakaznici`
--
ALTER TABLE `zakaznici`
  ADD PRIMARY KEY (`id_zakaznika`);

--
-- AUTO_INCREMENT pro tabulky
--

--
-- AUTO_INCREMENT pro tabulku `dopravci`
--
ALTER TABLE `dopravci`
  MODIFY `id_dopravce` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pro tabulku `objednane_zbozi`
--
ALTER TABLE `objednane_zbozi`
  MODIFY `id_objednavky` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pro tabulku `objednavky`
--
ALTER TABLE `objednavky`
  MODIFY `id_objednavky` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pro tabulku `produkty`
--
ALTER TABLE `produkty`
  MODIFY `id_produktu` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT pro tabulku `zakaznici`
--
ALTER TABLE `zakaznici`
  MODIFY `id_zakaznika` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Omezení pro exportované tabulky
--

--
-- Omezení pro tabulku `objednane_zbozi`
--
ALTER TABLE `objednane_zbozi`
  ADD CONSTRAINT `objednane_zbozi_ibfk_1` FOREIGN KEY (`id_objednavky`) REFERENCES `objednavky` (`id_objednavky`),
  ADD CONSTRAINT `objednane_zbozi_ibfk_2` FOREIGN KEY (`id_produktu`) REFERENCES `produkty` (`id_produktu`);

--
-- Omezení pro tabulku `objednavky`
--
ALTER TABLE `objednavky`
  ADD CONSTRAINT `objednavky_ibfk_1` FOREIGN KEY (`id_zakaznika`) REFERENCES `zakaznici` (`id_zakaznika`),
  ADD CONSTRAINT `objednavky_ibfk_2` FOREIGN KEY (`id_dopravce`) REFERENCES `dopravci` (`id_dopravce`),
  ADD CONSTRAINT `objednavky_ibfk_3` FOREIGN KEY (`status_objednavky`) REFERENCES `statusy_objednavek` (`id_statusu_objednavky`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
