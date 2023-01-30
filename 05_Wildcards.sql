USE Northwind;

-- %

SELECT * FROM Customers WHERE Country LIKE 'A%'; --Alle Customer finden die in einem Land wohnen das mit A anf�ngt

SELECT * FROM Customers WHERE Country LIKE 'a%'; --Case-Insensitive

SELECT * FROM Customers WHERE Country LIKE '%A'; --Alle L�nder die mit A enden

SELECT * FROM Customers WHERE Country LIKE '%A%'; --A in der Mitte (beliebig viele Zeichen sind auch 0 Zeichen -> Andorra)

SELECT * FROM Customers WHERE Country LIKE '%A%A%'; --Alle L�nder die mindestens 2 A's enthalten

-- _

SELECT * FROM Customers WHERE City LIKE '_�nchen'; --Genau ein beliebiges Zeichen suchen

SELECT * FROM Customers WHERE PostalCode LIKE '____'; --Genau vier beliebige Zeichen suchen

SELECT * FROM Customers WHERE PostalCode LIKE '1____';

-- []

SELECT * FROM Customers WHERE Country LIKE '[abc]%'; --Alle L�nder die mit A, B oder C anfangen

SELECT * FROM Customers WHERE Country LIKE '[a-f]%'; --Bereich festlegen mit Bindestrich

SELECT * FROM Customers WHERE PostalCode LIKE '[0-9][0-9][0-9][0-9]'; --UK Postleitzahlen fallen raus

SELECT * FROM Customers WHERE Country LIKE '[^a-f]%'; --^: Klammer invertieren

SELECT * FROM Customers WHERE Country LIKE '[a-c|v-z]%'; --Bereiche verbinden

SELECT * FROM Customers WHERE CompanyName LIKE '%[%]%'; --Sonderfall: Prozent suchen

SELECT * FROM Customers WHERE CompanyName LIKE '%['']%'; --Sonderfall: Hochkomma suchen