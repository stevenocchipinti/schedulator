class Event < ActiveRecord::Base
  has_many :timeslots, dependent: :destroy
  has_many :attendees, dependent: :destroy

  accepts_nested_attributes_for :timeslots,
    allow_destroy: true,
    reject_if: lambda { |t| t[:datetime_string].blank? }

  accepts_nested_attributes_for :attendees,
    allow_destroy: true,
    reject_if: lambda { |t| t[:email_address].blank? }
end
