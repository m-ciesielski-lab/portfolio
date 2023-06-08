@Manual
# Documentation
# <Link_to_Confluence_page>

  Feature: User is able to edit his own personal information on the "User Account" page

    Scenario: Unsuccessful editing of personal information by logged-in user - No access token provided (401)

    Scenario: Unsuccessful editing of personal information by logged-in user - Provided access token is invalid (401)

    Scenario Outline: Unsuccessful editing of personal information by logged-in user - fields are not provided according to the requirements

      Given there is user who exist in the System
      And  user is logged into the System
      When user want to edit his own personal information
      And field <field> is set incorrectly - <data> - <reason>
      And other fields are provided according to the requirements
      Then user data is not updated
      And http status code "400" is returned

      Examples:

        | field            | data            | reason                           |
        | firstName        | ""              | size must be between 2 and 254   |
        | firstName        | null            | must not be null                 |
        | firstName        | not a string    | not of string type               |
        | lastName         | ""              | size must be between 2 and 254   |
        | lastName         | null            | must not be null                 |
        | lastName         | not a string    | not of string type               |
        | phoneCountryCode | not a string    | not of string type               |
        | phoneCountryCode | "abc"           | Only numbers and '-' are allowed |
        | phoneCountryCode | ""              | Size must be between 1 and 7     |
        | phoneCountryCode | "12345678"      | Size must be between 1 and 7     |
        | phone            | not a string    | not of string type               |
        | phone            | "abc"           | Only numbers are allowed         |
        | phone            | ""              | Size must be between 3 and 12    |
        | phone            | "1234567890123" | Size must be between 3 and 12    |
        | email            | email@email.pl1 | Email must be a valid email      |
        | email            | email#email.pl  | Email must be a valid email      |
        | email            | @mail.com       | Email must be a valid email      |

    Scenario:  Unsuccessful editing of personal information by logged-in user - Phone number and country code combination must be unique per user in the system (409)

      Given there is  user who exist in the System
      And  user is logged into the System
      When  user want to edit his own personal information
      And combination fields "phoneCountryCode" and "phone" has the same values as existing  user
      And other fields are provided according to the requirements
      Then  user data is not updated
      And http status code is returned as "409" with error message as "Phone number and country code combination must be unique" and error code as "ER213"

    Scenario Outline:  Unsuccessful editing of personal information by logged-in user - Phone number and country code combination must either th be empty or th contain value

      Given there is  user who exist in the System
      And  user is logged into the System
      When  user want to edit his own personal information
      And field "phone" is provided as <phone>
      And field "phoneCountryCode" is provided as <phoneCountryCode>
      And other fields are provided according to the requirements
      And user sends the request
      Then  user data is not updated
      And http status code is returned as "400" with error message: "<errorMessage>" and error code as "ER002"

      Examples:

        | phone       | phoneCountryCode | errorMessage                                           |
        | null        | 48               | phone must not be null if phoneCountryCode is not null |
        | 84826541822 | mull             | phoneCountryCode must not be null if phone is not null |

    Scenario Outline: Unsuccessful editing of personal information by logged-in user - Incorrect sending method (405) (PUT is correct method)

      Given there is  user who exist in the System
      And  user is logged into the System
      When  user want to edit his own personal information
      And incorrect method is provided <sending_method>
      And all required fields are provided correctly according to the requirements
      And  user send request
      Then response fields are not returned
      And http status code "405" is returned

      Examples:

        | sending_method |
        | POST           |
        | PATCH          |
        | GET            |
        | DELETE         |