class Public::FavoritesController < ApplicationController
  before_action :authenticate_member!
  
  def create
    free_post = FreePost.find(params[:free_post_id])
    favorite = current_member.favorites.new(free_post_id: free_post.id)
    favorite.save
    redirect_to request.referer
  end

  def destroy
    free_post = FreePost.find(params[:free_post_id])
    favorite = current_member.favorites.find_by(free_post_id: free_post.id)
    favorite.destroy
    redirect_to request.referer
  end
end
