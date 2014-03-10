Given(/^today is "(.*?)"$/) do |datetime|
  Timecop.travel(Chronic.parse(datetime))
end

Given(/^an? "(.*?)" event with the following timeslots exists:$/) do |name, timeslots|
  # TODO: Probably should make a factory for this?
  Event.create(
    name: name,
    description: "Some description",
    timeslots: timeslots.raw.flatten.collect do |timeslot|
      Timeslot.new.tap {|t| t.datetime_string = timeslot }
    end
  )
end

When(/^I vote for the following timeslots:$/) do |table|
  # table is a Cucumber::Ast::Table
  pending # express the regexp above with the code you wish you had
end

Then(/^the "(.*?)" event should have the following votes:$/) do |arg1, table|
  # table is a Cucumber::Ast::Table
  pending # express the regexp above with the code you wish you had
end

When(/^I (fill in|create) an? "(.*?)" event with the following timeslots:$/) do |action, name, timeslots|
  visit new_event_path
  fill_in "Name", with: name
  timeslots.raw.flatten.each_with_index do |timeslot, index|
    timeslot_fields[index].set timeslot
  end
  step "I create the event" if action == "create"
end

Then(/^A "(.*?)" event should exist (with|without) the following timeslots:$/) do |name, comparison, timeslots|
  visit events_path
  click_link name
  timeslots.raw.flatten.each do |timeslot|
    if comparison == "with"
      expect(page).to have_content(timeslot)
    elsif comparison == "without"
      expect(page).not_to have_content(timeslot)
    end
  end
end

When(/^I remove the "(.*?)" timeslot$/) do |timeslot|
  remove_link_for(timeslot).click
end

When(/^I add a new timeslot for "(.*?)"$/) do |timeslot|
  click_link "add-timeslot"
  timeslot_fields.last.set timeslot
end

When(/^I create the event$/) do
  click_button "Create Event"
end


def remove_link_for(timeslot)
  links = within_fieldset("Timeslots") { all('.remove_fields') }
  index = timeslot_fields.map(&:value).index(timeslot)
  links[index]
end

def timeslot_fields
  within_fieldset("Timeslots") { all('input[type=text]') }
end
