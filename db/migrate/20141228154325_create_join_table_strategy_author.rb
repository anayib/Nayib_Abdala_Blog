class CreateJoinTableStrategyAuthor < ActiveRecord::Migration
  def change
    create_join_table :strategies, :authors do |t|
      t.index [:strategy_id, :author_id]
      # t.index [:author_id, :strategy_id]
    end
  end
end
