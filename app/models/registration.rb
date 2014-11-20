class Registration < ActiveRecord::Base
   attr_accessible :name, :age, :sex, :address, :number, :phone, :email, :team_id, :is_leader, :qq ,:id_card
   belongs_to :team
end
