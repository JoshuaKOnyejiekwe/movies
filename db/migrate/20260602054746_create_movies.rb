class CreateMovies < ActiveRecord::Migration[8.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :genre
      t.integer :rating
      t.text :review
      t.boolean :watched

      t.timestamps
    end
  end
end
