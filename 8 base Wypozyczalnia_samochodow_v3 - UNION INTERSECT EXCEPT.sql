-- UNION - suma bez powtórzeń
-- UNION ALL - suma z powtórzeniami
-- INTERSECT - część wspólna, otrzymamy tylko te rekordy które znajdują się w obu tabelach (wszystkie rekordy takie same uznaje się za wspólne)
-- EXCEPT - odejmuje rekordy z drugiego SELECTa  i pomija rekordy zupełnie niepasujące drugiego SELECTa (przeciwieństwo INTERSECT)

-- 1. Wyświetl w jednej tabeli dane osobowe klientów i pracowników: imię, nazwisko, e-mail, płeć
SELECT
	klienci.imie_klienta AS imię,
	klienci.nazwisko_klienta AS nazwisko,
	klienci.miasto_klienta AS miasto,
	klienci.email_klienta AS e-mail,
	klienci.plec AS płeć,
	'klient' AS rola -- dodana nowa kolumna z nagłówkiem rola by ogarnąć które dane należą do której tabeli
FROM klienci
UNION
SELECT
	pracownicy.imie_pracownika,
	pracownicy.nazwisko_pracownika,
	pracownicy.miasto_pracownika,
	pracownicy.email_pracownika,
	NULL,
	'pracownik'
FROM pracownicy


-- 2. Wyświetl imiona i nazwiska kolientów, którzy wypożyczali Audi A4 oraz pracowników, którzy obsługiwali wypożyczenia Audi A4
(bez powiązań między klientem a obsługującym go pracownikiem)
SELECT 
	klienci.imie_klienta 'imie', 
	klienci.nazwisko_klienta 'nazwisko', 
	samochody.marka 'marka', 
	samochody.model 'model', 
	'klient' rola 
FROM klienci 
	INNER JOIN wypozyczenia ON wypozyczenia.id_klienta=klienci.id_klienta 
	INNER JOIN dane_wypozyczen ON dane_wypozyczen.id_wypozyczenia=wypozyczenia.id_wypozyczenia 
	INNER JOIN samochody ON samochody.id_samochodu=dane_wypozyczen.id_samochodu
WHERE samochody.model='a4'
UNION
SELECT
	pracownicy.imie_pracownika,
	pracownicy.nazwisko_pracownika,
	samochody.model,
	samochody.marka,
	'pracownik' 
FROM pracownicy
INNER JOIN wypozyczenia ON wypozyczenia.id_pracownika=pracownicy.id_pracownika
INNER JOIN dane_wypozyczen ON dane_wypozyczen.id_wypozyczenia=wypozyczenia.id_wypozyczenia 
INNER JOIN samochody ON samochody.id_samochodu=dane_wypozyczen.id_samochodu
WHERE samochody.model='a4'

-- 2a. Inne rozwiązanie: z CONCAT bez UNION
SELECT
	klienci.imie_klienta,
    klienci.nazwisko_klienta,
	concat(samochody.marka,' ', samochody.model) auto,
	pracownicy.imie_pracownika,
	pracownicy.nazwisko_pracownika
FROM klienci
	INNER JOIN wypozyczenia ON klienci.id_klienta=wypozyczenia.id_klienta
	INNER JOIN dane_wypozyczen ON wypozyczenia.id_wypozyczenia=dane_wypozyczen.id_wypozyczenia
    INNER JOIN samochody ON dane_wypozyczen.id_samochodu=samochody.id_samochodu
	INNER JOIN pracownicy ON pracownicy.id_pracownika=wypozyczenia.id_pracownika
WHERE samochody.marka="audi" AND samochody.model="a4"

-- 3. Wyświetl imiona i nazwiska klientów, którzy wypożyczali samochody Reanult Clio oraz Opel Astra
SELECT 
	klienci.imie_klienta, 
	klienci.nazwisko_klienta
FROM klienci 
INNER JOIN wypozyczenia ON wypozyczenia.id_klienta=klienci.id_klienta 
INNER JOIN dane_wypozyczen ON dane_wypozyczen.id_wypozyczenia=wypozyczenia.id_wypozyczenia 
INNER JOIN samochody ON samochody.id_samochodu=dane_wypozyczen.id_samochodu
WHERE 
	samochody.model='clio'
INTERSECT
SELECT 
	klienci.imie_klienta, 
	klienci.nazwisko_klienta
FROM klienci 
INNER JOIN wypozyczenia ON wypozyczenia.id_klienta=klienci.id_klienta 
INNER JOIN dane_wypozyczen ON dane_wypozyczen.id_wypozyczenia=wypozyczenia.id_wypozyczenia 
INNER JOIN samochody ON samochody.id_samochodu=dane_wypozyczen.id_samochodu
WHERE 
	samochody.model='astra'

-- 4. Wyświetl klientów, którzy wypożyczali dwa konkretne samochody (corsa, astra) w tym samym dniu. Do zapytania dołącz id, datę wypożyczenia oraz model auta
SELECT 
	klienci.imie_klienta, 
	klienci.nazwisko_klienta,
	wypozyczenia.id_wypozyczenia,
	wypozyczenia.data_wyp,
	samochody.marka
FROM klienci 
INNER JOIN wypozyczenia ON wypozyczenia.id_klienta=klienci.id_klienta 
INNER JOIN dane_wypozyczen ON dane_wypozyczen.id_wypozyczenia=wypozyczenia.id_wypozyczenia 
INNER JOIN samochody ON samochody.id_samochodu=dane_wypozyczen.id_samochodu
WHERE 
	samochody.model='corsa'
INTERSECT
SELECT 
	klienci.imie_klienta, 
	klienci.nazwisko_klienta,
	wypozyczenia.id_wypozyczenia,
	wypozyczenia.data_wyp,
	samochody.marka
FROM klienci 
INNER JOIN wypozyczenia ON wypozyczenia.id_klienta=klienci.id_klienta 
INNER JOIN dane_wypozyczen ON dane_wypozyczen.id_wypozyczenia=wypozyczenia.id_wypozyczenia 
INNER JOIN samochody ON samochody.id_samochodu=dane_wypozyczen.id_samochodu
WHERE 
	samochody.model='astra'

-- 5. Wyświetl imiona i nazwiska klientów, którzy wypożyczali Forda Mondeo ale nie wypożyczali nigdy Opla Astry
SELECT
	klienci.imie_klienta,
	klienci.nazwisko_klienta
FROM klienci
	INNER JOIN wypozyczenia ON klienci.id_klienta=wypozyczenia.id_klienta
	INNER JOIN dane_wypozyczen ON wypozyczenia.id_wypozyczenia=dane_wypozyczen.id_wypozyczenia
	INNER JOIN samochody ON dane_wypozyczen.id_samochodu=samochody.id_samochodu
WHERE samochody.model="mondeo"
EXCEPT
SELECT
	klienci.imie_klienta,
	klienci.nazwisko_klienta
FROM klienci
	INNER JOIN wypozyczenia ON klienci.id_klienta=wypozyczenia.id_klienta
	INNER JOIN dane_wypozyczen ON wypozyczenia.id_wypozyczenia=dane_wypozyczen.id_wypozyczenia
	INNER JOIN samochody ON dane_wypozyczen.id_samochodu=samochody.id_samochodu
WHERE samochody.model="astra"


-- 6. Wyświetl imiona i nazwiska klientów, którzy wypożyczali oraz pracowników, którzy obsługiwali wypożyczenia aut marki BMW.
SELECT 
	klienci.imie_klienta 'imie', 
	klienci.nazwisko_klienta 'nazwisko',
	'klient' rola
FROM klienci 
INNER JOIN wypozyczenia ON wypozyczenia.id_klienta=klienci.id_klienta 
INNER JOIN dane_wypozyczen ON dane_wypozyczen.id_wypozyczenia=wypozyczenia.id_wypozyczenia 
INNER JOIN samochody ON samochody.id_samochodu=dane_wypozyczen.id_samochodu
WHERE 
	samochody.marka='BMW'
UNION
SELECT 
	pracownicy.imie_pracownika,
	pracownicy.nazwisko_pracownika,
	'pracownik'
FROM pracownicy
INNER JOIN wypozyczenia ON wypozyczenia.id_pracownika=pracownicy.id_pracownika 
INNER JOIN dane_wypozyczen ON dane_wypozyczen.id_wypozyczenia=wypozyczenia.id_wypozyczenia 
INNER JOIN samochody ON samochody.id_samochodu=dane_wypozyczen.id_samochodu
WHERE 
	samochody.marka='BMW'


-- 7. Wyświetl imiona i nazwiska klientów, którzy w okresie od maja do września 2022 roku wypożyczali auta marki BMW model 3 oraz Mercedesa model CLK.
SELECT 
	klienci.imie_klienta, 
	klienci.nazwisko_klienta
FROM klienci 
INNER JOIN wypozyczenia ON wypozyczenia.id_klienta=klienci.id_klienta 
INNER JOIN dane_wypozyczen ON dane_wypozyczen.id_wypozyczenia=wypozyczenia.id_wypozyczenia 
INNER JOIN samochody ON samochody.id_samochodu=dane_wypozyczen.id_samochodu
WHERE 
	samochody.model='3'
	AND wypozyczenia.data_wyp BETWEEN '2022-05-01' AND '2022-09-31'
INTERSECT
SELECT 
	klienci.imie_klienta, 
	klienci.nazwisko_klienta
FROM klienci 
INNER JOIN wypozyczenia ON wypozyczenia.id_klienta=klienci.id_klienta 
INNER JOIN dane_wypozyczen ON dane_wypozyczen.id_wypozyczenia=wypozyczenia.id_wypozyczenia 
INNER JOIN samochody ON samochody.id_samochodu=dane_wypozyczen.id_samochodu
WHERE 
	samochody.model='clk'
	AND wypozyczenia.data_wyp BETWEEN '2022-05-01' AND '2022-09-31'


-- 8. Wyświetl imiona i nazwiska klientów, którzy wypożyczali Renault Clio, ale nie wypożyczali BMW 3.
SELECT 
	klienci.imie_klienta, 
	klienci.nazwisko_klienta,
	samochody.model
FROM klienci 
INNER JOIN wypozyczenia ON wypozyczenia.id_klienta=klienci.id_klienta 
INNER JOIN dane_wypozyczen ON dane_wypozyczen.id_wypozyczenia=wypozyczenia.id_wypozyczenia 
INNER JOIN samochody ON samochody.id_samochodu=dane_wypozyczen.id_samochodu
WHERE 
	samochody.model='clio'
EXCEPT
SELECT 
	klienci.imie_klienta, 
	klienci.nazwisko_klienta,
	samochody.model
FROM klienci 
INNER JOIN wypozyczenia ON wypozyczenia.id_klienta=klienci.id_klienta 
INNER JOIN dane_wypozyczen ON dane_wypozyczen.id_wypozyczenia=wypozyczenia.id_wypozyczenia 
INNER JOIN samochody ON samochody.id_samochodu=dane_wypozyczen.id_samochodu
WHERE 
	samochody.model='3'

















	

