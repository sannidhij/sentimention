require 'net/http'
require 'json'

class Twitter
  def self.search(search_term)
    uri = URI "http://search.twitter.com/search.json?q=#{search_term}"
    response = Net::HTTP.get uri
    HashWithIndifferentAccess.new JSON.parse(response)
  end
end