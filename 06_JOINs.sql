USE Northwind;

--Tabellen haben Abh�ngigkeiten zueinander in Form von IDs

--Prim�rschl�ssel (PK -> Primary Key)
----Existiert generell in jeder Tabelle (nicht erzwungen)
----Datens�tze eindeutig identifizieren
----Jeder Datensatz muss einen eindeutigen Schl�ssel haben (keine Duplikate)

--Fremdschl�ssel (FK)
----Prim�rschl�ssel aus einer anderen Tabelle -> Referenz
----Kann nur Werte enthalten die in der referenzierten Tabelle auch existieren

SELECT * FROM Orders; --EmployeeID
SELECT * FROM Employees; --Datens�tze kombinieren �ber EmployeeID

SELECT * FROM Orders
INNER JOIN Employees --Hier andere Tabelle angeben
ON Orders.EmployeeID = Employees.EmployeeID; --Hier angeben welche 2 Spalten verbunden werden

SELECT 
Employees.EmployeeID, --Ambiguous column name EmployeeID (in Orders und in Employees ist eine EmployeeID enthalten)
FirstName + ' ' + LastName AS FullName,
Freight,
ShipName,
ShipAddress
FROM Orders
INNER JOIN Employees
ON Orders.EmployeeID = Employees.EmployeeID; --Sinnvolle Spalten ausw�hlen

SELECT 
e.EmployeeID, --Hier ist der Alias erzwingend, da Spalte in beiden Tabellen
e.FirstName + ' ' + e.LastName AS FullName,
o.Freight, --Hier sind die Aliases optional, da jede Spalte nur in einer Tabelle vorkommt
o.ShipName,
o.ShipAddress
FROM Orders AS o --Tabellenalias: Tabelle einen kurzen Namen geben um diese einfacher zu verwenden
INNER JOIN Employees e --AS nicht notwendig
ON o.EmployeeID = e.EmployeeID;

SELECT * FROM Orders o
INNER JOIN Customers c
ON o.CustomerID = c.CustomerID; --Orders und Customer kombinieren

SELECT 
o.OrderID,
o.Freight,
o.OrderDate,
o.CustomerID,
c.CompanyName,
c.ContactName,
c.Phone,
CONCAT_WS(' ', c.Address, c.City, c.PostalCode, c.Country) AS [Volle Adresse]--Funktionen im SELECT benutzen
FROM Orders o
INNER JOIN Customers c
ON o.CustomerID = c.CustomerID; --Sinnvolle Spalten ausw�hlen

SELECT * FROM Customers c
JOIN Orders o --INNER kann weggelassen werden
ON c.CustomerID = o.CustomerID; --Tabellen im FROM und im JOIN vertauschen um die Ausgabe umzudrehen

SELECT * FROM [Order Details] od
INNER JOIN Orders o ON od.OrderID = o.OrderID
INNER JOIN Products p ON od.ProductID = p.ProductID; --JOIN mit mehr als 2 Tabellen

SELECT 
o.OrderID,
od.ProductID,
p.ProductName,
p.QuantityPerUnit,
od.UnitPrice,
od.Quantity,
o.Freight
FROM [Order Details] od
INNER JOIN Orders o ON od.OrderID = o.OrderID
INNER JOIN Products p ON od.ProductID = p.ProductID; --Sinnvolle Spalten bei JOINs mit 3 Tabellen

SELECT * FROM Orders o
INNER JOIN Customers c
ON o.CustomerID = c.CustomerID; --830 Datens�tze

SELECT * FROM Orders o
RIGHT JOIN Customers c --Beachtet auch Datens�tze die auf der anderen Seite keine �bereinstimmung haben
ON o.CustomerID = c.CustomerID; --832 Datens�tze

SELECT * FROM Customers c
LEFT JOIN Orders o --RIGHT -> LEFT
ON o.CustomerID = c.CustomerID; --Customer und Order vertauschen damit Customer links sind

SELECT * FROM Customers c
FULL JOIN Orders o --Durch FULL werden beide Seiten erg�nzt (Alle Kunden die keine Bestellungen haben und alle Bestellungen die keine Kunden haben)
ON c.CustomerID = o.CustomerID;

SELECT c.* FROM Customers c --c.* um nur Daten aus Customer anzuzeigen
LEFT JOIN Orders o
ON o.CustomerID = c.CustomerID
WHERE o.OrderID IS NULL; --Hier schauen welche Kunden noch keine Bestellungen get�tigt haben

SELECT * FROM Orders CROSS JOIN Customers; --Alle Bestellungen mit allen Kunden kombinieren (Kreuzprodukt)