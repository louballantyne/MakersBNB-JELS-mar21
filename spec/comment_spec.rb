require 'comment' 

describe Comment do 
  describe '.all' do 
    it 'returns a list of all comments' do
      comment = Comment.all 
      
      expect(comment.first).to be_a Comment 
      expect(comment.first.comment).to eq 'What an amazing castle!'
    end
  end

  describe '.create' do
    it 'creates a new row in the database and returns it as a Comment object' do
      new_comment = Comment.create(listing_id: '1', user_id: '1', comment: 'This looks lovely')

      expect(new_comment).to be_a(Comment)
      expect(new_comment.comment).to eq('This looks lovely')
    end
  end
end