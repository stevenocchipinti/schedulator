class Vote < ActiveRecord::Base
  belongs_to :attendee
  belongs_to :timeslot
end
