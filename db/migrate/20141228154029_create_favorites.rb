class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.references :user, index: true
      t.references :strategy, index: true
      t.date :date

      t.timestamps
    end
  end
end
