class Matchup < ActiveRecord::Base
  belongs_to :week
  belongs_to :season
  belongs_to :team

  def first_team
    Team.find(first_team_id)
  end

  def second_team
    Team.find(second_team_id)
  end

end
