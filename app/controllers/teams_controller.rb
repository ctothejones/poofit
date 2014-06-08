class TeamsController < ApplicationController
  def new
    @team = Team.new
    @league = League.find(params[:league_id])
  end

  def create
    @team = Team.new
    @team.name = params[:team][:name]
    @team.league_id = params[:team][:league_id]

    @team.save

    if @team.save
      redirect_to "/leagues/#{@team.league_id}/teams/#{@team.id}", :notice => "Team created successfully!"
    else
      render "new"
    end
  end

  def show
    @team = Team.find(params[:id])
    @team_members = @team.users
    @captain = @team.captain
    @league = @team.league
    @company = @league.company

    @league.seasons.each do |season|
    	if season.current
    		@current_season = season
      end
    end

    @matchups_this_season = @current_season.matchups
    @teams_matchups_this_season = @matchups_this_season.where({ :first_team_id => @team.id }) + @matchups_this_season.where({ :second_team_id => @team.id })
    @teams_matchups_this_season_in_order = @teams_matchups_this_season.sort_by{ |matchup| matchup[:week_id] }

    @win_count = @team.win_count(@current_season)
  end

  def edit
    @league = League.find(params[:league_id])
    @team = Team.find(params[:id])
    @team_members = @team.users
  end

  def update
    @league = League.find(params[:league_id])
    @team = Team.find(params[:id])
    @team.name = params[:team][:name]

    @current_captain = @team.captain
    @current_captain.is_captain = false
    @current_captain.save

    @new_captain = User.find(params[:new_captain])
    @new_captain.is_captain = true
    @new_captain.save

    @team.save

    if @team.save
      redirect_to league_team_path(@league, @team), :notice => "Team updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @league = League.find(params[:league_id])
    @team = Team.find(params[:id])
    @team.destroy

    redirect_to "/leagues/#{@league.id}", :notice => "Team deleted"
  end


end
