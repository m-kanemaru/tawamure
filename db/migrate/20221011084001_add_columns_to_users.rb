class AddColumnsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :is_deleted, :boolean, null: false, default: "FALSE"
    add_column :users, :nickname, :string, null: false
    add_column :users, :name, :string, null: false
    add_column :users, :birthdate, :date, null: false
    add_column :users, :image_id, :string, null: false
    add_column :users, :mobile, :string, null: false
  end
end
