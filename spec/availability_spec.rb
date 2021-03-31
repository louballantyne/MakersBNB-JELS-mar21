# frozen_string_literal: true

require 'availability'

describe Availability do
  describe '.all' do
    it 'returns a list of available dates per location' do
      available = Availability.all

      expect(available.first).to be_a Availability
      expect(available.first.dates).to eq '2021-04-03'
    end
  end

  describe '.create' do
    it 'creats a new row on the database and returns it as a Availability object' do
      new_availability = Availability.create(listing_id: '1', dates: '2021-04-03')

      expect(new_availability).to be_a(Availability)
      expect(new_availability.dates).to eq('2021-04-03')
    end
  end
end
