class Public::CommentsController < ApplicationController

  def create
    free_post = FreePost.find(params[:free_post_id])
    comment = Comment.new(comment_params)
    comment.member_id = current_member.id
    comment.free_post_id = free_post.id
    comment.save
    redirect_to free_post_path(free_post)
  end


  def destroy
    Comment.find(params[:id]).destroy
    redirect_to free_post_path(params[:free_post_id])
  end


  private

  def comment_params
    params.require(:comment).permit(:comment)
  end

end