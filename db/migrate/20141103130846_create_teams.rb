class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.integer :season
      t.string  :state
      t.timestamps
    end
  end
end
