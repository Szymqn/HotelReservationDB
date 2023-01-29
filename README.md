# Hotel Reservation Datebase by Oracle

**Reservations**

The Reservations table holds information about hotel reservations made by guests.

Columns:

    reservation_id: A unique identifier for each reservation
    guest_id: The identifier for the guest who made the reservation
    date_id: The identifier for the dates of the reservation
    room_id: The identifier for the room of the reservation
    device_sys: The device system used to make the reservation
    location: The location of the reservation
    user_name: The username of the guest who made the reservation

**Guests**

The Guests table holds information about guests who have made reservations at hotels.

Columns:

    guest_id: A unique identifier for each guest
    first_name: The first name of the guest
    middle_name: The middle name of the guest
    last_name: The last name of the guest
    email: The email address of the guest

**Dates**

The Dates table holds information about the dates of reservations made by guests.

Columns:

    date_id: A unique identifier for each date
    check_in: The check-in date for the reservation
    checkout: The checkout date for the reservation
    time_zone: The time zone for the reservation

**Hotels**

The Hotels table holds information about hotels.

Columns:

    hotel_id: A unique identifier for each hotel
    hotel_name: The name of the hotel
    owner_id: The identifier for the owner of the hotel
    location_id: The identifier for the location of the hotel
    number_of_stars: The number of stars for the hotel

**Owners**

The Owners table holds information about hotel owners.

Columns:

    owner_id: A unique identifier for each owner
    first_name: The first name of the owner
    middle_name: The middle name of the owner
    last_name: The last name of the owner
    email: The email address of the owner

**Rooms**

The Rooms table holds information about hotel rooms.

Columns:

    room_id: A unique identifier for each room
    hotel_id: The identifier for the hotel where the room is located
    room_number: The room number of the room
    room_type: The type of room
    max_occupancy: The maximum occupancy for the room

**Locations**

The Locations table holds information about the locations of hotels.

Columns:

    location_id: A unique identifier for each location
    city: The city where the hotel is located
    country: The country where the hotel is located

**Countries**

The Countries table holds information about countries.

Columns:

    country_id: A unique identifier for each country
    country_name: The name of the country

**Hotels_Owners**

The Hotels_Owners table holds information about the relationship between hotels and owners.

Columns:

    hotel_id: The identifier for the hotel
    owner_id: The identifier for the owner