class AddColumnToEmployees < ActiveRecord::Migration[5.2]
  def change
    add_column :employees, :picture, :string
  end
end
