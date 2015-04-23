class AddServiceRefToStrategies < ActiveRecord::Migration
  def change
    add_reference :strategies, :service, index: true
  end
end
