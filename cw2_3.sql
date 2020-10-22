drogi(id int, geometria geometry);
budynki(id int, geometria geometry, nazwa varchar(30));


SELECT ST_Area(geometria) AS pole_powierzchni, 
ST_Perimeter(geometria) AS obwod, 
ST_AsText(geometria) AS STt
FROM budynki
WHERE nazwa ='Buildings';

SLECET ST_Area(geometria) AS Ppowierzchni, nazwa
FROM budynki
ORDER_BY St_Area(geometria); 

SLECET ST_Area(geometria) AS Ppowierzchni, nazwa
FROM budynki
ORDER_BY nazwa DESC; 

budynki(id int, geometria geometry, nazwa varchar(30)); 
punkty informacyjne (id int, geometria geometry, nazwa varchar(30)); 

SELECT ST_Distance(b.geometria , p.geometria) 
FROM budynki b, punkty p
WHERE b.nazwa = "Buildingsb"
AND p.nazwa = 'P'; 


