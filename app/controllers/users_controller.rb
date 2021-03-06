class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @team = @user.team
    @league = @team.league

    ## model - sfdc_signed_in instead of this if statement ##
    if current_user.authentications.find_by({ :provider => "salesforce" })
      @client = Restforce.new :oauth_token => current_user.oauth_token,
        :refresh_token => current_user.refresh_token,
        :instance_url  => current_user.instance_url,
        :client_id     => SALESFORCE_CONFIG['key'],
        :client_secret => SALESFORCE_CONFIG['secret']

      @current_user_accounts = @client.query("SELECT Name FROM Account WHERE OwnerId = '#{current_user.sfdc_user_id}'")

      @current_user_tasks = @client.query("SELECT Subject FROM Task WHERE OwnerId = '#{current_user.sfdc_user_id}' AND Status = 'Completed'")
      @current_user_calls = []
      @current_user_tasks.each do |task|
        if task.Subject.downcase == "call"
          @current_user_calls << task
        end
      end
    end
  end

  def update

    ##Had to do with update attribute for paperclip, but may have to change around when adding edit for rest of user model - may have something to do with strong parameters##
    @user = User.find(params[:id])
    @user.update_attribute(:photo, params[:user][:photo])

    redirect_to "/users/#{@user.id}"
  end
end
