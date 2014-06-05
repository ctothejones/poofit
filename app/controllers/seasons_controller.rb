class SeasonsController < ApplicationController
  def new
    @season = Season.new
    @league = League.find(params[:league_id])
    @season_count = @league.seasons.count
  end

  def create
    @season = Season.new
    @season.league_id = params[:season][:league_id]
    @season.start_date = params[:season][:start_date]
    @season.end_date = @season.start_date.advance :weeks => 12
    @season.number = @league.seasons.count + 1

    @season.save

    # Create weeks -> DRY up into model later
    12.times do |week|
      week = Week.new
      week.season_id = @season.id
      week.number = @season.weeks.count + 1
      if week.number == 1
        week.start_date = @season.start_date
      else
        week.start_date = @season.start_date.advance :weeks => (week.number - 1)
      end
      week.end_date = week.start_date.advance :weeks => 1
      week.save
    end

    ## Creating Matchups - Must happen after teams are set _> DRY up into model later ##
    @league = League.find(params[:season][:league_id])
    number_of_teams = @league.teams.count
    number_of_matchups_per_week = number_of_teams/2

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

    if @season.save
      redirect_to "/leagues/#{@league.id}"
    else
      render "new"
    end
  end

end
