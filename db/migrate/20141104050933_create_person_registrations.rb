class CreatePersonRegistrations < ActiveRecord::Migration
  def change
    create_table :person_registrations do |t|

      t.string :name
      t.integer :age
      t.string :sex
      t.string :id_card
      t.string :qq
      t.string :address
      t.string :number
      t.string :phone
      t.string :email
      t.integer :season ,:default => 1 #第几赛季
      
      t.belongs_to :team
      t.timestamps
    end
  end
end
