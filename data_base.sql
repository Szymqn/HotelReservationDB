-- refresh
DROP TABLE Reservations;
DROP TABLE Guests;
DROP TABLE Dates;
DROP TABLE Hotels;
DROP TABLE Owners;
DROP TABLE Rooms;
DROP TABLE Locations;
DROP TABLE Countries;
DROP TABLE Hotels_Owners;

CREATE TABLE Reservations
(
    reservation_id NUMBER,
    guest_id       NUMBER       NOT NULL UNIQUE,
    date_id        NUMBER       NOT NULL UNIQUE,
    room_id        NUMBER       NOT NULL UNIQUE,
    device_sys     VARCHAR2(30),
    location       VARCHAR2(30),
    user_name      VARCHAR2(30) NOT NULL UNIQUE,
    CONSTRAINT Reservations_PK PRIMARY KEY (reservation_id),
    CONSTRAINT Reservations_FK_1 FOREIGN KEY (guest_id) REFERENCES Guests (guest_id),
    CONSTRAINT Reservations_FK_2 FOREIGN KEY (date_id) REFERENCES Dates (date_id),
    CONSTRAINT Reservations_FK_4 FOREIGN KEY (room_id) REFERENCES Rooms (room_id)
);

INSERT INTO Reservations
VALUES (321, 135, 11, 201, 'android', 'Poland', 'Kowal123'),
       (322, 136, 12, 202, 'android', 'Germany', 'Zbychu321'),
       (323, 137, 13, 203, 'MacOS', 'Poland', 'MaciekPL'),
       (324, 138, 14, 204, 'Windows', 'Russia', 'JanuszK'),
       (325, 139, 15, 205, 'IOS', 'Germany', 'Zbigi'),
       (326, 140, 16, 206, 'Windows', 'United Kingdom', 'Kamilo'),
       (327, 141, 17, 207, 'IOS', 'Lithuania', 'Przemo');


CREATE TABLE Guests
(
    guest_id    NUMBER,
    first_name  VARCHAR2(30) NOT NULL,
    middle_name VARCHAR2(30) DEFAULT NULL,
    last_name   VARCHAR2(30) NOT NULL,
    email       VARCHAR2(30) NOT NULL UNIQUE,
    CONSTRAINT Guests_PK PRIMARY KEY (guest_id)
);

INSERT INTO Guests
VALUES (135, 'Jan', 'Adam', 'Kowalski', 'akowal@gmail.com'),
       (136, 'Zbigniew', null, 'Jankowski', 'zjankow@gmail.com'),
       (137, 'Maciej', null, 'Kowalewski', 'mkowalew@gmail.com'),
       (138, 'Janusz', 'Piotr', 'Krak', 'jkraw@gmail.com'),
       (139, 'Zbigniew', 'Adam', 'Kowalski', 'zkowals@gmail.com'),
       (140, 'Kamil', null, 'Wisniewski', 'kwisn@gmail.com'),
       (141, 'Przemysław', null, 'Zasada', 'przemoz@gmail.com');

CREATE TABLE Dates
(
    date_id   NUMBER,
    check_in  DATE         NOT NULL,
    checkout  DATE         NOT NULL,
    time_zone VARCHAR2(30) NOT NULL,
    CHECK (check_in < checkout),
    CONSTRAINT Dates_PK PRIMARY KEY (date_id)
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
    owner_id      NUMBER       NOT NULL,
    location_id     NUMBER       NOT NULL,
    number_of_stars NUMBER       NOT NULL CHECK ( number_of_stars > 0 ),
    CONSTRAINT Hotels_PK PRIMARY KEY (hotel_id),
    CONSTRAINT Hotels_FK1 FOREIGN KEY (location_id) REFERENCES Locations(location_id)
);

INSERT INTO Hotels
VALUES (21, 'Radisson Blu Daugava', 11, 41, 4),
       (22, 'Hilton on Park Lane', 12, 42, 5),
       (23, 'Cavalier Hotel Prague', 13, 43, 3),
       (24, 'Grand Hyatt Kuwait', 14, 44, 5),
       (25, 'InterContinental Los Angeles', 12, 45, 4),
       (26, 'ibis Bogota Museo', 16, 46, 3),
       (27, 'Radisson Blu Park Hotel', 17, 47, 4);

CREATE TABLE Hotels_Owners
(
    id NUMBER,
    hotel_id    NUMBER,
    owner_id    NUMBER,
    CONSTRAINT Hotel_Owners_PK PRIMARY KEY (id),
    CONSTRAINT Hotel_Owners_FK1 FOREIGN KEY (owner_id) REFERENCES Owners(owner_id),
    CONSTRAINT Hotels_Owners_FK2 FOREIGN KEY (hotel_id) REFERENCES Hotels(hotel_id)
);


CREATE TABLE Locations
(
    location_id NUMBER,
    address     VARCHAR2(30) NOT NULL,
    city        VARCHAR2(30) NOT NULL,
    zip_code    VARCHAR(15)  NOT NULL,
    country_id  NUMBER       NOT NULL,
    CONSTRAINT Locations_PK PRIMARY KEY (location_id),
    CONSTRAINT Locations_FK_1 FOREIGN KEY (country_id) REFERENCES Countries (country_id)
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
    CONSTRAINT Countries_PK PRIMARY KEY (country_id)
);

INSERT INTO Countries
VALUES (51, 'Latvia', 'LV', 'Latvian', 'Europe', '+371'),
       (52, 'England', 'ENG', 'English', 'Europe', '+44'),
       (53, 'Czechia', 'CZ', 'Czech', 'Europe', '+420'),
       (54, 'Kuwait', 'KW', 'Arabic', 'Asia', '+965'),
       (55, 'California', 'CA', 'English', 'USA', '310'),
       (56, 'Colombia', 'CO', 'Spanish', 'South America', '+57'),
       (57, 'Norway', 'NO', 'Norwegian', 'Europe', '+47');

CREATE TABLE Owners
(
    owner_id    NUMBER,
    first_name    VARCHAR2(30) NOT NULL,
    last_name     VARCHAR2(30) NOT NULL,
    phone_num     NUMBER       NOT NULL CHECK ( phone_num > 0 ),
    date_of_birth DATE         NOT NULL,
    CONSTRAINT Owners_PK PRIMARY KEY (owner_id)
);

INSERT INTO Owners
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
    hotel_id NUMBER,
    floor    NUMBER NOT NULL,
    standard VARCHAR2(30) DEFAULT NULL,
    size     NUMBER NOT NULL CHECK ( size > 0 ),
    price    NUMBER NOT NULL CHECK ( price > 0 ),
    CONSTRAINT Rooms_PK PRIMARY KEY (room_id),
    CONSTRAINT Rooms_FK1 FOREIGN KEY (room_id) REFERENCES Hotels (hotel_id)
);

INSERT INTO Rooms
VALUES (201, 21,  20, 'premium', 85, 4850),
       (202, 22, 12, 'premium', 60, 3740),
       (203, 23, 8, 'casual', 30, 500),
       (204, 24, 10, 'casual', 33, 850),
       (205, 25, 5, 'casual', 28, 450),
       (206, 26, 13, 'premium', 38, 2950),
       (207, 27, 15, 'premium', 85, 4550);