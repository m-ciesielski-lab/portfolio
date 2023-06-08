@Manual
# Documentation
# <Link_to_Confluence_page>

  Feature: System user is able to view his own personal information on the "User Account" page

    Scenario: Unsuccessful display of personal information by logged-in user - No access token provided (401)

    Scenario: Unsuccessful display of personal information by logged-in user - Provided access token is invalid (401)

    Scenario Outline: Unsuccessful display of personal information by logged-in user - Incorrect sending method (405) (GET is correct method)

      Given there is user who exist in the System
      And user is logged into the System
      When user want to display his own personal information
      And incorrect method is provided <sending_method>
      And user send request
      Then response fields are not returned
      And http status code "405" is returned

      Examples:

        | sending_method |
        | POST           |
        | PATCH          |
        | PUT            |
        | DELETE         |