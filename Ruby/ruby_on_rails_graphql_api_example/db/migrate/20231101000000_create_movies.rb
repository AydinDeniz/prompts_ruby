
class CreateMovies < ActiveRecord::Migration[6.0]
  def change
    create_table :movies do |t|
      t.string :title, null: false
      t.integer :release_year
      t.references :genre, foreign_key: true
      t.timestamps
    end
  end
end
