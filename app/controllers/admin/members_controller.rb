class Admin::MembersController < ApplicationController
  before_action :authenticate_admin!

  layout 'admin'

  def index
    @members = Member.all
  end


  def show
    @member = Member.find(params[:id])
    @free_posts = @member.free_posts.all
  end

  def destroy
    @member = Member.find(params[:id])
    if @member.destroy
      flash[:notice] = "Member was successfully deleted."
    else
      flash[:alert] = "Failed to delete the member."
    end
    redirect_to admin_members_path
  end

  

end
