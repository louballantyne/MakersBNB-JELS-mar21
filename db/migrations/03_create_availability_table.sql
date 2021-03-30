CREATE TABLE availability (id SERIAL PRIMARY KEY, 
                           listing_id INTEGER, 
                           dates DATE, 
                           FOREIGN KEY(listing_id) REFERENCES listings (listing_id) 
                           ON DELETE CASCADE);
