class Team < ActiveRecord::Base
  attr_accessible :number, :team_leader, :name
  has_many :registrations
end
