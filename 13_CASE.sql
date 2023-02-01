USE Northwind;

--CASE: Erzeugt eine neue Spalte im SELECT abhängig von der gegebenen Bedingung

SELECT *,
	CASE --If/Else Baum
		WHEN Freight > 100 THEN 'Teure Bestellung'
		WHEN Freight <= 100 THEN 'Günstige Bestellung'
	END AS Status
FROM Orders;

SELECT *,
	CASE
		WHEN Country IN('Austria', 'Germany', 'Switzerland') THEN 'Spricht Deutsch'
		ELSE 'Spricht kein Deutsch' --ELSE für alle anderen Fälle
	END AS [Kann Deutsch]
FROM Customers;

SELECT *,
	CASE
		WHEN ShippedDate < RequiredDate THEN 'Vorzeitig angekommen'
		WHEN ShippedDate = RequiredDate THEN 'Genau rechtzeitig angekommen'
		WHEN ShippedDate > RequiredDate THEN 'Zu spät angekommen'
		ELSE 'Noch nicht angekommen' --Für NULL Fälle
	END AS Lieferstatus
FROM Orders
ORDER BY Lieferstatus; --ORDER BY auch möglich durch Alias

--Rechnungsposten > 5000 -> 20% Rabatt, Rechnungsposten > 2000 -> 10% Rabatt, Rechnungsposten > 500 -> 5% Rabatt
SELECT * FROM [Order Details]
WHERE Quantity * UnitPrice >
CASE
	WHEN Discount >= 0.2 THEN 5000 --Wenn dieses CASE ausgeführt wird, werden die restlichen CASEs ausgelassen
	WHEN Discount >= 0.1 THEN 2000
	WHEN Discount >= 0.05 THEN 500
	--ELSE 0 --Passiert automatisch
END