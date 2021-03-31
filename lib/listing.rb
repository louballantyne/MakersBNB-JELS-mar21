# frozen_string_literal: true

require_relative 'database_connection'

class Listing
  attr_reader :listing_id, :name, :country, :city, :sleeps, :bedrooms, :bathrooms, :description, 
              :type, :user_id

  def initialize(listing_id:, name:, country:, city:, sleeps:, bedrooms:, bathrooms:, description:, type:, user_id:)
    @listing_id = listing_id
    @name = name
    @country = country
    @city = city
    @sleeps = sleeps
    @bedrooms = bedrooms
    @bathrooms = bathrooms
    @description = description
    @type = type
    @user_id = user_id
  end

  def self.all
    result = DatabaseConnection.query('SELECT * FROM listings;')
    result.map do |listing|
      Listing.new(listing_id: listing['listing_id'], name: listing['name'], country: listing['country'], city: listing['city'],
                  sleeps: listing['sleeps'], bedrooms: listing['bedrooms'], bathrooms: listing['bathrooms'],
                  description: listing['description'], type: listing['type'], user_id: listing['user_id'])
    end
  end

  def self.create(name:, country:, city:, sleeps:, bedrooms:, bathrooms:, description:, type:, user_id:)
    result = DatabaseConnection.query("INSERT INTO listings (name, country, city, sleeps, bedrooms, bathrooms, description, type, user_id)
      VALUES('#{name}', '#{country}', '#{city}', '#{sleeps}', '#{bedrooms}', '#{bathrooms}', '#{description}', '#{type}', '#{user_id}')
      RETURNING listing_id, name, country, city, sleeps, bedrooms, bathrooms, description, type, user_id;")
    Listing.new(listing_id: result[0]['listing_id'], name: result[0]['name'], country: result[0]['country'], city: result[0]['city'],
                sleeps: result[0]['sleeps'], bedrooms: result[0]['bedrooms'], bathrooms: result[0]['bathrooms'],
                description: result[0]['description'], type: result[0]['type'], user_id: result[0]['user_id'])
  end

  def self.find(id)
    result = DatabaseConnection.query("SELECT * FROM listings WHERE listing_id = '#{id}'")
    Listing.new(listing_id: result[0]['listing_id'], name: result[0]['name'], country: result[0]['country'], city: result[0]['city'],
                sleeps: result[0]['sleeps'], bedrooms: result[0]['bedrooms'], bathrooms: result[0]['bathrooms'],
                description: result[0]['description'], type: result[0]['type'], user_id: result[0]['user_id'])
  end

  def self.edit(listing_id:, name:, country:, city:, sleeps:, bedrooms:, bathrooms:, description:, type:)
    result = DatabaseConnection.query("UPDATE listings SET name = '#{name}', country = '#{country}', city = '#{city}', sleeps = '#{sleeps}',
    bedrooms = '#{bedrooms}', bathrooms = '#{bathrooms}', description = '#{description}', type = '#{type}' WHERE listing_id = '#{listing_id}'
    RETURNING listing_id, name, country, city, sleeps, bedrooms, bathrooms, description, type, user_id;")

    Listing.new(listing_id: result[0]['listing_id'], name: result[0]['name'], country: result[0]['country'], city: result[0]['city'],
                sleeps: result[0]['sleeps'], bedrooms: result[0]['bedrooms'], bathrooms: result[0]['bathrooms'],
                description: result[0]['description'], type: result[0]['type'], user_id: result[0]['user_id'])
  end

  def self.delete(listing_id)
    DatabaseConnection.query("DELETE FROM listings WHERE listing_id = '#{listing_id}';")
  end
end
