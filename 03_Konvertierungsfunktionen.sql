USE Northwind;

--CAST: Wandelt einen Wert zu einem anderen Typen um
SELECT CAST(GETDATE() AS DATE); --Datetime zu einem Date konvertieren (Zeit fällt weg)

SELECT CAST(GETDATE() AS TIME); --Datetime zu einer Zeit konvertieren (Datum fällt weg)

SELECT HireDate, CAST(HireDate AS DATE) FROM Employees; --Cast auf Tabellenspalten anwenden

SELECT '123' + 3; --'123' wird automatisch zu int konvertiert

SELECT '123.4' + 3; --Kommazahlen sind hier nicht möglich

SELECT CAST('123.4' AS FLOAT) + 3; --Explizite Konvertierung erzwingen

SELECT CAST('2023-01-30' AS DATE); --Datumsstring konvertieren (Datumsfunktionen jetzt möglich)

SELECT CAST('30.01.2023' AS DATE); --Funktioniert

SELECT CAST('01/30/2023' AS DATE); --Funktioniert nicht

--CONVERT: Selbiges wie CAST nur alt

SELECT CONVERT(DATE, '2023-01-30');

--Date Styles
--https://docs.microsoft.com/en-us/sql/t-sql/functions/cast-and-convert-transact-sql?view=sql-server-2017#date-and-time-styles

SELECT CONVERT(VARCHAR, GETDATE(), 4); --30.01.23
SELECT CONVERT(VARCHAR, GETDATE(), 104); --30.01.2023

--FORMAT: Formatiert den gegebenen Wert in die angegebene Formatierung

/*
	Intervalle:
    year, yyyy, yy = Year
    month, MM, M = month
    week, ww, wk = Week
    day, dd, d = Day
    hour, hh = hour
    minute, mi, n = Minute
    second, ss, s = Second
    millisecond, ms = Millisecond
	nanosecond, ns

    weekday, dw, w = Weekday (1-7)
    dayofyear, dy, y = Day of the year (1-366)
    quarter, qq, q = Quarter (1-4)
*/

SELECT FORMAT(GETDATE(), 'yy-MM-dd');

SELECT FORMAT(GETDATE(), 'dd.MM.yyyy');

SELECT FORMAT(GETDATE(), 'dd.MM.yyyy hh:mm:ss');

SELECT FORMAT(GETDATE(), 'd dd ddd dddd M MM MMM MMMM yy yyyy');

SELECT FORMAT(GETDATE(), 'dddd, dd. MMMM yyyy hh:mm:ss');

SELECT FORMAT(HireDate, 'dddd, dd. MMMM yyyy hh:mm:ss') FROM Employees;

--Schnellformatierungen
SELECT FORMAT(GETDATE(), 'd');
SELECT FORMAT(GETDATE(), 'D');

SELECT FORMAT(12345, 'Die Zahl ist #');
SELECT FORMAT(12345, 'Die Zahl beginnt mit # und endet mit #');

SELECT FORMAT(HireDate, 'D') FROM Employees;