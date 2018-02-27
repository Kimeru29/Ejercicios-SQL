CREATE DATABASE [Computer Store];

USE [Computer Store]
GO

CREATE TABLE Manufacturers(
	Code INT IDENTITY PRIMARY KEY NOT NULL,
	Name VARCHAR(100) NOT NULL);
	
CREATE TABLE Products(
	Code INT IDENTITY PRIMARY KEY NOT NULL,
	Name VARCHAR(100) NOT NULL,
	Price FLOAT NOT NULL,
	Manufacturer INT FOREIGN KEY REFERENCES Manufacturers(Code));
	
INSERT INTO Manufacturers VALUES('Dulcería X');
INSERT INTO Manufacturers VALUES('Galletería Y');
INSERT INTO Manufacturers VALUES('Panadería Z');

INSERT INTO Products VALUES('Polvorón', 8.50, 2);
INSERT INTO Products VALUES('Galletón', 5.50, 2);
INSERT INTO Products VALUES('Barquillo', 3.50, 2);
INSERT INTO Products VALUES('Golos', 25, 1);
INSERT INTO Products VALUES('Crunch', 12, 1);
INSERT INTO Products VALUES('Nuez garampiñada', 16.50, 1);
INSERT INTO Products VALUES('Volcán', 5, 3);
INSERT INTO Products VALUES('Choripan', 15, 3);
INSERT INTO Products VALUES('Pay queso', 12, 3);

-- 1. Select the names of all the products in the store.
SELECT Name FROM Products;

--2. Select the names and the prices of all the products in the store.
SELECT Name, Price FROM Products;

--3. Select the name of the products with a price less than or equal to $200.
SELECT Name FROM Products
WHERE Price <= 200;

--4. Select all the products with a price between $60 and $120.
SELECT * FROM Products
WHERE Price >= 60 AND Price <= 120;

--5. Select the name and price in cents
SELECT Name, Price, Price*100 AS [Price in cents] FROM Products;

--6. Compute the average price of all the products.
SELECT AVG(Price) AS 'Average' FROM Products;

--7. Compute the average price of all products with manufacturer code equal to 2.
SELECT AVG(Price) AS 'Average of Galletería' FROM Products
WHERE Manufacturer = 2;

--8.  Compute the number of products with a price larger than or equal to $180.
SELECT COUNT(*) AS 'Items' FROM Products
WHERE Price >= 10;

--9. Select the name and price of all products with a price larger than or equal to $180, and sort first by price (in descending order), and then by name (in ascending order).
SELECT Name, Price FROM Products
WHERE Price >= 10
ORDER BY Price DESC, Name ASC;

--10. Select all the data from the products, including all the data for each product's manufacturer.
SELECT * FROM Products
INNER JOIN Manufacturers ON Products.Manufacturer = 
Manufacturers.Code;

--11. Select the product name, price, and manufacturer name of all the products.
SELECT Products.Name, Products.Price, Manufacturers.Name AS 'Manufacturer' FROM PRODUCTS
INNER JOIN Manufacturers ON Products.Manufacturer = 
Manufacturers.Code;

--12. Select the average price of each manufacturer's products, showing only the manufacturer's code.
SELECT AVG(Price), Manufacturer
FROM Products
GROUP BY Manufacturer;

--13.Select the average price of each manufacturer's products, showing the manufacturer's name.
SELECT AVG(Price), Manufacturers.Name FROM Products
INNER JOIN Manufacturers ON Products.Manufacturer = 
Manufacturers.Code
GROUP BY Manufacturers.Name;

--14. Select the names of manufacturer whose products have an average price larger than or equal to $150.
SELECT AVG(Price), Manufacturers.Name FROM Products
INNER JOIN Manufacturers ON Products.Manufacturer = 
Manufacturers.Code
GROUP BY Manufacturers.Name
HAVING AVG(Price) >= 10;

