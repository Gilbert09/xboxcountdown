class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :game_id
      t.integer :publisher_id
      t.string :title
      t.datetime :release_date
      t.timestamps null: false
    end
  end
end
