class ChangeColorColumnToHex < ActiveRecord::Migration
  def change
    rename_column :colors, :color, :hex
  end
end
