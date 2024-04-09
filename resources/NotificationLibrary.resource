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


*** Variables ***
${user}                   #Gmail Account being used to send the email 
${APPPASSGMAIL}           #Gmail Account App Pass being used to send the email
${sender}                 #Email Address being used as the name of the sender
${subject}               
${replyTo}                    

*** Keywords ***

Notify Email Recipients
    [Arguments]        ${suite_name}
    [Documentation]    Sends an email notification to everyone on the notify list to let them know test results

    ${suite_name_split}=     Split String    ${suite_name}    separator=.
    ${subject}=        Set Variable       Test Suite "${suite_name_split}[0]" Has Completed
    Log To Console     ${subject}

    #Cannot contain any special characters, including the "..." line continuation unless this is encoded.
    ${body}=           Set Variable       Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque ac euismod mi. Nam blandit mollis urna laoreet luctus. Vestibulum efficitur libero orci. Ut lobortis, dolor id scelerisque vulputate, eros dui tempor neque, eu posuere neque felis non erat. In aliquet augue arcu, ac tristique tellus aliquet ut. Vivamus vestibulum metus quis dui rutrum, sed blandit arcu pellentesque. Praesent bibendum fringilla.

    Send Email To Many        ${subject}                  ${body}                   ${user}              ${notify_list}         ${user}           ${APPPASSGMAIL}

Notify Email Recipients With Attached Reports
    [Documentation]    Attaches log.html, output.xml, and report.html to the email being sent to the notify list
    [Arguments]        ${suite_name}

    ${suite_name_split}=     Split String    ${suite_name}    separator=.
    ${subject}=        Set Variable       Test Suite "${suite_name_split}[0]" Has Completed
    ${body}=           Set Variable       Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque ac euismod mi. Nam blandit mollis urna laoreet luctus. Vestibulum efficitur libero orci. Ut lobortis, dolor id scelerisque vulputate, eros dui tempor neque, eu posuere neque felis non erat. In aliquet augue arcu, ac tristique tellus aliquet ut. Vivamus vestibulum metus quis dui rutrum, sed blandit arcu pellentesque. Praesent bibendum fringilla.

    #Filepath needs to be given as from the .py file
    @{files}=             Create List    ${OUTPUT_DIR}/log.html     ${OUTPUT_DIR}/report.html    ${OUTPUT_DIR}/output.xml   
    ${directory_contents}=               List Directory             ${OUTPUT_DIR}
    Log To Console                       ${directory_contents}
    Send Email Attachments To Many    
    ...                ${subject}                  
    ...                ${body}                   
    ...                ${sender}              
    ...                ${notify_list}         
    ...                ${user}           
    ...                ${APPPASSGMAIL}
    ...                ${files}