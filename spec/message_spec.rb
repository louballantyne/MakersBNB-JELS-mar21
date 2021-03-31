require 'message' 

describe Message do 
  describe '.all' do 
    it 'returns a list of all messages' do
      message = Message.all 
      
      expect(message.first).to be_a Message 
      expect(message.first.message).to eq 'What an amazing castle!'
    end
  end

  describe '.create' do
    it 'creates a new row in the database and returns it as a message object' do
      new_message = Message.create(listing_id: '1', user_id: '1', message: 'This looks lovely')

      expect(new_message).to be_a Message
      expect(new_message.message).to eq('This looks lovely')
    end
  end
end