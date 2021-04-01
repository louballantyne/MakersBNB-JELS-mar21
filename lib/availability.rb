# frozen_string_literal: true

class Availability
  attr_reader :id, :listing_id, :dates

  def initialize(id:, listing_id:, dates:)
    @id = id
    @listing_id = listing_id
    @dates = dates
  end

  def self.all
    result = DatabaseConnection.query('SELECT * FROM availability')
    result.map do |dates|
      Availability.new(id: dates['id'], listing_id: dates['listing_id'], dates: dates['dates'])
    end
  end

  def self.create(listing_id:, dates:)
    result = DatabaseConnection.query("INSERT INTO availability (listing_id, dates)
    VALUES('#{listing_id}', '#{dates}') RETURNING id, listing_id, dates;")
    Availability.new(id: result[0]['id'], listing_id: result[0]['listing_id'], 
dates: result[0]['dates'])
  end

end
