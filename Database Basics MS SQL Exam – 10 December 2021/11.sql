--Problem 11

CREATE FUNCTION udf_FlightDestinationsByEmail(@email NVARCHAR(MAX))
RETURNS INT
AS
BEGIN
	DECLARE @destinations INT
	SET @destinations = (SELECT COUNT(p.Id) 
						   FROM Passengers p
						   JOIN FlightDestinations fd ON fd.PassengerId = p.Id
						  WHERE p.Email LIKE @email)
	RETURN @destinations
END


