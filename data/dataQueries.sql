--
--    Show Records
--

-- Row 5 - Show records from E1 -- Country
SELECT *
FROM Country
ORDER BY id;

-- Row 6 - Show records from E2 -- Airport (these are in a one-to-many relationship with E1) --
SELECT *
FROM Airport;
ORDER BY id;

-- Row 7 - Show records from E3 -- Airline (these are in a one-to-many relationship with E1) --
SELECT *
FROM Airline;
ORDER BY id;

-- Row 8 - Show records from E4 -- Flight (many-to-many relationship between E2 and E3) --
SELECT Flight.id, Airline.name, Airline.code, Flight.flightNum, Flight.origin, Flight.destination,
       Flight.departTime, Flight.arriveTime, Flight.flightTime, A.city AS depCity, B.city AS arrCity
FROM Flight INNER JOIN Airline ON airline = code INNER JOIN Airport A on A.code = Flight.origin
       INNER JOIN Airport B on B.code = Flight.destination
ORDER BY Flight.id;

-- Row 9 - Show records from many-to-many relationship -- Destination (many-to-many relationship between E2 and E3) --
SELECT Destination.id, Airline.name, Airport.city, Destination.destination
FROM Destination
INNER JOIN Airline ON airline = code
INNER JOIN Airport ON Airport.code = Destination.destination
ORDER BY Destination.id;

-- Row 10 - The one-to-many relationships can be viewed in the Country column of the Airport and Airline tables.
SELECT country
FROM Airport;



--
--    Add Records
--

-- Row 11 - Add new records to E1 -- Country
INSERT INTO Country (name, capital)
VALUES ('[name]', '[capital]');

-- Row 12 - Add new records to E2 -- Airport
INSERT INTO Airport (code, name, city, country)
VALUES ('[code]', '[name]', '[city]', '[country]');

-- Row 13 - Add new records to E3 -- Airline
INSERT INTO Airline (code, name, country)
VALUES ('[code]', '[name]', '[country]');

-- Row 14 - Add new records to E4 -- Flight
INSERT INTO Flight (airline, flightNum, origin, destination,
            departTime, arriveTime, flightTime)
VALUES ('[airlineCode]', '[flightNum]', '[origin]', '[destination]',
            '[departTime]', '[arriveTime]', '[flightTime]');



--
--    Remove Records
--

-- Row 15 - Remove records from E1 -- Country
DELETE FROM Country
WHERE name='[name]';

-- Row 16 - Remove records from E2 -- Airport
DELETE FROM Airport
WHERE code = '[code]';

-- Row 17 - Remove records from E3 -- Airline
DELETE FROM Airline
WHERE code = '[code]';

-- Row 18 - Remove records from E4 -- Flight
DELETE FROM Flight
WHERE id = '[id]';




--
--    Associate / De-Associate Relationships
--

-- Row 19 - Associate any rows between E2 (Airport) and E3 (Airline) in many-to-many relationship --
INSERT INTO Destination (airline, destination)
VALUES ('[airlineCode]', '[destinationCode]');

-- Row 20 - De-associate any rows between E2 (Airport) and E3 (Airline) in many-to-many relationship --
DELETE FROM Destination
WHERE id = '[id]';

-- Row 21 - Change association of rows between E2 (Airport) and E3 (Airline) in many-to-many relationship --
UPDATE Destination
SET destination = '[newDestinationCode]'
WHERE id = '[id]';

-- Row 22
-- Associate any rows between E1 (Country) and E2 (Airport ) in the one-to-many relationship --
-- This cannot be imnplemented because the country that an airport is located
-- in and the country that an airline is based out of both cannot be modified.
-- The field is required when the record is created and should not be changed.
-- Per https://piazza.com/class/jfeeua298i24a?cid=195, returning an error message
-- to the user will be sufficient. This will be implemented as part of Rule 26.

-- Row 23
-- De-associate any rows between E1 and E3 in the one-to-many relationship --
-- This also cannot be imnplemented because the country that an airport is located
-- in and the country that an airline is based out of both cannot be null.
-- The field is required when the record is created and cannot be removed.
-- Per https://piazza.com/class/jfeeua298i24a?cid=195, returning an error message
-- to the user will be sufficient. This will be implemented as part of Rule 26.



--
--    Search records -- These all satisfy Row 24
--

-- Search records in E1 by 2 attributes --
SELECT *
FROM Country
WHERE LOWER(name) LIKE LOWER('%[query]%') OR LOWER(capital) LIKE LOWER('%[query]%');

-- Search records in E2 by 3 attributes --
SELECT *
FROM Airport
WHERE LOWER(name) LIKE LOWER('%[query]%') OR LOWER(code) LIKE LOWER('%[query]%')
      OR LOWER(city) LIKE LOWER('%[query]%');

-- Search records in E3 by 2 attributes --
SELECT *
FROM Airline
WHERE LOWER(name) LIKE LOWER('%[query]%') OR LOWER(code) LIKE LOWER('%[query]%')
ORDER BY Airline.id;

-- Search records in E4 by 9 attributes, including referenced rows in forgein tables --
SELECT Flight.id, Airline.name, Airline.code, Flight.flightNum, Flight.origin, Flight.destination,
       Flight.departTime, Flight.arriveTime, Flight.flightTime, orig.city AS depCity, dest.City AS arrCity
FROM Flight INNER JOIN Airline ON airline = Airline.code INNER JOIN Airport orig ON Flight.origin = orig.Code
       INNER JOIN Airport dest ON Flight.destination = dest.code
WHERE LOWER(Airline.name) LIKE LOWER('%[query]%') OR LOWER(Airline.code) LIKE LOWER('%[query]%')
       OR CAST(Flight.flightNum AS CHAR) LIKE LOWER('%[query]%') OR LOWER(orig.name) LIKE LOWER('%[query]%')
       OR LOWER(orig.code) LIKE LOWER('%[query]%') OR LOWER(dest.name) LIKE LOWER('%[query]%')
       OR LOWER(dest.code) LIKE LOWER('%[query]%') OR LOWER(orig.city) LIKE LOWER('%[query]%')
       OR LOWER(dest.city) LIKE LOWER('%[query]%')
ORDER BY Flight.id;

-- Search records in E5 by 5 attributes, including referenced rows in forgein tables --
SELECT Destination.id, Airline.name, Airport.city, Destination.destination
FROM Destination
INNER JOIN Airline ON airline = Airline.code INNER JOIN Airport ON destination = Airport.code
WHERE LOWER(Airline.name) LIKE LOWER('%[query]%') OR LOWER(Airline.code) LIKE LOWER('%[query]%')
      OR LOWER(Airport.name) LIKE LOWER('%[query]%') OR LOWER(Airport.code) LIKE LOWER('%[query]%')
      OR LOWER(Airport.city) LIKE LOWER('%[query]%')
ORDER BY Destination.id;



--
--    Filter Records -- These all satisfy Row 25
--

-- Show selected record from E1 --
SELECT *
FROM Country
WHERE name = '[selectedCountry]';

-- Show selected record from E2 --
SELECT *
FROM Airport
WHERE code = '[selectedAirport]';

-- Show selected record from E3 --
SELECT *
FROM Airline
WHERE code = '[selectedAirline]';


-- Show selected record from E4, with 3 different dropdowns --

-- Filter flights by airline --
SELECT Flight.id, Airline.name, Airline.code, Flight.flightNum, Flight.origin, Flight.destination,
       Flight.departTime, Flight.arriveTime, Flight.flightTime, A.city AS depCity, B.city AS arrCity
FROM Flight INNER JOIN Airline ON airline = code INNER JOIN Airport A on A.code = Flight.origin
       INNER JOIN Airport B on B.code = Flight.destination
WHERE airline = '[airline]'
ORDER BY Flight.id;

-- Filter flights by origin --
SELECT Flight.id, Airline.name, Airline.code, Flight.flightNum, Flight.origin, Flight.destination,
       Flight.departTime, Flight.arriveTime, Flight.flightTime, A.city AS depCity, B.city AS arrCity
FROM Flight INNER JOIN Airline ON airline = code INNER JOIN Airport A on A.code = Flight.origin
       INNER JOIN Airport B on B.code = Flight.destination
WHERE origin = '[origin]'
ORDER BY Flight.id;

-- Filter flights by destination --
SELECT Flight.id, Airline.name, Airline.code, Flight.flightNum, Flight.origin, Flight.destination,
      Flight.departTime, Flight.arriveTime, Flight.flightTime, A.city AS depCity, B.city AS arrCity
FROM Flight INNER JOIN Airline ON airline = code INNER JOIN Airport A on A.code = Flight.origin
      INNER JOIN Airport B on B.code = Flight.destination
WHERE destination = '[destination]'
ORDER BY Flight.id;

-- Filter flights by airline and origin --
SELECT Flight.id, Airline.name, Airline.code, Flight.flightNum, Flight.origin, Flight.destination,
       Flight.departTime, Flight.arriveTime, Flight.flightTime, A.city AS depCity, B.city AS arrCity
FROM Flight INNER JOIN Airline ON airline = code INNER JOIN Airport A on A.code = Flight.origin
       INNER JOIN Airport B on B.code = Flight.destination
WHERE airline = '[airline]' AND origin = '[origin]'
ORDER BY Flight.id;

-- Filter flights by origin and destination --
SELECT Flight.id, Airline.name, Airline.code, Flight.flightNum, Flight.origin, Flight.destination,
       Flight.departTime, Flight.arriveTime, Flight.flightTime, A.city AS depCity, B.city AS arrCity
FROM Flight INNER JOIN Airline ON airline = code INNER JOIN Airport A on A.code = Flight.origin
       INNER JOIN Airport B on B.code = Flight.destination
WHERE origin = '[origin]' AND destination = '[destination]'
ORDER BY Flight.id;

-- Filter flights by airline and destination --
SELECT Flight.id, Airline.name, Airline.code, Flight.flightNum, Flight.origin, Flight.destination,
      Flight.departTime, Flight.arriveTime, Flight.flightTime, A.city AS depCity, B.city AS arrCity
FROM Flight INNER JOIN Airline ON airline = code INNER JOIN Airport A on A.code = Flight.origin
      INNER JOIN Airport B on B.code = Flight.destination
WHERE destination = '[destination]' AND airline = '[airline]'
ORDER BY Flight.id;

-- Filter flights by airline and origin and destination --
SELECT Flight.id, Airline.name, Airline.code, Flight.flightNum, Flight.origin, Flight.destination,
       Flight.departTime, Flight.arriveTime, Flight.flightTime, A.city AS depCity, B.city AS arrCity
FROM Flight INNER JOIN Airline ON airline = code INNER JOIN Airport A on A.code = Flight.origin
       INNER JOIN Airport B on B.code = Flight.destination
WHERE airline = '[airline]' AND origin = '[origin]' AND destination = '[destination]'
ORDER BY Flight.id;


-- Show selected record from E5, with 2 different dropdowns --

-- Filter destinations by airline --
SELECT Destination.id, Airline.name, Airport.city, Destination.destination
FROM Destination INNER JOIN Airline ON airline = code
INNER JOIN Airport ON Airport.code = Destination.destination
WHERE airline = '[code]'
ORDER BY Destination.id

SELECT Destination.id, Airline.name, Airport.city, Destination.destination
FROM Destination INNER JOIN Airline ON airline = code
INNER JOIN Airport ON Airport.code = Destination.destination
WHERE destination = '[selectedDestination]'
ORDER BY Destination.id



--
--    Update Details
--


-- Row 26 - Update details for E2 -- Airport
-- The reason I update E2 and not E1 is because an airport's name can change, but the name or capital of a country tends to stay the same.
UPDATE Airport
SET name = '[inputName]'
WHERE code = '[currentAirportCode]';
-- When the user tries to edit the Airport entry, they will be able to change the name.
-- The country cell will become a dropdown, however editing this will trigger an error, as explained for Rows 21 and 22.
-- This is acceptable per https://piazza.com/class/jfeeua298i24a?cid=195, see Row 21 and Row 22
-- above about associating/de-associating rows in the one-to-many relationships.
