class Public::SessionsController < Devise::SessionsController

  def after_sign_in_path_for(resource)
    members_mypage_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def reject_member
    @member = Member.find_by(email: params[:member][:email])
     if @member
      if @member.valid_password?(params[:member][:password]) && (@member.active_for_authentication? == true)
      else
       flash[:error] = "退会済みです。再度新規登録をしてご利用ください。"
       redirect_to new_member_registration_path
      end
     else
       flash[:error] = "該当するユーザーが見つかりません。"
     end
  end



  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
   #def new
     #super
   #end

  # POST /resource/sign_in
   def create
    @member = Member.find_by(email: params[:member][:email]) 
     if @member
      if @member.valid_password?(params[:member][:password]) 
        if !@member.active_for_authentication?
          flash[:error] = "退会済みです。再度新規登録をしてご利用ください。"
        end
      else
        flash[:error] = "パスワードが誤っています。"
      end
     else
      flash[:error] = "該当するユーザーが見つかりません。"
     end
    super
   end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
