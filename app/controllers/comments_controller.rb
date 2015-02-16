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

  def vote
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @vote = Vote.create(user: current_user, vote: params[:vote], votable: @comment)

    if @vote.valid?
      flash[:notice] = "Your vote is counted."
    else
      flash[:notice] = "You've already voted."
    end
    redirect_to :back
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end
end