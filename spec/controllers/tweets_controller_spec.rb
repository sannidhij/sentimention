require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe TweetsController do
  describe "GET tweets" do
    it "displays the list of tweets stored" do 
      Tweet.delete_all
      Twitter.stub(:current_sentiment).exactly(5).times.and_return(:positive)
      5.times do |i|
        Tweet.create(original: {name: 'bob #{i}'})
      end
      
      get :index
    end
  end
end