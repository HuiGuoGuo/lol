class CreateSeasons < ActiveRecord::Migration
  def change
    create_table :seasons do |t|

      t.timestamps
      t.string :season
    end
  end
end
