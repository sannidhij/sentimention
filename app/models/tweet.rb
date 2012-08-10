class Tweet
  include Mongoid::Document
  field :original, type: Hash
  field :twitter_id, type: Integer
  field :sentiment, type: String
  field :tweet_date, type: Date
  
  after_create :fetch_sentiment

  def fetch_sentiment
    update_attribute :sentiment, Twitter.current_sentiment(original['text'])
  end
end