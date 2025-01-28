class Public::GroupMembersController < ApplicationController
  before_action :authenticate_member!

  def create
    @group = Group.find(params[:group_id])
    current_member.join_group(@group)
    redirect_to request.referer
  end

  def update
    #@group = Group.find(params[:group_id])
    @group_member = GroupMember.find(params[:group_member_id])
    if @group_member.update(group_member_params)
      flash[:notice] = "success"
      redirect_back(fallback_location: root_url)
    else
      flash[:alert] = "failed"
      redirect_back(fallback_location: root_url)
    end
  end

  def destroy
    @group = Group.find(params[:group_id])
    current_member.reject_group(@group)
    redirect_to request.referer
  end

  private

  def group_member_params
    params.require(:group_member).permit(:status)
  end
  
end
