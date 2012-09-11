Feature: rake license:action_items:ok
  As a user
  I want a rake task "license:action_items:ok" that returns 0/1 exit codes based on whether or not there any action items
  So that I can create a CI build that fails if there are any action items

  Background:
    Given I have a rails application with license finder

  Scenario: Application with action items
    Given my rails app depends on a gem "gpl_licensed_gem" licensed with "GPL"
    And I whitelist the "MIT" license
    When I run "rake license:action_items:ok"
    Then it should exit with status code 1

  Scenario: Application with no action items
    Given I whitelist the following licenses: "MIT, ruby, other"
    When I run "rake license:action_items:ok"
    Then I should see "All gems are approved for use" in its output
    And it should exit with status code 0

  Scenario: Deprecation for version 1.0
    When I run "rake license:action_items:ok"
    Then I should see "rake license:action_items:ok is deprecated and will be removed in version 1.0.  Use rake license:action_items instead." in its output
