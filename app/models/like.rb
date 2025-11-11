class Like < ApplicationRecord
  belongs_to :user
  belongs_to :likeable, polymorphic: true

  validates :user_id, presence: true
  validates :likeable_id, :likeable_type, presence: true
  validates :user_id, uniqueness: { scope: [:likeable_type, :likeable_id], message: "has already liked this item" }

end
