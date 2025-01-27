class Public::FavoritesController < ApplicationController
  before_action :authenticate_member!
  
  def create
    free_post = FreePost.find(params[:free_post_id])
    current_member.favorite(free_post)
    redirect_to request.referer
  end

  def destroy
    free_post = FreePost.find(params[:free_post_id])
    current_member.unfavorite(free_post)
    redirect_to request.referer
  end
end
