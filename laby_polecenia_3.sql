USE Northwind;

-- ĆWICZENIE

-- 1. Wybierz nazwy i ceny produktów (baza northwind) o cenie jednostkowej
-- pomiędzy 20.00 a 30.00, dla każdego produktu podaj dane adresowe dostawcy.
SELECT ProductName, UnitPrice, Suppliers.Address
  FROM Products
  INNER JOIN Suppliers
    ON Products.SupplierID = Suppliers.SupplierID
  WHERE UnitPrice BETWEEN 20 AND 30;

-- 2. Wybierz nazwy produktów oraz inf. o stanie magazynu dla produktów
-- dostarczanych przez firmę ‘Tokyo Traders’.
SELECT ProductName, UnitsInStock, Suppliers.CompanyName
  FROM Products
  INNER JOIN Suppliers
    ON Products.SupplierID = Suppliers.SupplierID
  WHERE Suppliers.CompanyName LIKE 'Tokyo Traders';

-- 3. Czy są jacyś klienci którzy nie złożyli żadnego zamówienia w 1997 roku, jeśli tak
-- to pokaż ich dane adresowe.
SELECT DISTINCT Customers.CustomerID, Customers.Address
  FROM Orders
  INNER JOIN Customers
    ON Orders.CustomerID = Customers.CustomerID
  WHERE YEAR(OrderDate) != '1997';

-- 4. Wybierz nazwy i numery telefonów dostawców, dostarczających produkty,
-- których aktualnie nie ma w magazynie.
SELECT ProductName, UnitsInStock, Suppliers.Phone
  FROM Products
  INNER JOIN Suppliers
    ON Products.SupplierID = Suppliers.SupplierID
  WHERE UnitsInStock = 0;

-- ĆWICZENIE

-- 1. Napisz polecenie, które wyświetla listę dzieci będących członkami biblioteki (baza
-- library). Interesuje nas imię, nazwisko i data urodzenia dziecka.
USE library
SELECT firstname, lastname, juvenile.birth_date
  FROM member
  INNER JOIN juvenile
    ON member.member_no = juvenile.member_no
  WHERE DATEDIFF(YEAR, juvenile.birth_date, GETDATE()) < 22;

-- 2. Napisz polecenie, które podaje tytuły aktualnie wypożyczonych książek.
SELECT DISTINCT title
  FROM title
  INNER JOIN copy
    ON title.title_no = copy.title_no
  WHERE on_loan = 'Y';

-- 3. Podaj informacje o karach zapłaconych za przetrzymywanie książki o tytule ‘Tao
-- Teh King’. Interesuje nas data oddania książki, ile dni była przetrzymywana i jaką
-- zapłacono karę.
USE library
SELECT title,
       loanhist.out_date,
       loanhist.in_date,
       DATEDIFF(DAY, loanhist.out_date, loanhist.in_date) AS HowLong,
       loanhist.fine_assessed
  FROM title
  INNER JOIN loanhist
    ON title.title_no = loanhist.title_no
  WHERE title LIKE 'Tao Teh King'
  ORDER BY fine_assessed DESC;

-- 4. Napisz polecenie które podaje listę książek (numery ISBN) zarezerwowanych
-- przez osobę o nazwisku: Stephen A. Graff.
USE library
SELECT isbn
  FROM loan
  INNER JOIN member
    ON member.member_no = loan.member_no
  WHERE lastname = 'Graff'
    AND firstname = 'Stephen'
    AND middleinitial = 'A';

-- ĆWICZENIA

-- 1. Wybierz nazwy i ceny produktów (baza northwind) o cenie jednostkowej
-- pomiędzy 20.00 a 30.00, dla każdego produktu podaj dane adresowe dostawcy,
-- interesują nas tylko produkty z kategorii ‘Meat/Poultry’.
SELECT ProductName, UnitPrice, Suppliers.Address
  FROM Products
  INNER JOIN Suppliers
    ON Products.SupplierID = Suppliers.SupplierID
  INNER JOIN Categories
    ON Products.CategoryID = Categories.CategoryID
  WHERE UnitPrice BETWEEN 20 AND 30
    AND Categories.CategoryName = 'Meat/Poultry';

-- 2. Wybierz nazwy i ceny produktów z kategorii ‘Confections’ dla każdego produktu
-- podaj nazwę dostawcy.
SELECT ProductName, UnitPrice, Suppliers.CompanyName
  FROM Products
  INNER JOIN Suppliers
    ON Products.SupplierID = Suppliers.SupplierID
  INNER JOIN Categories
    ON Products.CategoryID = Categories.CategoryID
  WHERE Categories.CategoryName = 'Confections';

-- 3. Wybierz nazwy i numery telefonów klientów , którym w 1997 roku przesyłki
-- dostarczała firma ‘United Package’.
SELECT Customers.ContactName, Customers.Phone
  FROM Orders
  INNER JOIN Customers
    ON Orders.CustomerID = Customers.CustomerID
  INNER JOIN Shippers
    ON Orders.ShipVia = Shippers.ShipperID
  WHERE Shippers.CompanyName = 'United Package'
    AND YEAR(Orders.ShippedDate) = '1997';

-- 4. Wybierz nazwy i numery telefonów klientów, którzy kupowali produkty z kategorii
-- ‘Confections’.
SELECT ContactName, Phone, Orders.OrderID, [Order Details].ProductID, Products.CategoryID
  FROM Customers
  INNER JOIN Orders
    ON Customers.CustomerID = Orders.CustomerID
  INNER JOIN [Order Details]
    ON Orders.OrderID = [Order Details].OrderID
  INNER JOIN Products
    ON [Order Details].ProductID = Products.ProductID
  INNER JOIN Categories
    ON Products.CategoryID = Categories.CategoryID
  WHERE Categories.CategoryName = 'Confections'

-- ĆWICZENIA

-- 1. Napisz polecenie, które wyświetla pracowników oraz ich podwładnych (baza
-- northwind).
SELECT (a.FirstName + ' ' + a.LastName) AS Boss,
       (b.FirstName + ' ' + b.LastName) AS Servant
  FROM Employees AS a
  JOIN Employees AS b
    ON a.EmployeeID = b.ReportsTo;

-- 2. Napisz polecenie, które wyświetla pracowników, którzy nie mają podwładnych
-- (baza northwind).
SELECT (a.FirstName + ' ' + a.LastName) AS NoSubordinates
  FROM Employees AS a
  LEFT OUTER JOIN Employees AS b
    ON a.EmployeeID = b.ReportsTo
  WHERE b.ReportsTo IS NULL;

-- ĆWICZENIA

USE library;

-- 1. Napisz polecenie które zwraca imię i nazwisko (jako pojedynczą kolumnę –
-- name), oraz informacje o adresie: ulica, miasto, stan kod (jako pojedynczą
-- kolumnę – address) dla wszystkich dorosłych członków biblioteki.
SELECT (lastname + ' ' + firstname) AS Name,
       (street + ' ' + city + ' ' + zip) AS Address
  FROM member
  LEFT OUTER JOIN adult
    ON member.member_no = adult.member_no
  WHERE adult.member_no IS NOT NULL;

-- 2. Napisz polecenie, które zwraca: isbn, copy_no, on_loan, title, translation, cover,
-- dla książek o isbn 1, 500 i 1000. Wynik posortuj wg ISBN.
SELECT loan.isbn, loan.copy_no, copy.on_loan, title.title, item.translation, item.cover
  FROM loan
  INNER JOIN copy
    ON loan.isbn = copy.isbn
  INNER JOIN title
    ON copy.title_no = title.title_no
  INNER JOIN item
    ON copy.isbn = item.isbn
  ORDER BY copy.isbn

-- 3. Napisz polecenie które zwraca o użytkownikach biblioteki o nr 250, 342, i 1675
-- (dla każdego użytkownika: nr, imię i nazwisko członka biblioteki), oraz informację
-- o zarezerwowanych książkach (isbn, data).
SELECT member.member_no,
       firstname,
       lastname,
       reservation.isbn,
       reservation.log_date
  FROM member
  LEFT OUTER JOIN reservation
    ON member.member_no = reservation.member_no
  WHERE member.member_no = 250
     OR member.member_no = 342
     OR member.member_no = 1675;

-- 4. Podaj listę członków biblioteki mieszkających w Arizonie (AZ), którzy mają więcej niż
-- dwoje dzieci zapisanych do biblioteki.
SELECT member.*
  FROM member
  INNER JOIN adult
    ON member.member_no = adult.member_no
  WHERE member.member_no in (
      SELECT adult_member_no
        FROM juvenile
        GROUP BY adult_member_no
        HAVING COUNT(*) > 1
      )
    AND adult.state = 'AZ';

-- ĆWICZENIE

-- 1. Podaj listę członków biblioteki mieszkających w Arizonie (AZ) którzy mają więcej
-- niż dwoje dzieci zapisanych do biblioteki oraz takich którzy mieszkają w Kalifornii
-- (CA) i mają więcej niż troje dzieci zapisanych do biblioteki.
SELECT lastname, firstname
  FROM member
  INNER JOIN adult
    ON member.member_no = adult.member_no
  WHERE member.member_no in (
      SELECT adult_member_no
        FROM juvenile
        GROUP BY adult_member_no
        HAVING COUNT(*) > 1
      )
    AND adult.state = 'AZ'

UNION

SELECT lastname, firstname
  FROM member
  INNER JOIN adult
    ON member.member_no = adult.member_no
  WHERE member.member_no in (
      SELECT adult_member_no
        FROM juvenile
        GROUP BY adult_member_no
        HAVING COUNT(*) > 3
      )
    AND adult.state = 'CA';
