-- 1. uzyskaj info o nr wypozyczenia, marce, modelu auta które zostały wypozyczone (marka, model, nr wypozyczenia)
SELECT 
	dane_wypozyczen.id_wypozyczenia,
	samochody.marka, 
	samochody.model
FROM dane_wypozyczen
	INNER JOIN samochody ON samochody.id_samochodu=dane_wypozyczen.id_samochodu
ORDER BY dane_wypozyczen.id_wypozyczenia

-- zapytanie z użyciem NATURAL JOIN
-- !!! Jeżeli nazwy kolumn tworzące relacje są dokładnie takie same (klucze mają te same nazwy) to NIE TRZEBA podawać warunku relacji używająć NATURAL JOIN np.
SELECT 
	dane_wypozyczen.id_wypozyczenia,
	samochody.marka, 
	samochody.model
FROM dane_wypozyczen
	NATURAL JOIN samochody // bo tu kolumna gdzie jest klucz nazywa się tak samo: samochody.id_samochodu=dane_wypozyczen.id_samochodu
ORDER BY dane_wypozyczen.id_wypozyczenia

-- 2. Dodaj do poprzedniego wyniku daty wypożyczeń
SELECT 
	dane_wypozyczen.id_wypozyczenia,
	samochody.marka, 
	samochody.model,
	wypozyczenia.data_wyp
FROM dane_wypozyczen
	INNER JOIN samochody ON samochody.id_samochodu=dane_wypozyczen.id_samochodu
	INNER JOIN wypozyczenia ON wypozyczenia.id_wypozyczenia=dane_wypozyczen.id_wypozyczenia
ORDER BY dane_wypozyczen.id_wypozyczenia

-- 3. Dodaj dane o klientach które dane wypożyczenie realizowali
SELECT 
	dane_wypozyczen.id_wypozyczenia,
	samochody.marka, 
	samochody.model,
	wypozyczenia.data_wyp,
	klienci.imie_klienta,
	klienci.nazwisko_klienta
FROM dane_wypozyczen
	INNER JOIN samochody ON samochody.id_samochodu=dane_wypozyczen.id_samochodu
	INNER JOIN wypozyczenia ON wypozyczenia.id_wypozyczenia=dane_wypozyczen.id_wypozyczenia
	INNER JOIN klienci ON klienci.id_klienta=wypozyczenia.id_klienta
ORDER BY dane_wypozyczen.id_wypozyczenia


-- 4. Dodaj imie i nazwisko pracownika, który obsługiwał dane wypożyczenie
SELECT 
	dane_wypozyczen.id_wypozyczenia,
	samochody.marka, 
	samochody.model,
	wypozyczenia.data_wyp,
	klienci.imie_klienta,
	klienci.nazwisko_klienta,
	pracownicy.imie_pracownika,
	pracownicy.nazwisko_pracownika
FROM dane_wypozyczen
	INNER JOIN samochody ON samochody.id_samochodu=dane_wypozyczen.id_samochodu
	INNER JOIN wypozyczenia ON wypozyczenia.id_wypozyczenia=dane_wypozyczen.id_wypozyczenia
	INNER JOIN klienci ON klienci.id_klienta=wypozyczenia.id_klienta
	INNER JOIN pracownicy ON pracownicy.id_pracownika=wypozyczenia.id_pracownika
ORDER BY dane_wypozyczen.id_wypozyczenia

-- 5.pokaż datę wypożyczenia oraz jakie auto zostało w danym dniu wypożyczone (relacja wiele do wielu- złączenie z użyciem tabeli łącznikowej- trzeba ją wpisać do joina mimo że w select nie pobieramy z niej kolumn)
SELECT 
	wypozyczenia.data_wyp,
	samochody.marka, 
	samochody.model
FROM wypozyczenia
	INNER JOIN dane_wypozyczen ON wypozyczenia.id_wypozyczenia=dane_wypozyczen.id_wypozyczenia
	INNER JOIN samochody ON samochody.id_samochodu=dane_wypozyczen.id_samochodu  
ORDER BY wypozyczenia.data_wyp

-- 6. Podaj nazwiska pracowników oraz id wypożyczeń które obsługiwali (INNER JOIN tutaj pokaże tylko pracowników, którzy obsłużyli wypożyczenie a NIE wszystkich pracowników bo warunkiem łączenia jest porownianie id_pracownika - musi być w obu tabelach)
SELECT 
	pracownicy.nazwisko_pracownika
	wypozyczenia.id_wypozyczenia
FROM pracownicy, 
	INNER JOIN wypozyczenia ON wypozyczenia.id_pracownika=pracownicy.id_pracownika

-- 7. Złączenia zewnętrzne LEFT JOIN: 
Podaj nazwiska pracowników oraz id wypożyczeń które obsługiwali (JOIN złączy tabelę w taki sposób: wskazana tabela po lewej stronie joina ma WSZYSKIE zapisane w niej rekordy a będzie doklejona ta po prawej stronie joina z wartościami NULL które nie mają dopasowań)
SELECT 
	pracownicy.nazwisko_pracownika,
	wypozyczenia.id_wypozyczenia
FROM pracownicy
	LEFT JOIN wypozyczenia ON wypozyczenia.id_pracownika=pracownicy.id_pracownika
ORDER BY wypozyczenia.id_wypozyczenia

-- 8.Sprawdź którzy pracownicy nie obsłużyli żadnych wypożyczeń
SELECT 
	pracownicy.nazwisko_pracownika,
	wypozyczenia.id_wypozyczenia
FROM pracownicy
	LEFT JOIN wypozyczenia ON wypozyczenia.id_pracownika=pracownicy.id_pracownika
WHERE wypozyczenia.id_wypozyczenia IS NULL
ORDER BY wypozyczenia.id_wypozyczenia

-- 9. Sprawdź którzy pracownicy nie obsłużyli żadnych wypożyczeń - podaj tylko nazwisko takich pracowników
(klazula WHERE pozwala na fitrowanie po kolumnach których nie wypisywaliśmy w SELECT)
SELECT 
	pracownicy.nazwisko_pracownika,
FROM pracownicy
	LEFT JOIN wypozyczenia ON wypozyczenia.id_pracownika=pracownicy.id_pracownika
WHERE wypozyczenia.id_wypozyczenia IS NULL
ORDER BY wypozyczenia.id_wypozyczenia

-- 10. wypożyczenia bez klientów - bez danych klienta - bo klient ma prawo żądać usunięcia danych z baz
SELECT 
	dane_wypozyczen.id_wypozyczenia,
	samochody.marka, 
	samochody.model,
	wypozyczenia.data_wyp,
	klienci.imie_klienta,
	klienci.nazwisko_klienta
FROM dane_wypozyczen
	INNER JOIN samochody ON samochody.id_samochodu=dane_wypozyczen.id_samochodu
	INNER JOIN wypozyczenia ON wypozyczenia.id_wypozyczenia=dane_wypozyczen.id_wypozyczenia
	LEFT JOIN klienci ON klienci.id_klienta=wypozyczenia.id_klienta
ORDER BY dane_wypozyczen.id_wypozyczenia

-- 11. Sprawdź wypożyczenia obsługiwane przez osoby które już nie pracują
SELECT 
	dane_wypozyczen.id_wypozyczenia,
	samochody.marka, 
	samochody.model,
	wypozyczenia.data_wyp,
	klienci.imie_klienta,
	klienci.nazwisko_klienta,
	pracownicy.imie_pracownika,
	pracownicy.nazwisko_pracownika
FROM dane_wypozyczen
	INNER JOIN samochody ON samochody.id_samochodu=dane_wypozyczen.id_samochodu
	INNER JOIN wypozyczenia ON wypozyczenia.id_wypozyczenia=dane_wypozyczen.id_wypozyczenia
	LEFT JOIN klienci ON klienci.id_klienta=wypozyczenia.id_klienta
	LEFT JOIN pracownicy ON pracownicy.id_pracownika=wypozyczenia.id_pracownika
ORDER BY dane_wypozyczen.id_wypozyczenia

-- 12. Pokaż id wypożyczeń których nie obsługiwał żaden kokretny pracownik 
(RIGHT JOIN - wyświetlane są wszystkie rekordy z tabeli znajdującej się po PRAWEJ stronie klazuli)
SELECT 
	wypozyczenia.id_wypozyczenia
FROM pracownicy
	RIGHT JOIN wypozyczenia ON pracownicy.id_pracownika=wypozyczenia.id_pracownika
WHERE wypozyczenia.id_pracownika IS NULL

-- 13. Pokaż id wypożyczeń których nie obsługiwał żaden kokretny pracownik używając LEFT JOIN
SELECT 
	wypozyczenia.id_wypozyczenia
FROM wypozyczenia
	LEFT JOIN pracownicy ON pracownicy.id_pracownika=wypozyczenia.id_pracownika
WHERE wypozyczenia.id_pracownika IS NULL

-- 14. Sprawdź czy bazie jest zapisany klient który nie wypożyczał od nas auta
SELECT
	klienci.nazwisko_klienta
FROM 
	klienci
	LEFT JOIN wypozyczenia ON klienci.id_klienta=wypozyczenia.id_klienta
WHERE wypozyczenia.id_wypozyczenia IS NULL

-- 15. Sprawdź czy bazie jest zapisany klient który nie wypożyczał od nas auta z użyciem RIGHT JOIN
SELECT
	klienci.nazwisko_klienta
FROM 
	wypozyczenia
	RIGHT JOIN klienci ON klienci.id_klienta=wypozyczenia.id_klienta
WHERE wypozyczenia.id_wypozyczenia IS NULL

-- 16. Wskaż auta (model i marka), które nigdy nie były wypożyczone
SELECT
	samochody.marka,
	samochody.model
FROM samochody
	LEFT JOIN dane_wypozyczen ON samochody.id_samochodu=dane_wypozyczen.id_samochodu
WHERE dane_wypozyczen.id_samochodu IS NULL

-- 17. stwórz tabelę z kolumnami:
id wypozyczenia, marka, model, data_wyp, imie_klienta, nazwisko_klienta
SELECT
	wypozyczenia.idwypozyczenia,
	samochody.marka,
	samochody.model,
	wypozyczenia.data_wyp,
	klienci.imie_klienta,
	klienci.nazwisko_klienta
FROM wypozyczenia 
	LEFT JOIN dane_wypozyczen ON dane_wypozyczen.id_wypozyczenia=wypoczyczenia.id_wypozyczenia
	LEFT JOIN samochody ON dane_wypozyczen.id_samochodu=samochody.id_samochodu
	LEFT JOIN klienci ON wypoczyczenia.id_klienta=klienci.id_klienta
	

-- 18. Raport: wartość wypożyczeń, imie_klienta, nazwisko_klienta
SELECT 
	SUM(dane_wypozyczen.cena_doba*dane_wypozyczen.ilosc_dob) AS wartosc,
	klienci.imie_klienta,
	klienci.nazwisko_klienta
FROM dane_wypozyczen
	INNER JOIN wypozyczenia ON wypozyczenia.id_wypozyczenia=dane_wypozyczen.id_wypozyczenia
	INNER JOIN klienci ON klienci.id_klienta=wypozyczenia.id_klienta
GROUP BY wypozyczenia.id_klienta



-- 19. Sprawdź czy klienci i pracownicy pochodzą z tego samego miasta
SELECT
	klienci.imie_klienta,
	klienci.nazwisko_klienta,
	pracownicy.imie_pracownika,
	pracownicy.nazwisko_pracownika,
	pracownicy.miasto_pracownika AS miasto
FROM klienci
	INNER JOIN pracownicy ON klienci.miasto_klienta=pracownicy.miasto_pracownika

-- 20. Kto jest przełożonym danego pracownika? (SELF JOIN - łączenie w tej samej tablicy)
SELECT
	p.nazwisko_pracownika,
	s.nazwisko_pracownika szef
FROM pracownicy p
	JOIN pracownicy s ON p.szef_id=s.id_pracownika

-- 21. Wyświetl daty wypożyczeń, a także imiona o nazwiska klientów, którzy w danym dniu dokonali wypożyczenia
SELECT wypozyczenia.data_wyp,
	klienci.imie_klienta,
	klienci.nazwisko_klienta
	FROM wypozyczenia
		INNER JOIN klienci ON wypozyczenia.id_klienta=klienci.id_klienta

-- 22. Wyświetl marki i modele aut wraz z cenami za dobę wypożyczenia
SELECT
	samochody.marka,
	samochody.model,
	dane_wypozyczen.cena_doba 
	FROM samochody
		LEFT JOIN dane_wypozyczen ON samochody.id_samochodu=dane_wypozyczen.id_samochodu
          GROUP BY samochody.model
      ORDER BY samochody.marka

-- 23. Wyświetl imiona i nazwiska pracowników wypożyczalni, którzy obsługiwali wypożyczenia w lipcu 2022 roku
SELECT
	pracownicy.imie_pracownika,
	pracownicy.nazwisko_pracownika,
	wypozyczenia.data_wyp
	FROM pracownicy
		INNER JOIN wypozyczenia ON pracownicy.id_pracownika=wypozyczenia.id_pracownika
	WHERE wypozyczenia.data_wyp BETWEEN '2022-07-01' AND '2022-07-31'

-- 24. Wyświetl marki i modele aut, które w okresie od kwietnia do września wypożyczał klient o nazwisku Karwowski
SELECT
	samochody.marka,
	samochody.model,
	klienci.nazwisko_klienta,
    wypozyczenia.data_wyp
	FROM samochody
	INNER JOIN dane_wypozyczen ON samochody.id_samochodu=dane_wypozyczen.id_samochodu
	INNER JOIN wypozyczenia ON wypozyczenia.id_wypozyczenia=dane_wypozyczen.id_wypozyczenia
	INNER JOIN klienci ON klienci.id_klienta=wypozyczenia.id_klienta
		WHERE klienci.nazwisko_klienta='Karwowski' AND wypozyczenia.data_wyp BETWEEN '2022-04-01' AND '2022-09-30'  
ORDER BY `wypozyczenia`.`data_wyp` DESC 

-- 25. Wyświetl wartość wypożyczeń, które obsługiwał pracownik o nazwisku Nowacki
SELECT
	SUM(dane_wypozyczen.cena_doba*dane_wypozyczen.ilosc_dob) wartosc,
	pracownicy.nazwisko_pracownika,
	wypozyczenia.id_pracownika
	FROM dane_wypozyczen
	INNER JOIN wypozyczenia ON dane_wypozyczen.id_wypozyczenia=wypozyczenia.id_wypozyczenia
	INNER JOIN pracownicy ON pracownicy.id_pracownika=wypozyczenia.id_pracownika
		WHERE pracownicy.nazwisko_pracownika='Nowacki'
