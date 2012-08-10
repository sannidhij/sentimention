class TweetsController < ApplicationController

  def create
    tweet = Tweet.find(params[:id])
    tweet.update_attribute :sentiment, params[:sentiment]
    render :nothing => true
  end
  
  def refresh
    tweets = Twitter.search("thoughtworks", Tweet.max(:twitter_id))
    tweets[:results].each do |tweet|
      Tweet.create(original: tweet, twitter_id: tweet[:id].to_i, tweet_date: Date.parse(tweet[:created_at]))
    end
  end
  
  def charts
    neutral_count = Tweet.where(:sentiment => "neutral").count
    positive_count = Tweet.where(:sentiment => "positive").count
    negative_count = Tweet.where(:sentiment => "negative").count
    @pie_chart_data = "[{name: 'Positive', y: #{positive_count}, color: '#228B22'},
                       {name: 'Negative', y: #{negative_count}, color: '#FF3030'},
                       {name: 'Neutral', y: #{neutral_count}, color: '#97FFFF'}]"
  end
end