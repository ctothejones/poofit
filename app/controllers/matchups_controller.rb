class MatchupsController < ApplicationController
  def show
    @league = current_user.league
    @current_season = Season.where({ :league_id => @league.id }).last

  end

end
