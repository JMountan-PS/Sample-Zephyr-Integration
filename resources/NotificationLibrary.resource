*** Settings ***
Library                QForce
Library                String
Library                DateTime
Library                Collections
Library                OperatingSystem

#Required import for sending an email through gmail
Library                ../libraries/smtp.py

#Required variable import for the users to receive notifications
Variables              ../data/NotifyList.py

*** Keywords ***

Notify Email Recipients
    [Documentation]    Sends an email notification to everyone on the notify list to let them know test results
    
    ${suite_name_split}=     Split String    ${SUITE NAME}    separator=.
    ${subject}=        Convert To String      Test Suite "${suite_name_split}[0]" Has Completed
    ${body}=           Convert To String       Lorem ipsum dolor sit amet \n\n\n\n https://qentinelqi.github.io/shop/ \n\n\n\n Praesent bibendum fringilla.

    Send Email To Many        ${subject}                  ${body}                   ${user}            ${notify_list}         ${user}           ${APPPASSGMAIL}