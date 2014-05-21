class Team < ActiveRecord::Base
  belongs_to :league
  has_many :users
  has_and_belongs_to_many :matchups

  def captain
    users.find_by({ :is_captain => true })
  end
end
