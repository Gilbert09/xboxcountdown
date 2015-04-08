class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :publisher_id
      t.string :title
      t.string :console
      t.datetime :release_date
      t.timestamps null: false
    end
  end
end
