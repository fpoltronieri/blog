class Like < ApplicationRecord
  belongs_to :user
  belongs_to :likeable, polymorphic: true

  after_commit :broadcast_like_count, on: [:create, :destroy]


  private 

  def broadcast_like_count
      Turbo::StreamsChannel.broadcast_replace_to(
      likeable,
      target: ActionView::RecordIdentifier.dom_id(likeable, :likes_count),
      partial: "likes/likes_count",
      locals: { likeable: likeable }
    )
  end
end
