Feature: Event Creation
  In order for the group to decide when an event will take place
  As a user
  I want to create an event

  Scenario: Create an event using natural language
    Given today is "1st of January, 2013"
    When I create a "dinner" event with the following timeslots:
      | 6pm |
      | Tomorrow at 6:30pm |
      | Friday, 7:30pm |
    Then A "dinner" event should exist with the following timeslots:
      | 2013-01-01 18:00:00 |
      | 2013-01-02 18:30:00 |
      | 2013-01-04 19:30:00 |
