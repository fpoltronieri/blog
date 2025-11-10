class AddLikeToPost < ActiveRecord::Migration[8.1]
  def change
    add_column :posts, :like, :integer
  end
end
