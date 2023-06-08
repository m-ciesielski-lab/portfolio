@Manual
# Documentation
# <Link_to_Confluence_page>

  Feature: System user is able to change his PIN code on the "User Account" page

    Scenario Outline: Successful change of PIN code by logged-in user

      Given there is user who exist in the System
      And user is logged into the System
      When user want to change PIN code
      And mandatory field "currentPassword" is provided as "<currentPassword>"
      And mandatory field "newPinCode" is provided as "<newPinCode>"
      And mandatory field "confirmNewPinCode" is provided as "<confirmNewPinCode>"
      And user sends request
      Then new PIN code has been set
      And http status code "200" is returned
      And data are correctly saved in the user audit log as "User changed his PIN code"
      And email with confirmation of PIN code change was sent to user

      Examples:

        | currentPassword | newPinCode | confirmNewPinCode |
        | ._0^J8?sQ1l     | 123456     | 123456            |
        | tJY%)5k8X$      | 010101     | 010101            |
        | v1.nl.<^)A      | 111111     | 111111            |
        | :_E7x_-`2n      | 945658     | 945658            |
        | B=qio272d}      | 000000     | 000000            |
        | Ni;*g,z3o+      | 325840     | 325840            |
        | /m;E9~WHXO      | 748932     | 748932            |
        | WIs4D<}s_8      | 987654     | 987654            |
        | f@)Tla!q74      | 014778     | 014778            |