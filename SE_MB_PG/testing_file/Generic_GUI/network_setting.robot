*** Settings ***
Library   Browser
Library    SeleniumLibrary

*** Variable ***
${username}    admin
${password}    Aa123456
${DHCP_IP Address}    http://192.168.4.104/index.html
${Manual_IP Address}    http://10.0.50.41/index.html

*** Test Cases ***
Check If DHCP Can Be Enable Properly
    [Documentation]    Test if DHCP of the DUT can be eable properly.
    [Tags]    Network_Settings
    Go To DUT Webpage    ${Manual_IP Address}
    Go To Subwebpage    Network Settings
    Go To Subwebpage    IPv4 Settings
    Enable Or Disble DHCP
    Take Screenshot
    Save And Apply
    Go To DUT Webpage    ${DHCP_IP Address}
    Go To Subwebpage    Network Settings
    Go To Subwebpage    IPv4 Settings
    Check If The Element State Correct    css=iframe >>> input[name="chkDHCP0"]    checked

Check If DHCP Can Be Disable Properly
    [Documentation]    Test if DHCP of the DUT can be disable properly.
    [Tags]    Network_Settings
    Go To DUT Webpage    ${DHCP_IP Address}
    Go To Subwebpage    Network Settings
    Go To Subwebpage    IPv4 Settings
    Enable Or Disble DHCP
    Change IP Manaully    10.0.50.41
    Change Subnet Manaully    255.255.0.0
    Change Gateway Manaully    10.0.50.254
    Take Screenshot
    Save And Apply
    Go To DUT Webpage    ${Manual_IP Address}
    Go To Subwebpage    Network Settings
    Go To Subwebpage    IPv4 Settings
    Check If The Element State Correct    css=iframe >>> input[name="chkDHCP0"]    unchecked

*** Keyword ***
Go to DUT Webpage
    [Arguments]    ${IP}
    ${old_timeout} =    Set Browser Timeout    1m
    New Context     ignoreHTTPSErrors=True    httpCredentials={'username': '$username', 'password': '$password'}
    New Page    ${IP}
    Sleep     3s
    Set Browser Timeout    ${old_timeout}
    Take Screenshot

Go To Subwebpage
    [Arguments]    ${title}
    Hover    xpath=//a[contains(text(),"${title}")]
    Mouse Button    click
    Sleep     1s
    Take Screenshot

Enable Or Disble DHCP
    Take Screenshot
    Hover    css=iframe >>> input[name="chkDHCP0"]
    Mouse Button    click

Change IP Manaully
    [Arguments]    ${IP}
    Type Text    css=iframe >>> input[name="txtIP0"]    ${IP}

Change Subnet Manaully
    [Arguments]    ${Subnet}
    Type Text    css=iframe >>> input[name="txtSubnet0"]    ${Subnet}

Change Gateway Manaully
    [Arguments]    ${Gateway}
    Type Text    css=iframe >>> input[name="txtGateway0"]    ${Gateway}

Save And Apply
    Hover    css=iframe >>> input[type="submit"]
    Mouse Button    click

Check If The Element State Correct
    [Arguments]    ${element}    ${state}
    Get Checkbox State    ${element}    ==    ${state}


    