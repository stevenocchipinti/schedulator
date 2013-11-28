Given(/^today is "(.*?)"$/) do |datetime|
  Timecop.freeze(Chronic.parse(datetime))
end

When(/^I create an? "(.*?)" event with the following timeslots:$/) do |name, timeslots|
  visit new_event_path
  fill_in "Name", with: name
  timeslots.raw.flatten.each_with_index do |timeslot, index|
    fill_in "Timeslot ##{index+1}", with: timeslot
  end
  click_button "Create Event"
end

Then(/^A "(.*?)" event should exist with the following timeslots:$/) do |name, timeslots|
  visit events_path
  click_link name
  timeslots.raw.flatten.each do |timeslot|
    expect(page).to have_content(timeslot)
  end
end
