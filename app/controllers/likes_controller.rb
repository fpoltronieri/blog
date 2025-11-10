class LikesController < ApplicationController
  before_action :set_likeable

  def create
    @like = @likeable.likes.build(user: Current.user)

    if @like.save
      respond_to do |format|
        format.html { redirect_back fallback_location: root_path }
        format.json { render json: { success: true } }
        format.turbo_stream
      end
    else
      redirect_back fallback_location: root_path, alert: "Errore"
    end
  end

  def destroy
    @like = @likeable.likes.find(params[:id])
    @like.destroy

    respond_to do |format|
      format.html { redirect_back fallback_location: root_path }
      format.json { render json: { success: true } }
      format.turbo_stream
    end
  end

  private

  def set_likeable
    if params[:post_id]
      @likeable = Post.find(params[:post_id])
    elsif params[:comment_id]
      @likeable = Comment.find(params[:comment_id])
    end
  end
end
