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

  describe '.find' do 
    it 'finds any available date per listing id' do 
      find = Availability.find(listing_id: '1')

      expect(find.first).to be_a Availability
      expect(find.first.dates).to eq '2021-04-03' 
    end 
  end 
end
