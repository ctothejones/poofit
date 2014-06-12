class Team < ActiveRecord::Base
  belongs_to :league
  has_many :users
  has_many :matchups

  validates :name, presence: true

  def captain
    users.find_by({ :is_captain => true })
  end

  def win_count(season)
    season.matchups.where({ :winner => id }).count
  end

end
