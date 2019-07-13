class CommentsController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    comment = post.comments.new(comment_params)
    comment.user_id = current_user.id
    if comment.save
    redirect_to post_path(post)
    else
        p.comment.errors
    end
  end
  def destroy
  p post_params
end
end

  private

  def comment_params
      params.require(:comment).permit(:description)
  end
