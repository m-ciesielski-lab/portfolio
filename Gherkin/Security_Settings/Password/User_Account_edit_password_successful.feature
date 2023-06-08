@Manual
# Documentation
# <Link_to_Confluence_page>

  Feature: System user is able to change password on the "User Account" page

    Scenario Outline: Successful password change by logged in user

      Given there is user who exist in the System
      And user is logged into the System
      When user want to change password
      And mandatory field "currentPassword" is provided as "<currentPassword>"
      And mandatory field "newPassword" is provided as "<newPassword>"
      And mandatory field "confirmNewPassword" is provided as "<confirmNewPassword>"
      And user sends request
      Then new password has been set
      And http status code "200" is returned
      And data are correctly saved in the user audit log as "User changed his password"
      And email with confirmation of password change was sent to user
      And user can log in the System with new password

      Examples:

        | currentPassword | newPassword          | confirmNewPassword   |
        | ._0^J8?sQ1l     | xPg'wl6Qt_h          | xPg'wl6Qt_h          |
        | tJY%)5k8X$      | #DpOV,wRV9{          | #DpOV,wRV9{          |
        | v1.nl.<^)A      | );rN^jT_Ydb35Et4P0v< | );rN^jT_Ydb35Et4P0v< |
        | O0*y@j`/5:      | UH:Dd*Fo.vc|O2|-pKJi | UH:Dd*Fo.vc|O2|-pKJi |
        | :_E7x_-`2n      | FRGg_V14GD;W4HTPTI3o | FRGg_V14GD;W4HTPTI3o |
        | B=qio272d}      | H96=DHohd;&w)'<06?cL | H96=DHohd;&w)'<06?cL |
        | Ni;*g,z3o+      | @_$-TTFm;lNMNf{26n<4 | @_$-TTFm;lNMNf{26n<4 |
        | /m;E9~WHXO      | {0qu1xT{^>           | {0qu1xT{^>           |
        | WIs4D<}s_8      | )m`F=3-anQ           | )m`F=3-anQ           |
        | f@)Tla!q74      | Ab44q/m&bsx          | Ab44q/m&bsx          |