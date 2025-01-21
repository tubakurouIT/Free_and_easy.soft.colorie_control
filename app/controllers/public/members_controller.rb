class Public::MembersController < ApplicationController
  before_action :ensure_correct_member, only: [ :edit, :update]
  before_action :ensure_guest_member, only: [:edit]
  before_action :authenticate_member!

  def index
    @members = Member.all
    @member = Member.new
  
  end


  def mypage
    @members = Member.all
    @post = Post.new
    @posts = current_member.posts.limit(3)
    @free_post = FreePost.new
    @free_posts = current_member.free_posts.limit(3)
    @groups = current_member.groups.limit(3)
  end


  def show
    #@member = current_member
    @member = Member.find(params[:id])
    
    @free_post = FreePost.new
    @free_posts = @member.free_posts.all
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
    redirect_to members_mypage_path, notice: "You have updated user successfully."
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
      redirect_to members_mypage_path
    end
  end

  def ensure_guest_member
    @member = Member.find(params[:id])
    if @member.guest_member?
      redirect_to member_path(current_member) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end  

end
