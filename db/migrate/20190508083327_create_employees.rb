class CreateEmployees < ActiveRecord::Migration[5.2]
  def change
    create_table :employees do |t|
      t.string :name
      t.datetime :join_date
      t.integer :gender
      t.string :position

      t.timestamps
    end
  end
end
