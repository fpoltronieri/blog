class LikesController < ApplicationController
  before_action :set_likeable

  def create
    like = Like.find_or_create_by!(user: Current.user, likeable: @likeable)
    created = like.previously_new_record? || like.saved_change_to_id?
    Rails.logger.debug "LIKE ##{like.id} created: #{created}"
    Turbo::StreamsChannel.broadcast_replace_to(
      @likeable,
      target: ActionView::RecordIdentifier.dom_id(@likeable, :likes_count),
      partial: "likes/likes_count",
      locals: { likeable: @likeable }
    )
    respond_to do |f|
      f.turbo_stream
      f.html { redirect_back fallback_location: @likeable }
    end
  end

  def destroy
    Like.find_by(user: Current.user, likeable: @likeable)&.destroy
    @likeable.reload
    respond_to do |f|
      f.turbo_stream
      f.html { redirect_back fallback_location: @likeable }
    end
  end

  private

  def set_likeable
    @likeable =
      if params[:post_id]
        Post.find(params[:post_id])
      elsif params[:comment_id]
        Comment.find(params[:comment_id])
      end
  end
end

