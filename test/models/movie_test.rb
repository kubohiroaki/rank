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

require 'test_helper'

class MovieTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
