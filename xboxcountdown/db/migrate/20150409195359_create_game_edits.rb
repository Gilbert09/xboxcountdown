class CreateGameEdits < ActiveRecord::Migration
  def change
    create_table :game_edits do |t|
      t.integer :game_id
      t.integer :publisher_id
      t.string :title
      t.datetime :release_date
      t.string :console
      t.string :state
      t.string :note
      t.timestamps null: false
    end
  end
end
