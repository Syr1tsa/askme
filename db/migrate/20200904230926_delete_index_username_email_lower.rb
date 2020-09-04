class DeleteIndexUsernameEmailLower < ActiveRecord::Migration[6.0]
  def change
    remove_index ['lower(users)', 'lower(email)'], name: "index_lower_users_on_lower_email_index"
  end
end
