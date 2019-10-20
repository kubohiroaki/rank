module MoviesHelper
    
    def image_url(movie)
        if movie.image1.blank?
           "https://dummyimage.com/200x200/000/fff"
        else
            # "/movies/image1/#{movie.id}/#{movie.image1}"
            movie.image1
        end
    end
    
    def image2_url(movie)
        if movie.image2.blank?
           "https://dummyimage.com/200x200/000/fff"
        else
            # "/movies/image1/#{movie.id}/#{movie.image1}"
            movie.image2
        end
    end
    
    def image3_url(movie)
        if movie.image3.blank?
           "https://dummyimage.com/200x200/000/fff"
        else
            # "/movies/image1/#{movie.id}/#{movie.image1}"
            movie.image3
        end
    end
    
    def movie_like_count(movie)
        MovieLike.where(movie_id: movie.id).count
    end
end
