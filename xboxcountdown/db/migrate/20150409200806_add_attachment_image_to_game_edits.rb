class AddAttachmentImageToGameEdits < ActiveRecord::Migration
  def self.up
    change_table :game_edits do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :game_edits, :image
  end
end
