class TweetsController < ApplicationController
  def index
    @tweets = Twitter.search "thoughtworks"
  end
  
  def refresh
    tweets = Twitter.search("thoughtworks")
    tweets.each do |tweet|
      Tweet.create(original: tweet)
    end
  end
end