class Message 

  attr_reader :message_id, :listing_id, :user_id, :message, :timestamp 

  def initialize(message_id:, listing_id:, user_id:, message:, timestamp:)
    @message_id = message_id
    @listing_id = listing_id
    @user_id = user_id
    @message = message 
    @timestamp = timestamp
  end 

  def self.all 
    result = DatabaseConnection.query("SELECT * FROM messages;")
    result.map do |message|
      Message.new(message_id: result[0]['message_id'], listing_id: result[0]['listing_id'], user_id: result[0]['user_id'],
        message: result[0]['message'], timestamp: result[0]['timestamp'])
    end
  end

  def self.create(listing_id:, user_id:, message:)
    result = DatabaseConnection.query("INSERT INTO messages(listing_id, user_id, message)
    VALUES('#{listing_id}', '#{user_id}', '#{message}') RETURNING message_id, listing_id, user_id, message;")
    Message.new(message_id: result[0]['message_id'], listing_id: result[0]['listing_id'], user_id: result[0]['user_id'],
      message: result[0]['message'], timestamp: result[0]['timestamp'])
  end
end 