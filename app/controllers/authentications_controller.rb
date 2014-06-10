class AuthenticationsController < ApplicationController

  def create
    auth = request.env["omniauth.auth"]
    current_user.authentications.find_or_create_by(:provider => auth['provider'], :uid => auth['uid'])
    flash[:notice] = "Authentication Successful"
    redirect_to "/users/#{current_user.id}"
  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Authentication destroyed"
    redirect_to "/users/#{current_user.id}"
  end


end
