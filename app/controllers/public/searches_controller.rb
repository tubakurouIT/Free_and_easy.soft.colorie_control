class Public::SearchesController < ApplicationController
  before_action :authenticate_member!
  
  def search
    @model = params[:model]
    @content = params[:content]
    @method = params[:method]
    
    # 選択したモデルに応じて検索を実行
    if @model  == "member"
      @records = Member.search_for(@content, @method)
    else
      @records = FreePost.search_for(@content, @method)
    end
    
  end
end