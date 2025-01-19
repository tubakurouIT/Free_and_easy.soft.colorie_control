class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!
  layout 'admin'

  def destroy
    free_post_id = Comment.find(params[:id]).free_post_id
    Comment.find(params[:id]).destroy
    redirect_to admin_free_post_path(free_post_id)
  end

end
