class CreateTimeslots < ActiveRecord::Migration
  def change
    create_table :timeslots do |t|
      t.datetime :datetime
      t.integer :event_id

      t.timestamps
    end
  end
end
