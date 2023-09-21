--05. Online Store Database 
CREATE TABLE OrderItems(
    OrderID INT UNIQUE ,
    ItemID INT UNIQUE
)

CREATE TABLE Orders(
    OrderID INT FOREIGN KEY REFERENCES [OrderItems](OrderID),
    CustomerID INT UNIQUE
)

CREATE TABLE Customers(
    CustomerID INT FOREIGN KEY REFERENCES [Orders](CustomerID),
    [Name] NVARCHAR(50) NOT NULL,
    Birthday DATE ,
    CityID INT UNIQUE
)

CREATE TABLE Items(
    ItemID INT FOREIGN KEY REFERENCES [OrderItems](ItemID),
    [Name] NVARCHAR(50) NOT NULL,
    ItemTypeID INT UNIQUE
)
CREATE TABLE ItemTypes(
    ItemTypeID INT FOREIGN KEY REFERENCES [Items](ItemTypeID),
    [Name] NVARCHAR(50) NOT NULL
)

CREATE TABLE Cities(
    CityID INT FOREIGN KEY REFERENCES [Customers](CityID),
    [Name] NVARCHAR(50) NOT NULL
)