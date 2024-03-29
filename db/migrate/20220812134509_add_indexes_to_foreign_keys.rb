class AddIndexesToForeignKeys < ActiveRecord::Migration[7.0]
  def change
    add_index :comments, [:author_id, :post_id]
    add_index :posts, :author_id
    add_index :likes, [:author_id, :post_id]
  end
end
