# == Schema Information
#
# Table name: movies
#
#  id              :integer          not null, primary key
#  title           :string(255)
#  image1          :string(255)
#  image2          :string(255)
#  image3          :string(255)
#  story_point     :integer
#  story_comment   :string(255)
#  graphic_point   :integer
#  graphic_comment :string(255)
#  comedy_point    :integer
#  comedy_comment  :string(255)
#  excite_point    :integer
#  excite_comment  :string(255)
#  emotion_point   :integer
#  emotion_comment :string(255)
#  fiction         :boolean
#  category_id     :integer
#  description     :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Movie < ApplicationRecord
  extend OrderAsSpecified
  belongs_to :category
  has_many :movie_likes, dependent: :destroy
    mount_uploader :image1, ImageUploader
    mount_uploader :image2, ImageUploader
    mount_uploader :image3, ImageUploader
  
   validates :title , presence: true
   validates :image1, presence: true
   validates :story_point, presence: true
   validates :story_comment, presence: true
   validates :graphic_point, presence: true
   validates :graphic_comment, presence: true
   validates :comedy_point, presence: true
   validates :comedy_comment, presence: true
   validates :excite_point, presence: true
   validates :excite_comment, presence: true
   validates :emotion_point, presence: true
   validates :emotion_comment, presence: true
   validates :description, presence: true
   validates :category_id, presence: true
  # validates :fiction, presence: true
  
  # def total_score
  #     sum = 0
  #     if params[:evaluation].nil?
  #         sum = story_point + graphic_point + comedy_point +  excite_point + emotion_point
  #     else
  #       params[:evaluation].each do |e|
  #         sum = sum + story_point if params[:evaluation] == "story"
  #       end
  #     end
  # end
  
  # before_create :calc_total
    
  # def calc_total
  #     self.total_point = self.story_point + self.graphic_point + self.comedy_point + self.excite_point + self.emotion_point
  # end
  
  # def total_point
  #   story_point + graphic_point + comedy_point + excite_point + emotion_point
  # end
  # def set_total_point
  #   {:total_point => total_point}
  # end
  
  def self.total_point
    movies = self.group(:id).select('id, title, image1, fiction, SUM(story_point + emotion_point + graphic_point + excite_point + comedy_point) as total').order("total desc", "id desc")
    return movies
  end
  

  # def like_from?(user)
  #   self.movie_likes.exists?(user_id: user.id)
  # end
    
  
end
