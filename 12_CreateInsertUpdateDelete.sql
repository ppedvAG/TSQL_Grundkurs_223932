USE Northwind;

CREATE TABLE Test
(
	--primary key: Prim�rschl�ssel, eindeutige Spalte, kann nicht null sein, h�ufig IDs, mehrere Prim�rschl�ssel (kombinierter Schl�ssel)
	--identity: Erh�ht die Spalte automatisch um 1, gut f�r IDs
	--identity(<Startwert>, <Inkrement>)
	ID int identity primary key,
	Vorname varchar(20),
	Nachname varchar(20) not null --Feld kann nicht null sein
);

---------------------------------------------------------------------------

--INSERT INTO <Name> VALUES (<Wert1>, <Wert2>, ...), (<Wert1>, <Wert2>, ...)
INSERT INTO Test VALUES
('Max', 'Muster')

--Mehrere Datens�tze gleichzeitig einf�gen
INSERT INTO Test VALUES
('Max', 'Muster'),
('Test', 'Test');

--Nur bestimmte Spalten in die Tabelle schreiben statt jeden Wert
INSERT INTO Customers (CustomerID, CompanyName, Country) VALUES
('PPEDV', 'ppedv AG', 'DE');

--NULL nicht m�glich da Nachname NOT NULL ist
INSERT INTO Test VALUES
('Test', NULL)

CREATE PROC p_Test
AS
	SELECT FirstName, LastName FROM Employees;
GO

--Ergebnis einer Prozedur in eine Tabelle eintragen
INSERT INTO Test
EXEC p_Test;

--SELECT INTO: Ergebnis eines SELECTs in eine neue Tabelle eintragen
SELECT FirstName, LastName
INTO Test
FROM Employees;

--Ergebnis eines SELECTs in eine Tabelle eintragen
INSERT INTO Test
SELECT FirstName, LastName FROM Employees;

---------------------------------------------------------------------------

--UPDATE <Name> SET <Spalte> = <Neuer Wert>
UPDATE Test SET Nachname = 'Test';

--Bei UPDATE unbedingt WHERE verwenden um nicht alle Daten zu �ndern
UPDATE Test
SET Nachname = Nachname + '123' --Den bestehenden Wert verwenden
WHERE ID BETWEEN 5 AND 10;

---------------------------------------------------------------------------

--CREATE SEQUENCE <Name> AS <Datentyp>
CREATE SEQUENCE TestSeq AS INT;

--Startwert und Inkrement festlegen
CREATE SEQUENCE TestSeq AS INT
START WITH 230000
INCREMENT BY 1;

--N�chsten Wert holen
SELECT NEXT VALUE FOR TestSeq;

--N�chsten Value auch bei INSERT m�glich
INSERT INTO Test VALUES
(NEXT VALUE FOR TestSeq, 'Test');

---------------------------------------------------------------------------

--DELETE FROM <Name>
DELETE FROM Test; --L�scht alle Daten ohne WHERE

DELETE FROM Test WHERE ID > 20;

--L�scht alle Daten (kann kein WHERE beinhalten)
--Programmierer wollte explizit alle Daten l�schen
TRUNCATE TABLE Test;

---------------------------------------------------------------------------

--Transaktion
--Speichert ausgef�hrte INSERT/UPDATE/DELETE Statements und erm�glicht damit mehr Sicherheit
BEGIN TRANSACTION;

INSERT INTO Test VALUES --Tabelle wird gesperrt und INSERT wird vorerst nicht ausgef�hrt
('Max', 'Muster'),
('Test', 'Test');

UPDATE Test SET Nachname = 'X'; --UPDATE wird auch gespeichert

COMMIT; --Tempor�re �nderungen in die Datenbank schreiben (�nderungen �bernehmen)
ROLLBACK; --Tempor�re �nderungen r�ckg�ngig machen (Alte Daten wiederherstellen)

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; --Tempor�re Daten lesbar machen

---------------------------------------------------------------------------

SELECT * FROM INFORMATION_SCHEMA.TABLES; --Alle Tabellen und Views anzeigen
SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE = 'BASE TABLE'; --Alle Tabellen anzeigen

SELECT * FROM INFORMATION_SCHEMA.COLUMNS; --Alle Spalten anzeigen
SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Employees'; --Alle Spalten einer Tabelle anzeigen

---------------------------------------------------------------------------

ALTER TABLE Test ADD X int;

---------------------------------------------------------------------------

CREATE TABLE FKTest
(
	TestID int primary key identity,
	Name varchar(20)
);

CREATE TABLE PKTest
(
	ID int identity,
	Vorname varchar(20),
	Nachname varchar(20),
	Geburtsdatum date,
	FK_TestID int, --Muss den selben Typen wie der Schl�ssel in der anderen Tabelle haben

	CONSTRAINT PK_ID PRIMARY KEY(ID),

	CONSTRAINT FK_PKTest_FKTest --Name von FK angeben
	FOREIGN KEY(FK_TestID) --Die Spalte des FK in dieser Tabelle angeben
	REFERENCES FKTest(TestID), --Die andere Tabelle + Spalte angeben

	--Check Constraint: �berpr�ft vor einer �nderung ob der gegebene Wert valide ist
	CONSTRAINT CHK_GebDat CHECK (YEAR(Geburtsdatum) > 1900)
);

--Nicht m�glich, da kein Datensatz in der anderen Tabelle mit ID 1
INSERT INTO PKTest VALUES
('test', 'test', '20000101', 1);

INSERT INTO FKTest VALUES
('Max');

--Nicht m�glich, da Check-Constraint verletzt
INSERT INTO PKTest VALUES
('test', 'test', '18000101', 1);