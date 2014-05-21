class Season < ActiveRecord::Base
  belongs_to :league
  has_many :weeks
  has_many :matchups


  def current
    Date.today.between?(start_date, end_date)
  end

end
