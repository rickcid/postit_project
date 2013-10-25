class CommentsController < ApplicationController
  before_action :require_user

  def create
    @post = Post.find_by(slug: params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to posts_path(@post), notice: 'Congratulations, your comment was created!'
    else
      @post.reload
      render 'posts/show'
    end
  end

  def vote
    @post = Post.find_by(slug: params[:post_id])
    @comment = Comment.find(params[:id])
    Vote.create(voteable: @comment, creator: current_user, vote: params[:vote])
    respond_to do |format|
      format.html { redirect_to :back, notice: "Your vote was counted." }
      format.js 
    end   
  end


  private
    def comment_params
      params.require(:comment).permit(:body)
    end
end
