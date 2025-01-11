class Public::PostsController < ApplicationController
  before_action :authenticate_member!

  def index
    @post = Post.new
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id]) 
    @member = @post.member
    @post_new = Post.new
    

  end

  def edit
    is_matching_login_member
    @post = Post.find(params[:id])
  end


  def create
    @post = Post.new(posts_params)
    @post.member_id = current_member.id
    @post.save
    if @post.save
      redirect_to post_path(@post), notice: "You have created book successfully."
    else
      @posts = Post.all
      render 'index'
    end
  end

  def update
    is_matching_login_member
    @post = Post.find(params[:id])
    if @post.update(posts_params)
      redirect_to post_path(@post), notice: "You have updated book successfully."
    else
      render "edit"
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
      redirect_to post_path(post)
    end
  end

end
