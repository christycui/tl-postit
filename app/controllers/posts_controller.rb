class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      flash[:notice] = "Your post is created."
      redirect_to post_path(post)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
  end

  private
  def post_params
    params.require(:post).permit!
  end

end
