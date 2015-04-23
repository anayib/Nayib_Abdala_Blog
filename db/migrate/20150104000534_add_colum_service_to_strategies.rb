class AddColumServiceToStrategies < ActiveRecord::Migration
  def change
    add_column :strategies, :service, :string
  end
end
