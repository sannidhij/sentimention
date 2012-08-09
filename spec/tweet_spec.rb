require File.join(File.dirname(__FILE__), 'spec_helper')

describe Tweet do
  describe "create" do
    it "should save the tweet with original content" do
      Tweet.create(original: "foo").should_not be_nil
    end
  end
end