class RenameCommnetColumnToPostComments < ActiveRecord::Migration[6.1]
  def change
    rename_column :post_comments, :commnet, :comment
    end
end
