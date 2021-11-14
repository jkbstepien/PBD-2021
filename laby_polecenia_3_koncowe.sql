USE Northwind;

-- ĆWICZENIE 1

-- 1. Dla każdego zamówienia podaj łączną liczbę zamówionych jednostek towaru oraz
-- nazwę klienta.
SELECT Orders.OrderID,
       SUM([Order Details].Quantity) AS TotalQuantity,
       Customers.CompanyName
  FROM Orders
  INNER JOIN [Order Details]
    ON Orders.OrderID = [Order Details].OrderID
  INNER JOIN Customers
    ON Orders.CustomerID = Customers.CustomerID
  GROUP BY Orders.OrderID, Customers.CompanyName
  ORDER BY Orders.OrderID;

-- 2. Zmodyfikuj poprzedni przykład, aby pokazać tylko takie zamówienia, dla których
-- łączna liczbę zamówionych jednostek jest większa niż 250.
SELECT Orders.OrderID,
       SUM([Order Details].Quantity) AS TotalQuantity,
       Customers.CompanyName
  FROM Orders
  INNER JOIN [Order Details]
    ON Orders.OrderID = [Order Details].OrderID
  INNER JOIN Customers
    ON Orders.CustomerID = Customers.CustomerID
  GROUP BY Orders.OrderID, Customers.CompanyName
  HAVING SUM([Order Details].Quantity) > 250
  ORDER BY Orders.OrderID;

-- 3. Dla każdego zamówienia podaj łączną wartość tego zamówienia oraz nazwę
-- klienta.
SELECT Orders.OrderID,
       SUM([Order Details].Quantity * [Order Details].UnitPrice) AS TotalPrice,
       Customers.CompanyName
  FROM Orders
  INNER JOIN [Order Details]
    ON Orders.OrderID = [Order Details].OrderID
  INNER JOIN Customers
    ON Orders.CustomerID = Customers.CustomerID
  GROUP BY Orders.OrderID, Customers.CompanyName
  ORDER BY Orders.OrderID;

-- 4. Zmodyfikuj poprzedni przykład, aby pokazać tylko takie zamówienia, dla których
-- łączna liczba jednostek jest większa niż 250.
SELECT Orders.OrderID,
       SUM([Order Details].Quantity * [Order Details].UnitPrice) AS TotalPrice,
       Customers.CompanyName
  FROM Orders
  INNER JOIN [Order Details]
    ON Orders.OrderID = [Order Details].OrderID
  INNER JOIN Customers
    ON Orders.CustomerID = Customers.CustomerID
  GROUP BY Orders.OrderID, Customers.CompanyName
  HAVING SUM([Order Details].Quantity) > 250
  ORDER BY Orders.OrderID;

-- 5. Zmodyfikuj poprzedni przykład tak żeby dodać jeszcze imię i nazwisko
-- pracownika obsługującego zamówienie.
SELECT Orders.OrderID,
       SUM([Order Details].Quantity * [Order Details].UnitPrice) AS TotalPrice,
       Customers.CompanyName,
       (Employees.LastName + ' ' + Employees.FirstName) AS Employee
  FROM Orders
  INNER JOIN [Order Details]
    ON Orders.OrderID = [Order Details].OrderID
  INNER JOIN Customers
    ON Orders.CustomerID = Customers.CustomerID
  INNER JOIN Employees
    ON Orders.EmployeeID = Employees.EmployeeID
  GROUP BY Orders.OrderID,
           Customers.CompanyName,
           Employees.LastName,
           Employees.FirstName
  HAVING SUM([Order Details].Quantity) > 250
  ORDER BY Orders.OrderID;

-- ĆWICZENIE 2

-- 1. Dla każdej kategorii produktu (nazwa), podaj łączną liczbę zamówionych przez
-- klientów jednostek towarów z tej kategorii.
SELECT Categories.CategoryName,
       SUM([Order Details].Quantity) AS TotalQuantity
  FROM Products
  INNER JOIN Categories
    ON Products.CategoryID = Categories.CategoryID
  INNER JOIN [Order Details]
    ON Products.ProductID = [Order Details].ProductID
  GROUP BY Categories.CategoryName;

-- 2. Dla każdej kategorii produktu (nazwa), podaj łączną wartość zamówionych przez
-- klientów jednostek towarów z tej kategorii.
SELECT Categories.CategoryName,
       SUM([Order Details].Quantity * [Order Details].UnitPrice) AS TotalPrice
  FROM Products
  INNER JOIN Categories
    ON Products.CategoryID = Categories.CategoryID
  INNER JOIN [Order Details]
    ON Products.ProductID = [Order Details].ProductID
  GROUP BY Categories.CategoryName;

-- 3. Posortuj wyniki w zapytaniu z poprzedniego punktu wg:
-- a) łącznej wartości zamówień
SELECT Categories.CategoryName,
       SUM([Order Details].Quantity * [Order Details].UnitPrice) AS TotalPrice
  FROM Products
  INNER JOIN Categories
    ON Products.CategoryID = Categories.CategoryID
  INNER JOIN [Order Details]
    ON Products.ProductID = [Order Details].ProductID
  GROUP BY Categories.CategoryName
  ORDER BY TotalPrice;

-- b) łącznej liczby zamówionych przez klientów jednostek towarów
SELECT Categories.CategoryName,
       SUM([Order Details].Quantity * [Order Details].UnitPrice) AS TotalPrice,
       SUM([Order Details].Quantity) AS TotalQuantity
  FROM Products
  INNER JOIN Categories
    ON Products.CategoryID = Categories.CategoryID
  INNER JOIN [Order Details]
    ON Products.ProductID = [Order Details].ProductID
  GROUP BY Categories.CategoryName
  ORDER BY SUM([Order Details].Quantity);
-- 4. Dla każdego zamówienia podaj jego wartość uwzględniając opłatę za przesyłkę
SELECT [Order Details].OrderID,
       SUM([Order Details].Quantity * [Order Details].UnitPrice) + Orders.Freight AS TotalPrice
  FROM [Order Details]
  INNER JOIN Orders
    ON [Order Details].OrderID = Orders.OrderID
  GROUP BY [Order Details].OrderID, Orders.Freight
  ORDER BY [Order Details].OrderID;

SELECT [Order Details].Quantity * [Order Details].UnitPrice FROM [Order Details] WHERE OrderID = 10248;
SELECT Freight FROM Orders WHERE OrderID = 10248;

-- ĆWICZENIE 3

-- 1. Dla każdego przewoźnika (nazwa) podaj liczbę zamówień które przewieźli w 1997r.
SELECT Shippers.CompanyName, COUNT(Orders.OrderID) AS TotalOrdersProcessed
  FROM Orders
  INNER JOIN Shippers
    ON Orders.ShipVia = Shippers.ShipperID
  WHERE YEAR(Orders.ShippedDate) = '1997'
  GROUP BY Shippers.CompanyName
  ORDER BY Shippers.CompanyName;

-- 2. Który z przewoźników był najaktywniejszy (przewiózł największą liczbę
-- zamówień) w 1997r, podaj nazwę tego przewoźnika.
SELECT TOP 1 Shippers.CompanyName, COUNT(Orders.OrderID) AS TotalOrdersProcessed
  FROM Orders
  INNER JOIN Shippers
    ON Orders.ShipVia = Shippers.ShipperID
  WHERE YEAR(Orders.ShippedDate) = '1997'
  GROUP BY Shippers.CompanyName
  ORDER BY TotalOrdersProcessed DESC;

-- 3. Dla każdego pracownika (imię i nazwisko) podaj łączną wartość zamówień
-- obsłużonych przez tego pracownika.
SELECT Employees.FirstName,
       Employees.LastName,
       SUM([Order Details].Quantity * [Order Details].UnitPrice) AS EmployeeTotalValue
  FROM Orders
  INNER JOIN Employees
    ON Orders.EmployeeID = Employees.EmployeeID
  INNER JOIN [Order Details]
    ON Orders.OrderID = [Order Details].OrderID
  GROUP BY Employees.FirstName,
           Employees.LastName;

-- 4. Który z pracowników obsłużył największą liczbę zamówień w 1997r, podaj imię i
-- nazwisko takiego pracownika.
SELECT Employees.FirstName,
       Employees.LastName,
       COUNT(*) AS OrdersProcessed
  FROM Orders
  INNER JOIN Employees
    ON Orders.EmployeeID = Employees.EmployeeID
  WHERE YEAR(Orders.ShippedDate) = '1997'
  GROUP BY Employees.FirstName,
           Employees.LastName
  ORDER BY OrdersProcessed DESC;

-- 5. Który z pracowników obsłużył najaktywniejszy (obsłużył zamówienia o
-- największej wartości) w 1997r, podaj imię i nazwisko takiego pracownika.
SELECT TOP 1 Employees.FirstName,
       Employees.LastName,
       SUM([Order Details].Quantity *
           [Order Details].UnitPrice *
           (1 - [Order Details].Discount)) AS TotalValue
  FROM Orders
  INNER JOIN Employees
    ON Orders.EmployeeID = Employees.EmployeeID
  INNER JOIN [Order Details]
    ON Orders.OrderID = [Order Details].OrderID
  WHERE YEAR(Orders.ShippedDate) = '1997'
  GROUP BY Employees.FirstName,
           Employees.LastName
  ORDER BY TotalValue DESC;

-- ĆWICZENIE 4

-- 1.Dla każdego pracownika (imię i nazwisko) podaj łączną wartość zamówień
-- obsłużonych przez tego pracownika. Ogranicz wynik tylko do pracowników:
-- a) którzy mają podwładnych
SELECT a.FirstName,
       a.LastName,
       SUM([Order Details].Quantity *
           [Order Details].UnitPrice *
           (1 - [Order Details].Discount)) AS TotalValue
  FROM Employees AS a
  LEFT OUTER JOIN Employees AS b
    ON a.EmployeeID = b.ReportsTo
  INNER JOIN Orders
    ON a.EmployeeID = Orders.EmployeeID
  INNER JOIN [Order Details]
    ON Orders.OrderID = [Order Details].OrderID
  WHERE b.ReportsTo IS NOT NULL
  GROUP BY a.FirstName, a.LastName
  ORDER BY a.LastName;

-- b) którzy nie mają podwładnych
SELECT a.FirstName,
       a.LastName,
       SUM([Order Details].Quantity *
           [Order Details].UnitPrice *
           (1 - [Order Details].Discount)) AS TotalValue
  FROM Employees AS a
  LEFT OUTER JOIN Employees AS b
    ON a.EmployeeID = b.ReportsTo
  INNER JOIN Orders
    ON a.EmployeeID = Orders.EmployeeID
  INNER JOIN [Order Details]
    ON Orders.OrderID = [Order Details].OrderID
  WHERE b.ReportsTo IS NULL
  GROUP BY a.FirstName, a.LastName
  ORDER BY a.LastName;
