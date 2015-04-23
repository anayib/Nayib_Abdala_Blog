class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :name
      t.text :bio
      t.string :image_url
      t.date :date

      t.timestamps
    end
  end
end
