class AddFalseToAdmin < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :admin, :boolean, default: false
  end
end
