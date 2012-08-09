require File.join(File.dirname(__FILE__), 'spec_helper')

describe Twitter do
  describe "current_sentiment" do
    it "should get the sentiment from the sentiment140 API" do
      uri = URI "http://www.sentiment140.com/api/classify?text=awesome"
      Net::HTTP.should_receive(:get).with(uri).and_return("{\"results\":{\"polarity\":4}}" )
      Twitter.current_sentiment("awesome")
    end

    it "should return positive when the sentiment polarity is 4" do
      uri = URI "http://www.sentiment140.com/api/classify?text=this%20app%20is%20awesome"
      Net::HTTP.should_receive(:get).with(uri).and_return("{\"results\":{\"polarity\":4}}" )
      Twitter.current_sentiment("this app is awesome").should == :positive
    end

    it "should return negative when the sentiment polarity is 4" do
      uri = URI "http://www.sentiment140.com/api/classify?text=this%20app%20is%20awful"
      Net::HTTP.should_receive(:get).with(uri).and_return("{\"results\":{\"polarity\":0}}" )
      Twitter.current_sentiment("this app is awful").should == :negative
    end

    it "should return neutral when the sentiment polarity is 4" do
      uri = URI "http://www.sentiment140.com/api/classify?text=this%20is%20a%20sentence"
      Net::HTTP.should_receive(:get).with(uri).and_return("{\"results\":{\"polarity\":2}}" )
      Twitter.current_sentiment("this is a sentence").should == :neutral
    end
  end
end