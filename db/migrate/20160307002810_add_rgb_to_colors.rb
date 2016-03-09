class AddRgbToColors < ActiveRecord::Migration
  def change
    add_column :colors, :rgb, :string
  end
end
