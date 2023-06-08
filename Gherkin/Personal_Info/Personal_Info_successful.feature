@Manual
# Documentation
# <Link_to_Confluence_page>

  Feature: Admin display the user personal details

    Scenario Outline: Successful display of user sensitive data - Visibility users's PESEL and ID card

      Given list of users with PESEL and ID card exists in the database
      And admin is logged in the system
      And admin has permission <permission1> and <permission2>
      When admin is going to display user PESEL and ID card
      And user_id is provided
      And request is sent
      Then user's data is returned
      And admin can see the <visibility> "pesel" and "IdentificationCard" values
      And http status code <httpStatusCode> is returned with <errorMessage> error message and with <errorCode>

      Examples:

        | permission1           | permission2              | visibility | httpStatusCode | errorMessage  | errorCode |
        | PER_VIEW_USER_DETAILS | PER_VIEW_USER_IDENTIFIER | full       | 200            | none          | none      |
        | PER_VIEW_USER_DETAILS |                          | partial    | 200            | none          | none      |
        |                       | PER_VIEW_USER_IDENTIFIER | none       | 403            | Access denied | ERR003    |
        |                       |                          | none       | 403            | Access denied | ERR003    |