class Tweet
  include Mongoid::Document
  field :original, type: Hash
  field :sentiment, type: String
  
  before_create :fetch_sentiment

  def fetch_sentiment
    # p original['text'], Twitter.current_sentiment(original['text'])
  end
end