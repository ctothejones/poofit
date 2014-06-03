class Week < ActiveRecord::Base
  belongs_to :season
  has_many :matchups

  def current
    Date.today.between?(start_date, end_date)
  end
end
