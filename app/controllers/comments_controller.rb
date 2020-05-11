class CommentsController < ApplicationController
  before_action :require_user
  
  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.post = @post
    @comment.creator = current_user

    if @comment.save
      flash[:notice] = "Your comment was added"
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end

  def vote
    @comment = Comment.find(params[:id])

    if Vote.where(user_id: current_user.id, votable_type: "Comment", votable_id: @comment.id).empty?
      Vote.create(votable: @comment, creator: current_user, vote: params[:vote])
      flash[:notice] = "Your vote was counted."
    else
      flash[:error] = "You already voted on this comment."
    end

    redirect_back fallback_location: posts_path
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end