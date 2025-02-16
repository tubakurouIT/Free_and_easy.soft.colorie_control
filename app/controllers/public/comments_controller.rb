class Public::CommentsController < ApplicationController
  before_action :authenticate_member!

  def create
    @free_post = FreePost.find(params[:free_post_id])
    @comment = Comment.new(comment_params)
    @comment.member_id = current_member.id
    @comment.free_post_id = @free_post.id
    @comment.save

    # if @comment.save
    #   redirect_to free_post_path(@free_post), notice: "successfully"
    # else
    #   flash.now[:error] = "コメントに失敗しました。"
    #   @member = @free_post.member
    #   @free_post_new = FreePost.new
    #   render 'public/free_posts/show'
    # end
  end

  def destroy
    @comment = Comment.find_by_id(params[:id])
    @free_post = @comment&.free_post
    @comment&.destroy
    #redirect_to free_post_path(params[:free_post_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end


  
end