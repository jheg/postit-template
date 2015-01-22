class CommentsController < ApplicationController
  before_action :require_user

  def create

    @the_post = Post.find(params[:post_id])
    @comment = @the_post.comments.build(params.require(:comment).permit(:body))
    @comment.creator = User.first # TODO Fix 

    if @comment.save
      flash[:notice] = 'Your comment was added'
      redirect_to post_path(@the_post)
    else
      render 'posts/show'
    end
  end
end