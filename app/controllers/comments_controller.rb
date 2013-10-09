class CommentsController < ApplicationController

  def create
    @post = post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.creator = User.first

    if @comment.save
      redirect_to action: :show, id: @post.id #or, redirect_to posts_path(@post), notice: 'Congratulations, your comment was created!'
    else
      @post.reload
      render 'posts/show'
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:body)
    end
end
