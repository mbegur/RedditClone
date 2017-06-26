class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.string :url
      t.string :content
      t.integer :sub_id
      t.integer :user_id, null: false
      t.timestamps null: false
    end
    add_index :posts, :user_id
    add_index :posts, :sub_id
  end
end
