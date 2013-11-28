class Timeslot < ActiveRecord::Base
  belongs_to :event

  def datetime_string=(string)
    self.datetime = Chronic.parse string
  end

  def datetime_string
    self.datetime && self.datetime.strftime("%Y-%m-%d %H:%M:%S")
  end
end
