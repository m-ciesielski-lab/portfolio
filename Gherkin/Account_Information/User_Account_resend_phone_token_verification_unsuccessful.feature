@Manual
# Documentation
# <Link_to_Confluence_page>

  Feature: User is able to resend sms activation token on "User Account" page

    Scenario: Unsuccessful resending sms with activation token by logged-in user - No access token provided (401)

    Scenario: Unsuccessful resending sms with activation token by logged-in user - Provided access token is invalid (401)

    Scenario: Unsuccessful resending sms with activation token by logged-in user - Incorrect sending method (405) (POST is correct method)

    Scenario: Unsuccessful resending sms with activation token by logged-in user - Phone country code and phone is not valid (409)

      Given there is user who exist in the System
      And user is logged into the System
      And field "phoneCountryCode" on user page is returned as null
      And field "phone" on user page is returned as null
      When user want to resend verification token to phone number
      And user sent request
      Then verification token has not been generated
      And 6 digit code has not been sent by sms to valid  user phone number
      And http status code "409" is returned  with error message as "Phone number or phone country code is not valid" and error code as "ER226"

    Scenario: Unsuccessful resending sms with activation token by logged-in user - Phone number is already verified (409)

      Given there is user who exist in the System
      And  user is logged into the  System
      And field "mobilePhoneVerificationStatus" on user page is returned as true
      When user want to resend verification token to phone number
      And user sent request
      Then verification token has not been generated
      And 6 digit code has not been sent by sms to valid user phone number
      And http status code "409" is returned  with error message as "Phone number is already verified" and error code as "ER225"