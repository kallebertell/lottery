class CreateParticipations < ActiveRecord::Migration
  def change
    create_table :participations do |t|
      t.integer :event_id
      t.integer :user_id

      t.timestamps
    end

    add_index :participations, [:event_id, :user_id], :unique => true
  end
end
