require File.join(File.dirname(__FILE__), 'spec_helper')

describe Tweet do
  describe "create" do
    it "should save the tweet with original content" do
      Twitter.should_receive(:current_sentiment).and_return(:positive)
      Tweet.create(original: {name: 'bob'}).should_not be_nil
    end
  end
end