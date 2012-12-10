class SearchTermsController < ApplicationController

  def create
    term = SearchTerm.new params[:search_term]
    term.save!
    redirect_to tweets_path
  end

end
