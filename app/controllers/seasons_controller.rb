class SeasonsController < ApplicationController
  def new
    @season = Season.new
    @league = League.find(params[:league_id])
    @season_count = @league.seasons.count
  end

  def create
    @league = League.find(params[:season][:league_id])
    @season = Season.new
    @season.league_id = params[:season][:league_id]
    @season.start_date = params[:season][:start_date]
    @season.end_date = @season.start_date.advance :weeks => 12

    @season.save

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

    if @season.save
      redirect_to "/leagues/#{@league.id}"
    else
      render "new"
    end
  end

end
