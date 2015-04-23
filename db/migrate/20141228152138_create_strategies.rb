class CreateStrategies < ActiveRecord::Migration
  def change
    create_table :strategies do |t|
      t.string :title
      t.text :intro
      t.date :date
      t.references :user, index: true

      t.timestamps
    end
  end
end
