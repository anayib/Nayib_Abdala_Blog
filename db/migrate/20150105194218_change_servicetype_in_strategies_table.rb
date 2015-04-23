class ChangeServicetypeInStrategiesTable < ActiveRecord::Migration
  def change
    remove_column :strategies, :servicetype
    add_column :strategies, :servicetype, :integer
  end
end
