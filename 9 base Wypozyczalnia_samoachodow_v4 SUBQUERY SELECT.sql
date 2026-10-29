-- 1. Najniższa cena katalogowa samochodów
SELECT * FROM samochody
WHERE samochody.cena_katalogowa= (SELECT MIN(samochody.cena_katalogowa) FROM samochody)

-- 2. Wyświetl informacje o samochodach, które są droższe niż wszystkie samochody z klasy aut luksusowych
---------------------------------
SELECT * FROM samochody
	WHERE samochody.cena_katalogowa>ANY (SELECT samochody.cena_katalogowa FROM samochody WHERE samochody.id_klasy=5)
-- ANY wskaże wartość najniższą ze zbioru i do niej będzie przyrównywać kolumny
---------------------------------
SELECT * FROM samochody
	WHERE samochody.cena_katalogowa>ALL (SELECT samochody.cena_katalogowa FROM samochody WHERE samochody.id_klasy=5)

-- 3. Wyświetl informacje o samochodach marki OPEL, wraz ze średnią ceną samochodów tej marki za dobę
SELECT 
	samochody.marka,
	samochody.model,
	samochody.nr_rejestracyjny,
	samochody.cena_katalogowa,
	(SELECT ROUND(AVG(samochody.cena_katalogowa),2)
		FROM samochody
 		WHERE samochody.marka='opel') AS 'srednia cena za Opla'
 FROM samochody
 WHERE samochody.marka='opel'

-- 4. Wyświetl informacje o samochodach marki OPEL, wraz z różnicą względem ceny średniej oraz z przypisaniem czy cena jest 'powyżej' czy 'poniżej' średniej
SELECT 
	samochody.marka,
	samochody.model,
	samochody.nr_rejestracyjny,
	samochody.cena_katalogowa,
	samochody.cena_katalogowa-(SELECT ROUND(AVG(samochody.cena_katalogowa),2)
		FROM samochody
 		WHERE samochody.marka='opel') AS 'cena względem średniej',
    IF ((samochody.cena_katalogowa-(SELECT ROUND(AVG(samochody.cena_katalogowa),2)
		FROM samochody
 		WHERE samochody.marka='opel'))>0,
        'powyżej',
        'poniżej') AS 'cena powyżej/poniżej średniej'
    FROM samochody
    WHERE samochody.marka='opel'


-- 5. Wyświetl informacje o ilości(liczbie) wypożyczeń, w ramach których klient wypożyczał więcej niż jeden samochód
SELECT
	COUNT(*) AS 'wypożyczenia pow 2'
FROM 
    (SELECT 
     dane_wypozyczen.id_wypozyczenia
	FROM dane_wypozyczen
	GROUP BY dane_wypozyczen.id_wypozyczenia
	HAVING COUNT(dane_wypozyczen.id_wypozyczenia)>=2) podzapytanie

-- 6.Wyświetl informacje o klientach, którzy dokonali największej ilości wypożyczeń
SELECT 
	klienci.imie_klienta,
    klienci.nazwisko_klienta,
    COUNT(wypozyczenia.id_klienta) AS 'ile'
    FROM klienci
    INNER JOIN wypozyczenia ON wypozyczenia.id_klienta=klienci.id_klienta
    GROUP BY wypozyczenia.id_klienta
    HAVING 
    		ile=(SELECT COUNT(wypozyczenia.id_klienta) as 'maks'
                 FROM klienci 
                 INNER JOIN wypozyczenia ON wypozyczenia.id_klienta=klienci.id_klienta
    			GROUP BY wypozyczenia.id_klienta
                ORDER BY maks DESC LIMIT 1)


-- 7. Wyświetl informacje o samochodach, ktore nigdy nie były wypożyczane
SELECT * FROM samochody
LEFT JOIN dane_wypozyczen ON dane_wypozyczen.id_samochodu=samochody.id_samochodu
WHERE dane_wypozyczen.id_samochodu IS NULL

-- 7a. Alternatywnie

SELECT * FROM `samochody` WHERE id_samochodu NOT IN (SELECT id_samochodu
                                                     FROM dane_wypozyczen
 						     WHERE id_samochodu IS NOT NULL)

-- 8. Wyświetl ID klientów, którzy nie dokonali jeszcze wypożyczenia.
SELECT *
FROM klienci
WHERE id_klienta NOT IN (SELECT
                            id_klienta
    			        FROM wypozyczenia
                        WHERE id_klienta IS NOT NULL)

-- 8a. Alternatywnie
SELECT klienci.id_klienta
FROM klienci
LEFT JOIN wypozyczenia ON wypozyczenia.id_klienta=klienci.id_klienta
WHERE wypozyczenia.id_klienta IS NULL

-- 9. Wyświetl imiona i nazwiska klientów, którzy nie wypożyczali jeszcze aut z klasy sedan.
SELECT
klienci.id_klienta,
klienci.imie_klienta,
klienci.nazwisko_klienta
FROM klienci
WHERE klienci.id_klienta NOT IN (SELECT wypozyczenia.id_klienta 
                         FROM wypozyczenia
                         	INNER JOIN dane_wypozyczen ON dane_wypozyczen.id_wypozyczenia = wypozyczenia.id_wypozyczenia
                            INNER JOIN samochody ON samochody.id_samochodu = dane_wypozyczen.id_samochodu
                            INNER JOIN klasy_samochodow ON klasy_samochodow.id_klasy = samochody.id_klasy
                         WHERE klasy_samochodow.nazwa_klasy = 'sedan')

-- 10. Policz ilość wypożyczeń tylko na jedno auto.
SELECT COUNT(*) 'ile pojedynczych wypozyczen'
FROM (
	  SELECT dane_wypozyczen.id_wypozyczenia 
      FROM dane_wypozyczen 
      GROUP BY dane_wypozyczen.id_wypozyczenia
      HAVING COUNT(dane_wypozyczen.id_wypozyczenia)=1
	 ) AS podzapytanie

-- 11. Wyświetl marki i modele aut, które były wypożyczane najmniej razy.
SELECT 
samochody.marka,
samochody.model,
COUNT(dane_wypozyczen.id_samochodu) AS 'ile_wypozyczen'
FROM
samochody
INNER JOIN dane_wypozyczen ON dane_wypozyczen.id_samochodu=samochody.id_samochodu
GROUP BY dane_wypozyczen.id_samochodu
HAVING ile_wypozyczen=(SELECT COUNT(dane_wypozyczen.id_samochodu) AS ilosc 
                       FROM samochody
                       INNER JOIN dane_wypozyczen ON dane_wypozyczen.id_samochodu=samochody.id_samochodu
                       GROUP BY dane_wypozyczen.id_samochodu
                       ORDER BY ilosc
                       LIMIT 1)
