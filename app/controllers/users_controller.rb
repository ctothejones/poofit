class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @team = @user.team
    @league = @team.league
    @authentications = current_user.authentications.all
  end

end
