class Event < ActiveRecord::Base
  has_many :timeslots, dependent: :destroy

  accepts_nested_attributes_for :timeslots,
    allow_destroy: true,
    reject_if: lambda { |t| t[:datetime_string].blank? }
end
