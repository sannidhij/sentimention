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
    generate_user_aggregates
    user_criteria = UserAggregates.desc('value.total_tweets').limit(10)
    @top_tweet_user_names = user_criteria.map { |ua| ua['_id']['user_name'] }
    total_trend = user_criteria.map { |ua| ua['value']['total_tweets'] }
    positive_trend = user_criteria.map { |ua| ua['value']['positive_tweets'] }
    negative_trend = user_criteria.map { |ua| ua['value']['negative_tweets'] }
    neutral_trend = user_criteria.map { |ua| ua['value']['neutral_tweets'] }    
    @trend_chart_data = "[{name: 'Negative', data: #{negative_trend}, color: '#FF3030'}, 
                          {name: 'Neutral', data: #{neutral_trend}, color: '#97FFFF'}, 
                          {name: 'Positive', data: #{positive_trend}, color: '#228B22'},
                          {name: 'Total', data: #{total_trend} }]"
  end

  private
  def generate_user_aggregates
    map = %Q{
      function () {
      	var positive_tweets = 0, negative_tweets = 0, neutral_tweets = 0;
      	switch (this.sentiment) { 
      		case 'positive':
      			positive_tweets = 1;
      			break;
      		case 'negative':
      			negative_tweets = 1;
      			break;
      		case 'neutral':
      			neutral_tweets = 1;
      			break;
      	} 

      	emit({user_name:this.original.from_user_name }, { total_tweets:1, positive_tweets:positive_tweets, negative_tweets:negative_tweets, neutral_tweets:neutral_tweets, sentiment:this.sentiment });
      }
    }
    
    reduce = %Q{
      function(key, values) {
      		 var total_tweets = 0, negative_tweets = 0, neutral_tweets = 0;
      		 var positive_tweets = 0; 
      		 values.forEach(function(v) {
      		 									total_tweets += v['total_tweets'];
      		 									if (v['sentiment'] === 'positive') { positive_tweets += v['positive_tweets']; };
      											if (v['sentiment'] === 'negative') { negative_tweets += v['negative_tweets']; };
      											if (v['sentiment'] === 'neutral') { neutral_tweets += v['neutral_tweets']; };
      											sentiment = v['sentiment'];
      											});
      		return {total_tweets: total_tweets, positive_tweets: positive_tweets, negative_tweets: negative_tweets, neutral_tweets: neutral_tweets};
      }
    }
    
    Tweet.map_reduce(map, reduce).out(merge: "user_aggregates").each do |document|
      p document
    end
  end
  
end