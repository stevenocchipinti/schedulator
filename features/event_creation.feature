Feature: Event Creation
  In order for the group to decide when an event will take place
  As a user
  I want to create an event

  Background:
    Given today is "1st of January, 2013"

  Scenario: Create an event using natural language
    When I create a "dinner" event with the following timeslots:
      | 6pm                |
      | Tomorrow at 6:30pm |
      | Friday, 7:30pm     |
    Then A "dinner" event should exist with the following timeslots:
      | 2013-01-01 18:00:00 |
      | 2013-01-02 18:30:00 |
      | 2013-01-04 19:30:00 |

  @javascript
  Scenario: Dynamically remove timeslots while creating an event
    When I fill in a "dinner" event with the following timeslots:
      | 6pm                |
      | Tomorrow at 6:30pm |
      | Friday, 7:30pm     |
    And I remove the "Friday, 7:30pm" timeslot
    And I create the event
    Then A "dinner" event should exist without the following timeslots:
      | 2013-01-04 19:30:00 |

  @javascript
  Scenario: Dynamically add timeslots while creating an event
    When I fill in a "dinner" event with the following timeslots:
      | 6pm                |
      | Tomorrow at 6:30pm |
      | Friday, 7:30pm     |
    And I add a new timeslot for "2 weeks from now"
    And I create the event
    Then A "dinner" event should exist with the following timeslots:
      | 2013-01-01 18:00:00 |
      | 2013-01-02 18:30:00 |
      | 2013-01-04 19:30:00 |
      | 2013-01-15 12:00:00 |