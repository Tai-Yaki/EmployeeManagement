class SetDefaultToPositionOfEmployee < ActiveRecord::Migration[5.2]
  def change
    change_column :employees, :position, :string, default: "なし"
  end
end
