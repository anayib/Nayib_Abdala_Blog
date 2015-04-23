class CreateTips < ActiveRecord::Migration
  def change
    create_table :tips do |t|
      t.string :title
      t.text :content
      t.references :strategy, index: true

      t.timestamps
    end
  end
end
