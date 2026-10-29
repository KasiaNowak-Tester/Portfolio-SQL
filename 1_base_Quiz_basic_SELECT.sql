--Znajdź w bazie: 1. Pytanie nr 15
	SELECT * FROM pytania WHERE id=15

-- Znajdź w bazie:2. Pytania, w których poprawną odpowiedzią jest "a"
	SELECT * FROM pytania WHERE answer="a"

-- Znajdź w bazie:3. Pytania z roku 2007
	SELECT * FROM pytania WHERE rok=2007

-- Znajdź w bazie:4. Pytania z programowania z roku 2009
	SELECT * FROM pytania WHERE kategoria="programowanie" AND rok=2009

-- Znajdź w bazie:5. Tylko treści pytań i 4 odpowiedzi z roku 2010
	SELECT tresc, odpa, odpb, odpc, odpd FROM pytania WHERE rok=2010

-- Znajdź w bazie:6. Pytania ułożone alfabetycznie wg treści
	SELECT * FROM pytania ORDER BY tresc ASC

-- Znajdź w bazie:7. Treści pytań o numerach 10-12
	SELECT id, tresc FROM pytania WHERE id BETWEEN 10 AND 12
	SELECT id, tresc FROM pytania WHERE id>=10 AND id<=12  -- second version

-- Znajdź w bazie:8. Pytania zaczynające się od słów “Jak”
	SELECT * FROM pytania WHERE tresc LIKE "Jak%"

-- Znajdź w bazie:9. Pytania zawierające frazę "C++"
	SELECT * FROM pytania WHERE tresc LIKE "%C++%" 
				OR odpa LIKE "%C++%" 
				OR odpb LIKE "%C++%" 
				OR odpc LIKE "%C++%" 
				OR odpd LIKE "%C++%" 

-- Znajdź w bazie:10. Pytania z programowania oraz systemów operacyjnych i sieci z roku 2012
	SELECT * FROM pytania 
				WHERE (kategoria="programowanie"
				       OR kategoria="systemy operacyjne i sieci")
				       AND rok=2012
