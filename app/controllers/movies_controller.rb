class MoviesController < ApplicationController
    before_action :require_login, only: [:new, :create, :edit, :update, :destroy]

    def like
      @movie = Movie.find(params[:id])
      MovieLike.create(movie_id: @movie.id)
      redirect_to movies_path and return
    end
    
    def love
      @movielike_ids = MovieLike.group(:movie_id).order("COUNT(movie_id) desc").pluck(:movie_id)
      @movies = Movie.where(id: @movielike_ids).order_as_specified(id: @movielike_ids)
    end
    
    def maxim
      @movies = Movie.where.not(maxim: nil)
    end

    def se
      if params[:word].present?
        @movies = Movie.where("title like ?", "%#{params[:word]}%").order("id desc")
      else
        flash.now[:danger] = "映画は見つかりませんでした"
        render "se"
      end
    end


    def index
        @page = 0
        @page_story = 0
        @page_comedy = 0
        @page_emotion = 0
        @page_fiction = 0
        @movies = Movie.total_point.limit(5)
        @movies_story = Movie.limit(5).order('story_point desc')
        @movies_comedy = Movie.limit(5).order('comedy_point desc')
        @movies_emotion = Movie.limit(5).order('emotion_point desc')
        @movies_fiction = Movie.total_point.where(fiction: false).limit(5)
        @movie_count = Movie.all.count/5
    end
    
    def next
        set_pege_param
        @page = params[:page].to_i + 1
        # @page_story = params[:page_story].to_i
        # @page_comedy = params[:page_comedy].to_i
        # @page_emotion = params[:page_emotion].to_i
        # @page_fiction = params[:page_fiction].to_i
        search_movie
        render "index"
    end
    
    def prev
        set_pege_param
        @page = params[:page].to_i - 1
        search_movie
        render "index"
    end
    
    def next_story
        set_pege_param
        @page_story = params[:page_story].to_i + 1
        search_movie
        render "index"
    end
    def prev_story
        set_pege_param
        @page_story = params[:page_story].to_i - 1
        search_movie
        render "index"
    end
    
    def next_comedy
        set_pege_param
        @page_comedy = params[:page_comedy].to_i + 1
        search_movie
        render "index"
    end
    def prev_comedy
        set_pege_param
        @page_comedy = params[:page_comedy].to_i - 1
        search_movie
        render "index"
    end
    
    def next_emotion
        set_pege_param
        @page_emotion = params[:page_emotion].to_i + 1
        search_movie
        render "index"
    end
    def prev_emotion
        set_pege_param
        @page_emotion = params[:page_emotion].to_i - 1
        search_movie
        render "index"
    end   
    
    def next_fiction
        set_pege_param
        @page_fiction = params[:page_fiction].to_i + 1
        search_movie
        render "index"
    end
    def prev_fiction
        set_pege_param
        @page_fiction = params[:page_fiction].to_i - 1
        search_movie
        render "index"
    end
    
    def search_result
        count = 0
        text = "*,"
        params[:evaluation].each do |e|
          if params[:evaluation][eval(':' + e)]!= '0'
            text += e + "_point+"
            count += 1
          end
        end
        text.chop!
        text += " as point"
        if count == 0
          text = "*,"
          params[:evaluation].each do |e|
              text += e + "_point+"
          end
          text.chop!
          text += " as point"
        end
      @movies = Movie.select(text)
      @movies = @movies.where(category_id:  params[:category_id]) if params[:category_id].present?
       
      if params[:fiction].present?
        if params[:fiction] == 'true'
          @movies = @movies.where(fiction: true)
        else
          @movies = @movies.where(fiction: false)
        end
      end
      if params[:align] =='asc'
        @movies = @movies.order('point asc')          
      elsif params[:align] =='desc'
        @movies = @movies.order('point desc')
      end

    end
    
    
    def show
      input = params[:id]
      unless (/^[+-]?[0-9]+$/ =~ input)
        redirect_to movies_path and return
      end
      @movie = Movie.find(params[:id])
    end
     
    
    
    def new
      @movie = Movie.new
    end

    def create
      attr = movie_params
      # attr[:total_point] = attr[:story_point] + attr[:graphic_point] + attr[:comedy_point] + attr[:excite_point] + attr[:emotion_point]
      @movie = Movie.new(attr)
      # @movie = Movie.new(movie_params)
      if @movie.save
        flash[:success] = "映画を投稿しました"
        redirect_to movies_path and return 
      else
        # binding.pry
        # flash[:danger] = "映画を投稿できませんでした"
        flash[:danger] = ""
        @movie.errors.full_messages.each do |m|
        flash[:danger] += m
        end
        render "new" and return
      end
    end

    def edit
      @movie = Movie.find(params[:id])
    end
    
    def update
      @movie = Movie.find(params[:id])
      if @movie = Movie.update(movie_params)
        flash[:success] = "映画情報を更新しました"
        redirect_to movie_path and return 
      else
        # binding.pry
        flash[:danger] = "映画情報を更新できませんでした"
        render "edit" and return

      end
    end

    def destroy
      @movie = Movie.find(params[:id])
      if @movie.destroy
        flash[:success] = "映画情報を削除しました"
        redirect_to movies_path and return 
      else
        # binding.pry
        flash[:danger] = "映画情報を削除できませんでした"
        redirect_to movie_path and return 
      end
    end
    
    private
  
    def require_login
      unless user_signed_in?
        flash[:danger] = "管理者専用ページとなります"
        redirect_to sign_in_path and return # halts request cycle
      end
    end
    
    def search_movie
      @movies = Movie.total_point.limit(5).offset(5 * @page)
      @movies_story = Movie.limit(5).offset(5 * @page_story).order('story_point desc')
      @movies_comedy = Movie.limit(5).offset(5 * @page_comedy).order('comedy_point desc')
      @movies_emotion = Movie.limit(5).offset(5 * @page_emotion).order('emotion_point desc')
      @movies_fiction = Movie.total_point.where(fiction: false).limit(5).offset(5 * @page_fiction)
    end
    
    def set_pege_param
      @page = params[:page].to_i 
      @page_story = params[:page_story].to_i
      @page_comedy = params[:page_comedy].to_i
      @page_emotion = params[:page_emotion].to_i
      @page_fiction = params[:page_fiction].to_i
    end
    
    def movie_params
      params.require(:movie).permit(:maxim, :title, :story_point, :story_comment, :graphic_point, :graphic_comment, :comedy_point, :comedy_comment, :excite_point, :excite_comment, :emotion_point, :emotion_comment, :fiction, :description, :category_id, :image1, :image2, :image3)
    end
  
end
