class CommentsController < ApplicationController
  before_action :require_user

  def create

    @the_post = Post.find(params[:post_id])
    @comment = @the_post.comments.build(params.require(:comment).permit(:body))
    @comment.creator = current_user 

    if @comment.save
      flash[:notice] = 'Your comment was added'
      redirect_to post_path(@the_post)
    else
      render 'posts/show'
    end
  end

  def vote
    comment = Comment.find(params[:id])
    @vote = Vote.create(vote: params[:vote], creator: current_user, voteable: comment)
    
    if @vote.valid?
      if @vote.vote == true
        flash[:notice] = 'Thanks for your vote'
      else
        flash[:notice] = 'OH DEAR! but thanks'
      end
    else
      flash[:error] = 'You can only vote once for this comment'
    end
    redirect_to :back
  end
end