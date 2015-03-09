require 'spec_helper'

feature 'create event' do

  scenario 'create a new event' do
    visit new_event_path

    fill_in "Name", with: "Jack"
    fill_in "Description", with: "Big party!"

    # Test dynamic timeslot inputs

    timeslot_fields[0].set "1:00 pm"
    timeslot_fields[1].set "2:00 pm"
    timeslot_fields[2].set "3:00 pm"
    expect(timeslot_values).to eq(["1:00 pm", "2:00 pm", "3:00 pm"])

    remove_timeslot_link_for("2:00 pm").click
    expect(timeslot_values).to eq(["1:00 pm", "3:00 pm"])

    click_link "add-timeslot"
    timeslot_fields[2].set "4:00 pm"
    expect(timeslot_values).to eq(["1:00 pm", "3:00 pm", "4:00 pm"])

    # Test dynamic attendee inputs

    attendee_fields[0].set "jack@example.com"
    attendee_fields[1].set "joe@example.com"
    attendee_fields[2].set "jim@example.com"
    expect(attendee_values).to eq([
      "jack@example.com",
      "joe@example.com",
      "jim@example.com"
    ])

    remove_attendee_link_for("joe@example.com").click
    expect(attendee_values).to eq([
      "jack@example.com",
      "jim@example.com"
    ])

    click_link "add-attendee"
    attendee_fields[2].set "jake@example.com"
    expect(attendee_values).to eq([
      "jack@example.com",
      "jim@example.com",
      "jake@example.com"
    ])

    # Create the event

    click_button "Create Event"

    expect(datetimes).to include(
      Chronic.parse("1:00 pm"),
      Chronic.parse("3:00 pm"),
      Chronic.parse("4:00 pm")
    )

    expect(email_addresses).to include(
      "jack@example.com",
      "jim@example.com",
      "jake@example.com"
    )
  end
end


# Helpers for the `new` page

def remove_timeslot_link_for(timeslot)
  links = within_fieldset("Timeslots") { all('.remove_fields') }
  index = timeslot_values.index(timeslot)
  links[index]
end

def timeslot_fields
  within_fieldset("Timeslots") { all('input[type=text]') }
end

def timeslot_values
  timeslot_fields.map(&:value)
end

def remove_attendee_link_for(attendee)
  links = within_fieldset("Attendees") { all('.remove_fields') }
  index = attendee_values.index(attendee)
  links[index]
end

def attendee_fields
  within_fieldset("Attendees") { all('input[type=text]') }
end

def attendee_values
  attendee_fields.map(&:value)
end


# Helpers for the `show` page

def datetimes
  all(".event_table td.event_datetime").map {|e| Chronic.parse(e.text) }
end

def email_addresses
  all(".avatar").map {|e| e["data-email"] }
end

