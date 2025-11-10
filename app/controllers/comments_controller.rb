class CommentsController < ApplicationController
  before_action :set_post
  # Inseriamo un controllo per assicurarci che solo l'user 
  # che ha scritto il commento possa eliminarlo
  before_action :set_comment, only: [:destroy]
  before_action :authorize_comment_deletion, only: [:destroy]

  #
  #def show
  #  @comment = @post.comments.find(params[:id])
  #end

  def create
    puts "comment_params: #{comment_params.inspect}"
    comment = @post.comments.new(comment_params)
    if comment.save
      redirect_to @post, notice: "Comment was successfully created."
    else
      redirect_to posts_path, alert: "Failed to create comment."
    end
  end

  def destroy
    @comment.destroy
    redirect_to @post, notice: "Comment was successfully deleted."
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def comment_params 
    params.expect(comment: [:content]).merge(user: Current.user)
  end

  def authorize_comment_deletion
  redirect_to url(@post), alert: 'Non puoi rimuovere il commento' unless @comment.user == Current.user
  end
    
end
