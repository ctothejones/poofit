class MatchupsController < ApplicationController
  def show
    @league = current_user.league
    @current_season = Season.where({ :league_id => @league.id }).last

  end

  def create
    ## Creating Matchups - Must happen after teams are set -> DRY up into model later ##
    @league = League.find(params[:league_id])
    @season = Season.find(params[:season_id])

    number_of_teams = @league.teams.count
    number_of_matchups_per_week = number_of_teams/2

    if @season.matchups.count == 0
      @season.weeks.each do |week|
        shuffled_team_ids = @league.team_ids.shuffle

        number_of_matchups_per_week.times do |matchup|
          matchup = Matchup.new
          matchup.week_id = week.id
          matchup.season_id = @season.id

          random_team_1 = shuffled_team_ids.sample
          matchup.first_team_id = random_team_1
          shuffled_team_ids = shuffled_team_ids - [random_team_1]

          random_team_2 = shuffled_team_ids.sample
          matchup.second_team_id = random_team_2
          shuffled_team_ids = shuffled_team_ids - [random_team_2]

          matchup.save
        end
      end
    end

    redirect_to "/leagues/#{@league.id}", :notice => "Matchups created successfully!"

  end

end
