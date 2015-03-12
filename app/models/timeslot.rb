class Timeslot < ActiveRecord::Base
  belongs_to :event
  has_many :votes

  def datetime_string=(string)
    self.datetime = Chronic.parse string
  end

  def datetime_string
    self.datetime && self.datetime.strftime("%Y-%m-%d %l:%M %p")
  end
end
