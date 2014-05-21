class Week < ActiveRecord::Base
  belongs_to :season
  has_many :matchups
  has_and_belongs_to_many :teams

  def current
    Date.today.between?(start_date, end_date)
  end
end
