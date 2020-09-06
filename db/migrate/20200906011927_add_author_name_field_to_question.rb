class AddAuthorNameFieldToQuestion < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :author, :string
  end
end
