class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.boolean :available
      t.integer :attendee_id
      t.integer :timeslot_id

      t.timestamps
    end
  end
end
