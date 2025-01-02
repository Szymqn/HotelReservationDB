-- refresh
DROP TABLE Reservations;
DROP TABLE Reservations_Log;
DROP TABLE Guests;
DROP TABLE Hotels;
DROP TABLE Owners;
DROP TABLE Rooms;
DROP TABLE Locations;
DROP TABLE Hotels_Owners;

CREATE TABLE Reservations
(
    reservation_id NUMBER       NOT NULL UNIQUE,
    guest_id       NUMBER       NOT NULL UNIQUE,
    room_id        NUMBER       NOT NULL UNIQUE,
    device_sys     VARCHAR2(30),
    country_name   VARCHAR2(30),
    country_s_name VARCHAR2(3),
    user_name      VARCHAR2(30) NOT NULL UNIQUE,
    check_in       DATE         NOT NULL,
    checkout       DATE         NOT NULL,
    time_zone      VARCHAR2(30) NOT NULL,
    CHECK (check_in < checkout),
    CONSTRAINT Reservations_PK PRIMARY KEY (reservation_id),
    CONSTRAINT Reservations_FK_1 FOREIGN KEY (guest_id) REFERENCES Guests (guest_id),
    CONSTRAINT Reservations_FK_4 FOREIGN KEY (room_id) REFERENCES Rooms (room_id)
);

CREATE TABLE Reservations_Log
(
    log_id          INTEGER PRIMARY KEY AUTOINCREMENT,
    user_name       VARCHAR2(30) NOT NULL,
    timestamp       VARCHAR2(30) NOT NULL,
    action          VARCHAR2(30) NOT NULL,
    reservation_id  NUMBER NOT NULL,
    guest_id        NUMBER NOT NULL,
    room_id         NUMBER NOT NULL,
    device_sys      VARCHAR2(30),
    country_name    VARCHAR2(30),
    country_s_name  VARCHAR2(3),
    check_in        DATE NOT NULL,
    checkout        DATE NOT NULL,
    time_zone       VARCHAR2(30) NOT NULL
);

INSERT INTO Reservations
VALUES (321, 135, 201, 'android', 'Poland', 'pl', 'Kowal123', '2023-01-12', '2023-01-20', 'UTC+2'),
       (322, 136, 202, 'android', 'Germany', 'de', 'Zbychu321', '2023-01-22', '2023-02-01', 'UTC'),
       (323, 137, 203, 'MacOS', 'Poland', 'pl', 'MaciekPL', '2023-01-12', '2023-02-12', 'UTC+1'),
       (324, 138, 204, 'Windows', 'Russia', 'rus', 'JanuszK', '2023-02-23', '2023-03-07', 'UTC+3'),
       (325, 139, 205, 'IOS', 'Germany', 'de', 'Zbigi', '2023-03-15', '2023-04-03', 'UTC-8'),
       (326, 140, 206, 'Windows', 'United Kingdom', 'uk', 'Kamilo', '2023-01-12', '2023-01-20', 'UTC-5'),
       (327, 141, 207, 'IOS', 'Lithuania', 'lt', 'Przemo', '2023-01-12', '2023-01-20', 'UTC+1');

CREATE TRIGGER reservations_logs_delete
    AFTER DELETE ON Reservations
    FOR EACH ROW
BEGIN
    INSERT INTO Reservations_Log (user_name, timestamp, action, reservation_id, guest_id, room_id,
                                  device_sys, country_name, country_s_name, check_in, checkout, time_zone)
    VALUES ('system_user', CURRENT_TIMESTAMP, 'delete', OLD.reservation_id, OLD.guest_id, OLD.room_id,
            OLD.device_sys, OLD.country_name, OLD.country_s_name, OLD.check_in, OLD.checkout, OLD.time_zone);
END;

CREATE TRIGGER reservations_logs_insert
    AFTER INSERT ON Reservations
    FOR EACH ROW
BEGIN
    INSERT INTO Reservations_Log (user_name, timestamp, action, reservation_id, guest_id, room_id,
                                  device_sys, country_name, country_s_name, check_in, checkout, time_zone)
    VALUES ('system_user', CURRENT_TIMESTAMP, 'insert', NEW.reservation_id, NEW.guest_id, NEW.room_id,
            NEW.device_sys, NEW.country_name, NEW.country_s_name, NEW.check_in, NEW.checkout, NEW.time_zone);
END;

DELETE FROM Reservations WHERE reservation_id = 322;
INSERT INTO Reservations VALUES (328, 142, 208, 'android', 'Poland', 'pl', 'Kowal1236', '2023-01-12', '2023-01-20', 'UTC+2');

SELECT * FROM Reservations_Log;

CREATE TABLE Guests
(
    guest_id    NUMBER          NOT NULL UNIQUE,
    first_name  VARCHAR2(30)    NOT NULL,
    middle_name VARCHAR2(30)    DEFAULT NULL,
    last_name   VARCHAR2(30)    NOT NULL,
    email       VARCHAR2(30)    NOT NULL UNIQUE,
    phone_code  VARCHAR2(5)     NOT NULL,
    phone_num   NUMBER          NOT NULL CHECK ( phone_num > 0 ),
    age         NUMBER          NOT NULL CHECK ( age > 0 ),
    sex         VARCHAR2(1)     NOT NULL,
    nationality VARCHAR2(30)    NOT NULL,
    CONSTRAINT Guests_PK PRIMARY KEY (guest_id)
);

INSERT INTO Guests
VALUES (135, 'Jan', 'Adam', 'Kowalski', 'akowal@gmail.com', '+48', 123456789, 25, 'M', 'Polish'),
       (136, 'Zbigniew', null, 'Jankowski', 'zjankow@gmail.com', '+49', 987654321, 35, 'M', 'German'),
       (137, 'Maciej', null, 'Kowalewski', 'mkowalew@gmail.com', '+48', 548652157, 45, 'M', 'Polish'),
       (138, 'Janusz', 'Piotr', 'Krak', 'jkraw@gmail.com', '+7', 548652157, 55, 'M', 'Russian'),
       (139, 'Zbigniew', 'Adam', 'Kowalski', 'zkowals@gmail.com', '+49', 548652157, 65, 'M', 'German'),
       (140, 'Kamil', null, 'Wisniewski', 'kwisn@gmail.com', '+44', 548652157, 75, 'M', 'British'),
       (141, 'Przemysław', null, 'Zasada', 'przemoz@gmail.com', '+370', 548652157, 85, 'M', 'Lithuanian');

CREATE TABLE Hotels
(
    hotel_id        NUMBER       NOT NULL UNIQUE,
    hotel_name      VARCHAR2(40) NOT NULL,
    owner_id        NUMBER       NOT NULL,
    location_id     NUMBER       NOT NULL,
    number_of_stars NUMBER       NOT NULL,
    rating          NUMBER       NOT NULL,
    parking         BOOLEAN      DEFAULT FALSE,
    restaurant      BOOLEAN      DEFAULT FALSE,
    bar             BOOLEAN      DEFAULT FALSE,
    wifi            BOOLEAN      DEFAULT FALSE,
    CHECK ( number_of_stars > 0 ),
    CHECK ( rating > 0 ),
    CONSTRAINT Hotels_PK PRIMARY KEY (hotel_id),
    CONSTRAINT Hotels_FK1 FOREIGN KEY (location_id) REFERENCES Locations (location_id)
);

INSERT INTO Hotels
VALUES (21, 'Radisson Blu Daugava', 11, 41, 4, 6, TRUE, TRUE, TRUE, TRUE),
       (22, 'Hilton on Park Lane', 12, 42, 5, 7, TRUE, TRUE, TRUE, TRUE),
       (23, 'Cavalier Hotel Prague', 13, 43, 3, 5, TRUE, TRUE, TRUE, TRUE),
       (24, 'Grand Hyatt Kuwait', 14, 44, 5, 7, TRUE, TRUE, TRUE, TRUE),
       (25, 'InterContinental Los Angeles', 12, 45, 4, 6, TRUE, TRUE, TRUE, TRUE),
       (26, 'ibis Bogota Museo', 16, 46, 3, 5, TRUE, TRUE, TRUE, TRUE),
       (27, 'Radisson Blu Park Hotel', 17, 47, 4, 6, TRUE, TRUE, TRUE, TRUE);

CREATE TABLE Hotels_Owners
(
    id       NUMBER NOT NULL UNIQUE,
    hotel_id NUMBER NOT NULL UNIQUE,
    owner_id NUMBER NOT NULL UNIQUE,
    CONSTRAINT Hotel_Owners_PK PRIMARY KEY (id),
    CONSTRAINT Hotel_Owners_FK1 FOREIGN KEY (owner_id) REFERENCES Owners (owner_id),
    CONSTRAINT Hotels_Owners_FK2 FOREIGN KEY (hotel_id) REFERENCES Hotels (hotel_id)
);


CREATE TABLE Locations
(
    location_id     NUMBER       NOT NULL UNIQUE,
    address         VARCHAR2(30) NOT NULL,
    city            VARCHAR2(30) NOT NULL,
    zip_code        VARCHAR2(15) NOT NULL,
    country_id      NUMBER       NOT NULL,
    country_name    VARCHAR2(30) NOT NULL,
    country_s_name  VARCHAR2(3)  NOT NULL,
    language        VARCHAR2(30) NOT NULL,
    continent       VARCHAR2(30) NOT NULL,
    dial_code       VARCHAR2(15) NOT NULL,
    CONSTRAINT Locations_PK PRIMARY KEY (location_id)
);

INSERT INTO Locations
VALUES (41, 'Kugu iela 24', 'Riga', 'LV-1007', 51, 'Latvia', 'LV', 'Latvian', 'Europe', '+371'),
       (42, '22 Paek Ln', 'London', 'W1K 1BE', 52, 'England', 'ENG', 'English', 'Europe', '+44'),
       (43, 'Plzenska 177', 'Prague', '150 00', 53, 'Czechia', 'CZ', 'Czech', 'Europe', '+420'),
       (44, '360 Mall Ring Rd Area', 'Zahra', '47451', 54, 'Kuwait', 'KW', 'Arabic', 'Asia', '+965'),
       (45, '900 Wilshire Blvd', 'Los Angeles', 'CA 90017', 55, 'California', 'CA', 'English', 'USA', '310'),
       (46, 'Tv. 6', 'Bogota', '#27-85', 56, 'Colombia', 'CO', 'Spanish', 'South America', '+57'),
       (47, 'Fornebuveien 80', 'Oslo', '1366', 57, 'Norway', 'NO', 'Norwegian', 'Europe', '+47');

CREATE TABLE Owners
(
    owner_id      NUMBER       NOT NULL UNIQUE,
    first_name    VARCHAR2(30) NOT NULL,
    last_name     VARCHAR2(30) NOT NULL,
    phone_num     NUMBER       NOT NULL CHECK ( phone_num > 0 ),
    date_of_birth DATE         NOT NULL,
    account_num   NUMBER       NOT NULL,
    currency      VARCHAR2(30) NOT NULL,
    bank_name     VARCHAR2(30) NOT NULL,
    nationality   VARCHAR2(30) NOT NULL,
    nip           NUMBER       NOT NULL CHECK ( nip > 0 ),
    CONSTRAINT Owners_PK PRIMARY KEY (owner_id)
);

INSERT INTO Owners
VALUES (11, 'Oskar', 'Eriksen', 216155536, '1965-04-23', 123456789, 'USD', 'Bank of America', 'Norwegian', 123456789),
       (12, 'Jan', 'Kowalski', 575486253, '1968-12-05', 987654321, 'EUR', 'Deutsche Bank', 'Polish', 987654321),
       (13, 'Marius', 'Geisler', 245631587, '1990-07-03', 548652157, 'GBP', 'Barclays', 'German', 548652157),
       (14, 'Oskar', 'Eriksen', 216155536, '1965-04-23', 123456789, 'USD', 'Bank of America', 'Norwegian', 123456789),
       (15, 'Otto', 'Sandgreen', 356487556, '1988-01-06', 548652157, 'EUR', 'Deutsche Bank', 'Danish', 548652157),
       (16, 'Edvard', 'Egede', 546785223, '2000-12-13', 548652157, 'GBP', 'Barclays', 'Greenlandic', 548652157),
       (17, 'Svend', 'Sørensen', 366548556, '1999-08-29', 548652157, 'USD', 'Bank of America', 'Danish', 548652157);

CREATE TABLE Rooms
(
    room_id  NUMBER         NOT NULL UNIQUE,
    hotel_id NUMBER         NOT NULL UNIQUE,
    floor    NUMBER         NOT NULL,
    standard VARCHAR2(30)   DEFAULT NULL,
    size     NUMBER         NOT NULL CHECK ( size > 0 ),
    price    NUMBER         NOT NULL CHECK ( price > 0 ),
    spa      BOOLEAN        DEFAULT FALSE,
    tv       BOOLEAN        DEFAULT FALSE,
    minibar  BOOLEAN        DEFAULT FALSE,
    safe     BOOLEAN        DEFAULT FALSE,
    CONSTRAINT Rooms_PK PRIMARY KEY (room_id),
    CONSTRAINT Rooms_FK1 FOREIGN KEY (room_id) REFERENCES Hotels (hotel_id)
);

INSERT INTO Rooms
VALUES (201, 21, 20, 'premium', 85, 4850, TRUE, TRUE, TRUE, TRUE),
       (202, 22, 12, 'premium', 60, 3740, TRUE, TRUE, TRUE, TRUE),
       (203, 23, 8, 'casual', 30, 500, TRUE, TRUE, TRUE, TRUE),
       (204, 24, 10, 'casual', 33, 850, TRUE, TRUE, TRUE, TRUE),
       (205, 25, 5, 'casual', 28, 450, TRUE, TRUE, TRUE, TRUE),
       (206, 26, 13, 'premium', 38, 2950, TRUE, TRUE, TRUE, TRUE),
       (207, 27, 15, 'premium', 85, 4550, TRUE, TRUE, TRUE, TRUE);