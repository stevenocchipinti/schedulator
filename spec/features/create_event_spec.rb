require 'spec_helper'

feature 'create event' do

  scenario 'create a new event' do
    visit new_event_path

    expect(timeslot_fields.size).to eq(3)

    fill_in "Name", with: "Jack"
    fill_in "Description", with: "Big party!"

    timeslot_fields[0].set "1:00 pm"
    timeslot_fields[1].set "2:00 pm"
    timeslot_fields[2].set "3:00 pm"
    expect(timeslot_values).to eq(["1:00 pm", "2:00 pm", "3:00 pm"])

    remove_link_for("2:00 pm").click
    expect(timeslot_values).to eq(["1:00 pm", "3:00 pm"])

    click_link "add-timeslot"
    timeslot_fields[2].set "4:00 pm"
    expect(timeslot_values).to eq(["1:00 pm", "3:00 pm", "4:00 pm"])

    click_button "Create Event"
    ["1:00 pm", "3:00 pm", "4:00 pm"].each do |timeslot|
      expect(page).to have_content(Chronic.parse(timeslot))
    end
  end
end


def remove_link_for(timeslot)
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
