USE Northwind;

-- ĆWICZENIE

-- 1. Podaj liczbę produktów o cenach mniejszych niż 10$ lub większych niż 20$.
SELECT COUNT(*) AS NumberOfProducts
  FROM Products
  WHERE UnitPrice NOT BETWEEN 10 AND 20;

-- 2. Podaj maksymalną cenę produktu dla produktów o cenach poniżej 20$.
SELECT MAX(UnitPrice) AS MaxPriceUnder20
  FROM Products
  WHERE UnitPrice < 20;

-- 3. Podaj maksymalną i minimalną i średnią cenę produktu dla produktów o
-- produktach sprzedawanych w butelkach (‘bottle’).
SELECT AVG(UnitPrice) AS AveragePrice,
       MIN(UnitPrice) AS MinimumPrice,
       MAX(UnitPrice) AS MaximumPrice
  FROM Products
  WHERE QuantityPerUnit LIKE '%bottle%';

-- 4. Wypisz informację o wszystkich produktach o cenie powyżej średniej.
SELECT *
  FROM Products
  WHERE UnitPrice > (SELECT AVG(UnitPrice) FROM Products);

-- 5. Podaj sumę/wartość zamówienia o numerze 10250.
SELECT SUM(UnitPrice * Quantity * (1 - Discount)) AS TotalPrice
  FROM [Order Details]
  WHERE OrderID = 10250;

-- ĆWICZENIE

-- 1. Podaj maksymalną cenę zamawianego produktu dla każdego zamówienia.
SELECT OrderID, MAX(UnitPrice) AS MaxPrice
  FROM [Order Details]
  GROUP BY OrderID;

-- 2. Posortuj zamówienia wg maksymalnej ceny produktu.
SELECT OrderID, MAX(UnitPrice) AS MaxPrice
  FROM [Order Details]
  GROUP BY OrderID
  ORDER BY MaxPrice DESC;

-- 3. Podaj maksymalną i minimalną cenę zamawianego produktu dla każdego
-- zamówienia.
SELECT MAX(UnitPrice), MIN(UnitPrice)
    FROM [Order Details]
    GROUP BY OrderID;

-- 4. Podaj liczbę zamówień dostarczanych przez poszczególnych spedytorów
-- (przewoźników).
SELECT COUNT(*) as Counter, ShipVia, (SELECT CompanyName FROM Shippers WHERE ShipperID = ShipVia) AS ShipperName
  FROM Orders
  GROUP BY ShipVia

-- 5. Który z spedytorów był najaktywniejszy w 1997 roku.
SELECT TOP 1 COUNT(*) as Counter, (SELECT CompanyName FROM Shippers WHERE ShipperID = ShipVia) AS ShipperName
  FROM Orders
  WHERE YEAR(ShippedDate) = 1997
  GROUP BY ShipVia
  ORDER BY Counter DESC;

-- Który ze spedytorów zarobił najwięcej na przesyłkach w 1997.
SELECT TOP 1 SUM(Freight) AS Value, (SELECT CompanyName FROM Shippers WHERE ShipperID = ShipVia) AS ShipperName
  FROM Orders
  WHERE YEAR(ShippedDate) = 1997
  GROUP BY ShipVia
  ORDER BY Value DESC;


-- ĆWICZENIE

-- 1. Wyświetl zamówienia dla których liczba pozycji zamówienia jest większa niż 5.
SELECT *
  FROM Orders
  WHERE OrderID IN (
      SELECT OrderID
        FROM [Order Details]
        GROUP BY OrderID
        HAVING COUNT(OrderID) > 5
      );

-- 2. Wyświetl klientów dla których w 1998 roku zrealizowano więcej niż 8 zamówień
-- (wyniki posortuj malejąco wg łącznej kwoty za dostarczenie zamówień dla
-- każdego z klientów).
SELECT *
  FROM Customers
  WHERE CustomerID IN (
      SELECT CustomerID
        FROM Orders
        WHERE YEAR(ShippedDate) = 1998
        GROUP BY CustomerID
        HAVING COUNT(CustomerID) > 8
      );