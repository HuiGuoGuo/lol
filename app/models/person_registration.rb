class PersonRegistration < ActiveRecord::Base
  attr_accessible :name, :age, :sex, :address, :number, :phone, :email, :team_id, :qq ,:id_card, :state
  GOOD={'a'=>'a','b'=>'b'}

  belongs_to :season
end
