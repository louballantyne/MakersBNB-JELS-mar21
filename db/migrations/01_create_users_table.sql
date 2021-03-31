CREATE TABLE users (user_id SERIAL PRIMARY KEY, 
                    username VARCHAR(20), 
                    email VARCHAR(50), 
                    password VARCHAR(100), 
                    first_name VARCHAR(30),
                    last_name VARCHAR(30));

CREATE TABLE listings (listing_id SERIAL PRIMARY KEY, 
                        name VARCHAR(30), 
                       country VARCHAR(40), 
                       city VARCHAR(85), 
                       sleeps INTEGER, 
                       bedrooms INTEGER, 
                       bathrooms INTEGER, 
                       description VARCHAR(250), 
                       type VARCHAR(20), 
                       price DECIMAL(5,2),
                       user_id INTEGER, 
                       FOREIGN KEY(user_id) REFERENCES users (user_id) 
                       ON DELETE CASCADE);

CREATE TABLE availability (id SERIAL PRIMARY KEY, 
                           listing_id INTEGER, 
                           dates DATE, 
                           FOREIGN KEY(listing_id) REFERENCES listings (listing_id) 
                           ON DELETE CASCADE);

CREATE TABLE messages (message_id SERIAL PRIMARY KEY, 
                      listing_id INTEGER, 
                       user_id INTEGER,
                       message VARCHAR(250), 
                       timestamp TIMESTAMP, 
                       FOREIGN KEY(listing_id) REFERENCES listings (listing_id)
                       ON DELETE CASCADE, 
                       FOREIGN KEY(user_id) REFERENCES users (user_id) 
                       ON DELETE CASCADE);

CREATE TABLE bookings (booking_id SERIAL PRIMARY KEY,
                        listing_id INTEGER,
                        user_id INTEGER,
                        date_from DATE,
                        date_end DATE,
                        price DECIMAL(5,2),
                        FOREIGN KEY(listing_id) REFERENCES listings (listing_id)
                        ON DELETE CASCADE,
                        FOREIGN KEY(user_id) REFERENCES users (user_id)
                        ON DELETE CASCADE);

CREATE TABLE ratings (rating_id SERIAL PRIMARY KEY,
                      booking_id INTEGER,
                      review VARCHAR(60),
                      FOREIGN KEY(booking_id) REFERENCES bookings (booking_id)
                      ON DELETE CASCADE);
