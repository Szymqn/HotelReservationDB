-- refresh
DROP TABLE Reservations;
DROP TABLE Guests;
DROP TABLE Dates;
DROP TABLE Hotels;
DROP TABLE Managers;
DROP TABLE Rooms;
DROP TABLE Hotels_Locations;
DROP TABLE Locations;
DROP TABLE Countries;

CREATE TABLE Reservations
(
    reservation_id NUMBER,
    hotel_id       NUMBER,
    guest_id    NUMBER,
    device         VARCHAR2(30),
    location       VARCHAR2(30),
    user_name      VARCHAR2(30),
    CONSTRAINT Reservations_PK PRIMARY KEY (reservation_id)
);

CREATE TABLE Guests
(
    guest_id    NUMBER,
    date_id     NUMBER NOT NULL UNIQUE,
    first_name  VARCHAR2(30) NOT NULL,
    middle_name VARCHAR2(30) DEFAULT NULL,
    last_name   VARCHAR2(30) NOT NULL UNIQUE,
    email       VARCHAR2(30) NOT NULL UNIQUE,
    CONSTRAINT Guests_PK PRIMARY KEY (guest_id),
    FOREIGN KEY (guest_id) REFERENCES Reservations(guest_id)
);

CREATE TABLE Dates
(
    date_id     NUMBER,
    check_in    DATE NOT NULL,
    checkout    DATE NOT NULL,
    time_zone   VARCHAR2(30) NOT NULL,
    CHECK (check_in < checkout),
    CONSTRAINT Dates_PK PRIMARY KEY (date_id),
    FOREIGN KEY (date_id) REFERENCES Guests(date_id)
);

CREATE TABLE Hotels
(
    hotel_id    NUMBER,
    hotel_name  VARCHAR2(30) NOT NULL,
    manager_id  NUMBER NOT NULL UNIQUE,
    location_id NUMBER NOT NULL UNIQUE,
    room_id     NUMBER NOT NULL UNIQUE,
    number_of_stars NUMBER NOT NULL,
    CONSTRAINT Hotels_PK PRIMARY KEY (hotel_id),
    FOREIGN KEY (hotel_id) REFERENCES Reservations(hotel_id)
);

CREATE TABLE Hotels_Locations
(
    id          NUMBER,
    hotel_id    NUMBER NOT NULL UNIQUE,
    location_id NUMBER NOT NULL UNIQUE,
    CONSTRAINT Hotels_Locations_PK PRIMARY KEY (id),
    FOREIGN KEY (hotel_id) REFERENCES Hotels(hotel_id) ON DELETE CASCADE,
    FOREIGN KEY (location_id) REFERENCES Locations(location_id) ON DELETE CASCADE
);

CREATE TABLE Locations
(
    location_id     NUMBER,
    address         VARCHAR2(30) NOT NULL,
    city            VARCHAR2(30) NOT NULL,
    zip_code        VARCHAR(15) NOT NULL,
    country_id      NUMBER NOT NULL UNIQUE,
    CONSTRAINT Locations_PK PRIMARY KEY (location_id)
);

CREATE TABLE Countries
(
    country_id  NUMBER,
    name        VARCHAR2(30) NOT NULL,
    s_name      VARCHAR2(3) NOT NULL,
    language    VARCHAR2(30) NOT NULL,
    continent   VARCHAR2(30) NOT NULL,
    s_continent VARCHAR2(30) NOT NULL,
    CHECK ( LENGTH(name) > LENGTH(s_name) ),
    CONSTRAINT Countries_PK PRIMARY KEY (country_id),
    FOREIGN KEY (country_id) REFERENCES Locations(country_id)
);

CREATE TABLE Managers
(
    manager_id      NUMBER,
    first_name      VARCHAR2(30) NOT NULL,
    last_name       VARCHAR2(30) NOT NULL,
    manager_id_num  NUMBER NOT NULL UNIQUE CHECK ( manager_id_num > 0 ),
    nationalization VARCHAR2(30) DEFAULT NULL,
    CONSTRAINT Managers_PK PRIMARY KEY (manager_id),
    FOREIGN KEY (manager_id) REFERENCES Hotels(manager_id)
);

CREATE TABLE Rooms
(
    room_id     NUMBER,
    floor       NUMBER NOT NULL,
    standard    VARCHAR2(30) DEFAULT NULL,
    size        NUMBER NOT NULL CHECK ( size > 0 ),
    type        VARCHAR2(30),
    CONSTRAINT Rooms_PK PRIMARY KEY (room_id),
    FOREIGN KEY (room_id) REFERENCES Hotels(room_id)
);