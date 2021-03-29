class Comment 

  attr_reader :comment_id, :listing_id, :user_id, :comment, :timestamp 

  def initialize(comment_id:, listing_id:, user_id:, comment:, timestamp:)
    @comment_id = comment_id
    @listing_id = listing_id
    @user_id = user_id
    @comment = comment 
    @timestamp = timestamp
  end 

  def self.all 
    result = DatabaseConnection.query("SELECT * FROM comments;")
    result.map do |comment|
      Comment.new(comment_id: result[0]['comment_id'], listing_id: result[0]['listing_id'], user_id: result[0]['user_id'],
        comment: result[0]['comment'], timestamp: result[0]['timestamp'])
    end
  end

  def self.create(listing_id:, user_id:, comment:)
    result = DatabaseConnection.query("INSERT INTO comments(listing_id, user_id, comment)
    VALUES('#{listing_id}', '#{user_id}', '#{comment}') RETURNING comment_id, listing_id, user_id, comment;")
    Comment.new(comment_id: result[0]['comment_id'], listing_id: result[0]['listing_id'], user_id: result[0]['user_id'],
      comment: result[0]['comment'], timestamp: result[0]['timestamp'])
  end
end 