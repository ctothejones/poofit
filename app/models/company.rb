class Company < ActiveRecord::Base
  has_many :leagues
  has_many :teams
  has_many :users

  validates :name, presence: true
end
