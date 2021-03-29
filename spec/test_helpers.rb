require 'pg'

def reset_table
  connection = PG.connect(dbname: 'makers_bnb_test')
  connection.exec("TRUNCATE TABLE users, listings, availability, comments RESTART IDENTITY;")
  connection.exec("INSERT INTO users(username, email, password, name) 
                  VALUES ('poshhouseperson', 'poshhouseperson@notadomain.com', 'password1', 'Isabel Stephenson');")
  connection.exec("INSERT INTO listings(name, country, city, sleeps, bedrooms, 
                  bathrooms, description, type, user_id) 
                  VALUES ('poshhouse', 'United Kingdom', 'London', '6', '4', '3', 
                  'blah blah posh house blah blaaah', 'small castle', '1')")
end 