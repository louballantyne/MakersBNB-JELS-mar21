require './lib/database_connection'

if ENV['RACK_ENV'] = 'test'
  DatabaseConnection.setup(dbname: 'makers_bnb_test')
else
  DatabaseConnection.setup(dbname: 'makers_bnb')
end 