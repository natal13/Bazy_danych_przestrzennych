CREATE EXTENSION postgis;

--
SELECT COUNT(DISTINCT p.gid) AS "Liczba_budynków" 
FROM popp p, majrivers maj 
WHERE popp.f_codedesc = 'Building' 
AND ST_DWithin(p.geom, maj.geom, 100000);

--
CREATE TABLE tableB AS
SELECT DISTINCT p.gid, p.cat, p.f_codedesc, p.f_code, p.type, p.geom 
FROM popp p, majrivers maj
WHERE popp.f_codedesc = 'Building' 
AND ST_DWithin(p.geom, maj.geom, 100000);

--
CREATE TABLE airportsNew AS
SELECT name, geom, elev 
FROM airports;

--
SELECT name AS lotniskoE, ST_Y(geom) AS wspolrzedne
FROM airportsNew
ORDER BY wspolrzedne ASC LIMIT 1;

SELECT name AS lotniskoW, ST_Y(geom) AS wspolrzedne
FROM airportsNew
ORDER BY wspolrzedne DESC LIMIT 1;

--
INSERT INTO airportsNew 
VALUES ('airportB', (SELECT ST_Centroid 
  (ST_ShortestLine(
  (SELECT geom FROM airportsNew WHERE name LIKE 'NIKOLSKI AS'),
  (SELECT geom FROM airportsNew WHERE name LIKE 'NOATAK')))), 
  100);

--

SELECT ST_Area(
ST_Buffer(ST_ShortestLine(
(SELECT geom FROM lakes WHERE names = 'Iliamna Lake'),
(SELECT geom FROM airports WHERE name = 'AMBLER')),1000)) 
AS Pp;



