class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @team = @user.team
    @league = @team.league

    @client = Restforce.new :oauth_token => current_user.oauth_token,
      :refresh_token => current_user.refresh_token,
      :instance_url  => current_user.instance_url,
      :client_id     => SALESFORCE_CONFIG['key'],
      :client_secret => SALESFORCE_CONFIG['secret']

    @accounts = @client.query("SELECT Name FROM Account WHERE OwnerId = '005i0000002QZPlAAO'")
  end

end
