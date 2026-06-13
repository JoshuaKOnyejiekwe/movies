class AddingTmDbFieldsToMovies < ActiveRecord::Migration[8.1]
  def change
    change_table :movies do |t|
      t.integer :tmdb_id
      t.string :poster_url
      t.string :release_date
      t.text :overview
      t.boolean :custom, default: true
  end
end
