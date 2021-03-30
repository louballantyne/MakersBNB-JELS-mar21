CREATE TABLE comments (comment_id SERIAL PRIMARY KEY, 
                       listing_id INTEGER, 
                       user_id INTEGER, 
                       comment VARCHAR(250), 
                       timestamp TIMESTAMP, 
                       FOREIGN KEY(listing_id) REFERENCES listings (listing_id), 
                       FOREIGN KEY(user_id) REFERENCES users (user_id) 
                       ON DELETE CASCADE);
