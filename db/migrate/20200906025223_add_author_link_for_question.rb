class AddAuthorLinkForQuestion < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :author_link, :string
  end
end
