class RankingController < ApplicationController
  def top
    @movies = Movie.all
  end
end
