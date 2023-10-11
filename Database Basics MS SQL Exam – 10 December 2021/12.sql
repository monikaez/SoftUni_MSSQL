--Problem 12
CREATE PROC usp_SearchByAirportName(@airportName NVARCHAR(70))
AS
BEGIN
	SELECT 
	ap.AirportName,
	p.FullName,
	CASE 
		WHEN fd.TicketPrice <= 400 THEN 'Low'
		WHEN fd.TicketPrice BETWEEN 401 AND 1500 THEN 'Medium'
		ELSE 'High'
	END AS [LevelOfTickerPrice],
	ac.Manufacturer,
	ac.Condition,
	act.TypeName
  FROM Airports ap
  JOIN FlightDestinations fd ON fd.AirportId = ap.Id
  JOIN Aircraft ac ON ac.Id = fd.AircraftId
  JOIN Passengers p ON p.Id = fd.PassengerId
  JOIN AircraftTypes act ON act.Id = ac.TypeId
 WHERE ap.AirportName = @airportName
 ORDER BY ac.Manufacturer, p.FullName
END

EXEC usp_SearchByAirportName 'Sir Seretse Khama International Airport'