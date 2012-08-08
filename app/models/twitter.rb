require 'net/http'
require 'json'

class Twitter
  def self.search(search_term)
    uri = URI "http://search.twitter.com/search.json?q=#{search_term}"
    response = Net::HTTP.get uri
    HashWithIndifferentAccess.new JSON.parse(response)
  end
  
  def self.current_sentiment(tweet)
    uri = URI "http://www.sentiment140.com/api/classify?text=#{URI.escape(tweet)}"
    response = Net::HTTP.get uri
    json = HashWithIndifferentAccess.new JSON.parse(response)
    case json[:results][:polarity]
    when 4
      :positive
    when 0
      :negative
    else
      :neutral
    end
  end
end