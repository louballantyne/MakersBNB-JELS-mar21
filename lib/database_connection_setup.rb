require './lib/database_connection'

def check_env
  if ENV['RACK_ENV'] = 'test'
    DatabaseConnection.setup(dbname: 'makers_bnb_test')
  else
    DatabaseConnection.setup(dbname: 'makers_bnb')
  end 
end