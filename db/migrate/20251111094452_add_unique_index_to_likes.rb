class AddUniqueIndexToLikes < ActiveRecord::Migration[8.1]
  def change
      add_index :likes, [:user_id, :likeable_type, :likeable_id],
            unique: true,
            name: "index_likes_on_user_and_likeable_unique"
  end
end
