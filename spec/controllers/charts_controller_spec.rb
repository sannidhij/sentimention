require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe ChartsController do
  describe "#trend_chart" do
    it "should return list of dates with tweets" do
      Tweet.delete_all
      Twitter.stub(:current_sentiment).and_return(:positive)
      Tweet.create(original: {name: 'bob #{i}' }, tweet_date: Date.parse("2012-08-09"))
      get :trend_chart
      assigns[:dates].should == ['08-09-2012']
      assigns[:trend].should == {'08-09-2012' => {"positive" => 1, "negative" => 0, "neutral" => 0}}
    end
  end
end