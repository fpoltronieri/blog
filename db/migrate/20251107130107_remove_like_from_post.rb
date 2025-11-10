class RemoveLikeFromPost < ActiveRecord::Migration[8.1]
  def change
    remove_column :posts, :like, :integer
  end
end
