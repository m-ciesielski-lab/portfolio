@Manual
# Documentation
# <Link_to_Confluence_page>

  Feature: User is able to edit his own personal information on the "User Account" page

    Scenario Outline: Successful editing of personal information by logged-in user

      Given there is user who exist in the System
      And user is logged into the System
      When user want to edit his own personal information
      And mandatory field "firstName" is set as <OldFirstName>
      And mandatory field "lastName" is set as <OldLastName>
      And mandatory field "email" has the same value as previous
      And optional field "phoneCountryCode" is set as <OldPhoneCountryCode>
      And optional field "phone" is set as <OldPhone>
      And user send request
      Then user personal information is updated
      And http status code "200" is returned
      And "id" is returned
      And "email" is returned
      And "emailVerificationStatus" is returned
      And "firstName" is returned as <NewFirstName>
      And "lastName" is returned as <NewLastName>
      And "jobTitle" is returned
      And "phoneCountryCode" is returned as <NewPhoneCountryCode>
      And "phone" is returned as <NewPhone>
      And "mobilePhoneVerificationStatus" is returned
      And "status" is returned
      And "registrationDate" is returned
      And data are correctly saved in the user audit log

      Examples:

        | OldFirstName             | OldLastName              | OldPhoneCountryCode    | OldPhone                | NewFirstName             | NewLastName              | NewPhoneCountryCode    | NewPhone                |
        | Bruce                    | Wallbrook                | null                   | null                    | Alexander                | Peatheyjohns             | 12345-6                | 9998877                 |
        | Belinda                  | Cowherd                  | 1                      | 9998877                 | Beverley                 | Klausewitz               | null                   | null                    |
        | Martin                   | Offield                  | 1                      | 123                     | Kayla                    | Disdel                   | null                   | null                    |
        | Alina                    | Duxbarry                 | 1234567                | 1234                    | Bard                     | Davidof                  | null                   | null                    |
        | Elian                    | Grisbrook                | 1-23456                | 12345                   | Cody                     | Keenleyside              | 1-23456                | 123456                  |
        | Naomi                    | Kilday                   | 12-3456                | 123456                  | Matty                    | Mc Comb                  | null                   | null                    |
        | Harold                   | Houchen                  | 123-456                | 1234567                 | Shayne                   | Van der Kruijs           | 1                      | 1020304059              |
        | between 2-254 characters | between 2-254 characters | between 1-7 characters | between 3-12 characters | between 2-254 characters | between 2-254 characters | between 1-7 characters | between 3-12 characters |

    Scenario Outline: Successful editing of personal information by logged-in user - Procedure for changing email address on the My Account page

      Given there is user who exist in the System
      And user is logged into the System
      And personal data for user field "email" is set as <OldEmail>
      And personal data for for user field "status" is set as <OldStatus>
      And personal data for for user field "emailVerificationStatus" is set as <OldEmailVerificationStatus>
      When user want to edit his own personal information
      And mandatory field "email" is set as new <NewEmail>
      And all required fields are provided correctly according to the requirements
      And user send request
      Then user personal information is updated
      And http status code "200" is returned
      And new email verification token in UUID format is sent to new email
      And user is kick out from the system
      And "id" is returned
      And "email" is returned as <NewEmail>
      And "emailVerificationStatus" is returned as <NewEmailVerificationStatus>
      And "firstName" is returned
      And "lastName" is returned
      And "jobTitle" is returned
      And "phoneCountryCode" is returned
      And "phone" is returned
      And "mobilePhoneVerificationStatus" is returned
      And "status" is returned as <NewStatus>
      And "registrationDate" is returned
      And data are correctly saved in the user audit log

      Examples:

        | OldEmail        | OldStatus | OldEmailVerificationStatus | NewEmail        | NewEmailVerificationStatus | NewStatus                  |
        | user_1@name.com | ACTIVE    | true                       | user_2@name.com | false                      | PENDING_EMAIL_VERIFICATION |
        | user_2@name.com | ACTIVE    | true                       | user_3@name.com | false                      | PENDING_EMAIL_VERIFICATION |
        | user_4@name.com | ACTIVE    | true                       | user_5@name.com | false                      | PENDING_EMAIL_VERIFICATION |

    Scenario Outline: Successful editing of personal information by logged-in user - Procedure for changing phone number on the My Account page

      Given there is user who exist in the System
      And user is logged into the System
      And personal data for user field "phoneCountryCode" is set as <OldPhoneCountryCode>
      And personal data for user field "phone" is set as <OldPhone>
      And personal data for for user field "mobilePhoneVerificationStatus" is set as <OldPhoneVerificationStatus>
      When user want to edit his own personal information
      And field "phoneCountryCode" is set as new <NewPhoneCountryCode>
      And field "phone" is set as new <NewPhone>
      And all required fields are provided correctly according to the requirements
      And user send request
      Then user personal information is updated
      And http status code "200" is returned
      And user receives an sms message with a 6-digit activation token code
      And "id" is returned
      And "email" is returned
      And "emailVerificationStatus" is returned
      And "firstName" is returned
      And "lastName" is returned
      And "jobTitle" is returned
      And "phoneCountryCode" is returned as <NewPhoneCountryCode>
      And "phone" is returned as <NewPhone>
      And "mobilePhoneVerificationStatus" as <NewPhoneVerificationStatus>
      And "status" is returned
      And "registrationDate" is returned
      And data are correctly saved in the user audit log

      Examples:

        | OldPhoneCountryCode | OldPhone    | OldPhoneVerificationStatus | NewPhoneCountryCode | NewPhone   | NewPhoneVerificationStatus |
        | 1-242               | 12267414450 | true                       | 2-342               | 2267414452 | false                      |
        | 229                 | 86213318    | false                      | 129                 | 86213307   | false                      |
        | 1                   | 732121274   | true                       | 2                   | 732121245  | false                      |