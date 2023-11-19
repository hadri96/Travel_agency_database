--#1
SELECT AVG(price) AS Average_ticket_price
FROM Flight_booking
JOIN Flight ON Flight_booking.flight_id = Flight.flight_id
JOIN Airline ON Flight.airline_id = Airline.airline_id
WHERE Airline.airline_name = 'Air France';

--#2
SELECT country, COUNT(*) AS Number_of_Customer
FROM Customer
GROUP BY country;

--#3
SELECT airport_name
FROM Airport
WHERE country = 'France' AND city = 'Paris';

--#4-1
SELECT city, country, COUNT(*) AS airport_count
FROM Airport
GROUP BY city, country
HAVING COUNT(*) = (
    SELECT MAX(cnt)
    FROM (
        SELECT COUNT(*) AS cnt
        FROM Airport
        GROUP BY city, country
    ) AS subquery);

--#4-2
SELECT city, country, COUNT(*) AS airport_count
FROM Airport
GROUP BY city, country
ORDER BY airport_count DESC
LIMIT 1;

--#5 
--#Notice: Since no company use Airbus A300, the result is nothing
SELECT airline_name
FROM Airline
JOIN Flight ON Airline.airline_id = Flight.airline_id
JOIN Aircraft ON Aircraft.aircraft_id = Flight.aircraft_id
WHERE aircraft_name = 'Airbus A300';


--#6-1
SELECT DISTINCT customer_id, first_name, last_name
FROM Customer 
JOIN Trip USING (customer_id) 
JOIN Flight_booking USING (trip_id)
WHERE flight_id IN (
    SELECT flight_id
    FROM flight
    WHERE flight.airport_dst IN (
        SELECT airport_id AS airport_dest
        FROM Airport
        WHERE city = 'Sydney' AND country = 'Australia'
    )
);

--#6-2
SELECT DISTINCT Customer.customer_id, Customer.first_name, Customer.last_name
FROM Customer 
JOIN Trip ON Customer.customer_id = Trip.customer_id
JOIN Flight_booking ON Trip.trip_id = Flight_booking.trip_id
JOIN Flight ON Flight_booking.flight_id = Flight.flight_id
JOIN Airport ON Flight.airport_dst = Airport.airport_id
WHERE Flight.airport_dst IN (
   SELECT airport_id AS airport_dest
   FROM Airport
   WHERE city = 'Sydney' AND country = 'Australia');

--#7
SELECT airport_id, airport_name, city, country
FROM Airport
WHERE airport_id = (
    SELECT airport
    FROM (
        SELECT airport_src AS airport, SUM(flight_count) AS total_flights
        FROM (
            SELECT airport_src, COUNT(*) AS flight_count
            FROM Flight
            GROUP BY airport_src
            UNION ALL
            SELECT flight.airport_dst, COUNT(*) AS flight_count
            FROM Flight
            GROUP BY flight.airport_dst
        ) combined_flights
        GROUP BY airport
        ORDER BY total_flights DESC
        LIMIT 1
    ) most_busy_airport);

--#8
SELECT AVG(price) AS average_price_of_economy_class
FROM Flight_booking
WHERE travel_class = 'economy';

--#9
SELECT AVG(price) AS average_price_of_business_class
FROM Flight_booking
WHERE travel_class = 'business';

--#10 
SELECT DISTINCT airport_name, city, country
FROM Trip
JOIN Flight_booking ON Trip.trip_id = Flight_booking.trip_id 
JOIN Flight ON Flight_booking.flight_id = Flight.flight_id
JOIN Airport ON flight.airport_dst = Airport.airport_id
WHERE customer_id IN
	(SELECT customer_id
	FROM customer
	WHERE country = 'France')
ORDER BY airport_name;

--#11 
SELECT Airport.city, Airport.country
FROM Customer
JOIN Trip ON Customer.customer_id = Trip.customer_id
JOIN Flight_booking ON Flight_booking.trip_id = Trip.trip_id
JOIN Flight ON Flight.flight_id = Flight_booking.flight_id
JOIN Airport ON Flight.airport_dst = Airport.airport_id
WHERE gender = 'F'
GROUP BY Airport.city, Airport.country
ORDER BY COUNT(*) DESC
LIMIT 1;

--#12
SELECT Airport.city, Airport.country
FROM Customer
JOIN Trip ON Customer.customer_id = Trip.customer_id
JOIN Flight_booking ON Flight_booking.trip_id = Trip.trip_id
JOIN Flight ON Flight.flight_id = Flight_booking.flight_id
JOIN Airport ON Flight.airport_dst = Airport.airport_id
WHERE gender = 'M'
GROUP BY Airport.city, Airport.country
ORDER BY COUNT(*) DESC
LIMIT 1;

--#13 
SELECT country, count(*) AS number_of_customers_to_Paris
FROM Customer 
JOIN Trip ON Customer.customer_id = Trip.customer_id
JOIN Flight_booking ON Trip.Trip_id = Flight_booking.Trip_id
JOIN Flight ON Flight_booking.flight_id = Flight.flight_id
WHERE flight.airport_dst IN 
	(SELECT airport_id
	FROM Airport
	WHERE city = 'Paris')
GROUP BY country;

--#14
SELECT city, COUNT(*) AS Number_of_hotels
FROM Hotel
GROUP BY city;

--#15 
SELECT SUM(price) AS amount_of_money_spent_by_Tatiana_REZE
FROM Flight_booking
JOIN Trip ON Flight_booking.trip_id = Trip.trip_id
JOIN Customer ON Customer.customer_id = Trip.customer_id
WHERE first_name = 'Tatiana' AND last_name = 'REZE';