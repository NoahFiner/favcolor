class ChangeDescToDescriptionInColors < ActiveRecord::Migration
  def change
    rename_column :colors, :desc, :description
  end
end
