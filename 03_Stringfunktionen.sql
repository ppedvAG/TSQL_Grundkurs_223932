USE Northwind;

SELECT FirstName + ' ' + LastName FROM Employees; --Strings verbinden mit +

SELECT CONCAT(FirstName, ' ', LastName) FROM Employees; --CONCAT: beliebig viele Strings zusammenbauen

SELECT CONCAT_WS(' ', FirstName, LastName) FROM Employees; --CONCAT_WS: Concat with Separator, baut beliebig viele Strings zusammen mit einem Separator

SELECT CONCAT_WS(' ', Address, City, PostalCode, Country) AS [Volle Adresse] FROM Customers; --Adresse erzeugen mit CONCAT_WS

--TRIM/LTRIM/RTRIM: Schneiden Abstände weg
SELECT TRIM(' Test '); --Alle Abstände links und rechts entfernen
SELECT LTRIM(' Test '); --Alle Abstände links entfernen
SELECT RTRIM(' Test '); --Alle Abstände rechts entfernen

--LOWER/UPPER: Macht den ganzen Text lowercase oder UPPERCASE
SELECT LOWER('Test');
SELECT UPPER('Test');

--LEN/DATALENGTH: Geben die Länge des Texts zurück
SELECT LEN(' Test '); --Macht automatisch ein RTRIM
SELECT DATALENGTH(' Test '); --DATALENGTH um RTRIM zu verhindern

--REVERSE: Dreht den String um
SELECT REVERSE('Test');

SELECT REVERSE(FirstName), LEN(LastName) FROM Employees; --Funktionen auf Spalten anwenden

--LEFT/RIGHT/SUBSTRING: Nehmen einen Teil vom Text
SELECT LEFT('Testtext', 4); --4 Zeichen von Links nehmen
SELECT RIGHT('Testtext', 4); --4 Zeichen von Rechts nehmen
SELECT SUBSTRING('Testtext', 2, 4); --Zeichen von der Mitte nehmen (2 als Startzeichen -> e und dann 4 Zeichen -> estt)

--REPLICATE: Gibt den String X-Mal aus
SELECT REPLICATE('xy', 4);

--STUFF: In einen Text einen anderen Text einbauen
SELECT STUFF('Testtext', 2, 0, '_Hallo_'); --Vor Stelle 2 (e) den Text (_Hallo_) mit 0 Zeichen Überschreibung einbauen
SELECT STUFF('Testtext', 2, 7, '_Hallo_'); --7 Zeichen überschreiben

--REPLACE: Ersetzt alle Vorkommnisse von dem gegebenen Text mit einem anderen Text
SELECT REPLACE('Testtext', 'e', '-'); --Ersetze alle E's mit einem Bindestrich
SELECT REPLACE('Test', 't', '-'); --REPLACE achtet nicht auf Groß-/Kleinschreibung (T und t werden hier ersetzt)

--CHARINDEX: Das erste Vorkommen von einem gegebenen Zeichen
SELECT CHARINDEX('x', 'Testtext'); --Hier Text zum suchen und Kriterium vertauschen
SELECT CHARINDEX('t', 'Testtext', 6); --Startposition zur Suche angeben