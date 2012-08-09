class TweetsController < ApplicationController

  def refresh
    tweets = Twitter.search("thoughtworks", Tweet.max(:twitter_id))
    tweets[:results].each do |tweet|
      Tweet.create(original: tweet, twitter_id: tweet[:id].to_i)
    end
  end
  
  def charts
    @neutral_count = Tweet.where(:sentiment => "neutral").count
    @positive_count = Tweet.where(:sentiment => "positive").count
    @negative_count = Tweet.where(:sentiment => "negative").count
  end
end