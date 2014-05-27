class TeamsController < ApplicationController
  def show

    @team = Team.find(params[:id])
    ## Sort later by # of poofs this week ##
    @team_members = @team.users
    ##
    @captain = @team.captain
    @league = @team.league
    @company = @league.company
    @seasons = @league.seasons

    @seasons.each do |season|
    	if season.current
    		@current_season = season
      end
    end

    @weeks_this_season = @current_season.weeks

    @matchups_this_season = Matchup.where({ :season_id => @current_season.id })
    @teams_matchups_this_season = @matchups_this_season.where({ :first_team_id => @team.id }) + @matchups_this_season.where({ :second_team_id => @team.id })
    @teams_matchups_this_season_in_order = @teams_matchups_this_season.sort_by{ |matchup| matchup[:week_id] }

    @win_count = 0
    @teams_matchups_this_season.each do |matchup|
      if matchup.winner == @team.id
        @win_count += 1
      end
    end
    @loss_count = @teams_matchups_this_season.count - @win_count
  end
end
