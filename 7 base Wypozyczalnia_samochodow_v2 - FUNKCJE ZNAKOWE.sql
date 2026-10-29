-- 1. tablica Klienci: usunięcie zbędnych spacji w kolumnach imię i nazwisko
SELECT 
	trim(imie_klienta),
	trim(nazwisko_klienta)
FROM `klienci` 

-- 2.Usunąć spacje ze środka tekstu
SELECT 
	replace(klienci.imie_klienta,' ','')
FROM `klienci` 

-- 3. Wyświetl imiona, nazwiska klientów i miasta z jakich pochodzą. Wyniki posortuj wg liczby znaków w kolumnie miasto
SELECT 
	replace(klienci.imie_klienta,' ','') 'imie',
	klienci.nazwisko_klienta 'nazwisko',
	klienci.miasto_klienta 'miasto'
FROM `klienci` 
ORDER BY char_length(klienci.miasto_klienta) DESC;

-- 4. Poprawienie spacji w imionach i nazwiskach klientów w bazie
UPDATE klienci SET 
	klienci.imie_klienta=replace(klienci.imie_klienta,' ',''),
	klienci.imie_klienta=trim(klienci.imie_klienta),
	klienci.nazwisko_klienta=replace(klienci.nazwisko_klienta,' ','')


-- 5. Wyświetl nazwy domen w jakich klienci mają adresy e-mail- bez duplikatów
SELECT DISTINCT 
	substring(klienci.email_klienta,instr(klienci.email_klienta,'@') +1) 'domena'
FROM `klienci` 

-- 6. Wyświetl adresy email z kolumną ze mailami ze zmienioną końcówką domeny z pl na eu
SELECT klienci.email_klienta,
       replace(klienci.email_klienta,'pl','eu')
FROM `klienci` 
WHERE klienci.email_klienta LIKE "%@wp.pl"

-- 7. Wyświetl w JEDNEJ kolumnie imiona i nazwiska klientów z dołączonym zwrotem grzecznościowym.
SELECT 
	concat (
        IF (klienci.plec='M','Pan ','Pani '),
        klienci.imie_klienta,
        ' ',
        klienci.nazwisko_klienta) 'klienci'
FROM `klienci` 

-- 8. [Ćwiczenie podsumowujące]
Wyświetl auta (1 kolumna marka i model) oraz ilość wypożyczeń z dopiskiem 'raz' lub 'razy'
Kolejność:
-połączenie kolumn marka i model pojazdu
-obliczenie ilości wypożyczeń danego pojazdu
-zmiana pierwszych liter marek i modeli aut na wielkie
- dodane frazy 'raz' albo 'razy' do ilości wypożyczonych aut w zależności od spełnionego warunku
- warunkowanie sprawdzające ilość znaków łańcucha - tam gdzie będzie 
spełniony warunek to zmiana liter na wielkie

SELECT
	concat(
		IF( 
		char_length(samochody.marka)<=3,
		ucase(samochody.marka),
		concat(ucase(left(samochody.marka,1)),substring(samochody.marka,2))
		),
	' ',
	IF(
	char_length(samochody.model)<=3,
		ucase(samochody.model),
		concat(ucase(left(samochody.model,1)),substring(samochody.model,2))
		)
		) 'Auto',
	concat(
		COUNT(dane_wypozyczen.id_samochodu),
	' ',
	CASE WHEN COUNT(dane_wypozyczen.id_samochodu) = 1 THEN 'raz' ELSE 'razy' END
		) 'Ilość wypożyczeń'
FROM samochody
	LEFT JOIN dane_wypozyczen ON samochody.id_samochodu=dane_wypozyczen.id_samochodu
GROUP BY dane_wypozyczen.id_samochodu
ORDER BY COUNT(dane_wypozyczen.id_samochodu) DESC

-- wersja bez zmiany na duże litery w marce gdy nazwa poniżej 4 znaków:
SELECT 
CONCAT(
    ucase(left(samochody.marka,1)),
    substring(samochody.marka,2),
    ' ', 
     ucase(left(samochody.model,1)),
     substring(samochody.model,2)      
     ) AS Auta,
CONCAT(
    COUNT(dane_wypozyczen.id_samochodu),
    ' ',
    IF (COUNT(dane_wypozyczen.id_samochodu)=1, 'raz', 'razy')
     ) AS Ilosc_wypozyczen
FROM samochody
LEFT JOIN dane_wypozyczen ON samochody.id_samochodu=dane_wypozyczen.id_samochodu
GROUP BY dane_wypozyczen.id_samochodu
ORDER BY COUNT(dane_wypozyczen.id_samochodu) DESC

-- 9. Korzystając z funkcji lcase, ucase oraz left, right lub substring wyświetl nazwiska klientów zaczynając od małej litery, a kończąc na wielkiej (mroczeK, stelmacH)
SELECT 
	concat(
	lcase(left(klienci.nazwisko_klienta,char_length(klienci.nazwisko_klienta)-1)),
	ucase(right(klienci.nazwisko_klienta,1))
	) nazwisko
FROM klienci

-- 10. Korzystając z funkcji replace oraz instrukcji warunkowej wyświetl adresy mejlowe klientów ze zmienioną nazwą domeny pl na com i odwrotnie. Zadanie wykonaj dla domeny wp.pl oraz gmail.com, bez modyfikacji domeny onet.pl

-- wersja IF
SELECT
	klienci.email_klienta email_w_bazie,
	IF(
	   klienci.email_klienta LIKE "%gmail.com",
	   REPLACE (klienci.email_klienta,"com","pl"),
	   IF (
		klienci.email_klienta LIKE "%wp.pl",
		REPLACE (klienci.email_klienta,"pl","com"),
		klienci.email_klienta)
	   ) email_zmieniony
FROM klienci

-- 11. Korzystając z funkcji concat wyświetl w jednej kolumnie imię i nazwisko klienta, a w drugiej jego adres. Dodaj do wyników frazę „ul. ” przed nazwami ulic.
SELECT
	concat(
		klienci.imie_klienta,
		' ',
		klienci.nazwisko_klienta
		) klient,
	concat(
		klienci.ulica_klienta,
		' ',
		klienci.numer_domu_klienta,
		' ',
		klienci.kod_klienta,
		' ',
		klienci.miasto_klienta
		) adres
FROM klienci

-- 12. Korzystając z funkcji left, right lub substring wyświetl każdy element daty wypożyczenia (dzień, miesiąc i rok) w osobnych kolumnach.
SELECT
	substring(wypozyczenia.data_wyp,1,4) rok,
	substring(wypozyczenia.data_wyp,6,2) miesiac,
	substring(wypozyczenia.data_wyp,9) dzien
FROM wypozyczenia
	









