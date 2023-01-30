USE Northwind;

SELECT GETDATE(); --Jetztiges Datum, Millisekundengenau
SELECT SYSDATETIME(); --Jetztiges Datum, Nanosekundengenau

/*
	Intervalle:
    year, yyyy, yy = Year
    month, MM, M = month
    week, ww, wk = Week
    day, dd, d = Day
    hour, hh = hour
    minute, mi, m = Minute
    second, ss, s = Second
    millisecond, ms = Millisecond
	nanosecond, ns

    weekday, dw, w = Weekday (1-7)
    dayofyear, dy, y = Day of the year (1-366)
    quarter, qq, q = Quarter (1-4)
*/

--YEAR/MONTH/DAY
SELECT YEAR(GETDATE()); --Das Jahr vom heutigen Datum
SELECT MONTH(GETDATE()); --Das Monat vom heutigen Datum
SELECT DAY(GETDATE()); --Der Tag vom heutigen Datum

SELECT HireDate, YEAR(HireDate) AS Einstellungsjahr FROM Employees; --Datumsfunktion auf eine Spalte anwenden

--DATEPART: Gibt den Teil eines Datums zurück, flexibler als YEAR/MONTH/DAY
SELECT DATEPART(YEAR, GETDATE()); --Selbiges wie YEAR(...)
SELECT DATEPART(HOUR, GETDATE()); --Die Stunde vom heutigen Datum

SELECT DATEPART(WEEKDAY, GETDATE()); --Wochentag vom heutigen Datum numerisch (1 -> Montag)
SELECT DATEPART(DY, GETDATE()); --Den heutigen Jahrestag (30)
SELECT DATEPART(QQ, GETDATE()); --Das Quartal des Datums (1)

SELECT HireDate, DATEPART(DY, HireDate) FROM Employees;

--DATEDIFF: Unterschied zwischen zwei Datumswerten ermitteln
SELECT HireDate, DATEDIFF(YEAR, HireDate, GETDATE()) FROM Employees; --Wie lange sind unsere Mitarbeiter schon in der Firma? (ungenau)

SELECT DATEDIFF(YEAR, '30.01.2020', GETDATE()); --Deutsches Datum möglich weil deutscher Server
SELECT DATEDIFF(YEAR, '2020-01-30', GETDATE()); --ISO-8601 Datum immer möglich
SELECT DATEDIFF(YEAR, '01/30/2020', GETDATE()); --Amerikanisches Datum nicht möglich (aber auf amerikanischem Server möglich)

--Bei Datumswerten generell ISO benutzen

--DATENAME: Von Monaten oder Tagen den schönen Namen ausgeben
SELECT DATENAME(MONTH, GETDATE()); --Januar
SELECT DATENAME(WEEKDAY, GETDATE()); --Montag

--DATEADD: Addiert/Subtrahiert ein Intervall auf ein Datum
SELECT DATEADD(YEAR, 5, GETDATE()); --Addiert 5 Jahre auf das heutige Datum
SELECT DATEADD(YEAR, -5, GETDATE()); --Subtrahiert 5 Jahre vom heutigen Datum

SELECT DATEADD(DAY, 20, GETDATE()); --Überschläge werden beachtet
SELECT DATEADD(MONTH, 20, GETDATE()); --Auch bei Monaten sind Überschläge möglich

SELECT DATEADD(DAY, 730, GETDATE()); --Schaltjahre beachten mit DAY