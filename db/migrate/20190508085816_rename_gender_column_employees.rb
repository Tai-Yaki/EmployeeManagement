class RenameGenderColumnEmployees < ActiveRecord::Migration[5.2]
  def change
    rename_column :employees, :gender, :gender_id
  end
end
