class AddStateToPersonRegistration < ActiveRecord::Migration
  def change
    add_column :person_registrations, :state, :string
  end
end
