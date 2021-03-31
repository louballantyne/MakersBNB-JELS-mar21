require 'pg'
require_relative '../lib/user'

def reset_table
  connection = PG.connect(dbname: 'makers_bnb_test')
  connection.exec("TRUNCATE TABLE users, listings, availability, messages, bookings, ratings RESTART IDENTITY;")
  User.create(username: 'poshhouseperson', email: 'poshhouseperson@notadomain.com', password: 'password1', name: 'Isabel Stephenson')
  connection.exec("INSERT INTO listings(name, country, city, sleeps, bedrooms,
                  bathrooms, description, type, user_id)
                  VALUES ('poshhouse', 'United Kingdom', 'London', '6', '4', '3',
                  'blah blah posh house blah blaaah', 'small castle', '1')")
  connection.exec("INSERT INTO availability (listing_id, dates) VALUES('1','2021-04-03');")
  connection.exec("INSERT INTO messages (listing_id, user_id, message) VALUES ('1', '1', 'What an amazing castle!');")
end
