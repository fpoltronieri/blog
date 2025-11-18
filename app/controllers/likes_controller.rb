class LikesController < ApplicationController
  before_action :set_likeable
   
  def create
    Like.find_or_create_by!(user: Current.user, likeable: @likeable)
    respond_to do |f|
      f.turbo_stream
      f.html { redirect_back fallback_location: @likeable }
    end
  end

  def destroy
    Like.find_by(user: Current.user, likeable: @likeable)&.destroy
    respond_to do |f|
      f.turbo_stream
      f.html { redirect_back fallback_location: @likeable }
    end
  end
 
  private

  def set_likeable
    if params[:post_id]
      @likeable = Post.find(params[:post_id])
    elsif params[:comment_id]
      @likeable = Comment.find(params[:comment_id])
    else
      Rails.logger "MALFORMED REUQEST"
    end
  end

end
