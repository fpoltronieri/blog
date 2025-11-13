class Like < ApplicationRecord
  # RecordIdentifier is included to generate DOM IDs for broadcasting
  include ActionView::RecordIdentifier

  belongs_to :user
  belongs_to :likeable, polymorphic: true

  validates :user_id, presence: true
  validates :likeable_id, :likeable_type, presence: true
  validates :user_id, uniqueness: { scope: [:likeable_type, :likeable_id], message: "has already liked this item" }

  after_commit :broadcast_like_count, on: [:create, :destroy]

  private 

    def broadcast_like_count
      Rails.logger.debug "AFTER_CREATE_COMMIT like##{id} for #{likeable.class}##{likeable_id}"
      Turbo::StreamsChannel.broadcast_replace_to(
      likeable,
      target: ActionView::RecordIdentifier.dom_id(likeable, :likes_count),
      partial: "likes/likes_count",
      locals: { likeable: likeable }
    )
    end
end
