class AuthenticationsController < ApplicationController

  def create
    auth = request.env["omniauth.auth"]
    current_user.authentications.find_or_create_by(:provider => auth['provider'], :uid => auth['uid'])

    current_user.provider = auth.provider
    current_user.uid = auth.uid
    current_user.oauth_token = auth.credentials.token
    current_user.refresh_token = auth.credentials.refresh_token
    current_user.instance_url = auth.credentials.instance_url
    # current_user.sfdc_user_id = auth.extra.user_id
    current_user.save

    redirect_to "/users/#{current_user.id}"
  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    redirect_to "/users/#{current_user.id}"
  end


end
