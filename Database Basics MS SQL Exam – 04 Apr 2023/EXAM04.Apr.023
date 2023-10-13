--1
CREATE DATABASE  Accounting 

CREATE TABLE Countries
    (
        Id INT PRIMARY KEY IDENTITY,
       [Name] VARCHAR(10) NOT NULL
    )

CREATE TABLE Addresses
    (
        Id INT PRIMARY KEY IDENTITY,
        StreetName NVARCHAR(20) NOT NULL,
        StreetNumber INT ,
        PostCode INT NOT NULL,
        City VARCHAR(50) NOT NULL,
        CountryId INT FOREIGN KEY REFERENCES [Countries](Id) NOT NULL
    )

CREATE TABLE Vendors
(
    Id INT PRIMARY KEY IDENTITY,
    [Name] NVARCHAR(25) NOT NULL,
    NumberVAT NVARCHAR(15) NOT NULL,
    AddressId INT FOREIGN KEY  REFERENCES [Addresses](Id) NOT NULL
)

CREATE TABLE Clients
(
    Id INT PRIMARY KEY IDENTITY,
    [Name] NVARCHAR(25) NOT NULL,
    NumberVAT NVARCHAR(15) NOT NULL,
    AddressId INT FOREIGN KEY  REFERENCES [Addresses](Id) NOT NULl
   
)

CREATE TABLE Categories
(
    Id INT PRIMARY KEY IDENTITY,
    [Name] VARCHAR(10) NOT NULL
)

CREATE TABLE Products
(
    Id INT PRIMARY KEY IDENTITY,
    [Name] NVARCHAR(35) NOT NULL,
    Price DECIMAL(18,2) NOT NULL,
    CategoryId INT FOREIGN KEY REFERENCES [Categories](Id),
    VendorId INT FOREIGN KEY REFERENCES [Vendors](Id)
)

CREATE TABLE Invoices
(
    Id INT PRIMARY KEY IDENTITY,
    Number INT  UNIQUE NOT NULL,
    IssueDate DATETIME2 NOT NULL,
    DueDate DATETIME2 NOT NULL,
    Amount DECIMAL(18,2) NOT NULL,
    Currency VARCHAR(5) NOT NULL,
    ClientId INT FOREIGN KEY REFERENCES [Clients](Id)
)
CREATE TABLE ProductsClients

(
    ProductId INT FOREIGN KEY REFERENCES [Products](Id),
    ClientId INT FOREIGN KEY REFERENCES [Clients](Id),
    PRIMARY KEY (ProductId,ClientId)
)



-----2.INSERT

INSERT INTO Products([Name], Price, CategoryId, VendorId)
	VALUES
		('SCANIA Oil Filter XD01', 78.69, 1, 1),
		('MAN Air Filter XD01', 97.38, 1, 5),
		('DAF Light Bulb 05FG87', 55.00, 2, 13),
		('ADR Shoes 47-47.5', 49.85, 3, 5),
		('Anti-slip pads S', 5.87, 5, 7)

INSERT INTO Invoices(Number, IssueDate, DueDate, Amount, Currency, ClientId)
	VALUES
		(1219992181, '2023-03-01', '2023-04-30', 180.96, 'BGN', 3),
		(1729252340, '2022-11-06', '2023-01-04', 158.18, 'EUR', 13),
		(1950101013, '2023-02-17', '2023-04-18', 615.15, 'USD', 19)

--Update
--We've decided to change the due date of the invoices, issued in November 2022. Update the due date and change it to 2023-04-01.
--Then, you have to change the addresses of the clients, which contain "CO" in their names. 
--The new value of the addresses should be Industriestr, 79, 2353, Guntramsdorf, Austria.

UPDATE Invoices
SET DueDate = '2023-04-01'
WHERE IssueDate BETWEEN '2022-11-01' AND '2022-11-30'


 UPDATE Clients
	SET AddressId =
     (
		SELECT Id
		FROM Addresses
		WHERE StreetName = 'Industriestr'
		AND StreetNumber = 79
		AND PostCode = 2353
		AND City = 'Guntramsdorf'
		AND CountryId = 
            (
				SELECT Id
				FROM Countries
				WHERE Name = 'Austria'
			)
    )
 WHERE [Name] LIKE '%CO%'
--2variant na UPDATE
UPDATE Invoices
SET DueDate = '2023-04-01'
WHERE IssueDate BETWEEN '2022-11-01' AND '2022-11-30'

--SELECT*FROM Addresses
UPDATE Clients SET AddressId =3
WHERE [Name] LIKE '%Co%';
 --3.	Delete
--In table Clients, delete every client, whose VAT number starts with "IT". Keep in mind that there could be foreign key constraint conflicts.

DELETE FROM ProductsClients WHERE ClientId = 11
DELETE FROM Invoices WHERE ClientId = 11
DELETE 
FROM Clients
WHERE NumberVAT LIKE 'IT%'
--4.UPDATE


--Section 3. Querying (40 pts)
--

--5.Invoices by Amount and Date
-- Select all invoices, ordered by amount (descending), then by due date (ascending). 
-- Required columns:
-- •	Number
-- •	Currency
SELECT [Number],
        Currency
FROM Invoices
ORDER BY Amount DESC,DueDate



--6.Products by Category
-- Select all products with "ADR" or "Others" categories. Order results by Price (descending).
-- Required columns:
-- •	Id
-- •	Name
-- •	Price
-- •	CategoryName

SELECT 
    p.Id,
    p.Name,
    p.Price,
    c.[Name] CategoryName
FROM Categories c 
JOIN Products p ON p.CategoryId = c.Id
WHERE c.Name IN ('ADR', 'Others')
ORDER BY p.Price DESC

--7.	Clients without Products
-- Select all clients without products. Order them by name (ascending).
-- Required columns:
-- •	Id
-- •	Client
-- •	Address

SELECT 
	c.Id,
	c.Name,
	CONCAT(a.StreetName, ' ', a.StreetNumber, ', ', a.City, ', ', a.PostCode, ', ', cn.Name) AS [Address]
	FROM Clients AS c 
	LEFT JOIN ProductsClients AS pc	ON pc.ClientId = c.Id
	LEFT JOIN Products AS p	ON pc.ProductId = p.Id
	LEFT JOIN Addresses AS a ON c.AddressId = a.Id
	LEFT JOIN Countries AS cn ON a.CountryId = cn.Id
	WHERE p.Id IS NULL
	ORDER BY c.Name

    --7.Clients without Products  ---2 variant
-- Select all clients without products. Order them by name (ascending).
-- Required columns:
-- •	Id
-- •	Client
-- •	Address
SELECT 
    c.Id,
	c.Name,
	CONCAT(a.StreetName, ' ', a.StreetNumber, ', ', a.City, ', ', a.PostCode, ', ', cn.Name) AS [Address]
 FROM Clients AS c 
    JOIN Addresses AS a ON a.Id=c.AddressId
    JOIN Countries AS cn ON cn.Id=a.CountryId
    LEFT JOIN  ProductsClients AS pc ON pc.ClientId=c.Id
    WHERE pc.ProductId Is NULL
    ORDER BY c.[Name]


--8.First 7 Invoices
--Select the first 7 invoices that were issued before 2023-01-01 and 
--have an EUR currency or the amount of an invoice is greater than 500.00 
--and the VAT number of the corresponding client starts with "DE". 
--Order the result by invoice number (ascending), then by amount (descending).
-- Required columns:
-- •	Number
-- •	Amount
-- •	Client

SELECT TOP(7)
    i.[Number],
    i.Amount,
    c.[Name]  AS Client
FROM Invoices i 
    JOIN Clients c ON i.ClientId=c.Id
WHERE (i.IssueDate < '2023-01-01' AND i.Currency = 'EUR')
    OR (i.Amount > 500.00 AND c.NumberVAT Like 'DE%')
ORDER BY i.[Number],i.Amount DESC

--9.Clients with VAT
-- Select all of the clients that have a name, not ending in "KG",
-- and display their most expensive product and their VAT number. Order by product price (descending).
-- Required columns:
-- •	Client
-- •	Price
-- •	VAT Number

SELECT
    c.[Name] AS [Client]
    ,MAX(p.Price) AS Price
    ,c.NumberVAT AS [VAT Number]
FROM Clients c 
    JOIN ProductsClients pc ON pc.ClientId=c.Id
    JOIN Products p ON p.Id=pc.ProductId
WHERE c.[Name] NOT LIKE '%KG'

GROUP BY c.[Name],c.NumberVAT
ORDER BY MAX(p.Price) DESC;

--10.	Clients by Price
--Select all clients, which have bought products.
-- Select their name and average price (rounded down to the nearest integer).
-- Show only the results for clients, whose products are distributed by vendors with "FR" in their VAT number. 
--Order the results by average price (ascending), then by client name (descending).

SELECT
    c.[Name] AS [Client],
    FLOOR(AVG(p.Price)) AS [Average Price]

FROM Clients AS c 
    JOIN ProductsClients AS pc ON c.Id = pc.ClientId
    JOIN Products AS p ON p.Id= pc.ProductId
    JOIN Vendors AS v On v.Id= p.VendorId AND v.NumberVAT LIKE '%FR%'
GROUP BY c.[Name]
ORDER BY FLOOR(AVG(p.Price)) , c.[Name] DESC;
--Section 4. Programmability (20 pts)
--11.	Product with Clients
-- Create a user-defined function, named udf_ProductWithClients(@name) that receives a product's name.
-- The function should return the total number of clients that the product has been sold to.
CREATE OR ALTER FUNCTION udf_ProductWithClients(@name NVARCHAR(35))
RETURNS INT AS
BEGIN
	DECLARE @result INT =
	(
		SELECT
			COUNT(*)
		FROM Clients AS c
		JOIN ProductsClients AS pc ON pc.ClientId = c.Id
		JOIN Products AS p ON pc.ProductId = p.Id
		WHERE p.[Name] = @name
		GROUP BY p.Id
	)
	RETURN @result
END

--SELECT dbo.udf_ProductWithClients('DAF FILTER HU12103X')

--12.	Search for Vendors from a Specific Country
--Create a stored procedure, named usp_SearchByCountry(@country) that receives a country name. 
--The procedure must print full information about all vendors that have an address in the given country:
-- Name, NumberVAT, Street Name and Number (concatenated), PostCode and City (concatenated). 
--Order them by Name (ascending) and City (ascending).
CREATE OR ALTER PROCEDURE usp_SearchByCountry(@country VARCHAR(10))
AS
	SELECT
		v.[Name] AS Vendor,
		v.NumberVAT AS VAT,
		CONCAT(a.StreetName, ' ', StreetNumber) AS [Street Info],
		CONCAT(a.City, ' ', a.PostCode) AS [City Info]
	FROM Vendors AS v
	JOIN Addresses AS a ON a.Id = v.AddressId
	JOIN Countries AS c ON c.Id = a.CountryId
	WHERE c.[Name] = @country
	ORDER BY v.[Name], a.City

    --EXEC usp_SearchByCountry 'France'

