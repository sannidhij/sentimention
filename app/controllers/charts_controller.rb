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
    
  end
end