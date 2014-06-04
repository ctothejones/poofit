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

    ## Creating Matchups - Must happen after teams are set ##
    @league = League.find(params[:season][:league_id])
    number_of_teams = @league.teams.count
    number_of_matchups_per_week = number_of_teams/2

    # @season.weeks.each do |week|

    #   teams_with_matchups_this_week = []

    #   number_of_matchups_per_week.times do |matchup|
    #     matchup = Matchup.new
    #     matchup.week_id = week.id
    #     matchup.season_id = @season.id

    #     random_team = @league.teams.sample

    #     case random_team

    #     when week.matchups.nil?
    #       matchup.first_team_id = random_team.id
    #       teams_with_matchups_this_week << random_team.id

    #     when teams_with_matchups_this_week.include?(random_team.id)
    #       if matchup.first_team_id || matchup.second_team_id == random_team.id
    #         random_team = @league.teams.sample
    #           #assign to team w/ if statements below
    #       else


    #     else
    #       if matchup.first_team_id.present?
    #         if matchup.first_team_id == random_team.id
    #           random_team = @league.teams.sample
    #         else
    #           matchup.second_team_id = random_team.id
    #         end
    #       else
    #         matchup.first_team_id = random_team.id
    #       end
    #     end

    #     matchup.save
    #   end

    # end

  # ## while loop? while any matchup in any week is lacking a team? ##
  # # bye weeks if not even teams? Force even teams before season?
  # # handle this with cron job on morning of start_date?
  # @league.team_ids - [@league.team_ids.sample]


    if @season.save
      redirect_to "/leagues/#{@league.id}"
    else
      render "new"
    end
  end

end
