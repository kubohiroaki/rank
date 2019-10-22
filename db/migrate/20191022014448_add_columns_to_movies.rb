class AddColumnsToMovies < ActiveRecord::Migration[5.1]
  def change
    add_column :movies, :maxim, :string
  end
end
