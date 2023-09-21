07. Create Table People 
CREATE TABLE People(
    Id  INT PRIMARY KEY IDENTITY(1,1),
    [Name] VARCHAR(200) NOT NULL,
    Picture VARBINARY(MAX),
    CHECK(DATALENGTH(Picture) <= 200000),
    Height DECIMAL(3,2),
    Weight DECIMAL(5,2),
    Gender CHAR  NOT NULL CHECK (Gender = 'm' OR Gender = 'f'),
    Birthdate DATETIME2 NOT NULL,
    Biography  NVARCHAR(MAX)
);

INSERT INTO People([Name],Picture,Height,Weight,Gender,Birthdate,Biography)
VALUES
('Pepi',NUll,1.32,89.32,'m','03-03-1992','bio'),
('Pepino',NUll,1.58,89.32,'m','03-31-1992','bio'),
('Pepa',NUll,1.58,89.32,'f','03-31-1992','bio'),
('Pepi',NUll,0.58,89.32,'m','03-31-1992','bio'),
('Pepi',NUll,1.58,89.32,'m','03-31-1992','bio')