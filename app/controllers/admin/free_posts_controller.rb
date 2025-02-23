class Admin::FreePostsController < ApplicationController
  before_action :authenticate_admin!
  layout 'admin'

  def index
    @free_posts =FreePost.page(params[:page]).per(9).order(created_at: :desc)
  end

  def show
    @free_post = FreePost.find(params[:id])
    @member = @free_post.member
  end

  def destroy
    @free_post = FreePost.find(params[:id])
    @free_post.destroy
    redirect_to admin_free_posts_path
  end

  def self.search_for(content, method)
    if method == 'perfect'
      FreePost.where(body: content)
    elsif method == 'forward'
      FreePost.where('body LIKE ?', content + '%')
    elsif method == 'backward'
      FreePost.where('body LIKE ?', '%' + content)
    else
      FreePost.where('body LIKE ?', '%' + content + '%')
    end
  end


end
