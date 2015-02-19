class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, except: [:index, :show]


  def index
    @posts = Post.all.sort_by{|the_post| the_post.total_votes}.reverse
  end

  def show
    @comment= Comment.new
  end

  def new
    @the_post = Post.new
  end

  def create
    @the_post = Post.new(post_params)
    @the_post.creator = current_user



    if @the_post.save
      flash[:notice] = "Your post was created."
      redirect_to posts_path
    else
      render 'new'
    end
  end

  def vote
    @vote = Vote.create(voteable: @the_post, creator: current_user, vote: params[:vote])

    respond_to do |format| 
      format.html do 
        if @vote.valid?
          if @vote.vote == true
            flash[:notice] = 'Thanks for voting'
          else
            flash[:notice] = 'OUCH! but thanks for voting'
          end
        else
          flash[:error] = 'You can only vote for this once'
        end
        redirect_to :back
      end
      format.js
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
    @the_post = Post.find_by(slug: params[:id])
  end
end
