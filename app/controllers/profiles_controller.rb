class ProfilesController < ApplicationController
  def show

    @user = User.find(params[:id])
    @team = @user.team
    @league = @team.league

  end
end
