13. Movies Database 
CREATE TABLE Directors
(
    Id INT PRIMARY KEY IDENTITY,
    DirectorName NVARCHAR(100) NOT NULL,
    Notes NVARCHAR(MAX)
)

CREATE TABLE Genres
(
    Id INT PRIMARY KEY IDENTITY,
    GenreName NVARCHAR(100) NOT NULL,
    Notes NVARCHAR(MAX)
)

CREATE TABLE Categories
(
    Id INT PRIMARY KEY IDENTITY,
    CategoryName NVARCHAR(100) NOT NULL,
    Notes NVARCHAR(MAX)
)

CREATE TABLE Movies
(
    Id INT PRIMARY KEY IDENTITY,
    Title NVARCHAR(50) NOT NULL,
    DirectorId INT FOREIGN KEY REFERENCES [Directors](Id),
    CopyrightYear DATETIME2,
    Length INT,
    GenreId INT FOREIGN KEY REFERENCES [Genres](Id),
    CategoryId INT FOREIGN KEY REFERENCES [Categories](Id),
    Rating INT ,
    Notes NVARCHAR(MAX)
)

INSERT INTO [Directors]
VALUES
('ivan petrob','idiot'),
('mihail','super'),
('donald',NULL),
('duk duk','hai'),
('honkongsbos',null)

INSERT INTO [Genres]
VALUES
('MARTIN',NULL),
('IVAN',NULL),
('VASIL',NULL),
('MARTA',NULL),
('MONIKA',NULL)

INSERT INTO [Categories]
VALUES
('SATIRA','VERY SMAILS'),
('HUMOR',NULL),
('DRAMA','REV'),
('CHILD','HAHAHA'),
('FANTAZY',NULL)

INSERT INTO [Movies](Title, DirectorId, CopyrightYear, Length, GenreId, CategoryId, Rating)
VALUES
('HOME ALLOWN',1,'3-3-2020',2,1,1,2),
('HOME ALLOWN',2,'3-3-2020',3,2,3,5),
('HOME ALLOWN',3,'3-3-2020',1,3,2,5),
('HOME ALLOWN',4,'3-3-2020',5,4,1,5),
('HOME ALLOWN',5,'3-3-2020',4,5,4,5)


