USE Northwind;

--ORDER BY: Ergebnis nach einer Spalte sortieren

SELECT * FROM Customers ORDER BY Country;

SELECT * FROM Customers ORDER BY Country, City; --Sortierung nach mehreren Spalten (Primär: Country, Sekundär: City)

SELECT * FROM Customers ORDER BY Country DESC, City ASC; --ASC/DESC: Sortierrichtung vorgeben (DESC -> Absteigend, ASC -> Aufsteigend, Standard)

SELECT * FROM Customers ORDER BY 2; --Nach Spaltenindex sortieren (hier CompanyName)

SELECT CompanyName, ContactName, Address, Phone FROM Customers ORDER BY 2;

SELECT * FROM Customers ORDER BY 9, 6; --Sortierung nach mehreren Spalten mit Indizes

SELECT CONCAT_WS(' ', TitleOfCourtesy, FirstName, LastName) AS FullName FROM Employees ORDER BY FullName; --Nach Spaltenalias sortieren

SELECT CONCAT_WS(' ', TitleOfCourtesy, FirstName, LastName) AS [Full Name] FROM Employees ORDER BY [Full Name];

--DISTINCT: Macht das Ergebnis eindeutig (filtert Duplikate)

SELECT Country FROM Customers ORDER BY 1; --Duplikate -> 91 Datensätze

SELECT DISTINCT Country FROM Customers; --Keine Duplikate mehr -> 22 Datensätze

SELECT DISTINCT Country, City FROM Customers ORDER BY 1, 2; --Entfernt alle Duplikate von Kombinationen

SELECT COUNT(*) FROM Customers; --Anzahl der Customer

SELECT COUNT(DISTINCT Country) FROM Customers; --Anzahl der einzigartigen Länder

--TOP: Gibt die Top X Datensätze aus

SELECT TOP 10 *
FROM Orders; --Obersten 10 Datensätze der Tabelle (nicht aussagekräftig)

SELECT TOP 10 * FROM Orders ORDER BY Freight; --Die 10 günstigsten Bestellungen

SELECT TOP 10 * FROM Orders ORDER BY Freight DESC; --Die 10 teuersten Bestellungen

SELECT TOP 2 PERCENT * FROM Orders ORDER BY Freight; --Gibt die obersten 2% des Ergebnisses aus (2% der Tabelle -> 17 Datensätze)

SELECT TOP 2 PERCENT * FROM Orders WHERE Freight > 100 ORDER BY Freight DESC; --Filterung mit WHERE zuerst -> 187 Datensätze -> 2%: 4 Datensätze

SELECT TOP 2 PERCENT * FROM [Order Details] ORDER BY Quantity; --Kleinsten Bestellungen (44)

SELECT TOP 1 PERCENT * FROM [Order Details] ORDER BY Quantity; --Nicht alle Bestellungen mit 2 Quantity sichtbar (22)

SELECT * FROM [Order Details] WHERE Quantity <= 2; --69 Datensätze

SELECT TOP 4 PERCENT WITH TIES *
FROM [Order Details]
ORDER BY Quantity; --115

SELECT TOP 4 PERCENT *
FROM [Order Details]
ORDER BY Quantity; --87