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

--3. Select the name of the products with a price less than or equal to $10
SELECT Name FROM Products
WHERE Price <= 10; 

--4. Select all the products with a price between $5 and $12.
SELECT * FROM Products
WHERE Price >= 5 AND Price <= 12;

--5. Select the name and price in cents
SELECT Name, Price*100 FROM Products;

--6. Compute the average price of all the products.
SELECT AVG(Price) FROM Products;

--7. Compute the average price of all products with manufacturer code equal to 2.
SELECT AVG(Price) FROM Products
WHERE Manufacturer = 2;

--8.  Compute the number of products with a price larger than or equal to $10.
SELECT COUNT(*) FROM Products
WHERE Price >= 10;

--9. Select the name and price of all products with a price larger than or equal to $10, and sort first by price (in descending order), and then by name (in ascending order).
SELECT Name, Price FROM Products
WHERE Price >= 10
ORDER BY Price DESC, Name ASC;

--10. Select all the data from the products, including all the data for each product's manufacturer.
SELECT * FROM Products
INNER JOIN Manufacturers ON Manufacturer = Manufacturers.Code;

--11. Select the product name, price, and manufacturer name of all the products.
SELECT p.name, p.price, m.name FROM Products p
INNER JOIN Manufacturers m ON p.Manufacturer = m.Code;

--12. Select the average price of each manufacturer's products, showing only the manufacturer's code.
SELECT AVG(Price) FROM Products
GROUP BY Manufacturer;

--13.Select the average price of each manufacturer's products, showing the manufacturer's name.
SELECT AVG(p.Price), m.Name FROM Products p
INNER JOIN Manufacturers m ON p.Manufacturer = m.Code
GROUP BY m.Name;

--14. Select the names of manufacturer whose products have an average price larger than or equal to $7.
SELECT AVG(p.Price), m.name FROM Products p
INNER JOIN Manufacturers m ON Manufacturer = m.Code
GROUP BY m.Name
HAVING AVG(p.Price) >= 7;


--15. Select the name and price of the cheapest product.
SELECT TOP 1 name, price FROM Products
ORDER BY price ASC;

--16. Select the name of each manufacturer along with the name and price of its most expensive product.
SELECT m.name, p.name, p.price FROM Products p
INNER JOIN Manufacturers m ON p.Manufacturer = m.Code
AND p.Price = (
				SELECT MAX(p.Price) FROM Products p
				WHERE p.Manufacturer = m.Code
			  )
ORDER BY m.Name;

-- 17. Add a new product: bolillo, $3, manufacturer 3.
INSERT INTO Products VALUES('bolillo', 3, 3);

SELECT * FROM Products
WHERE Manufacturer = 3;

-- 18. Update the name of product 8 to "Choripan Premium".
UPDATE Products SET name='Choripan Premium'
WHERE Code = 8;

-- 19. Apply a 10% discount to all products.
SELECT name, price*.90 FROM Products;

-- 20. Apply a 10% discount to all products with a price larger than or equal to $12.
SELECT name, price*.90 FROM Products
WHERE price >= 12;