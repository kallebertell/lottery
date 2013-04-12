class AddBoolsToParticipations < ActiveRecord::Migration
  def change
    add_column :participations, :won, :boolean,  :default => false
    add_column :participations, :confirmed, :boolean,  :default => false
  end
end
