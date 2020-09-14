class DeleteAuthorlinkAythornameFieldsFromQuestion < ActiveRecord::Migration[6.0]
  def change
    remove_column :questions, :author_link, :author
  end
end
