class Admin::SearchesController < ApplicationController

  before_action :authenticate_admin!
  layout 'admin'

  def search
    @model = params[:model]
    @content = params[:content]
    @method = params[:method]
    
    
    
   # 選択したモデルに応じて検索を実行
    if @model  == "member"
      @records = Member.search_for(@content, @method)
    elsif @model == "free_post"
      @records = FreePost.search_for(@content, @method)
    else
      @records = Group.search_for(@content, @method)
    end
  end
end


