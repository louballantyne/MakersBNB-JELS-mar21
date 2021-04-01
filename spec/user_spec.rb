# frozen_string_literal: true

require 'user'

describe User do
  describe '.all' do
    it 'returns an array of all users' do
      user = User.all

      expect(user.first).to be_a User
      expect(user.first.first_name).to eq 'Isabel'
    end
  end

  describe '.create' do
    it 'creates a new user on the database and returns it as User object' do
      new_user = User.create(username: 'blahblah', email: 'blahblah@notadomain.com',
                             password: 'password1', confirm: 'password1',
                             first_name: 'Isabel', last_name: 'Stephenson')

      expect(new_user).to be_a(User)
      expect(new_user.last_name).to eq('Stephenson')
    end

    it 'hashes the password using BCrypt' do
      expect(BCrypt::Password).to receive(:create).with('password1')

      User.create(username: 'cheaperhouseperson', email: 'cheaperhouseperson@notadomain.com',
                  password: 'password1', confirm: 'password1',
                  first_name: 'Isabel', last_name: 'Stephenson')
    end

    it 'when the two passwords that the user has entered are the same a user is created' do
      new_user = User.create(username: 'blahblah', email: 'blahblah@notadomain.com',
                             password: 'password1', confirm: 'password1',
                             first_name: 'Isabel', last_name: 'Stephenson')

      expect(new_user).to be_a(User)
    end

    it 'when the two passwords that the user enters are different it returns a 3' do
      new_user = User.create(username: 'blahblah', email: 'blahblah@notadomain.com',
                             password: 'password1', confirm: 'password2',
                             first_name: 'Isabel', last_name: 'Stephenson')

      expect(new_user).to eq(3)
    end
  end

  describe '.find' do
    it 'can find a user per id' do
      find_user = User.find('1')

      expect(find_user).to be_a User
      expect(find_user.first_name).to eq 'Isabel'
    end
  end

  describe '.sign_in' do
    it 'allows existing user to sign in' do
      new_user = User.create(username: 'poorerhouseperson', email: 'poorerhouseperson@notadomain.com',
                             password: 'password2', confirm: 'password2',
                             first_name: 'Izzy', last_name: 'Stevenson')
      signed_in_user = User.sign_in(username: 'poorerhouseperson', password: 'password2')

      expect(signed_in_user.user_id).to eq new_user.user_id
    end
  end
end
