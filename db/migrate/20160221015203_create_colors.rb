class CreateColors < ActiveRecord::Migration
  def change
    create_table :colors do |t|
      t.string :color
      t.text :desc
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :colors, [:user_id, :created_at]
  end
end
