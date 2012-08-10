class ChartsController < ApplicationController

  def pie_chart
    neutral_count = Tweet.where(:sentiment => "neutral").count
    positive_count = Tweet.where(:sentiment => "positive").count
    negative_count = Tweet.where(:sentiment => "negative").count
    @pie_chart_data = "[{name: 'Positive', y: #{positive_count}, color: '#228B22'},
                       {name: 'Negative', y: #{negative_count}, color: '#FF3030'},
                       {name: 'Neutral', y: #{neutral_count}, color: '#97FFFF'}]"
  end

  def trend_chart
    @trend = {}
    Tweet.asc(:tweet_date).each do |tweet|
      values = @trend[tweet[:tweet_date].strftime("%m-%d-%Y")] || {positive: 0, negative: 0, neutral: 0}
      values[tweet.sentiment.to_sym] = (values[tweet.sentiment.to_sym] || 0) + 1
      @trend[tweet[:tweet_date].strftime("%m-%d-%Y")] = values
    end
    @dates = @trend.keys
    positive_trend = @trend.map {|_, values| values[:positive]}
    negative_trend = @trend.map {|_, values| values[:negative]}
    neutral_trend = @trend.map {|_, values| values[:neutral]}
    @trend_chart_data = "[{name: 'Positive', data: #{positive_trend}, color: '#228B22'},
                          {name: 'Negative', data: #{negative_trend}, color: '#FF3030'},
                          {name: 'Neutral', data: #{neutral_trend}, color: '#97FFFF'}]"
  end
  
  def top_tweeters_chart
    @top_tweet_user_names = UserAggregates.all.map { |ua| ua['_id']['user_name'] }
    total_trend = UserAggregates.all.map { |ua| ua['value']['total_tweets'] }
    positive_trend = UserAggregates.all.map { |ua| ua['value']['positive_tweets'] }
    negative_trend = UserAggregates.all.map { |ua| ua['value']['negative_tweets'] }
    neutral_trend = UserAggregates.all.map { |ua| ua['value']['neutral_tweets'] }    
    @trend_chart_data = "[{name: 'Negative', data: #{negative_trend}, color: '#FF3030'}, 
                          {name: 'Neutral', data: #{neutral_trend}, color: '#97FFFF'}, 
                          {name: 'Positive', data: #{positive_trend}, color: '#228B22'},
                          {name: 'Total', data: #{total_trend} }]"
  end
  
end