@Manual
# Documentation
# <Link_to_Confluence_page>

  Feature: User is able to verify phone number on "User Account" page using activation token

    Scenario: Successful verification of phone number using activation token by logged-in user

      Given there is user who exist in the System
      And user is logged into the System
      And field "mobilePhoneVerificationStatus" on user page is returned as false
      And verification token has been generated
      And token has been sent by sms to user
      When user want to verify his phone number
      And user enters valid 6 digit code from received sms
      And user sent request
      Then user phone number is verified
      And http status code "200" is returned
      And field "mobilePhoneVerificationStatus" on user page is returned as true
      And data are correctly saved in the user audit log