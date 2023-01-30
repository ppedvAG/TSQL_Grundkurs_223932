USE Northwind; --Datenbank auswählen

/*
Mehrzeiliger
Kommentar
*/

SELECT 100; --Einzelnen Wert ausgeben

SELECT 10.5; --Kommazahl mit Punkt statt Komma

SELECT 'Test'; --Text mit ''

--Strg + E: Markierte Statements ausführen
--Strg + R: Ergebnisansicht schließen

SELECT 100 * 3; --Berechnung

SELECT '100 * 3'; --Wird als Text interpretiert

SELECT 100 AS Zahl; --AS: Spalte einen Namen geben

SELECT 100 AS Zahl1, 'Text' AS Text, 200 AS Zahl2; --Mehrere Spalten ausgeben

SELECT * FROM Customers; --*: Alles

SELECT CompanyName FROM Customers; --Bestimmte Spalten auswählen

SELECT CompanyName, ContactName FROM Customers; --Mehrere Spalten auswählen

SELECT Freight * 5 FROM Orders; --Berechnungen auf Spalten durchführen

SELECT Freight % 5 FROM Orders; --Modulo (%): Gibt den Rest einer Division zurück

SELECT Address + City + PostalCode + Country FROM Customers; --Strings verbinden (unschön)

SELECT Address + ' ' + City + ' ' + PostalCode + ', ' + Country FROM Customers; --Strings verbinden mit Abständen

SELECT Address + ' ' + City + ' ' + PostalCode + ', ' + Country AS [Volle Adresse] FROM Customers;
SELECT Address + ' ' + City + ' ' + PostalCode + ', ' + Country AS "Volle Adresse" FROM Customers;
--Namen mit Abständen müssen mit [] oder "" angegeben werden

SELECT Address + ' ' + City + ' ' + PostalCode + ', ' + Country AS "Volle Adresse"
FROM Customers;

SELECT
CompanyName,
ContactName,
Address,
City
FROM Customers; --Umbrüche beliebig möglich