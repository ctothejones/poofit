class Matchup < ActiveRecord::Base
  belongs_to :week
  belongs_to :season
end
