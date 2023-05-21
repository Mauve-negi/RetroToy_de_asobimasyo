class AddPostTypeToPost < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :post_type, :integer
  end
end
