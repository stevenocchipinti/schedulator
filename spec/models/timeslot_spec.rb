require 'spec_helper'

describe Timeslot do
  let(:timeslot) { Timeslot.new }

  describe "#datetime_string=" do
    subject { timeslot.datetime_string = "2nd of January, 2013" }

    it "sets the value of self.datetime by parsing natural language" do
      subject
      expect(timeslot.datetime.strftime("%d-%m-%Y")).to eq("02-01-2013")
    end
  end

  describe "#datetime_string" do
    subject { timeslot.datetime_string }

    before { timeslot.datetime_string = "2nd of January, 2013 at 12:00pm" }

    it "returns a human readable version of self.datetime" do
      expect(subject).to eq("2013-01-02 12:00 PM")
    end
  end
end
