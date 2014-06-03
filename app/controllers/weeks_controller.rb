class WeeksController < ApplicationController
  def create
    @season = Seaosn.find(params[:season_id])
  end
end
