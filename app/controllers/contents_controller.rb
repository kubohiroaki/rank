class ContentsController < ApplicationController
  def show
        @movies = Movie.all
  end
end
