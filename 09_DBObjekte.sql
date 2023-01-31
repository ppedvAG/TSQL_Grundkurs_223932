USE Northwind;
GO --Mit GO ein Batch öffnen

--CREATE VIEW <Name> AS <SQL-Statement> GO
--Statischer Snapshot eines Teils der Datenbank
--v_ um Views von restlichen Objekten der Datenbank zu differenzieren
--kein ORDER BY

CREATE VIEW v_Countries
AS
	SELECT Country FROM Customers;
GO --Mit GO ein Batch schließen

SELECT * FROM v_Countries; --View ansprechen mit SELECT (hier WHERE und ORDER BY möglich)

SELECT * FROM v_Countries WHERE Country LIKE 'A%' ORDER BY 1;

DROP VIEW v_Countries;
GO

CREATE VIEW v_Countries
AS
	SELECT DISTINCT Country FROM Customers;
GO

DROP VIEW IF EXISTS v_Countries; --IF EXISTS um zu prüfen ob die View existiert

DROP VIEW v_Chefs;
CREATE VIEW v_Chefs
AS
	SELECT 
	e.EmployeeID AS EmpID,
	CONCAT_WS(' ', e.FirstName, e.LastName) AS EmpName,
	chef.EmployeeID AS ChefID,
	CONCAT_WS(' ', chef.FirstName, chef.LastName) AS ChefName
	FROM Employees chef
	RIGHT JOIN Employees e
	ON chef.EmployeeID = e.ReportsTo
GO

SELECT * FROM v_Chefs;

----------------------------------------------------------------------

--CREATE PROCEDURE <Name> AS <SQL-Statement> GO
--p_ um Prozeduren von restlichen Objekten zu differenzieren
--Fixes Verhalten auf der Datenbank speichern

CREATE PROCEDURE p_CountriesCities
AS
	SELECT DISTINCT Country, City FROM Customers;
GO

EXECUTE p_CountriesCities; --EXECUTE <Name> um eine Prozedur auszuführen
EXEC p_CountriesCities;
p_CountriesCities;

--Prozedur mit Parameter

CREATE PROC p_OrdersFromTo @StartDate date, @EndDate date --Zwei Parameter (@StartDate, @EndDate)
AS
	SELECT *
	FROM Orders o
	INNER JOIN Customers c ON o.CustomerID = c.CustomerID
	INNER JOIN Employees e ON o.EmployeeID = e.EmployeeID
	WHERE OrderDate BETWEEN @StartDate AND @EndDate
GO

EXEC p_OrdersFromTo @StartDate = '19970101', @EndDate = '19970303'; --Parameter müssen hier übergeben werden
EXEC p_OrdersFromTo @StartDate = '19980101', @EndDate = '19980303';

DROP PROC p_OrdersFromTo;
DROP PROC p_CountriesCities;

----------------------------------------------------------------------

--Temporäre Tabellen: Tabellen die zur Zwischenspeicherung von Daten gedacht sind, werden nach Verbindungsabbruch oder Server Neustart gelöscht

SELECT Country, City
INTO Test --Daten in eine neue Tabelle einfügen
FROM Customers;

SELECT Country, City
INTO #Test --Daten in eine temporäre Tabelle einfügen
FROM Customers; --Temporäre Tabelle mit # am Anfang

SELECT * FROM #Test; --Temporäre Tabellen verhalten sich wie normale Tabellen

--Globale Temporäre Tabelle: Wird gelöscht wenn alle Benutzer die Verbindung getrennt haben die mit dieser Tabelle interagiert haben
SELECT Country, City
INTO ##Test
FROM Customers;

SELECT * FROM ##Test;

INSERT INTO #Test
EXEC p_CountriesCities; --Ergebnis einer Prozedur direkt in eine Tabelle schreiben