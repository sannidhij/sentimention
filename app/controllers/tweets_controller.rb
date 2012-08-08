class TweetsController < ApplicationController
  def index
    @tweets = Twitter.search "thoughtworks"
  end
end