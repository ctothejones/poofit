class LeaguesController < ApplicationController
  def new
    @league = League.new
  end

  def create
    @league = League.new
    @league.name = params[:league][:name]
    @league.company_id = current_user.company_id
    @league.save

    if @league.save
      redirect_to "/leagues/#{@league.id}", :notice => "League created successfully."
    else
      render 'new'
    end
  end

  def show
    @league = League.find(params[:id])
    @company = @league.company
    @season = Season.new

    @league.seasons.each do |season|
      if season.current
        @current_season = season
      end
    end

    @standings = @league.teams.sort {|a,b| b.win_count(@current_season) <=> a.win_count(@current_season)}

  end

  def edit
    @league = League.find(params[:id])
  end

  def update
    @league = League.find(params[:id])
    @league.name = params[:league][:name]

    @league.save

    if @league.save
      redirect_to "/leagues/#{@league.id}", :notice => "League updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @league = League.find(params[:id])
    @league.destroy

    redirect_to "/companies/#{@user.company.id}", :notice => "League deleted"
  end
end
