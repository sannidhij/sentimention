class Tweet
  include Mongoid::Document
  field :original, type: Hash
  field :sentiment, type: String
  
  after_create :fetch_sentiment

  def fetch_sentiment
    update_attribute :sentiment, Twitter.current_sentiment(original['text'])
  end
end