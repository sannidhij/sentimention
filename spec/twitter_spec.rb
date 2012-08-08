require 'spec_helper'

describe Twitter do
  describe "current_sentiment" do
    it "should return positive when the sentiment polarity is 4" do
      Twitter.current_sentiment("this app is awesome").should == :positive
    end

    it "should return negative when the sentiment polarity is 4" do
      Twitter.current_sentiment("this app is awful").should == :negative
    end

    it "should return neutral when the sentiment polarity is 4" do
      Twitter.current_sentiment("this is a sentence").should == :neutral
    end
  end
end