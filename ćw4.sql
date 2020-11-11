CREATE TABLE obiekty(
	id INT PRIMARY KEY NOT NULL,
	nazwa VARCHAR(40),
	geometria GEOMETRY
	);


INSERT INTO obiekty VALUES
(1,'obiekt1',ST_GeomFromText('MULTICURVE((0 1, 1 1),CIRCULARSTRING(1 1, 2 0, 3 1, 4 2, 5 1),(5 1, 6 1))',0));
SELECT ST_CurveToLine(geometria) FROM obiekty WHERE nazwa = 'obiekt1';

INSERT INTO obiekty VALUES
(2,'obiekt2',ST_GeomFromText('CURVEPOLYGON(COMPOUNDCURVE((10 2, 10 6, 14 6),CIRCULARSTRING(14 6, 16 4, 14 2, 12 0, 10 2)),CIRCULARSTRING(11 2, 13 2, 11 2))',0));
SELECT ST_CurveToLine(geometria) FROM obiekty WHERE nazwa = 'obiekt2';

INSERT INTO obiekty VALUES
(3,'obiekt3',ST_GeomFromText('POLYGON((7 15, 10 17, 12 13, 7 15))',0));
SELECT geometria FROM obiekty WHERE nazwa = 'obiekt3';

INSERT INTO obiekty VALUES
(4,'obiekt4',ST_GeomFromText('LINESTRING(20 20, 25 25, 27 24, 25 22, 26 21, 22 19, 20.5 19.5)',0));
SELECT geometria FROM obiekty WHERE nazwa = 'obiekt4';

INSERT INTO obiekty VALUES
(5,'obiekt5',ST_GeomFromText('MULTIPOINT(30 30 59, 38 32 234)',0));
SELECT geometria FROM obiekty WHERE nazwa = 'obiekt5';

INSERT INTO obiekty VALUES
(6,'obiekt6',ST_GeomFromText('GEOMETRYCOLLECTION(LINESTRING(1 1, 3 2),POINT(4 2))',0));
SELECT geometria FROM obiekty WHERE nazwa = 'obiekt6';

--			    
SELECT ST_Area(ST_Buffer(ST_ShortestLine((
			 SELECT geometria 
			 FROM obiekty 
			 WHERE nazwa = 'obiekt3'),
	      	 	(SELECT geometria 
			FROM obiekty 
			WHERE nazwa = 'obiekt4'))
			,5)
	      );

--
UPDATE obiekty 
SET geom =  (SELECT ST_MakePolygon(ST_LineMerge(ST_Union((geom),'LINESTRING(20.5 19.5,20 20)'))) 
		FROM obiekty 
		WHERE nazwa='obiekt4')
WHERE nazwa = 'obiekt4'


-- 
INSERT INTO obiekty (id, nazwa, geom) 
	     VALUES (7,'obiekt7', 
		     (SELECT ST_Union(a.geom,b.geom) 
		      FROM obiekty a, obiekty b 
		      WHERE a.nazwa='obiekt3'
		      AND b.nazwa='obiekt4')
		    )	     
--
SELECT SUM(ST_Area(ST_Buffer(o.geometria,5))) 
	FROM obiekty o
	WHERE ST_HasArc(o.geometria) = false;	    
	     
