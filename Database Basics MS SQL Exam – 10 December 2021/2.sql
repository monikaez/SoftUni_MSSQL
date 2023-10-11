
--2.	Insert
Write a query to insert data into the Passengers table, based on the Pilots table. For all Pilots with an id between 5 and 15 (both inclusive), insert data in the Passengers table with the following values:
•	FullName  –  get the first and last name of the pilot separated by a single space
o	Example – 'Lois Leidle'
•	Email – set it to start with full name with no space and add '@gmail.com' - 'FullName@gmail.com'
o	 Example – 'LoisLeidle@gmail.com'


INSERT INTO Passengers (FullName,Email)
SELECT 
    CONCAT(FirstName,' ',LastName),
    CONCAT(FirstName,LastName,'@gmail.com')

FROM Pilots
WHERE Id>=5 AND Id<=15