@Manual
# Documentation
# <Link_to_Confluence_page>

  Feature: System user is able to change his PIN code on the "User Account" page

    Scenario: Unsuccessful change of PIN code by logged-in user - No access token provided (401)

    Scenario: Unsuccessful change of PIN code by logged-in user - Provided access token is invalid (401)

    Scenario: Unsuccessful change of PIN code by logged-in user - Incorrect sending method (405) (PUT is correct method)

    Scenario Outline: Unsuccessful change of PIN code by logged-in user - fields are not provided according to the requirements

      Given there is user who exist in the System
      And user is logged into the System
      When user want to change PIN code
      And mandatory field <field> is provided incorrect data as <data>
      And all rest mandatory fields are provided according to the requirements
      And user send request
      Then new PIN code has not been set
      And http status code is returned as "400" with error message as "<errorMessage>" and error code as "ER002"

      Examples:

        | field             | data                  | errorMessage                                                 |
        | currentPassword   | null                  | must not be blank                                            |
        | currentPassword   | space before password | Spaces before and after text are not allowed                 |
        | currentPassword   | space after password  | Spaces before and after text are not allowed                 |
        | currentPassword   | random integer        | not of string type                                           |
        | currentPassword   | boolean               | not of string type                                           |
        | newPinCode        | empty string          | must not be blank                                            |
        | newPinCode        | below 6 digit         | size must be minimum 6 digits                                |
        | newPinCode        | above 6 digit         | numeric value out of bounds (<6 digits>.<0 digits> expected) |
        | newPinCode        | null                  | must not be blank                                            |
        | newPinCode        | random integer        | not of string type                                           |
        | newPinCode        | boolean               | not of string type                                           |
        | confirmNewPinCode | empty string          | must not be blank                                            |
        | confirmNewPinCode | null                  | must not be blank                                            |
        | confirmNewPinCode | random integer        | not of string type                                           |
        | confirmNewPinCode | boolean               | not of string type                                           |

    Scenario Outline: Unsuccessful change of PIN code by logged-in user - Confirmation PIN code does not match to new PIN code

      Given there is user who exist in the System
      And user is logged into the System
      When user want to change PIN code
      And mandatory field "currentPassword" is provided correctly
      And mandatory field "newPinCode" is provided as "<newPinCode>"
      And mandatory field "confirmNewPinCode" is provided as "<confirmNewPinCode>"
      And user send request
      Then new PIN code has not been set
      And http status code is returned as "400" with error message as "Confirm new PIN code does not match the new PIN code value" and error code as "ER231"
      And data are correctly saved in the user audit log as "The user attempt to change PIN code failed: confirm new PIN code does not match the new PIN code value"

      Examples:

        | newPinCode | confirmNewPinCode |
        | 123456     | 789012            |

    Scenario: Unsuccessful change of PIN code by logged-in user - Current password is incorrect

      Given there is user who exist in the System
      And user is logged into the System
      When user want to change PIN code
      And mandatory field "currentPassword" is provided incorrectly
      And mandatory field "newPinCode" is provided correctly
      And mandatory field "confirmNewPinCode" is provided correctly
      And user send request
      Then new PIN code has not been set
      And http status code is returned as "403" with error message as "Authentication error: current password is incorrect" and error code as "ER229"
      And data are correctly saved in the user audit log as "The user attempt to change PIN code failed authentication error: current password is incorrect"