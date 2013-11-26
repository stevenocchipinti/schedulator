json.array!(@timeslots) do |timeslot|
  json.extract! timeslot, :datetime, :event_id
  json.url timeslot_url(timeslot, format: :json)
end
