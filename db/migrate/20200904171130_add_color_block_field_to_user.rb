class AddColorBlockFieldToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :color_block, :string
  end
end
