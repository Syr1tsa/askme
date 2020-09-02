class AddConstraintToUserForUsername < ActiveRecord::Migration[6.0]
  def change
    add_index ['lower(users)'], ['lower(email)'], :name => "index_lower_users_on_lower_email_index", :unique => true
  end
end
  