class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update]
  #before_action :logged_in?, excepts: [:show, :index]

  def index
    @posts = Post.all
  end

  def show
    @comment = Comment.new
    @comments = @post.comments.all
  end

  def new
    @post = Post.new
  end

  def create
    binding.pry
    @post = Post.new(post_params)
    @post.creator = User.first # change once we add authentication

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

  private
  def post_params
    params.require(:post).permit!
  end

  def set_post
    @post = Post.find(params[:id])
  end

end
