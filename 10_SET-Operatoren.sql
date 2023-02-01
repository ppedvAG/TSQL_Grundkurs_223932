USE Northwind;

SELECT 'Test1', 'Test2'; --Zwei Spalten

SELECT 'Test1'
UNION --Ergebnisse von beiden SELECTs kombinieren
SELECT 'Test2';

--UNION
--Beide SELECTs müssen die selben Spalten ausgeben (Anzahl + Datentypen)
--Filtert Duplikate (Performance)

--Wir wollen alle Adressen aus der DB haben
SELECT * FROM Customers;
SELECT * FROM Suppliers;

SELECT Address FROM Customers
UNION
SELECT Address FROM Suppliers; --Alle Adressen

SELECT CONCAT_WS(' ', Address, City, PostalCode, Country) FROM Customers
UNION
SELECT CONCAT_WS(' ', Address, City, PostalCode, Country) FROM Suppliers; --Alle langen Adressen

SELECT CompanyName FROM Customers
UNION
SELECT CompanyName FROM Suppliers; --Alle CompanyNames

SELECT CompanyName, ContactName FROM Customers
UNION
SELECT CompanyName FROM Suppliers; --Unterschiedlich viele Spalten nicht möglich

SELECT CompanyName, ContactName FROM Customers
UNION
SELECT CompanyName, NULL FROM Suppliers; --Spalten ergänzen durch '' oder NULL

SELECT CustomerID FROM Customers
UNION
SELECT SupplierID FROM Suppliers; --Unterschiedliche Typen sind nicht kompatibel

SELECT CustomerID FROM Customers
UNION
SELECT CAST(SupplierID AS varchar) FROM Suppliers; --Einzelne Spalten konvertieren in anderen Typen

SELECT CompanyName, ContactName, Address, Phone FROM Customers
UNION
SELECT CompanyName, ContactName, Address, Phone FROM Suppliers; --Sinnvolle Spalten auswählen

SELECT Phone FROM Customers
UNION
SELECT Phone FROM Suppliers
UNION
SELECT HomePhone FROM Employees; --Mehr als zwei Tabellen mit UNION kombinieren

SELECT Phone AS P1 FROM Customers --AS bei UNION: Das AS beim ersten SELECT wird akzeptiert, die anderen werden verworfen
UNION
SELECT Phone AS P2 FROM Suppliers --P2 wird verworfen
UNION
SELECT HomePhone AS P3 FROM Employees; --P3 wird verworfen

SELECT Country FROM Customers
INTERSECT
SELECT Country FROM Employees; --Finde alle Länder in denen wir Kunden und Mitarbeiter haben

SELECT Country FROM Customers
EXCEPT
SELECT Country FROM Employees; --Finde alle Länder in denen wir Kunden aber keine Mitarbeiter haben

DECLARE @i int = 0
WHILE @i < 20000
BEGIN
	INSERT INTO Umsatz2021 VALUES
	(DATEADD(DAY, RAND()*365, '20210101'), RAND()*1000);
	SET @i += 1;
END

SELECT * FROM Umsatz2019
UNION ALL --Duplikate nicht filtern durch UNION ALL
SELECT * FROM Umsatz2020
UNION ALL --Ohne ALL: 10s, Mit ALL: 7s
SELECT * FROM Umsatz2021;

CREATE VIEW UmsatzGesamt
AS
	SELECT * FROM Umsatz2019
	UNION ALL
	SELECT * FROM Umsatz2020
	UNION ALL
	SELECT * FROM Umsatz2021;
GO

--Auf Gesamtumsatz zugreifen und damit alle Tabellen abdecken
SELECT * FROM UmsatzGesamt WHERE umsatz > 900;
SELECT * FROM UmsatzGesamt ORDER BY umsatz DESC;
SELECT YEAR(Datum), SUM(Umsatz) FROM UmsatzGesamt GROUP BY YEAR(Datum);