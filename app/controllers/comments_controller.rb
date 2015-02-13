class CommentsController < ApplicationController
  before_action :require_user
  
  def create
    @comment = Comment.new(comment_params)
    @comment.creator = current_user
    @post = Post.find(params[:post_id])
    @comment.post = @post
    if @comment.save
      flash[:notice] = 'New comment added!'
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end
end