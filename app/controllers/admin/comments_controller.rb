class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!
  layout 'admin'

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to admin_free_post_path(params[:free_post_id])
  end

end
