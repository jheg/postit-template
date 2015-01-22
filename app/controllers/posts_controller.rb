class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update]
  before_action :require_user, except: [:index, :show]


  def index
    @posts = Post.all
  end

  def show
    @comment= Comment.new
  end

  def new
    @the_post = Post.new
  end

  def create
    @the_post = Post.new(post_params)
    @the_post.creator = User.first # TODO change once we have authentication



    if @the_post.save
      flash[:notice] = "Your post was created."
      redirect_to posts_path
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @the_post.update(post_params)
      flash[:notice] = "The post was updated"
      redirect_to post_path
    else
      render :edit
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids: [])
  end

  def set_post
    @the_post = Post.find(params[:id])
  end
end
