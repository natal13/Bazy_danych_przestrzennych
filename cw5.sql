1. CREATE TABLE obiektyNU(nazwa varchar, geom geometry);

INSERT INTO obiektynu values('obiekt1',ST_GeomFromText('CIRCULARSTRING(0 1, 1 1, 2 0, 3 1, 4 2, 5 1,6 1)'));

INSERT INTO obiektynu values('obiekt2',ST_GeomFromText('CURVEPOLYGON(CIRCULARSTRING(10 6,14 6, 16 4, 14 2, 12 0, 10 2,10 6),CIRCULARSTRING(11 2, 13 2 ,11 2))'));

INSERT INTO obiektynu values('obiekt3',ST_GeomFromText('POLYGON(( 7 15, 10 17, 12 13, 7 15))'));

INSERT INTO obiektynu values('obiekt4',ST_GeomFromText('MULTILINESTRING((20 20, 25 25,27 24, 25 22, 26 21, 22 19, 20.5 19.5))'));

INSERT INTO obiektynu values('obiekt5',ST_AsText(ST_Union(ST_GeomFromText('POINT(30 30 59)'), ST_GeomFromText('POINT(30 30 59)'))))
INSERT INTO obiektynu values('obiekt6',ST_AsText(ST_Union(ST_GeomFromText('POINT(4 2)'), ST_GeomFromText('LINESTRING(1 1,3 2)'))))
Do tabeli obiektyNU dodaj kolumnę l_pkt. W kolumnie tej wprowadź liczbę punktów tworzących powyższe geometrie.
Czy otrzymane wyniki są poprawne?

ALTER TABLE obiektynu ADD COLUMN lk_pkt geometry;
update obiektynu set lk_pkt= ST_PointOnSurface(geom)

................................................................................................................................................................
2. W tabeli obiektyNU zmień geometrię obiektu o nazwie obiekt3 na CURVEPOLYGON. Czy jest to możliwe?
Przetestuj działanie ST_LineToCurve na innych obiektach 
(np. 'LINESTRING(1 1, 3 3, 4 4, 5 5, 6 6)', 'LINESTRING(1 1, 3 3,
4 4, 5 5, 6 6, 8 8)' ). Zastanów się, kiedy ST_LineToCurve działa poprawnie.
UPDATE obiektyNU set geom=ST_LineToCurve(geom) where nazwa='obiekt3';
ST_LineToCurve — Converts a LINESTRING/POLYGON to a CIRCULARSTRING, CURVEPOLYGON

geometry ST_LineToCurve(geometry geomANoncircular);
geometria musi nie być juz łukiems

..............................................................................................................................................................
3. Wyznacz pole powierzchni bufora o wielkości 5 jednostek,
 który został utworzony wokół najkrótszej linii łączącej
obiekt 3 i 4.

 
 SELECT ST_Buffer(the_geom,5) As sqft FROM ( SELECT ST_AsText(ST_ShortestLine((SELECT geom from obiektynu where nazwa='obiekt3'),(SELECT geom from obiektynu where nazwa='obiekt4'))) from obiektynu limit 1) As foo(the_geom)

 //4. Zamień obiekt4 na poligon. Jaki warunek musi być spełniony aby można
 //było wykonać to zadanie? Zapewnij tewarunki.
 
 //warunek: 
  //figura musi sie konczyc i zaczynac w tym samym punkcie.zamieniam multilinestring na linestring
  UPDATE obiektynu set geom=ST_AsText(ST_LineMerge(geom))  where nazwa='obiekt4';
  UPDATE obiektynu set geom=(SELECT ST_Polygonize(geom) from obiektynu) where nazwa='obiekt4';

//..............................................................................................................................................................
//5. Jaka jest wysokość n.p.m. w punkcie znajdującym się w środku odcinka łączącego punkty z obiektu 5?

SELECT ST_XMax(ST_Centroid(geom)) FROM obiektynu where nazwa='obiekt5'
...............................................................................................................................................................
6. W tabeli obiektyNU jako obiekt6 zapisz obiekt złożony z obiektu 3 i obiektu 4.

INSERT INTO obiektynu VALUES('obiekt6',
 ST_AsText(ST_Union((SELECT geom from obiektynu where nazwa='obiekt3'), 
 (SELECT geom from obiektynu where nazwa='obiekt4'))));
 
7. Wyznacz pole powierzchni wszystkich buforów o wielkości 5 jednostek, 
które zostały utworzone wokół obiektów nie
zawierających łuków.

 SELECT ST_Buffer(geom,5) As pole from obiektynu where
 ST_GeometryType(geom)  NOT LIKE 'ST_CircularString' AND ST_GeometryType(geom) NOT LIKE 'ST_CurvePolygon'

 lub (lepsze)

 SELECT ST_Buffer(geom,5) As pole from obiektynu where
 ST_HasArc(geom)=false
 
8. Utwórz nową tabelę linieNU poprzez zamianę wszystkich obiektów 
tabeli obiektyNU na liniowe. 

CREATE TABLE linienu
  AS (SELECT nazwa,ST_CurveToLine(geom),l_pkt FROM obiektynu);
