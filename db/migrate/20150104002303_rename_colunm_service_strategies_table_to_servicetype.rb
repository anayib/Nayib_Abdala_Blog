class RenameColunmServiceStrategiesTableToServicetype < ActiveRecord::Migration
  def change
    rename_column :strategies, :service, :servicetype
  end
end
