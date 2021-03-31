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
    return 1 if username_exist?(username) == true
    return 2 if email_exist?(email) == true

    encrypted_password = BCrypt::Password.create(password)
    result = DatabaseConnection.query("INSERT INTO users (username, email, password, name)
    VALUES('#{username}', '#{email}', '#{encrypted_password}', '#{name}') RETURNING user_id, username, email, password, name;")
    User.new(user_id: result[0]['user_id'], username: result[0]['username'],
      email: result[0]['email'], password: result[0]['password'], name: result[0]['name'])
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
    email: result[0]['email'], password: result[0]['password'], name: result[0]['name'])
  end

  def self.sign_in(username:, password:)
    result = DatabaseConnection.query("SELECT * FROM users WHERE username = '#{username}';")
    # Return code 1 if username doesn't exist
    return 1 unless result.any?
    # Return code 2 if password is incorrect
    return 2 unless BCrypt::Password.new(result[0]['password']) == password

    User.new(user_id: result[0]['user_id'], username: result[0]['username'],
      email: result[0]['email'], password: result[0]['password'], name: result[0]['name'])
  end
end
