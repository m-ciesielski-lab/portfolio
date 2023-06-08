@Manual
# Documentation
# <Link_to_Confluence_page>

  Feature: User is able to verify phone number on "User Account" page using activation token

    Scenario: Unsuccessful verification of phone number using activation token by by logged-in user - No access token provided (401)

    Scenario: Unsuccessful verification of phone number using activation token by logged-in user - Provided access token is invalid (401)

    Scenario: Unsuccessful verification of phone number using activation token by logged-in user - Incorrect sending method (405) (PUT is correct method)

    Scenario: Unsuccessful verification of phone number using activation token by logged-in user - Token doesn't match

      Given there is user who exist in the System
      And user is logged into the System
      And verification token has been generated
      And token has been sent by sms to user
      When user want to verify his phone number
      And user enters wrong 6 digit code
      And user sent request
      Then user phone is not verified
      And http status code "400" is returned with error message as "Provided verification token is not valid" and error code as "ER224"
      And data are correctly saved in the user audit log

    Scenario: Unsuccessful verification of phone number using activation token by logged-in user - Token has expired

      Given there is user who exist in the System
      And user is logged into the System
      And verification token has been generated
      And token has been sent by sms to user
      When user want to verify his phone number
      And after 5 minutes the user enters a 6-digit code
      And user sent request
      Then user phone is not verified
      And http status code "409" is returned  with error message as "Mobile phone verification token expired" and error code as "ER223"
      And data are correctly saved in the user audit log

    Scenario: Unsuccessful verification of phone number using activation token by logged-in user - Phone number is already verified

      Given there is user who exist in the System
      And user is logged into the System
      When user want to verify his phone number
      And field "mobilePhoneVerificationStatus" on user page is returned as true
      And user enters 6 digit code
      And user sent request
      Then http status code "409" is returned with error message as "Phone number is already verified" and error code as "ER225"

    Scenario: Unsuccessful verification of phone number using activation token by logged-in user - Phone country code and phone is not valid

      Given there is user who exist in the System
      And user is logged into the System
      When user want to verify his phone number
      And field "phoneCountryCode" on user page is returned as null
      And field "phone" on user page is returned as null
      And user enters 6 digit code
      And user sent request
      Then http status code "409" is returned with error message as "Phone number or phone country code is not valid" and error code as "ER226"

    Scenario: Unsuccessful verification of phone number using activation token by logged-in user - Verification token doesn't exist

      Given there is user who exist in the System
      And user is logged into the System
      And verification token has not been generated
      And token has been not sent
      When user want to verify his phone number
      And user enters random 6 digit code
      And user sent request
      Then user phone is not verified
      And http status code "404" is returned  with error message as "Mobile phone verification token does not exist" and error code as "ER228"