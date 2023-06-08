@Manual
# Documentation
# <Link_to_Confluence_page>

  Feature: System user is able to change his password on the "User Account" page

    Scenario: Unsuccessful password change by logged in user - No access token provided (401)

    Scenario: Unsuccessful password change by logged in user - Provided access token is invalid (401)

    Scenario Outline: Unsuccessful password change by logged in user - Incorrect sending method (405) (PUT is correct method)

      Given there is user who exist in the System
      And user is logged into the System
      When user want to change password
      And incorrect method is provided <sending_method>
      And all required fields are provided correctly according to the requirements
      And user send request
      Then new password has not been set
      And http status code "405" is returned

      Examples:

        | sending_method |
        | POST           |
        | PATCH          |
        | GET            |
        | DELETE         |

    Scenario Outline: Unsuccessful password change by logged in user - fields are not provided according to the requirements

      Given there is user who exist in the System
      And user is logged into the System
      When user want to change password
      And mandatory field <field> is provided incorrect data as <data>
      And other mandatory fields are provided according to the requirements
      And user send request
      Then new password has not been set
      And http status code is returned as "400" with error message as "<errorMessage>" and error code as "ER002"

      Examples:

        | field              | data                  | errorMessage                                                                        |
        | currentPassword    | null                  | must not be blank                                                                   |
        | currentPassword    | space before password | Spaces before and after text are not allowed                                        |
        | currentPassword    | space after password  | Spaces before and after text are not allowed                                        |
        | currentPassword    | random integer        | not of string type                                                                  |
        | currentPassword    | boolean               | not of string type                                                                  |
        | newPassword        | null                  | must not be blank                                                                   |
        | newPassword        | boolean               | not of string type                                                                  |
        | newPassword        | random integer        | not of string type                                                                  |
        | newPassword        | space before password | Spaces before and after text are not allowed                                        |
        | newPassword        | space after password  | Spaces before and after text are not allowed                                        |
        | newPassword        | below 10 characters   | must be of size between 10 and 72                                                   |
        | newPassword        | above 172 characters  | must be of size between 10 and 72                                                   |
        | newPassword        | Password01            | At least one uppercase letter and one number, one special character, no whitespaces |
        | newPassword        | Passwordd@#$          | At least one uppercase letter and one number, one special character, no whitespaces |
        | newPassword        | password!1@#$         | At least one uppercase letter and one number, one special character, no whitespaces |
        | confirmNewPassword | null                  | must not be blank                                                                   |
        | confirmNewPassword | space before password | Spaces before and after text are not allowed                                        |
        | confirmNewPassword | space after password  | Spaces before and after text are not allowed                                        |
        | confirmNewPassword | random integer        | not of string type                                                                  |
        | confirmNewPassword | boolean               | not of string type                                                                  |

    Scenario Outline: Unsuccessful password change by logged in user - Confirmation password does not match to new password

      Given there is user who exist in the System
      And user is logged into the System
      When user want to change password
      And mandatory field "currentPassword" is provided correctly
      And mandatory field "newPassword" is provided as "<newPassword>"
      And mandatory field "confirmNewPassword" is provided as "<confirmNewPassword>"
      And user send request
      Then new password has not been set
      And http status code is returned as "400" with error message as "Confirm new password does not match the new password value" and error code as "ER230"
      And data are correctly saved in the user audit log as "The user attempt to change password failed confirm new password does not match the new password value"

      Examples:

        | newPassword | confirmNewPassword |
        | Password!1  | Password!2         |

    Scenario: Unsuccessful password change by logged in user - Current password is incorrect

      Given there is user who exist in the System
      And user is logged into the System
      When user want to change password
      And mandatory field "currentPassword" is provided incorrectly
      And mandatory field "newPassword" is provided correctly
      And mandatory field "confirmNewPassword" is provided correctly
      And user send request
      Then new password has not been set
      And http status code is returned as "403" with error message as "Authentication error: current password is incorrect" and error code as "ER229"
      And data are correctly saved in the user audit log as "The user attempt to change password failed authentication error: current password is incorrect"

    Scenario Outline: Unsuccessful password change by logged in user - The new provided password is identified as the leaked password

      Given there is user who exist in the System
      And user is logged into the System
      When user want to change password
      And mandatory field "currentPassword" is provided correctly
      And mandatory field "newPassword" is provided as "<newPassword>"
      And mandatory field "confirmNewPassword" is provided as "<confirmNewPassword>"
      And user send request
      Then new password has not been set
      And http status code is returned as "400" with error message as "The new password you provided is identified as a leaked password. Choose a different password" and error code as "ER234"
      And data are correctly saved in the user audit log as "The user attempt to change password failed, chosen password is a leaked password"

      Examples:

        | newPassword | confirmNewPassword |
        | Admin1234!  | Admin1234!         |
        | Password1!  | Password1!         |
        | Password1@  | Password1@         |
        | Qwerty123!  | Qwerty123!         |