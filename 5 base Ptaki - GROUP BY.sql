-- 1. Ile ptaków należących do każdego gatunku zaobserwowano? Ptaków którego gatunku było najwięcej? (gatunek\liczebnosc)
	SELECT gatunki.nazwa_zwyczajowa, 
	       SUM(liczebnosc) AS Liczba_Ptaków
	FROM gatunki, obserwacje
	WHERE gatunki.ID_gatunku=obserwacje.ID_gatunku
		GROUP BY gatunki.nazwa_zwyczajowa
		ORDER BY Liczba_Ptaków DESC


-- 2. Jakich 10 gatunków ptaków było obiektem najczęściej prowadzonych obserwacji 
przez ornitologów w powiecie gdańskim? (nazwa_zwyczajowa\najczesciej_obserw)
	SELECT gatunki.nazwa_zwyczajowa, 
	       COUNT(obserwacje.ID_gatunku) AS najczesciej_obserw
	FROM gatunki, obserwacje, lokalizacje
	WHERE gatunki.ID_gatunku=obserwacje.ID_gatunku
	      AND obserwacje.ID_lokalizacji=lokalizacje.ID_lokalizacji
              AND lokalizacje.powiat="gdanski"
			GROUP BY gatunki.nazwa_zwyczajowa 
			ORDER BY najczesciej_obserw DESC LIMIT 10


-- 3. W którym powiecie liczba zaobserwowanych ptaków z gatunku dzięcioł 
(lecz tylko tych osobników, które żerują w lesie) jest największa a w którym najmniejsza? (powiat\liczba_dzieciol)
	SELECT lokalizacje.powiat, 
	       SUM(obserwacje.liczebnosc) AS zerujacyDzieciolWlesie
	FROM gatunki, lokalizacje, obserwacje
	WHERE gatunki.nazwa_zwyczajowa LIKE "dzieciol%"
	      AND obserwacje.zachowanie = "zeruje"
	      AND lokalizacje.opis LIKE "%las%"
	      AND gatunki.ID_gatunku = obserwacje.ID_gatunku
	      AND obserwacje.ID_lokalizacji = lokalizacje.ID_lokalizacji
GROUP BY lokalizacje.powiat
ORDER BY zerujacyDzieciolWlesie DESC 





