class AddAttachmentAudioToArticles < ActiveRecord::Migration
  def self.up
    change_table :articles do |t|
      t.attachment :audio
    end
  end

  def self.down
    remove_attachment :articles, :audio
  end
end
