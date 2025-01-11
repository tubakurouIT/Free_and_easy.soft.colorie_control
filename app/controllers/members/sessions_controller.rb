class Members::SessionsController < ApplicationController
  def guest_sign_in
    member = Member.guest
    sign_in member
    redirect_to members_path, notice: "guestでログインしました。"
  end
end
