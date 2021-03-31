require 'bcrypt'

class User 

  attr_reader :user_id, :username, :email, :password, :name

  def initialize(user_id:, username:, email:, password:, name:)
    @user_id = user_id 
    @username = username 
    @email = email 
    @password = password 
    @name = name 
  end 

  def self.all 
    result = DatabaseConnection.query("SELECT * FROM users")
    result.map do |user|
      User.new(user_id: result[0]['user_id'], username: result[0]['username'],
        email: result[0]['email'], password: result[0]['password'], name: result[0]['name'])
    end 
  end 

  def self.create(username:, email:, password:, name:)
    encrypted_password = BCrypt::Password.create(password)
    result = DatabaseConnection.query("INSERT INTO users(username, email, password, name) 
    VALUES('#{username}', '#{email}', '#{encrypted_password}', '#{name}') RETURNING user_id, username, email, password, name;")
    User.new(user_id: result[0]['user_id'], username: result[0]['username'],
      email: result[0]['email'], password: result[0]['password'], name: result[0]['name'])
  end 

  def self.find(id)
    result = DatabaseConnection.query("SELECT * FROM users WHERE user_id = '#{id}';")
    User.new(user_id: result[0]['user_id'], username: result[0]['username'],
    email: result[0]['email'], password: result[0]['password'], name: result[0]['name'])
  end

  def self.sign_in(username, password)
    result = DatabaseConnection.query("SELECT * FROM users WHERE username = '#{username}';")
    return unless result.any?
    
    User.new(user_id: result[0]['user_id'], username: result[0]['username'],
      email: result[0]['email'], password: result[0]['password'], name: result[0]['name'])
  end
end 