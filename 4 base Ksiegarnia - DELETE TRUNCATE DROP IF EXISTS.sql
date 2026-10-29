-- 1. Skasuj zawartość pola: "Wojcik" w tabeli klienci

UPDATE klienci SET "" nazwisko = ""
	WHERE idklienta = 3

-- 2. Skasuj w tabeli zamowienia rekord nr 2
	DELETE FROM zamowienia WHERE idzamowienia= 2

-- 3. Usuń wszystkie rekordy z tabeli zamowienia (bez zniszczenia struktury tabeli)
	DELETE FROM zamowienia

-- 4. Usuń rekordy z tabeli slowa_kluczowe (metodą DELETE i TRUNCATE)
	DELETE FROM slowa_kluczowe
	
	TRUNCATE TABLE slowa_kluczowe

-- 5. Usuń 5 ostatnio zarejestrowanych osób w tabeli klienci (DELETE usuwa rekord po rekordzie)
	DELETE FROM klienci ORDER BY idklienta DESC LIMIT 5

-- 6. Usuń bazę ksiegarnia
	DROP DATABASE ksiegarnia

-- 7. Usuń tabelę klienci wraz z jej strukturą
	DROP TABLE klienci

-- 8. Usuń tabelę klienci wraz z jej strukturą (ponownie?)
	DROP TABLE IF EXISTS klienci


	
	

