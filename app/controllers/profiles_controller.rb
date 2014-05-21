class ProfilesController < ApplicationController
  def show

    ##FIX##
    @user = User.first
    @team = User.first.team
    @league = @team.league

  end
end
