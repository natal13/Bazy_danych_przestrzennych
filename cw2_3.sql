CREATE DATABASE DANE;
CREATE EXTENSION postgis;

CREATE TABLE drogi(id int, geometria geometry);
CREATE TABLE budynki(id int, geometria geometry, nazwa varchar(30));
CREATE TABLE punkty_informacyjne (id, geometria, nazwa)

SELECT ST_Area(geometria) AS pole_powierzchni, 
ST_Perimeter(geometria) AS obwod, 
ST_AsText(geometria) AS WKT
FROM budynki
WHERE nazwa ='Buildings';

SLECET ST_Area(geometria) AS Ppowierzchni, nazwa
FROM budynki
ORDER_BY St_Area(geometria); 

SLECET ST_Area(geometria) AS Ppowierzchni, nazwa
FROM budynki
ORDER_BY nazwa DESC; 

                                                               
--                                                             --
CREATE budynki(id int, geometria geometry, nazwa varchar(30)); 
CREATE punkty informacyjne (id int, geometria geometry, nazwa varchar(30)); 

SELECT ST_Distance(b.geometria , p.geometria) 
FROM budynki b, punkty p
WHERE b.nazwa = "BuildingB"
AND p.nazwa = 'P'; 

SELECT ST_Area(ST_Difference (
(SELECT  geometria 
FROM budynki WHERE nazwa='Buildingc'), 
ST_ST_Buffer((SELECT geometria 
FROM budynki 
WHERE nazwa ='BuildingB'), 0.5)))

SELECT nazwa ST_Centroid(b.geometria) 
AS centroid 
FROM budynki b, drogi d 
WHERE ST_Y(centroid )>4.5;
                            
SELECT ST_Area(ST_DymDifference(b.geometria, ST_GeomPromText(((4 7, 6 7, 6 8, 4 8, 47)))',0)));
                                                                      
