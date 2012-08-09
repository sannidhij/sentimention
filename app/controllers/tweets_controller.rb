class TweetsController < ApplicationController
  def index
    @tweets = Twitter.search "thoughtworks"
  end
  
  def refresh
    tweets = Twitter.search("thoughtworks")
    tweets[:results].each do |tweet|
      Tweet.create(original: tweet, twitter_id: tweet[:id].to_i)
    end
  end
end