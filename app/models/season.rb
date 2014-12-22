#encoding:utf-8
class Season < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :season
  # 赛季
  #
  #
  has_many :teams
  has_many :person_registrations
  def code

    if Season.last.present?
      id =  Season.last.id.to_i + 1
      return "赛季#{id}"
    else
      return "赛季1"
    end
  end 

end
