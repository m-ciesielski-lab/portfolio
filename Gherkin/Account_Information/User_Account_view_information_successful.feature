@Manual
# Documentation
# <Link_to_Confluence_page>

  Feature: System user is able to view his own personal information on the "User Account" page

    Scenario: Successful display of personal information by logged-in user

      Given there is user who exist in the System
      And user is logged into the System
      When user want to display his own personal information
      And user send request
      Then personal information is returned
      And "id" is returned
      And "email" is returned
      And "emailVerificationStatus" is returned
      And "firstName" is returned
      And "lastName" is returned
      And "jobTitle" is returned
      And "phoneCountryCode" is returned
      And "phone" is returned
      And "mobilePhoneVerificationStatus" is returned
      And "status" is returned
      And "registrationDate" is returned
      And http status code "200" is returned