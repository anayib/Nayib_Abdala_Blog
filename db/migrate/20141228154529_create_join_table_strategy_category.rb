class CreateJoinTableStrategyCategory < ActiveRecord::Migration
  def change
    create_join_table :strategies, :categories do |t|
      t.index [:strategy_id, :category_id]
      # t.index [:category_id, :strategy_id]
    end
  end
end
