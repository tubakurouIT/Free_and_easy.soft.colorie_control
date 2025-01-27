class Public::GroupsController < ApplicationController
  before_action :authenticate_member!
  before_action :ensure_correct_member, only: [:edit, :update, :destroy, :permits]
  before_action :ensure_guest_member, only: [:new, :edit, :create, :update, :destroy]

  def new
    @group = Group.new
  end

  def index
    @free_post = FreePost.new
    @groups = Group.all
    @member = Member.find(current_member.id)

    
  end

  def show
    @free_post =FreePost.new
    @group = Group.find(params[:id])
    @member = Member.find(current_member.id)
    @free_posts =FreePost.all
    @group_free_posts = FreePost.where(group_id: @group.id).page(params[:group_page]).per(10)
  end

  def edit
    @group = Group.find(params[:id]) 
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_member.id
    if @group.save
       @group.group_members.create(member_id: @group.owner_id)
      redirect_to groups_path
    else
      render :new
    end
  end

  def update
    if @group.update(group_params)
      redirect_to groups_path
    else
      render :edit
    end
  end

  def destroy
    @group = Group.find(params[:id])
    if current_member.id == @group.owner_id
    @group.destroy
    redirect_to groups_path, notice: "グループを削除しました"
    else
      redirect_to groups_path, alert: "権限がありません"
    end
  end


  def permits
    @group = Group.find(params[:id])
    @application_group_members = @group.group_members.where(status: 'application').page(params[:page])
    @permit_group_members = @group.group_members.where(status: 'permit').page(params[:page])
    @rejection_group_members = @group.group_members.where(status: 'rejection').page(params[:page])
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction, :group_image)
  end

  def ensure_correct_member
    @group = Group.find(params[:id])
    unless @group.owner_id == current_member.id
      redirect_to groups_path, alert: "グループオーナーのみ編集が可能です"
    end
  end


  def ensure_guest_member
    @member = current_member
    if @member.guest_member?
      redirect_to groups_path, notice: "ゲストユーザーはグループ機能を使用できません"
    end
  end  
end
