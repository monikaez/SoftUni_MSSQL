--2.	Insert
--Let's insert some sample data into the database. Write a query to add the following records into the corresponding tables.
-- All IDs (Primary Keys) should be auto-generated.
--BOOKINGS

-- ArrivalDate	DepartureDate	AdultsCount	ChildrenCount	TouristId	HotelId	RoomId
-- 2024-03-01	2024-03-11	1	0	21	3	5
-- 2023-12-28	2024-01-06	2	1	22	13	3
-- 2023-11-15	2023-11-20	1	2	23	19	7
--2023-12-05	2023-12-09	4	0	24	6	4
--2024-05-01	2024-05-07	6	0	25	14	6


INSERT INTO Bookings(ArrivalDate,DepartureDate,AdultsCount,ChildrenCount,TouristId,HotelId,RoomId)
VALUES ('2024-03-01', '2024-03-11', 1, 0, 21,3,5),
('2023-12-28', '2024-01-06', 2, 1, 22, 13,3),
('2023-11-15', '2023-11-20', 1, 2, 23, 19, 7),
('2023-12-05', '2023-12-09', 4, 0, 24, 6, 4),
('2024-05-01', '2024-05-07', 6, 0, 25, 14, 6)

-- Tourists
-- Name	PhoneNumber	Email	CountryId
-- John Rivers	653-551-1555	john.rivers@example.com	6
-- Adeline Aglaé	122-654-8726	adeline.aglae@example.com	2
-- Sergio Ramirez	233-465-2876	s.ramirez@example.com	3
-- Johan Müller	322-876-9826	j.muller@example.com	7
-- Eden Smith	551-874-2234	eden.smith@example.com	6

INSERT INTO Tourists([Name],PhoneNumber,Email,CountryId)
VALUES 
('John Rivers','653-551-1555','john.rivers@example.com',6),
('Adeline Aglaé', '122-654-8726', 'adeline.aglae@example.com', 2),
('Sergio Ramirez', '233-465-2876', 's.ramirez@example.com', 3),
('Johan Müller', '322-876-9826', 'j.muller@example.com', 7),
('Eden Smith', '551-874-2234', 'eden.smith@example.com', 6)


-- 3.	Update
-- We've decided to change the departure date of the bookings that are scheduled to arrive in December 2023. 
--The updated departure date for these bookings should be set to one day later than their original departure date.
-- We need to update the email addresses of tourists, whose names contain "MA". 
--The new value of their email addresses should be set to NULL.
UPDATE Bookings
SET DepartureDate =  DATEADD(day, 1, DepartureDate)
WHERE YEAR(DepartureDate) = 2023 AND MONTH (DepartureDate) = 12


UPDATE Tourists
SET Email =  NULL
WHERE [Name] LIKE ('%MA%')
 
--WHERE YEAR(DepartureDate) = 2023 AND MONTH (DepartureDate) = 12
---4.delete

DELETE FROM Bookings
WHERE TouristId IN(6,16,25)
DELETE FROM Tourists
WHERE [Name] LIKE '%Smith'


--5.	Bookings by Price of Room and Arrival Date
-- Select all bookings, ordered by price  of room (descending), then by arrival date (ascending). 
--The arrival date should be formatted in the 'yyyy-MM-dd' format in the query results.
-- Required columns:
-- •	ArrivalDate
-- •	AdultsCount
-- •	ChildrenCount
SELECT 
    FORMAT(b.ArrivalDate,'yyyy-MM-dd') AS ArrivalDate,
    b.AdultsCount,
    b.ChildrenCount

FROM Bookings AS b
JOIN Rooms AS r ON r.Id=b.RoomId
ORDER BY r.Price DESC ,ArrivalDate


-- 6.	Hotels by Count of Bookings
-- Select all hotels with "VIP Apartment" available. 
--Order results by the count of bookings (count of all bookings for the specific hotel,
-- not only for VIP apartment) made for every hotel (descending).
-- Required columns:
-- •	Id
-- •	Name
SELECT 
h.Id ,
h.[Name]

FROM Hotels AS h
JOIN HotelsRooms AS hr ON hr.HotelId = h.Id 
JOIN Rooms AS r ON r.Id= hr.RoomId
JOIN Bookings As b ON  b.HotelId = h.Id

WHERE r.Type = 'VIP Apartment'
GROUP BY h.[Name],h.Id

ORDER BY COUNT(h.Id) DESC 
---6 
SELECT hotl.Id , hotl.Name FROM Hotels hotl

JOIN HotelsRooms hr on hr.HotelId = hotl.id
JOIN Rooms room on room.Id = hr.RoomId
join Bookings book on book.HotelId = hotl.Id

where room.Type ='VIP Apartment'

GROUP BY hotl.Id , hotl.Name
ORDER BY COUNT (book.HotelId) DESC


--7.	Tourists without Bookings
-- Select all tourists that haven’t booked a hotel yet. Order them by name (ascending).
-- Required columns:
-- •	Id
-- •	Name
-- •	PhoneNumber

SELECT
 Id,
 [Name],
 PhoneNumber
FROM Tourists 
WHERE
    Id NOT IN (SELECT DISTINCT TouristId FROM Bookings)
ORDER BY [Name] ASC
--7
    SELECT
    Id,
    Name,
    PhoneNumber
FROM
    Tourists
WHERE
    Id NOT IN (SELECT DISTINCT TouristId FROM Bookings)
ORDER BY
    Name ASC;

    --8.First 10 Bookings
-- Select the first 10 bookings that will arrive before 2023-12-31. 
--You will need to select the bookings in hotels with odd-numbered IDs.
-- Sort the results in ascending order, first by CountryName, and then by ArrivalDate.
-- Required columns:
-- •	HotelName
-- •	DestinationName
-- •	CountryName
SELECT  TOP(10)
 h.[Name] AS HotelName,
d.[Name] AS DestinationName,
c.[Name] AS CountryName
FROM Bookings AS b 
JOIN Hotels AS h On h.Id = b.HotelId
JOIN Destinations d on d.Id = h.DestinationId
JOIN Countries c ON c.Id = d.CountryId

 WHERE b.ArrivalDate < '2023-12-31' AND h.Id  % 2 != 0 

 ORDER BY CountryName ,b.ArrivalDate

 --8
 SELECT TOP(10) hot.Name, dest.Name, cont.Name FROM Bookings book

JOIN Hotels hot on hot.Id = book.HotelId
JOIN Destinations dest on dest.Id = hot.DestinationId
JOIN Countries cont on cont.Id = dest.CountryId

where book.ArrivalDate < '2023-12-31' and  hot.Id % 2 != 0

ORDER BY cont.Name ASC, book.ArrivalDate ASC


--10.	Hotels Revenue
-- In this task, you will write an SQL query to calculate the total price of all bookings
-- for each hotel based on the room price and the number of nights guests have stayed. 
--The result should list the hotel names and their corresponding revenue.
-- •	Foreach Booking you should join data for the Hotel and the Room, using the Id references;
-- •	NightsCount – you will need the ArrivalDate and DepartureDate for a DATEDIFF function;
-- •	Calculate the TotalRevenue by summing the price of each booking, 
--using Price of the Room that is referenced to the specific Booking and multiply it by the NightsCount. 
-- •	Group all the bookings by HotelName using the reference to the Hotel. 
-- •	Order the results by TotalRevenue in descending order.
-- Required columns:
-- •	HotelName
-- •	TotalRevenue
SELECT h.[Name] AS HotelName,
       SUM(r.Price * DATEDIFF(DAY, b.ArrivalDate, b.DepartureDate)) AS TotalRevenue
FROM Bookings AS b
INNER JOIN Hotels AS h ON b.HotelId = h.Id
INNER JOIN Rooms AS r ON b.RoomId = r.Id
GROUP BY h.Name
ORDER BY TotalRevenue DESC;

-- Section 4. Programmability (20 pts)
-- 11.	Rooms with Tourists
-- Create a user-defined function, named udf_RoomsWithTourists(@name) that receives a room's type.
-- The function should return the total number of tourists that the specific room type has been booked for (adults + children).
-- Hint: A Double Room could be booked for: 2 adults + 0 children, 1 adult + 1 children, 1 adult + 0 children.
CREATE FUNCTION udf_RoomsWithTourists(@typeRooms NVARCHAR(40))
RETURNS INT
AS
BEGIN 
     DECLARE  @totalTourists INT;
        SELECT @totalTourists = SUM(AdultsCount + ChildrenCount)
        FROM Bookings AS b 
      JOIN Rooms AS r ON b.RoomId = r.Id
    WHERE r.Type = @typeRooms;

    IF @totalTourists IS NULL
        SET @totalTourists = 0;

    RETURN @totalTourists;
END;

-- 12.	Search for Tourists from a Specific Country
-- Create a stored procedure, named usp_SearchByCountry(@country) that receives a country name. 
--The procedure must print full information about all tourists that have an booked a room and have origin from the given country:
-- Name, PhoneNumber, Email and CountOfBookings (the count of all bookings made). Order them by Name (ascending) and CountOfBookings (decending).
CREATE PROCEDURE usp_SearchByCountry(@country NVARCHAR(50))
 
AS
BEGIN
    SELECT
        t.Name,
        t.PhoneNumber,
        t.Email,
        ISNULL(COUNT(b.Id), 0) AS CountOfBookings
    FROM
        Tourists AS t
    LEFT JOIN
        Bookings AS b ON t.Id = b.TouristId
    WHERE
        t.CountryId = (SELECT Id FROM Countries WHERE Name = @country)
    GROUP BY
        t.Name, t.PhoneNumber, t.Email
    ORDER BY
        t.Name ASC, CountOfBookings DESC;
END;