class RenameColumnNameInTips < ActiveRecord::Migration
  def change
    rename_column :tips, :title, :tip_title
  end
end
