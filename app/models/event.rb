class Event < ActiveRecord::Base
  has_many :timeslots, dependent: :destroy
  accepts_nested_attributes_for :timeslots
end
