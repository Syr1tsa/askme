class DefaultValuesForUrlAndColorBlock < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :avatar_url, :string, default: "avatar.jpg"
    change_column :users, :color_block, :string, default: "#a28089"
  end
end
