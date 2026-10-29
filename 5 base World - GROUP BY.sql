-- 1. Ile państw znajduje się na każdym z kontynentów? (Continent / Countries_Count)
	SELECT Continent, 
	       COUNT(Code) AS Countries_Count 
	FROM country 
		GROUP BY Continent 
		ORDER BY Countries_Count DESC

-- 2. Które języki (oficjalne, urzędowe) są używane przez najwięcej państw europejskich?(Language/European_Sum_Lang)
	SELECT countrylanguage.Language, 
 	       COUNT(CountryCode) AS European_Sum_Lang
	FROM countrylanguage, country 
	WHERE country.Code=countrylanguage.CountryCode 
		AND country.Continent="Europe" 
		AND countrylanguage.IsOfficial="T"
			GROUP BY countrylanguage.Language 
			ORDER BY European_Sum_Lang DESC

-- 3. Podaj dla każdego państwa w Ameryce Południowej łączną liczbę obywateli mieszkających w dużych miastach, o populacji wynoszącej co najmniej 100k mieszkańców (South_Am_Country\Population_above100k)
	SELECT country.Name, 
	       SUM(city.Population) AS Population_above100k 
	FROM city, country
	WHERE country.Continent="South America" 
 	      AND city.population>=100000
	      AND country.Code=city.CountryCode
			GROUP BY country.Name

-- Sprawdzenie wyniku: np.
	SELECT SUM(city.Population) 
	FROM city 
	WHERE Population>=100000 
	      AND CountryCode="BRA"









