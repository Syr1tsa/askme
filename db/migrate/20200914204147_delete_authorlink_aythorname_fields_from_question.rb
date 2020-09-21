class DeleteAuthorlinkAythornameFieldsFromQuestion < ActiveRecord::Migration[6.0]
  def change
    remove_column :questions, :author
  end
end
