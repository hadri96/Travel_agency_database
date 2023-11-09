#1
SELECT AVG(price)
FROM Flight_booking JOIN Flight USING flight_id
WHERE airline_id = 137;

#2
SELECT COUNT(*)
FROM Customer
GROUP BY country;

#3
SELECT airport_name
FROM Airport
WHERE country = "France" AND city = "Paris";

#4
SELECT city, country, COUNT(*)
FROM Airport
GROUP BY city
HAVING HAVING COUNT(*) = MAX(COUNT(*));

#5
SELECT airline_name
FROM Airline JOIN Flight USING airline_id
WHERE aircraft_id = 32;

#6
SELECT customer_id, first_name, last_name
FROM Customer JOIN Trip USING (customer_id) JOIN Flight_booking USING (trip_id)
WHERE flight_id =(SELECT flight_id
					FROM flight
					WHERE airport_dest = 
				 		(SELECT airport_id AS airport_dest
				 		FROM Airport
				 		WHERE city = "Sydney" AND country = "Australia"));

#7
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
            SELECT airport_dest, COUNT(*) AS flight_count
            FROM Flight
            GROUP BY airport_dest
        ) combined_flights
        GROUP BY airport
        ORDER BY total_flights DESC
        LIMIT 1
    ) most_busy_airport);

#8
SELECT AVG(price)
FROM Flight_booking
WHERE travel_class = "economy";

#9
SELECT AVG(price)
FROM Flight_booking
WHERE travel_class = "business";

#10
SELECT airport_name, city, country
FROM customer_fr JOIN Trip USING customer_id JOIN Flight USING trip_id JOIN Airport ON airport_dest = airport_id
WHERE customer_id IN
	(SELECT customer_id
	FROM customer
	WHERE country = "France");
	
#11
SELECT city, country
FROM customer_fr JOIN Trip USING customer_id JOIN Flight USING trip_id JOIN Airport ON airport_dest = airport_id
(SELECT customer_id
	FROM customer
	WHERE gender = "F") customer_f
GROUP BY airport_dest 
HAVING COUNT(*) = MAX(COUNT(*));

#12
SELECT city, country
FROM customer_fr JOIN Trip USING customer_id JOIN Flight USING trip_id JOIN Airport ON airport_dest = airport_id
(SELECT customer_id
	FROM customer
	WHERE gender = "M") customer_m
GROUP BY airport_dest 
HAVING COUNT(*) = MAX(COUNT(*));

#13
SELECT count(*)
FROM Trip
WHERE trip_id =
	(SELECT trip_id
	FROM Flight_booking
	WHERE flight_id =
		(SELECT flight_id
		FROM Flight
		WHERE airport_dest = 
			(SELECT airport_id
			FROM Airport
			WHERE city = "Paris")));
			
#14
SELECT city, COUNT(*)
FROM Hotel
GROUP BY city;

#15
SELECT SUM(price)
FROM Flight_booking
WHERE trip_id =
	(SELECT trip_id
	FROM trip
	WHERE customer_id =
		(SELECT customer_id
		FROM customer
		WHERE first_name = "Tatiana", last_name = "REZE"));
