class Matchup < ActiveRecord::Base
  belongs_to :week
  belongs_to :season

  def first_team
    Team.find(first_team_id)
  end

  def second_team
    Team.find(second_team_id)
  end

  def winning_team
    Team.find(winner)
  end
end
