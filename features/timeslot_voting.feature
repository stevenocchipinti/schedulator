Feature: Timeslot Voting
  In order for the group to decide when an event will take place
  As a user
  I want to vote on a suitable timeslot

  Background:
    Given today is "1st of January, 2013"
    And a "dinner" event with the following timeslots exists:
      | 6pm                |
      | Tomorrow at 6:30pm |
      | Friday, 7:30pm     |

  @wip @javascript
  Scenario: Vote on an event
    When I vote for the following timeslots:
      | 2013-01-01 18:00:00 |
      | 2013-01-02 18:30:00 |
    Then the "dinner" event should have the following votes:
      | Timeslot            | Votes |
      | 2013-01-01 18:00:00 | 1     |
      | 2013-01-02 18:30:00 | 1     |
      | 2013-01-04 19:30:00 | 0     |
