class CreateMovieLikes < ActiveRecord::Migration[5.1]
  def change
    create_table :movie_likes do |t|
      t.references :movie, foreign_key: true

      t.timestamps
    end
  end
end
