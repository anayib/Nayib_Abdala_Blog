class AddContentTypeToStrategies < ActiveRecord::Migration
  def change
    add_column :strategies, :content_type, :string
  end
end
