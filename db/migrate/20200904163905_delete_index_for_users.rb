class DeleteIndexForUsers < ActiveRecord::Migration[6.0]
  def change
    remove_index ["email", "username"], name: "index_users_on_email_and_username"
  end
end
