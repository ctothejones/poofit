class Season < ActiveRecord::Base
  belongs_to :league
  has_many :weeks
  has_many :matchups, :through => :weeks

  validates :start_date, presence: true


  def current
    Date.today.between?(start_date, end_date)
  end

end
