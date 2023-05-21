class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      
      t.integer :user_id, null: false #ユーザID
      t.string :title, null: false #タイトル
      t.string :body, null: false #投稿内容

      t.timestamps
    end
  end
end
