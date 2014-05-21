class League < ActiveRecord::Base
  belongs_to :company
  has_many :seasons
  has_many :teams
  has_many :users
end
