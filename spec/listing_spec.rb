require 'listing'

describe Listing do
  describe '.all' do
    it 'returns an array of all the listings' do
      listings = Listing.all

      expect(listings.first).to be_a(Listing)
      expect(listings.first.name).to eq('poshhouse')
    end
  end

  describe '.create' do
    it 'can create a new listing' do
      new_listing = Listing.create(name: 'shitty appartment', country: 'United Kingdom', city: 'London', sleeps: '3',
                                   bedrooms: '1', bathrooms: '1',
                                   description: 'At least it is cheap', type: 'appartment', price: '50', user_id: '1')

      expect(new_listing).to be_a Listing
      expect(new_listing.name).to eq 'shitty appartment'
    end
  end

  describe '.find' do
    it 'can find the right listing per given id' do
      find_listing = Listing.find('1')

      expect(find_listing).to be_a Listing
      expect(find_listing.name).to eq('poshhouse')
    end
  end

  describe '.edit' do
    it 'can edit a listing' do
      edited = Listing.edit(listing_id: '1', name: 'poshhouse', country: 'United Kingdom', city: 'London',
                            sleeps: '6', bedrooms: '4', bathrooms: '3',
                            description: 'something more sensible', type: 'house', price: '50')

      expect(edited.description).to eq 'something more sensible'
    end
  end

  describe '.delete' do
    it 'deletes a listing' do
      Listing.delete('1')
      listings = Listing.all

      expect(listings.first.name).not_to eq 'poshhouse'
    end
  end
end
