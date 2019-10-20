class AddTotalPointToMovies < ActiveRecord::Migration[5.1]
  def change
    add_column :movies, :total_point, :integer
  end
end
