class LeaguesController < ApplicationController
  def new
    @league = League.new
  end

  def create
    @league = League.new
    @league.name = params[:name]
    @league.company_id = current_user.company_id
    @league.save

    if @league.save
      ## change redirect to league.id ##
      redirect_to "/leagues/index", :notice => "League created successfully."
    else
      render 'new'
    end
  end

  def index
    @company = current_user.company
    @all_leagues = @company.leagues

  end

  def show

    @team = current_user.team

    @league = League.find(params[:id])
    @company = @league.company
    @teams_in_league = @league.teams
    @seasons = @league.seasons

    @seasons.each do |season|
      if season.current
        @current_season = season
      end
    end

    @matchups_this_season = Matchup.where({ :season_id => @current_season.id })
    @matchups_by_winner = @matchups_this_season.group_by{|matchup| matchup[:winner] }
    @standings = @matchups_by_winner.sort_by { |team_id, matchups| matchups.count }.reverse
    @standings_hash = {}
    @standings.each do |standing|
      @winner_id = standing[1][0].winner
      @the_team = Team.find(@winner_id)
      @standings_hash[@the_team] = @matchups_this_season.where({ :winner => @the_team.id }).count
    end

    @weeks_in_season_count = @current_season.weeks.count

  end

  def edit
    @league = League.find(params[:id])
  end

  def update
    @league = League.find(params[:id])
    @league.name = params[:name]

    @league.save

    if @league.save
      ## Change redirect to league.id page ##
      redirect_to "/leagues/index", :notice => "League updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @league = League.find(params[:id])
    @league.destroy

    redirect_to "/leagues/index", :notice => "League deleted"
  end
end
