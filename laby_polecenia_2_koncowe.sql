USE Northwind;

-- ZADANIA Z LABÓW (EKSTRA)

-- 1. Ile lat pracował w firmie każdy z pracowników?
SELECT FirstName, LastName, DATEDIFF(YEAR, HireDate, GETDATE()) AS HowLongWorks
  FROM Employees;

-- 2. Policz sumę lat przepracowanych przez wszystkich pracowników i średni
-- czas pracy w firmie.
SELECT SUM(DATEDIFF(YEAR, HireDate, GETDATE())) AS SumOfYears
  FROM Employees;

-- 3. Dla każdego pracownika wyświetl imię, nazwisko i wiek.
SELECT FirstName, LastName, DATEDIFF(YEAR, BirthDate, GETDATE()) AS Age
  FROM Employees;

-- 4. Policz średni wiek wszystkich pracowników.
SELECT AVG(DATEDIFF(YEAR, BirthDate, GETDATE())) AS AverageAge
  FROM Employees;

-- 5. Wyświetl wszystkich pracowników, którzy mają więcej niż 25 lat.
SELECT FirstName, LastName, DATEDIFF(YEAR, BirthDate, GETDATE()) AS Age
  FROM Employees
  WHERE DATEDIFF(YEAR, BirthDate, GETDATE()) > 25;

-- 6. Policz średnią liczbę miesięcy przepracowanych przez każdego pracownika.
SELECT AVG(DATEDIFF(MONTH, HireDate, GETDATE())) AS AverageMonthsWorked
  FROM Employees;

-- 7. Wyświetl dane wszystkich pracowników, którzy przepracowali w firmie co najmniej
-- 320 miesięcy, ale nie więcej niż 333.
SELECT *
  FROM Employees
  WHERE DATEDIFF(MONTH, HireDate, GETDATE()) >= 320
    AND DATEDIFF(MONTH, HireDate, GETDATE()) < 333;

-- ĆWICZENIE 1

-- 1. Napisz polecenie, które oblicza wartość sprzedaży dla każdego zamówienia
-- w tablicy order details i zwraca wynik posortowany w malejącej kolejności
-- (wg wartości sprzedaży).
SELECT OrderID, SUM(UnitPrice * Quantity * (1 - Discount)) AS OrderTotalPrice
  FROM [Order Details]
  GROUP BY OrderID
  ORDER BY OrderTotalPrice DESC;

-- 2. Zmodyfikuj zapytanie z poprzedniego punktu, tak aby zwracało pierwszych 10 wierszy.
SELECT TOP 10 OrderID,
              ROUND(SUM(UnitPrice * Quantity * (1 - Discount)), 2) AS OrderTotalPrice
  FROM [Order Details]
  GROUP BY OrderID
  ORDER BY OrderTotalPrice DESC;

-- ĆWICZENIE 2

-- 1. Podaj liczbę zamówionych jednostek produktów dla produktów, dla których
-- productid < 3.
SELECT SUM(Quantity) AS TotalQuantity
  FROM [Order Details]
  WHERE ProductID < 3;

-- 2. Zmodyfikuj zapytanie z poprzedniego punktu, tak aby podawało liczbę
-- zamówionych jednostek produktu dla wszystkich produktów.
SELECT ProductID, SUM(Quantity) AS TotalQuantity
  FROM [Order Details]
  GROUP BY ProductID
  ORDER BY ProductID;

-- 3. Podaj nr zamówienia oraz wartość zamówienia, dla zamówień, dla których
-- łączna liczba zamawianych jednostek produktów jest > 250.
SELECT ProductID,
       CAST(SUM(UnitPrice * Quantity * (1 - Discount)) AS DECIMAL(10, 2)) AS OrderValue
  FROM [Order Details]
  GROUP BY ProductID
  HAVING SUM(Quantity) > 250
  ORDER BY ProductID;

-- ĆWICZENIE 3

-- 1. Dla każdego pracownika podaj liczbę obsługiwanych przez niego zamówień.
SELECT EmployeeID, COUNT(OrderID) AS OrdersToService
  FROM Orders
  GROUP BY EmployeeID;

-- 2. Dla każdego spedytora/przewoźnika podaj wartość "opłata za przesyłkę"
-- przewożonych przez niego zamówień.
SELECT ShipVia, SUM(Freight) AS TotalFreight
  FROM Orders
  GROUP BY ShipVia
  ORDER BY ShipVia;


-- 3. Dla każdego spedytora/przewoźnika podaj wartość "opłata za przesyłkę"
-- przewożonych przez niego zamówień w latach o 1996 do 1997.


-- ĆWICZENIE 4

-- 1. Dla każdego pracownika podaj liczbę obsługiwanych przez niego zamówień z
-- podziałem na lata i miesiące.

-- 2. Dla każdej kategorii podaj maksymalną i minimalną cenę produktu w tej
-- kategorii.
