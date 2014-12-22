class AddReasonToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :reason_id, :integer
    add_column :person_registrations, :reason_id, :integer
  end
end
