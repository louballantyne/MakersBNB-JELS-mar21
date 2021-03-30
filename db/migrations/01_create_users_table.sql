CREATE TABLE users (user_id SERIAL PRIMARY KEY, 
                    username VARCHAR(20), 
                    email VARCHAR(50), 
                    password VARCHAR(100), 
                    name VARCHAR(30));

CREATE TABLE listings (listing_id SERIAL PRIMARY KEY, 
                        name VARCHAR(30), 
                       country VARCHAR(40), 
                       city VARCHAR(85), 
                       sleeps INTEGER, 
                       bedrooms INTEGER, 
                       bathrooms INTEGER, 
                       description VARCHAR(250), 
                       type VARCHAR(20), 
                       user_id INTEGER, 
                       FOREIGN KEY(user_id) REFERENCES users (user_id) 
                       ON DELETE CASCADE);

CREATE TABLE availability (id SERIAL PRIMARY KEY, 
                           listing_id INTEGER, 
                           dates DATE, 
                           FOREIGN KEY(listing_id) REFERENCES listings (listing_id) 
                           ON DELETE CASCADE);

CREATE TABLE comments (comment_id SERIAL PRIMARY KEY, 
                      listing_id INTEGER, 
                       user_id INTEGER, 
                       comment VARCHAR(250), 
                       timestamp TIMESTAMP, 
                       FOREIGN KEY(listing_id) REFERENCES listings (listing_id), 
                       FOREIGN KEY(user_id) REFERENCES users (user_id) 
                       ON DELETE CASCADE);
