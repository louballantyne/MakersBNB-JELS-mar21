# frozen_string_literal: true

class Message
  attr_reader :message_id, :listing_id, :sender_id, :recipient_id, :message, :timestamp

  def initialize(message_id:, listing_id:, sender_id:, recipient_id:, message:, timestamp:)
    @message_id = message_id
    @listing_id = listing_id
    @sender_id = sender_id
    @recipient_id = recipient_id
    @message = message
    @timestamp = timestamp
  end

  def self.all(id)
    result = DatabaseConnection.query("SELECT * FROM messages WHERE recipient_id = '#{id}';")
    result.map do |message|
      Message.new(message_id: message['message_id'], listing_id: message['listing_id'], 
                  sender_id: message['sender_id'], recipient_id: message['recipient_id'],
                  message: message['message'], timestamp: message['timestamp'])
    end
  end

  def self.create(listing_id:, sender_id:, recipient_id:, message:)
    result = DatabaseConnection.query("INSERT INTO messages(listing_id, sender_id, recipient_id, message)
    VALUES('#{listing_id}', '#{sender_id}', '#{recipient_id}', '#{message}') 
    RETURNING message_id, listing_id, sender_id, recipient_id, message;")
    Message.new(message_id: result[0]['message_id'], listing_id: result[0]['listing_id'], 
                sender_id: result[0]['sender_id'], recipient_id: result[0]['recipient_id'],
                message: result[0]['message'], timestamp: result[0]['timestamp'])
  end
end
