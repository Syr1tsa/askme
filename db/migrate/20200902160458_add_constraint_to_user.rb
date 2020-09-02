class AddConstraintToUser < ActiveRecord::Migration[6.0]
  def up
    add_check_constraint :users, 'UPPER(username) = username', name: 'check_username_lowercase'
  end

  def down
    remove_check_constraint :users, name: 'check_username_lowercase'
  end
end
