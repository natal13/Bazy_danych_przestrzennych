
CREATE DATABASE s304165;

CREATE SCHEMA firma;


CREATE TABLE pracownicy (
    id_pracownika INT NOT NULL, 
    imie VARCHAR(20) NOT NULL, 
    nazwisko VARCHAR(30) NOT NULL, 
    adres VARCHAR(40), 
    telefon VARCHAR(9)
    );
    
CREATE TABLE godziny(
    id_godziny INT NOT NULL, 
    data DATE, 
    liczba_godzin INT NOT NULL, 
    id_pracownika INT NOT NULL
    );
    
CREATE TABLE pensja_stanowisko(
    id_pensji INT NOT NULL, 
    stanowisko VARCHAR(50), 
    kwota FLOAT NOT NULL
    );
    
CREATE TABLE premia(
    id_premii INT NOT NULL, 
    rodzaj VARCHAR(20), 
    kwota FLOAT 
    );
    
CREATE TABLE wynagrodzenie(
    id_wynagrodzenia INT NOT NULL, 
    data DATE NOT NULL, 
    id_pracownika INT NOT NULL, 
    id_godziny INT NOT NULL, 
    id_pensji INT NOT NULL, 
    id_premii INT NOT NULL
    );


ALTER TABLE pracownicy
    ADD PRIMARY KEY(id_pracownika);
    
ALTER TABLE godziny
    ADD PRIMARY KEY(id_godziny);
    
ALTER TABLE pensja_stanowisko
    ADD PRIMARY KEY(id_pensji);
    
ALTER TABLE premia
    ADD PRIMARY KEY(id_premii);
    
ALTER TABLE wynagrodzenie
    ADD PRIMARY KEY(id_wynagrodzenia);



ALTER TABLE godziny
ADD CONSTRAINT id_pracownika_FK FOREIGN KEY (id_pracownika)
    REFERENCES  (pracownicy);

ALTER TABLE wynagrodzenie
ADD CONSTRAINT id_pracownikaFK FOREIGN KEY (id_pracownika)
    REFERENCES  (pracownicy),
ADD CONSTRAINT id_godzinyFK FOREIGN KEY (id_godziny)
    REFERENCES  (godziny),
ADD CONSTRAINT id_pensjiFK FOREIGN KEY (id_pensji)
    REFERENCES  (pensja_stanowisko),
ADD CONSTRAINT id_premiiFK FOREIGN KEY (id_premii)
    REFERENCES  (premia);

--CREATE INDEX nazwa_indeksu ON nazwa_tabeli (nazwa_kolumny); 

CREATE INDEX pracownik ON pracownicy(imie, nazwisko); 
CREATE INDEX l_godzin ON pensja_stanowisko(kwota);
CREATE INDEX i_premii ON premia(kwota);

COMMENT ON TABLE pracownicy IS 'Dane podstawowe wszystkich pracownikow ';
COMMENT ON TABLE godziny IS 'Ilosc przepracownach godzin';
COMMENT ON TABLE pensja_stanowisko IS 'Podstawowa wyplata w zaleznosci od stanowiska i przepracowanych godzin';
COMMENT ON TABLE premia IS 'Dodatkowa premia ';
COMMENT ON TABLE wynagrodzenie IS 'Laczne podsumowanie wynagrodzen pracownikow';





--###################################
--###### UZUPELNIANIE TABEL #########

ALTER TABLE godziny
    ADD miesiac DATE,
    ADD tydzien DATE;

--użyć datepart 

SELECT FROM wynagrodzenie CAST(data AS VARCHAR(15));


INSERT INTO ksiegowosc.pracownicy(id_pracownika, imie, nazwisko, adres, telefon) VALUES
  ('P1', 'Janusz', 'Kowal', 'Kraków ul. Smolki 81', '506182998'),
  ('P2', 'Irena', 'Joda', 'Kraków ul. Łany 21', '782555231'), 
  ('P3', 'Krystyna', 'Mikułowska', 'Kraków ul. Kręta 122', '739213331'),
  ('P4', 'Mateusz', 'Królik', 'Myślenice ul. Złota 2', '502177122'),
  ('P5', 'Krystian', 'Nowak', 'Myślenice ul. Spacerowa 7', '622381245')
  ('P6', 'Maciej', 'Słoneczny', 'Myślenice ul. Kasprowicza 29', '672291432'),
  ('P7', 'Klaudia', 'Nowak', 'Myślenice ul. Spacerowa 7', '504673992'),
  ('P8', 'Kajetan', 'Mróz', 'Skawina ul. Żwirki i Wigury 117', '532912432'),
  ('P9', 'Adrian', 'Pradel', 'Skawina ul. Kroabnicka 49', '621993472'),
  ('P10', 'Katarzyna', 'Ziemniak', 'Skawina ul. Zacisze 5', '781987177');


INSERT INTO ksiegowosc.godziny (id_godziny, data, liczba_godzin , id_pracownika) VALUES
  ('H1', '31-05-2020', 130, 'P1'),
  ('H2', '31-05-2020', 150, 'P2'),
  ('H3', '31-05-2020', 155, 'P3'),
  ('H4', '31-05-2020', 145, 'P4'),
  ('H5', '31-05-2020', 169, 'P5'),
  ('H6', '31-05-2020', 160, 'P6'),
  ('H7', '31-05-2020', 157, 'P7'),
  ('H8', '31-05-2020', 150, 'P8'),
  ('H9', '31-05-2020', 158, 'P9'),
  ('H10', '31-05-2020', 164, 'P10');



INSERT INTO ksiegowosc.pensja_stanowisko (id_pensji, stanowisko, kwota) VALUES
  ('S1', 'fakturzysta', 4000 ), 
  ('S2', 'stażystka', 1200 ), 
  ('S3', 'kierownik ds. finansowych', 5000 ), 
  ('S4', 'analityk kredytowy', 5500 ), 
  ('S5', 'kontroler finansowy', 4700 ), 
  ('S6', 'dyrektor finansowy', 11000), 
  ('S7', 'specjalista ds. kadr', 8700), 
  ('S8', 'główny księgowy', 6200 ), 
  ('S9', 'fakturzysta', 4000), 
  ('S10', 'stażystka', 1500); 

INSERT INTO ksiegowosc.premia (id_premii, rodzaj, kwota) VALUES
  ('B1', 'uznaniowa', 850),
  ('B2', 'roczna', 1050),
  ('B3', 'regulaminowa', 600),
  ('B4', 'roczna', 1100),
  ('B5', 'za nadgodziny', 710),
  ('B6', 'regulamina', 635),
  ('B7', 'uznaniowa', NULL),
  ('B8', 'kwartalna', 370),
  ('B9', 'roczna', 900),
  ('B10', 'za nadgodziny', 640);
  
  INSERT INTO ksiegowosc.wynagrodzenie( id_wynagrodzenia, data, id_pracownika, id_godziny, id_pensji, id_premii) VALUES
  ('W1', '31-05-2020', 'P1', 'H1', 'S1', 'B1'), 
  ('W2', '31-05-2020', 'P2', 'H2', 'S2', 'B2'),
  ('W3', '31-05-2020', 'P3', 'H3', 'S3', 'B3'),
  ('W4', '31-05-2020', 'P4', 'H4', 'S4', 'B4'),
  ('W5', '31-05-2020', 'P5', 'H5', 'S5', 'B5'),
  ('W6', '31-05-2020', 'P6', 'H6', 'S6', 'B6'),
  ('W7', '31-05-2020', 'P7', 'H7', 'S7', 'B7'),
  ('W8', '31-05-2020', 'P8', 'H8', 'S8', 'B8'),
  ('W9', '31-05-2020', 'P9', 'H9', 'S9', 'B9'),
  ('W10', '31-05-2020', 'P10', '10', 'S10', 'B10'),
  
  
  --##############
  --zapytania
  
 --6
  
SELECT id_pracownika, nazwisko FROM pracownicy;

SELECT id_pracownika FROM wynagrodzenia WHERE  ( SELECT id_pensja FROM pensja WHERE kwota>1000);

SELECT id_pracownika FROM wynagrodzenia WHERE 
  (SELECT id_premia FROM premia WHERE kwota = NULL AND (SELECT id_pensja FROM pensja WHERE kwota>200))
  
SELECT * FROM pracownicy WHERE imie LIKE 'J%'

SELECT * FROM pracownicy WHERE nazwisko LIKE '%n%' AND imie LIKE '%a'

SELECT imie, nazwisko, liczba_godzin-160 AS nadgodziny 
  FROM ksiegowosc.pracownicy JOIN ksiegowosc.godziny ON pracownicy.id_pracownika = godziny.id_pracownika;

SELECT imie, nazwisko, kwota FROM ksiegowosc.pracownicy, ksiegowosc.pensja, ksiegowosc.wynagrodzenie
  WHERE ksiegowosc.pensja.id_pensji = ksiegowosc.wynagrodzenie.id_pensji
    AND ksiegowosc.pracownicy.id_pracownika = ksiegowosc.wynagrodzenie.id_pracownika AND '1500' <= kwota AND kwota <= '3000';
  
  
SELECT imie, nazwisko, liczba_godzin -160 AS nadgodziny, id_premii FROM ksiegowosc.pracownicy, ksiegowosc.godziny, ksiegowosc.wynagrodzenie
  WHERE ksiegowosc.pracownicy.id_pracownika = ksiegowosc.godziny.id_pracownika
    AND ksiegowosc.wynagrodzenie.id_godziny = ksiegowosc.godziny.id_godziny AND liczba_godzin > 160 AND premia IS NULL;  
  
  
--7 

SELECT pensje.stanowisko, COUNT(pensje.stanowisko) FROM pensje, wynagrodzenie WHERE pensje.id_pensji = wynagrodzenie.id_pensji 
  GROUP BY pensje.stanowisko

SELECT imie, nazwisko, pensja.kwota, premia.kwota FROM ksiegowosc.pracownicy, ksiegowosc.wynagrodzenie, ksiegowosc.pensja, ksiegowosc.premia 
  WHERE ksiegowosc.wynagrodzenie.id_pracownika = ksiegowosc.pracownicy.id_pracownika 
    AND ksiegowosc.wynagrodzenie.id_pensji = ksiegowosc.pensja.id_pensji AND ksiegowosc.wynagrodzenie.id_premii = ksiegowosc.premia.id_premii 
      ORDER BY ksiegowosc.pensja.kwota DESC, ksiegowosc.premia.kwota DESC;

SELECT pensje.stanowisko, COUNT(pensje.stanowisko) FROM pensje, wynagrodzenie WHERE pensje.id_pensji = wynagrodzenie.id_pensji 
		GROUP BY pensje.stanowisko

SELECT MIN(kwota) AS minimalna, AVG(kwota) AS średnia, MAX(kwota) AS maksymalna FROM pensje WHERE stanowisko = 'fakturzysta'

SELECT SUM(pensje.kwota) AS całość FROM wynagrodzenie, pensje WHERE wynagrodzenie.id_pensji = pensje.id_pensji

SELECT COUNT (stanowisko) AS stanowiska, stanowisko FROM ksiegowosc.pensja, ksiegowosc.wynagrodzenie
  WHERE ksiegowosc.wynagrodzenie.id_pensji = ksiegowosc.pensja.id_pensji GROUP BY ksiegowosc.pensja.stanowisko;

SELECT pensje.stanowisko, COUNT(*) AS łącznie FROM pensje, premie, wynagrodzenie 
	WHERE pensje.id_pensji = wynagrodzenie.id_pensji AND premie.id_premii = wynagrodzenie.id_premii
	GROUP BY pensje.stanowisko

DELETE FROM ksiegowosc.wynagrodzenie USING ksiegowosc.pensja WHERE pensja.kwota <1200 AND wynagrodzenie.id_pensji = pensja.id_pensji

--8

UPDATE ksiegowosc.pracownicy SET telefon = '(+48)' || telefon

UPDATE ksiegowosc.pracownicy SET telefon = SUBSTRING(telefon,1,5) || ' ' || SUBSTRING(telefon,6,3) || '-' || SUBSTRING(telefon,9,3) || '-' || SUBSTRING(telefon,12,3);

SELECT id_pracownika, UPPER(imie) AS IMIE, UPPER(nazwisko) AS NAZWISKO, UPPER(adres) AS ADRES, telefon FROM ksiegowosc.pracownicy WHERE
LENGTH(nazwisko) = (SELECT MAX(LENGTH(nazwisko)) FROM ksiegowosc.pracownicy);

SELECT pr.*, MD5(kwota::VARCHAR(32)) AS pensja FROM ksiegowosc.pracownicy pr, ksiegowosc.wynagrodzenie wy, ksiegowosc.pensja pe WHERE 
wy.id_pracownika = pr.id_pracownika AND wy.id_pensji = pe.id_pensji;

SELECT imie, nazwisko, pensja.kwota AS pensja, premia.kwota AS premia FROM ksiegowosc.wynagrodzenie 
LEFT JOIN ksiegowosc.pracownicy ON ksiegowosc.wynagrodzenie.id_pracownika = ksiegowosc.pracownicy.id_pracownika
LEFT JOIN ksiegowosc.pensja ON ksiegowosc.wynagrodzenie.id_pensji = ksiegowosc.pensja.id_pensji
LEFT JOIN ksiegowosc.premia ON ksiegowosc.wynagrodzenie.id_premii = ksiegowosc.premia.id_premii;

--9

SELECT CONCAT('Pracownik '|| imie ||' ' ||nazwisko||', w dniu '|| data ||' otrzymał pensję, gdzie wynagrodzenie zasadnicze wynosiło '|| '' ) AS raport FROM ksiegowosc.pracownicy,ksiegowosc.wynagrodzenie;
				



