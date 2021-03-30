require 'user'

describe User do 
  describe '.all' do 
    it 'returns an array of all users' do
      user = User.all

      expect(user.last).to be_a User
      expect(user.last.name).to eq 'Isabel Stephenson'
    end 
  end 

  describe '.create' do
    it 'creates a new user on the database and returns it as User object' do
      new_user = User.create(username: 'poshhouseperson', email: 'poshhouseperson@notadomain.com', password: 'password1', name: 'Isabel Stephenson')

      expect(new_user).to be_a(User)
      expect(new_user.name).to eq('Isabel Stephenson')
    end

    it 'hashes the password using BCrypt' do
      expect(BCrypt::Password).to receive(:create).with('password1')
      
      User.create(username: 'poshhouseperson', email: 'poshhouseperson@notadomain.com', password: 'password1', name: 'Isabel Stephenson')
    end
  end

  describe '.find' do 
    it 'can find a user per id' do 
      find_user = User.find('1')

      expect(find_user).to be_a User
      expect(find_user.name).to eq 'Isabel Stephenson'
    end 
  end 
end