@Manual
# Documentation
# <Link_to_Confluence_page>

  Feature: Admin display the user personal details

    Scenario: Unsuccessful display of user personal details - No access token provided (401)

    Scenario: Unsuccessful display of user personal details - Provided access token is invalid (401)

    Scenario: Unsuccessful display of user personal details - Incorrect sending method (405) (GET is correct method)

    Scenario: Unsuccessful display of user personal details - Admin doesn't have proper permissions "PER_VIEW_USER_DETAILS" and "PER_VIEW_USER_IDENTIFIER" (403)

      Given user is registered in the system
      And admin who exists in the system has proper permission name "PER_VIEW_USER_DETAILS"
      And admin is not assigned to Operator who owns <dataID> company
      And admin is logged into the system
      When admin want to see user personal details
      And "userId" is provided
      And user <dataID> company is provided
      And admin send request
      Then user's data fields are not returned
      And http status code is "403" is returned with error message: "Requested location is forbidden" and error code is "ER003"

      Examples:

        | dataID  |
        | Qwerty  |
        | Xyz     |
        | Noname  |