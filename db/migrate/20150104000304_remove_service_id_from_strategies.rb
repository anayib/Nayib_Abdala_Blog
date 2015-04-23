class RemoveServiceIdFromStrategies < ActiveRecord::Migration
  def change
    remove_column :strategies, :service_id, :integer
  end
end
