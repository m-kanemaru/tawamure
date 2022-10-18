class ChangeNotnullToUsers < ActiveRecord::Migration[6.1]
  def change
    change_column_null :users, :image_id, true
  end
end
