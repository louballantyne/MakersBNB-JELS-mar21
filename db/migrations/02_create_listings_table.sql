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
