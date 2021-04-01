# frozen_string_literal: true

require 'pg'
require_relative '../lib/user'
require_relative '../lib/listing'

def reset_table
  connection = PG.connect(dbname: 'makers_bnb_test')
  connection.exec('TRUNCATE TABLE users, listings, availability, messages, bookings, ratings RESTART IDENTITY;')
  User.create(username: 'poshhouseperson', email: 'poshhouseperson@notadomain.com',
              password: 'password1', confirm: 'password1',
              first_name: 'Isabel', last_name: 'Stephenson')
  User.create(username: 'cheaphouseperson', email: 'cheaphouseperson@notadomain.com',
              password: 'password1', confirm: 'password1',
              first_name: 'Frankfurter', last_name: 'Sausage')

  Listing.create(name: 'poshhouse', country: 'United Kingdom', city: 'London', sleeps: '6', bedrooms: '4',
                 bathrooms: '3', description: 'blah blah posh house blah blaaah', type: 'small castle', price: '50', user_id: '1')
  Listing.create(name: 'The bath house', country: 'United Kingdom', price: '50', city: 'London', sleeps: '5',
                 bedrooms: '3', bathrooms: '2', description: 'has a swimmingpool', type: 'large house',
                 user_id: '1')
  Listing.create(name: 'cheaphouse', country: 'United Kingdom', city: 'London', sleeps: '2', bedrooms: '1',
                bathrooms: '1', description: 'blah blah a dive', type: 'small dive', price: '10', user_id: '2')
  Message.create(listing_id: '1', user_id: '2', message: 'Your house is a lot nicer than mine')
  Availability.create(listing_id: '2', dates: '2021-04-03')
  Availability.create(listing_id: '2', dates: '2021-04-04')

  connection.exec("INSERT INTO availability (listing_id, dates) VALUES('1','2021-04-03');")

  connection.exec("INSERT INTO messages (listing_id, user_id, message) VALUES ('1', '1', 'What an amazing castle!');")
end
