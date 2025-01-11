class Public::MembersController < ApplicationController
  before_action :ensure_correct_member, only: [ :edit, :update]
  before_action :ensure_guest_member, only: [:edit]

  def index
    @members = Member.all
    @post = Post.new
    @posts = Post.all
    @free_post = FreePost.new
    @free_posts = FreePost.all
  end


  def show
    #@member = current_member
    @member = Member.find(params[:id])
    @post = Post.new
    @posts = Post.all
    @free_post = FreePost.new
    @free_posts = FreePost.all
  end

  def edit
    @member = Member.find(params[:id])
    #@member = current_member
  end

  def update
    @member = Member.find(params[:id])
    #@member = current_member
    if @member.update(member_params)
      flash[:notice] = "会員情報を編集しました。"
    redirect_to members_path(@member), notice: "You have updated user successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @member = Member.find(current_member.id)
    @member.update(is_active: false)
    reset_session
    flash[:notice] = "退会処理を実行しました。"
    redirect_to root_path
  end

  private

  def member_params
    params.require(:member).permit(:name, :email, :profile_image, :introduction)
  end

  def ensure_correct_member
    @member = Member.find(params[:id])
    unless @member == current_member
      redirect_to member_path(current_member)
    end
  end

  def ensure_guest_member
    @member = Member.find(params[:id])
    if @member.guest_member?
      redirect_to member_path(current_member) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end  

end
