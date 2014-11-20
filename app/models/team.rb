class Team < ActiveRecord::Base
  attr_accessible :number, :team_leader, :team_name
  has_many :registrations
end
