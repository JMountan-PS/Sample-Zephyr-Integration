*** Settings ***
Resource    ../resources/NotificationLibrary.resource

*** Tasks ***
Send Emails with Attachments To stakeholders
    Notify Email Recipients With Attached Reports    ${SUITE NAME}