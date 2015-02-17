class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, except: [:show, :index, :vote]

  def index
    @posts = Post.all.sort_by{|x| x.total_votes}.reverse
  end

  def show
    @comment = Comment.new
    @comments = @post.comments.all
  end

  def new
    @post = Post.new
  end

  def create

    @post = Post.new(post_params)
    @post.creator = current_user

    if @post.save
      flash[:notice] = "Your post is created."
      redirect_to post_path(@post) 
    else
      render 'new'
    end
  end

  def edit
  end

  def update

    if @post.update(post_params)
      flash[:notice] = "Your post is updated."
      redirect_to post_path(@post)
    else
      render 'edit'
    end
  end

  def vote
    @vote = Vote.create(user: current_user, votable: @post, vote: params[:vote])

    if @vote.valid?
      flash[:notice] = "Your vote is counted."
    else
      flash[:error] = "You have already voted."
    end

    redirect_to :back
  end

  private
  def post_params
    params.require(:post).permit!
  end

  def set_post
    @post = Post.find(params[:id])
  end

end
