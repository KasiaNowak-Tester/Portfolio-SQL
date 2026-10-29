-- Znajdź w bazie:
-- 1. Imię i nazwisko (tylko te dwie dane) klienta numer 4.
	SELECT idklienta, imie, nazwisko FROM klienci WHERE idklienta=4

-- 2. Wszystkie dane samochodów z rocznika 2010.
	SELECT * FROM auta WHERE rocznik=2010

-- 3. Wszystkie dane na temat samochodów marki Ford posiadanych przez nas (innymi słowy: "jakie mamy auta        marki Ford w firmie i co o nich wiemy?").
	SELECT * FROM auta WHERE marka="Ford"

-- 4. Samochody o numerach w bazie od 2 do 4 włącznie.
	SELECT * FROM auta WHERE idauta BETWEEN 2 AND 4

-- 5. Imiona i nazwiska klientów, którzy mieszkają w Katowicach na ulicy Rolnej (pod dowolnym numerem).
	SELECT imie, nazwisko, adres, miasto FROM klienci WHERE adres LIKE "Rolna%" AND miasto="Katowice"

-- 6. Samochód w bazie (marka, model), którego ubezpieczenie jest najdroższe z wszystkich aut.
	SELECT marka, model, ubezpieczenie FROM auta ORDER BY ubezpieczenie DESC LIMIT 1

-- 7. Samochód (idauta, marka, model), który został najwcześniej wypożyczony (decyduje datawyp).
	SELECT auta.idauta, 
	       auta.marka, 
	       auta.model, 
	       wypozyczenia.idwyp, 
               wypozyczenia.datawyp 
	FROM auta, wypozyczenia 
	WHERE auta.idauta=wypozyczenia.idauta 
	ORDER BY wypozyczenia.datawyp ASC LIMIT 1

-- 8. Imiona i nazwiska osób, które wypożyczyły kiedykolwiek samochód nr 1.
	SELECT klienci.imie, 
	       klienci.nazwisko, 
	       auta.marka, 
	       auta.model, 
               auta.idauta 	
	FROM klienci, auta, wypozyczenia
	WHERE wypozyczenia.idauta=1 
		AND klienci.idklienta=wypozyczenia.idklienta 
		AND auta.idauta=wypozyczenia.idauta

-- 9. Jakie auta (marka, model) kiedykolwiek wypożyczyła u nas osoba nr 4?
	SELECT auta.marka, auta.model, wypozyczenia.idklienta
	FROM auta, wypozyczenia
	WHERE wypozyczenia.idklienta=4 
		AND auta.idauta=wypozyczenia.idauta 

-- 10. Jakie auta (marka, model) kiedykolwiek wypożyczyła u nas osoba o nazwisku "Pastewniak"?
	SELECT auta.marka, 
	       auta.model, 
	       wypozyczenia.idklienta, 
	       klienci.idklienta, 
	       klienci.imie, 
	       klienci.nazwisko
	FROM auta, wypozyczenia, klienci
	WHERE klienci.nazwisko="Pastewniak" 
		AND auta.idauta=wypozyczenia.idauta 
		AND klienci.idklienta=wypozyczenia.idklienta






