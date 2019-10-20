class CreateMovies < ActiveRecord::Migration[5.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :image1
      t.string :image2
      t.string :image3
      t.integer :story_point
      t.string :story_comment
      t.integer :graphic_point
      t.string :graphic_comment
      t.integer :comedy_point
      t.string :comedy_comment
      t.integer :excite_point
      t.string :excite_comment
      t.integer :emotion_point
      t.string :emotion_comment
      t.boolean :fiction
      t.references :category, foreign_key: true
      t.string :description

      t.timestamps
    end
  end
end
