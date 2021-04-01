# frozen_string_literal: true

require 'bcrypt'

class User
  attr_reader :user_id, :username, :email, :password, :first_name, :last_name

  def initialize(user_id:, username:, email:, password:, first_name:, last_name:)
    @user_id = user_id
    @username = username
    @email = email
    @password = password
    @first_name = first_name
    @last_name = last_name
  end

  def self.all
    result = DatabaseConnection.query('SELECT * FROM users')
    result.map do |user|
      User.new(user_id: user['user_id'], username: user['username'],
               email: user['email'], password: user['password'], first_name: user['first_name'], last_name: user['last_name'])
    end
  end

  def self.create(username:, email:, password:, confirm:, first_name:, last_name:)
    return 1 if username_exist?(username) == true
    return 2 if email_exist?(email) == true
    return 3 if password != confirm

    encrypted_password = BCrypt::Password.create(password)
    result = DatabaseConnection.query("INSERT INTO users (username, email, password, first_name, last_name)
    VALUES('#{username}', '#{email}', '#{encrypted_password}', '#{first_name}', '#{last_name}')
    RETURNING user_id, username, email, password, first_name, last_name;")
    User.new(user_id: result[0]['user_id'], username: result[0]['username'],
             email: result[0]['email'], password: result[0]['password'], first_name: result[0]['first_name'],
             last_name: result[0]['last_name'])
  end

  def self.username_exist?(username)
    db_search = DatabaseConnection.query("SELECT * FROM users WHERE username = '#{username}';")
    db_search.any?
  end

  def self.email_exist?(email)
    db_search = DatabaseConnection.query("SELECT * FROM users WHERE email = '#{email}';")
    db_search.any?
  end

  def self.find(id)
    return unless id

    result = DatabaseConnection.query("SELECT * FROM users WHERE user_id = '#{id}';")
    User.new(user_id: result[0]['user_id'], username: result[0]['username'],
             email: result[0]['email'], password: result[0]['password'],
             first_name: result[0]['first_name'], last_name: result[0]['last_name'])
  end

  def self.sign_in(username:, password:)
    result = DatabaseConnection.query("SELECT * FROM users WHERE username = '#{username}';")
    # Return code 1 if username doesn't exist
    return 1 unless result.any?
    # Return code 2 if password is incorrect
    return 2 unless BCrypt::Password.new(result[0]['password']) == password

    User.new(user_id: result[0]['user_id'], username: result[0]['username'],
             email: result[0]['email'], password: result[0]['password'],
             first_name: result[0]['first_name'], last_name: result[0]['last_name'])
  end
end
