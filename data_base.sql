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
    hotel_id       NUMBER       NOT NULL,
    guest_id       NUMBER       NOT NULL UNIQUE,
    device_sys     VARCHAR2(30),
    location       VARCHAR2(30),
    user_name      VARCHAR2(30) NOT NULL UNIQUE,
    CONSTRAINT Reservations_PK PRIMARY KEY (reservation_id)
);

INSERT INTO Reservations
VALUES (321, 22, 135, 'android', 'Poland', 'Kowal123'),
       (322, 23, 136, 'android', 'Germany', 'Zbychu321'),
       (323, 24, 137, 'MacOS', 'Lithuania', 'MaciekPL'),
       (324, 25, 138, 'Windows', 'Russia', 'JanuszK'),
       (325, 26, 139, 'IOS', 'Germany', 'Zbigi'),
       (326, 24, 140, 'Windows', 'United Kingdom', 'Kamilo'),
       (327, 26, 141, 'IOS', 'Poland', 'Przemo');


CREATE TABLE Guests
(
    guest_id    NUMBER,
    date_id     NUMBER       NOT NULL UNIQUE,
    first_name  VARCHAR2(30) NOT NULL,
    middle_name VARCHAR2(30) DEFAULT NULL,
    last_name   VARCHAR2(30) NOT NULL,
    email       VARCHAR2(30) NOT NULL UNIQUE,
    CONSTRAINT Guests_PK PRIMARY KEY (guest_id),
    FOREIGN KEY (guest_id) REFERENCES Reservations (guest_id)
);

INSERT INTO Guests
VALUES (135, 235, 'Jan', 'Adam', 'Kowalski', 'akowal@gmail.com'),
       (136, 236, 'Zbigniew', null, 'Jankowski', 'zjankow@gmail.com'),
       (137, 237, 'Maciej', null, 'Kowalewski', 'mkowalew@gmail.com'),
       (138, 238, 'Janusz', 'Piotr', 'Krak', 'jkraw@gmail.com'),
       (139, 239, 'Zbigniew', 'Adam', 'Kowalski', 'zkowals@gmail.com'),
       (140, 240, 'Kamil', null, 'Wisniewski', 'kwisn@gmail.com'),
       (141, 241, 'Przemysław', null, 'Zasada', 'przemoz@gmail.com');

CREATE TABLE Dates
(
    date_id   NUMBER,
    check_in  DATE         NOT NULL,
    checkout  DATE         NOT NULL,
    time_zone VARCHAR2(30) NOT NULL,
    CHECK (check_in < checkout),
    CONSTRAINT Dates_PK PRIMARY KEY (date_id),
    FOREIGN KEY (date_id) REFERENCES Guests (date_id)
);

INSERT INTO Dates
VALUES (235, '2023-01-12', '2023-01-20', 'UTC+2'),
       (236, '2023-01-22', '2023-02-01', 'UTC'),
       (237, '2023-01-12', '2023-02-12', 'UTC+1'),
       (238, '2023-02-23', '2023-03-07', 'UTC+3'),
       (239, '2023-03-15', '2023-04-03', 'UTC-8'),
       (240, '2023-01-12', '2023-01-20', 'UTC-5'),
       (241, '2023-01-12', '2023-01-20', 'UTC+1');

CREATE TABLE Hotels
(
    hotel_id        NUMBER,
    hotel_name      VARCHAR2(40) NOT NULL,
    manager_id      NUMBER       NOT NULL UNIQUE,
    location_id     NUMBER       NOT NULL UNIQUE,
    room_id         NUMBER       NOT NULL UNIQUE,
    number_of_stars NUMBER       NOT NULL,
    CONSTRAINT Hotels_PK PRIMARY KEY (hotel_id),
    FOREIGN KEY (hotel_id) REFERENCES Reservations (hotel_id)
);

INSERT INTO Hotels
VALUES (21, 'Radisson Blu Daugava', 11, 101, 201, 4),
       (22, 'Hilton on Park Lane', 12, 102, 202, 5),
       (23, 'Cavalier Hotel Prague', 13, 203, 203, 3),
       (24, 'Grand Hyatt Kuwait', 14, 104, 204, 5),
       (25, 'InterContinental Los Angeles', 15, 105, 205, 4),
       (26, 'ibis Bogota Museo', 16, 106, 206, 3),
       (27, 'Radisson Blu Park Hotel', 17, 107, 207, 4);

CREATE TABLE Hotels_Locations
(
    id          NUMBER,
    hotel_id    NUMBER NOT NULL UNIQUE,
    location_id NUMBER NOT NULL UNIQUE,
    CONSTRAINT Hotels_Locations_PK PRIMARY KEY (id),
    FOREIGN KEY (hotel_id) REFERENCES Hotels (hotel_id) ON DELETE CASCADE,
    FOREIGN KEY (location_id) REFERENCES Locations (location_id) ON DELETE CASCADE
);

INSERT INTO Hotels_Locations
VALUES (1, 21, 41),
       (2, 22, 42),
       (3, 23, 43),
       (4, 24, 44),
       (5, 25, 45),
       (6, 26, 46),
       (7, 27, 47);

CREATE TABLE Locations
(
    location_id NUMBER,
    address     VARCHAR2(30) NOT NULL,
    city        VARCHAR2(30) NOT NULL,
    zip_code    VARCHAR(15)  NOT NULL,
    country_id  NUMBER       NOT NULL UNIQUE,
    CONSTRAINT Locations_PK PRIMARY KEY (location_id)
);

INSERT INTO Locations
VALUES (41, 'Kugu iela 24', 'Riga', 'LV-1007', 51),
       (42, '22 Paek Ln', 'London', 'W1K 1BE', 52),
       (43, 'Plzenska 177', 'Prague', '150 00', 53),
       (44, '360 Mall Ring Rd Area', 'Zahra', '47451', 54),
       (45, '900 Wilshire Blvd', 'Los Angeles', 'CA 90017', 55),
       (46, 'Tv. 6', 'Bogota', '#27-85', 56),
       (47, 'Fornebuveien 80', 'Oslo', '1366', 57);

CREATE TABLE Countries
(
    country_id NUMBER,
    name       VARCHAR2(30) NOT NULL,
    s_name     VARCHAR2(3)  NOT NULL,
    language   VARCHAR2(30) NOT NULL,
    continent  VARCHAR2(30) NOT NULL,
    dial_code  VARCHAR2(15) NOT NULL,
    CHECK ( LENGTH(name) > LENGTH(s_name) ),
    CONSTRAINT Countries_PK PRIMARY KEY (country_id),
    FOREIGN KEY (country_id) REFERENCES Locations (country_id)
);

INSERT INTO Countries
VALUES (51, 'Latvia', 'LV', 'Latvian', 'Europe', '+371'),
       (52, 'England', 'ENG', 'English', 'Europe', '+44'),
       (53, 'Czechia', 'CZ', 'Czech', 'Europe', '+420'),
       (54, 'Kuwait', 'KW', 'Arabic', 'Asia', '+965'),
       (55, 'California', 'CA', 'English', 'USA', '310'),
       (56, 'Colombia', 'CO', 'Spanish', 'South America', '+57'),
       (57, 'Norway', 'NO', 'Norwegian', 'Europe', '+47');

CREATE TABLE Managers
(
    manager_id    NUMBER,
    first_name    VARCHAR2(30) NOT NULL,
    last_name     VARCHAR2(30) NOT NULL,
    phone_num     NUMBER       NOT NULL CHECK ( phone_num > 0 ),
    date_of_birth DATE         NOT NULL,
    CONSTRAINT Managers_PK PRIMARY KEY (manager_id),
    FOREIGN KEY (manager_id) REFERENCES Hotels (manager_id)
);

INSERT INTO Managers
VALUES (11, 'Oskar', 'Eriksen', 216155536, '1965-04-23'),
       (12, 'Jan', 'Kowalski', 575486253, '1968-12-05'),
       (13, 'Marius', 'Geisler', 245631587, '1990-07-03'),
       (14, 'Oskar', 'Eriksen', 216155536, '1965-04-23'),
       (15, 'Otto', 'Sandgreen', 356487556, '1988-01-06'),
       (16, 'Edvard', 'Egede', 546785223, '2000-12-13'),
       (17, 'Svend', 'Sørensen', 366548556, '1999-08-29');

CREATE TABLE Rooms
(
    room_id  NUMBER,
    floor    NUMBER NOT NULL,
    standard VARCHAR2(30) DEFAULT NULL,
    size     NUMBER NOT NULL CHECK ( size > 0 ),
    price    NUMBER NOT NULL CHECK ( price > 0 ),
    CONSTRAINT Rooms_PK PRIMARY KEY (room_id),
    FOREIGN KEY (room_id) REFERENCES Hotels (room_id)
);

INSERT INTO Rooms
VALUES (201, 20, 'premium', 85, 4850),
       (202, 12, 'premium', 60, 3740),
       (203, 8, 'casual', 30, 500),
       (204, 10, 'casual', 33, 850),
       (205, 5, 'casual', 28, 450),
       (206, 13, 'premium', 38, 2950),
       (207, 15, 'premium', 85, 4550);