class AuthenticationsController < ApplicationController

  def create
    auth =  request.env["omniauth.auth"]
    current_user.authentications.create(:provider => auth['provider'], :uid => auth['uid'])
    flash[:notice] = "Authentication Successful"
    redirect_to "/users/#{current_user.id}"
  end

  def destroy

  end


end
