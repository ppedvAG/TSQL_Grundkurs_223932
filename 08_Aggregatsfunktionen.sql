USE Northwind;

SELECT COUNT(*) FROM Customers; --Anzahl der Datens�tze

SELECT COUNT(*) FROM Customers WHERE Country = 'UK'; --Anzahl Customer aus UK (7)s

SELECT COUNT(DISTINCT Country) FROM Customers; --Anzahl einzigartiger (verschiedener) L�nder (22)

SELECT
AVG(Freight) AS Durchschnittskosten,
MIN(Freight) AS BilligsteBestellung,
MAX(Freight) AS TeuersteBestellung,
SUM(Freight) AS Gesamtkosten
FROM Orders;

SELECT *, AVG(Freight) FROM Orders; --AVG/MIN/MAX/SUM/COUNT sind mit * nicht m�glich

--------------------------------------------------------------------------------------------------------

SELECT *
FROM Orders
GROUP BY EmployeeID; --1er Gruppe (10258, 10270, 10275, ...), 2er Gruppe (11073, 11070, 11060, ...)

--In SELECT k�nnen nur Spalten ausgegeben werden, die in GROUP BY sind oder in einer Aggregatsfunktion sind

SELECT
EmployeeID, --M�glich, da in GROUP BY
COUNT(*) AS AnzBestellungen, --Aggregatsfunktion beziehen sich hier auch die einzelnen Gruppen
AVG(Freight) AS Durchschnittskosten,
MIN(Freight) AS KleinsteKosten,
MAX(Freight) AS MaxKosten,
SUM(Freight) AS Gesamtkosten
FROM Orders
GROUP BY EmployeeID;

SELECT
Country,
COUNT(*) AS AnzKunden
FROM Customers
GROUP BY Country
ORDER BY AnzKunden DESC;

SELECT
Country, City,
COUNT(*) AS AnzKunden
FROM Customers
GROUP BY Country, City --Erzeuge Country + City Gruppen (Andorra M�xico D.F., Argentina Buenos Aires, Austria Graz, ...)
ORDER BY COUNT(*) DESC; --Auch nach Aggregatsfunktionen kann sortiert werden

--------------------------------------------------------------------------------------------------------

--WHERE vs. GROUP BY + HAVING
--WHERE filtert die Daten bevor sie gruppiert werden
--HAVING filtert die Gruppen (die Daten nach WHERE werden hier verwendet)

SELECT
CustomerID,
COUNT(*)
FROM Orders
GROUP BY CustomerID
HAVING COUNT(*) >= 20; --Finde alle Gro�kunden (20 oder mehr Bestellungen

SELECT
CustomerID,
COUNT(*)
FROM Orders
WHERE Freight < 100 --Schr�nkt die Menge an Daten ein die bei GROUP BY verwendet wird
GROUP BY CustomerID
HAVING COUNT(*) >= 10;

SELECT COUNT(*) FROM Orders WHERE Freight < 100; --643

SELECT
CustomerID,
COUNT(*)
FROM Orders
GROUP BY CustomerID
HAVING AVG(Freight) >= 100; --Alle Aggregatsfunktionen hier unten m�glich

SELECT
c.CustomerID,
c.CompanyName,
COUNT(*) AS Anz
FROM Orders o
INNER JOIN Customers c
ON o.CustomerID = c.CustomerID
GROUP BY c.CustomerID, c.CompanyName
ORDER BY Anz DESC;
--Wenn nach einer Schl�sselspalte gruppiert wird, k�nnen weitere Spalten nach belieben hinzugef�gt werden.
--Nachdem der Schl�ssel eindeutig ist, ist jeder Datensatz automatisch alleine in seiner Gruppe.

SELECT
OrderID,
SUM(UnitPrice * Quantity) --Berechnungen hier m�glich
FROM [Order Details]
GROUP BY OrderID; --Gesamtpreise pro Rechnung in Order Details

SELECT
od.OrderID,
o.ShipName,
SUM(UnitPrice * Quantity) AS Summe
FROM [Order Details] od
INNER JOIN Orders o
ON o.OrderID = od.OrderID
GROUP BY od.OrderID, o.ShipName; --ShipName hier m�glich, da OrderID eindeutig