require 'net/http'
require 'json'

class Twitter
  def self.search(search_term, last_known_id=nil)
    search_url = "http://search.twitter.com/search.json?q=#{search_term}&rpp=100&result_type=recent"
    search_url << "&since_id=#{last_known_id}" if last_known_id
    uri = URI search_url
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