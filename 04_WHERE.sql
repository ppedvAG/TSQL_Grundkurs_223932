USE Northwind;

-- WHERE: Ausgabe filtern anhand von Bedingungen
-- Operatoren:
-- <, >, <=, >= kleiner, größer, kleiner-gleich, größer-gleich
-- =, !=, <> gleich, ungleich, ungleich
-- BETWEEN, IN, LIKE: BETWEEN: Zwischen X und Y, IN: innerhalb einer Liste
-- AND, OR: Bedingungen verknüpfen, AND: beide Bedingungen müssen wahr sein, OR: eine von beiden Bedingungen muss wahr sein oder beide
-- NOT: Bedingung invertieren

SELECT * FROM Orders WHERE Freight > 50; --Bestellungen mit Freight mindestens 50

SELECT * FROM Orders WHERE Freight < 50; --Bestellungen mit Frachtkosten von weniger als 50

SELECT * FROM Orders WHERE EmployeeID = 1 AND Freight > 50; --Alle Bestellungen vom Employee 1 mit mindestens 50 Frachtkosten

SELECT * FROM Orders WHERE EmployeeID = 1 OR Freight > 50; --Alle Bestellungen mit Employee 1 oder mindestens 50 Frachtkosten

--BETWEEN

SELECT * FROM Orders WHERE Freight BETWEEN 10 AND 20; --Alle Bestellungen mit Frachtkosten von 10 bis 20

SELECT * FROM Orders WHERE EmployeeID BETWEEN 1 AND 3; --Grenzen sind inkludiert

SELECT * FROM Orders WHERE OrderDate BETWEEN '19970101' AND '19970630'; --Between mit Datumswerten

SELECT * FROM Orders WHERE OrderDate BETWEEN '1997-01-01' AND '1997-06-30'; --In MySQL möglich, hier nicht

--Funktionen

SELECT * FROM Orders WHERE YEAR(OrderDate) = 1997; --Funktionen im WHERE benutzen

SELECT * FROM Orders WHERE DATEPART(DAY, OrderDate) = 20; --DATEPART auch möglich

--IN

SELECT * FROM Customers WHERE Country = 'Spain' OR Country = 'UK' OR Country = 'USA'; --Lang und unübersichtlich

SELECT * FROM Customers WHERE Country IN('Spain', 'UK', 'USA'); --Selbiges wie oben nur mit IN

SELECT * FROM Orders WHERE EmployeeID IN(1, 2, 5, 8); --IN mit numerischen Werten

SELECT * FROM Orders WHERE YEAR(OrderDate) IN(1997, 1998); --IN mit Funktion

SELECT * FROM Orders WHERE ShipCountry = 'UK' AND (YEAR(OrderDate) = 1997 OR YEAR(OrderDate) = 1998); --Mit Klammern kann man die Reihenfolge von Bedingungen anpassen

--NULL

SELECT * FROM Customers WHERE Fax != NULL; --NULL Vergleiche funktioniert nicht mit = oder !=

SELECT * FROM Customers WHERE Fax IS NOT NULL; --IS NOT NULL um zu schauen welche Datensätze nicht leer sind

SELECT * FROM Customers WHERE Fax IS NULL; --IS NULL um zu schauen welche Datensätze leer sind

--NOT

SELECT * FROM Orders WHERE OrderDate NOT BETWEEN '19970101' AND '19970630'; --Mit NOT BETWEEN invertieren

SELECT * FROM Orders WHERE EmployeeID NOT IN(1, 2, 5, 8); --Auch IN kann invertieren