class AddImagetoAuthors < ActiveRecord::Migration
    def self.up
    add_attachment :authors, :image
  end

  def self.down
    remove_attachment :authors, :image
  end
end
