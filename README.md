# Hotel Reservation Datebase by Oracle

**Reservations**

The Reservations table holds information about hotel reservations made by guests.

Columns:

    reservation_id (number): A unique identifier for each reservation
    guest_id (number): The identifier for the guest who made the reservation
    room_id (number): The identifier for the room of the reservation
    device_sys (varchar2(30)): The device system used to make the reservation
    country_name (varchar2(30)): The country name of the guest who made the reservation
    country_s_name (varchar2(3)): The country short name of the guest who made the reservation
    user_name (varchar2(30)): The username of the guest who made the reservation
    check_in (date): The check-in date of the reservation
    check_out (date): The check-out date of the reservation
    time_zone (varchar2(30)): The time zone of the reservation

**Guests**

The Guests table holds information about guests who have made reservations at hotels.

Columns:

    guest_id (number): A unique identifier for each guest
    first_name (varchar2(30)): The first name of the guest
    middle_name (varchar2(30)): The middle name of the guest
    last_name (varchar2(30)): The last name of the guest
    email (varchar2(30)): The email address of the guest
    phone_code (varchar2(5)): The phone code of the guest
    phone_number (number): The phone number of the guest
    age (number): The age of the guest
    sex (varchar2(1)): The sex of the guest
    nationality (varchar2(30)): The nationality of the guest

**Hotels**

The Hotels table holds information about hotels.

Columns:

    hotel_id (number): A unique identifier for each hotel
    hotel_name (varchar2(30)): The name of the hotel
    owner_id (number): The identifier for the owner of the hotel
    location_id (number): The identifier for the location of the hotel
    number_of_stars (number): The number of stars for the hotel
    rating (number): The rating of the hotel
    parking (boolean): The parking availability of the hotel
    restaurant (boolean): The restaurant availability of the hotel
    bar (boolean): The bar availability of the hotel
    wifi (boolean): The wifi availability of the hotel

**Owners**

The Owners table holds information about hotel owners.

Columns:

    owner_id (number): A unique identifier for each owner
    first_name (varchar2(30)): The first name of the owner
    last_name (varchar2(30)): The last name of the owner
    phone_num (number): The phone number of the owner
    date_of_birth (date): The date of birth of the owner
    account_num (number): The account number of the owner
    currency (varchar2(30)): The currency of the owner
    bank_name (varchar2(30)): The bank name of the owner
    nationality (varchar2(30)): The nationality of the owner
    nip (number): The nip of the owner's company

**Rooms**

The Rooms table holds information about hotel rooms.

Columns:

    room_id (number): A unique identifier for each room
    hotel_id (number): The identifier for the hotel where the room is located
    floor (number): The floor where the room is located
    standard (varchar2(30)): The standard of the room
    size (number): The size of the room
    price (number): The price of the room
    spa (boolean): The spa availability of the room
    tv (boolean): The TV availability of the room
    minibar (boolean): The minibar availability of the room
    safe (boolean): The safe availability of the room

**Locations**

The Locations table holds information about the locations of hotels.

Columns:

    location_id (number): A unique identifier for each location
    address (varchar2(30)): The address line of the location
    city (varchar2(30)): The city of the location
    zip_code (varchar2(15)): The zip code of the location
    country_id (number): The identifier for the country of the location
    country_name (varchar2(30)): The country name of the location
    country_s_name (varchar2(3)): The country short name of the location
    language (varchar2(30)): The language of the location
    continent (varchar2(30)): The continent of the location
    dial_code (varchar2(5)): The dial code of the location

**Hotels_Owners**

The Hotels_Owners table holds information about the relationship between hotels and owners.

Columns:

    hotel_id: The identifier for the hotel
    owner_id: The identifier for the owner