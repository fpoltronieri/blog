class CommentsController < ApplicationController
  before_action :set_post 
  # Inseriamo un controllo per assicurarci che solo l'user 
  # che ha scritto il commento possa eliminarlo

  def create
    puts "comment_params: #{comment_params.inspect}"
    comment = @post.comments.new(comment_params)
    if comment.save
      redirect_to @post, notice: "Comment was successfully created."
    else
      redirect_to posts_path, alert: "Failed to create comment."
    end

  end

  private
  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params 
    params.expect(comment: [:content]).merge(user: Current.user)
  end

  def authorize_comment_deletion
    redirect_to url(@post), alert: 'Non puoi rimuovere il commento' unless @comment.user == current_user
  end
    
end
