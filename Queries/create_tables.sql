CREATE TABLE Customer
(
	customer_id INTEGER PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	gender VARCHAR(1),
	birth_date DATE,
	country VARCHAR(30),
	phone_number VARCHAR(30) UNIQUE,
	email VARCHAR(50) UNIQUE
);

CREATE TABLE Trip
(
	trip_id INTEGER PRIMARY KEY,
	customer_id INTEGER NOT NULL,
	FOREIGN KEY(customer_id) REFERENCES Customer(customer_id)
		ON UPDATE CASCADE
);

CREATE TABLE Hotel
(
	hotel_id INTEGER PRIMARY KEY,
	hotel_name VARCHAR(100),
	hotel_address VARCHAR(300),
	city VARCHAR(50),
	country VARCHAR(50),
	hotel_score REAL
);

CREATE TABLE Hotel_Booking
(
	hotel_booking_id INTEGER PRIMARY KEY,
	price REAL NOT NULL,
	breakfast_included BOOLEAN,
	check_in_date DATE NOT NULL,
	check_out_date DATE NOT NULL,
	trip_id INTEGER NOT NULL,
	hotel_id INTEGER NOT NULL,
	FOREIGN KEY(hotel_id) REFERENCES Hotel(hotel_id)
		ON UPDATE CASCADE,
	FOREIGN KEY(trip_id) REFERENCES Trip(trip_id)
		ON UPDATE CASCADE
);

CREATE TABLE Review
(
	review_id INTEGER PRIMARY KEY,
	customer_id INTEGER NOT NULL,
	FOREIGN KEY(customer_id) REFERENCES Customer(customer_id)
		ON UPDATE CASCADE,
	hotel_booking_id INTEGER NOT NULL,
	FOREIGN KEY(hotel_booking_id) REFERENCES Hotel_Booking(hotel_booking_id)
		ON UPDATE CASCADE,
	review_date DATE NOT NULL,
	content TEXT,
	score REAL NOT NULL
);

CREATE TABLE Airline
(
	airline_id INTEGER PRIMARY KEY,
	airline_name VARCHAR(200),
	country VARCHAR(100),
	icao_code VARCHAR(5),
	iata_code VARCHAR(5),
	alias VARCHAR(50)
);

CREATE TABLE Airport
(
	airport_id INTEGER PRIMARY KEY,
	iata_code VARCHAR(5) UNIQUE,
	airport_name VARCHAR(200),
	icao_code VARCHAR(5) UNIQUE,
	city VARCHAR(100),
	country VARCHAR(100),
	latitude DECIMAL(10,6) NOT NULL,
	longitude DECIMAL(10,6) NOT NULL
);

CREATE TABLE Aircraft
(
	aircraft_id INTEGER PRIMARY KEY,
	aircraft_name VARCHAR(200),
	iata_code VARCHAR(5),
	icao_code VARCHAR(5)
);

CREATE TABLE Flight
(
	flight_id INTEGER PRIMARY KEY,
	flight_number VARCHAR(15) NOT NULL,
	flight_duration INTERVAL NOT NULL,
	departure_time TIME NOT NULL,
	departure_date DATE NOT NULL,
	airline_id INTEGER NOT NULL,
	airport_src INTEGER NOT NULL,
	airport_dst INTEGER NOT NULL,
	aircraft_id INTEGER NOT NULL,
	FOREIGN KEY(aircraft_id) REFERENCES Aircraft(aircraft_id)
		ON UPDATE CASCADE,
	FOREIGN KEY(airline_id) REFERENCES Airline(airline_id)
		ON UPDATE CASCADE,
	FOREIGN KEY(airport_dst) REFERENCES Airport(airport_id)
		ON UPDATE CASCADE,
	FOREIGN KEY(airport_src) REFERENCES Airport(airport_id)
		ON UPDATE CASCADE
);

CREATE TABLE Flight_booking
(
	flight_booking_id INTEGER PRIMARY KEY,
	flight_id INTEGER NOT NULL,
	FOREIGN KEY(flight_id) REFERENCES Flight(flight_id)
		ON UPDATE CASCADE,
	trip_id INTEGER NOT NULL,
	FOREIGN KEY(trip_id) REFERENCES Trip(trip_id)
		ON UPDATE CASCADE,
	seat VARCHAR(4),
	price REAL,
	travel_class VARCHAR(20)
);
