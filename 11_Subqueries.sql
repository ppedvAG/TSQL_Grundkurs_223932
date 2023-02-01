USE Northwind;

--Alle Bestellungen die von den Frachtkosten her über dem Durchschnitt sind
SELECT * FROM Orders WHERE Freight > AVG(Freight); --Nicht möglich

--Mit Variable
DECLARE @avg float = 0;
SET @avg = (SELECT AVG(Freight) FROM Orders);
--SELECT @avg;
SELECT * FROM Orders WHERE Freight > @avg ORDER BY Freight;

--Mit Unterabfrage
SELECT * FROM Orders WHERE Freight > (SELECT AVG(Freight) FROM Orders); --Aggregatsfunktionen geben immer einen Wert zurück

SELECT * FROM Orders WHERE Freight > (SELECT TOP 1 Freight FROM Orders); --Mit TOP 1 genau einen Wert holen

SELECT * FROM Orders WHERE Freight >= (SELECT Freight FROM Orders WHERE Freight > 1000); --Zufälligerweise kommt hier nur ein Wert heraus (DB schaut wie viele Werte hier heraus kommen)

--Subselect im IN (Finde alle Kunden die in einem Land wohnen in dem auch ein Employee wohnt)
SELECT * FROM Customers
WHERE Country IN(SELECT Country FROM Employees); --Alle Ergebnisse werden in das IN gegeben

SELECT Freight, (SELECT AVG(Freight) FROM Orders)
FROM Orders ORDER BY Freight; --Subselect im SELECT

SELECT *
FROM
(
	SELECT
	Orders.EmployeeID,
	Orders.Freight,
	Employees.FirstName + ' ' + Employees.LastName AS FullName --Jede Spalte muss einen Namen haben
	FROM Orders --Unterabfrage muss bei jeder Spalte einen anderen Namen haben
	INNER JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID
) AS Ergebnis --Unterabfrage muss einen Namen haben
WHERE Ergebnis.Freight > 50
ORDER BY Ergebnis.EmployeeID; --Korrelierte Abfrage

SELECT * FROM Customers
WHERE EXISTS (SELECT * FROM Customers WHERE Country LIKE 'X%'); --EXISTS gibt true/false zurück

SELECT * FROM Customers
WHERE NOT EXISTS (SELECT * FROM Customers WHERE Country LIKE 'X%'); --Wenn true -> alle Zeilen sonst keine Zeilen