@Manual
# Documentation
# <Link_to_Confluence_page>

  Feature: User is able to resend sms activation token on "User Account" page

    Scenario: Successful resending sms with activation token by logged-in user

      Given there is user who exist in the System
      And user is logged into the System
      And field "phoneCountryCode" on  user page  has valid data
      And field "phone" on user page has valid data
      When user want to resend verification token to phone number
      And user sent request
      Then verification token has been generated
      And 6 digit code has been sent by sms to valid  user phone number
      And http status code "200" is returned