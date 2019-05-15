class CreateProfileImages < ActiveRecord::Migration[5.2]
  def change
    create_table :profile_images do |t|
      t.integer :employee_id
      t.string :image

      t.timestamps
    end
  end
end
