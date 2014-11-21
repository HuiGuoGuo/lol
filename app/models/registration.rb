class Registration < ActiveRecord::Base
   attr_accessible :name, :age, :sex, :address, :number, :phone, :email, :team_id, :is_leader, :qq ,:id_card
   belongs_to :team
   scope  :leader, ->{where(is_leader: '1')}
end
