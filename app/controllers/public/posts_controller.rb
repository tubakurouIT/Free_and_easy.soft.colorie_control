class Public::PostsController < ApplicationController
  before_action :authenticate_member!
  before_action :is_matching_login_member, except: [:index, :create]
 
  def index
    @post = Post.new
    @posts = current_member.posts.all

    if params[:latest]
      @posts = current_member.posts.all.latest
    elsif params[:old]
      @posts = current_member.posts.all.old
    else
      @posts = current_member.posts.all
    end
  end

  def show
    @post = Post.find(params[:id]) 
    @member = @post.member
    @post_new = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(posts_params)
    @post.member_id = current_member.id
    @post.save
    if @post.save
      redirect_to posts_path, notice: "You have created Post successfully."
    else
      @members = Member.all
      @posts = current_member.posts.limit(3)
      @free_post = FreePost.new
      @free_posts = current_member.free_posts.limit(3)
      @groups = current_member.groups.limit(3)
      @permit_group_members = [] #@post.group_members.permit
      render 'public/members/mypage'
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(posts_params)
      redirect_to posts_path, notice: "You have updated Post successfully."
    else
      render "public/posts/edit"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private
  
  def posts_params
    params.require(:post).permit(:title, :body, :image)
  end

  def is_matching_login_member
    post = Post.find(params[:id])
    unless post.member.id == current_member.id
      redirect_to posts_path
    end
  end

end
