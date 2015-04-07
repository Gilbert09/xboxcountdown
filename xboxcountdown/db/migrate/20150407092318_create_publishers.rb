class CreatePublishers < ActiveRecord::Migration
  def change
    create_table :publishers do |t|
      t.integer :publisher_id
      t.string :name
      t.timestamps null: false
    end
  end
end
