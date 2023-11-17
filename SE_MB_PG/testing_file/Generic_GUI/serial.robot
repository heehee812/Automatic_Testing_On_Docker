*** Settings ***
Library   Browser
Library    SeleniumLibrary
Library    BuiltIn

*** Variable ***
${USERNAME}    admin
${PASSWORD}    Aa123456
${IP_ADDRESS}    http://192.168.4.106/index.html

*** Test Cases ***
Check If Application Mode Can Be Chnaged Porperly
    [Documentation]    Test if the applicationmode can be changed properly.
    [Tags]    Network_Settings
    &{web_path}=    Create Dictionary    ip=${IP_ADDRESS}    title=Serial    subtitle=COM1
    Go To ATOP Webpage    ${web_path}
    Select Link Mode    TCP Server
    &{tcp_config}=    Create Dictionary    app_mode=Virtual COM    port=4661    mac_con=4   behavior=Transparent Mode
    Configure TCP Server    ${tcp_config}
    # &{serial_config}=    Create Dictionary    app_mode=Virtual COM    port=4661    mac_con=4   behavior=Transparent Mode
    # Configure TCP Server    ${tcp_config}
    Take Screenshot
    # Save And Apply
    
*** Keyword ***
Go To ATOP Webpage
    [Arguments]    ${web_path}
    Go To DUT Webpage    ${web_path.ip}
    Go To Subwebpage    ${web_path.title}
    Go To Subwebpage    ${web_path.subtitle}

Go to DUT Webpage
    [Arguments]    ${IP}
    ${old_timeout} =    Set Browser Timeout    1m
    New Context     ignoreHTTPSErrors=True    httpCredentials={'username': '$USERNAME', 'password': '$PASSWORD'}
    New Page    ${IP}
    Sleep     3s
    Set Browser Timeout    ${old_timeout}

Go To Subwebpage
    [Arguments]    ${title}
    Click    xpath=//a[contains(text(),"${title}")]
    Sleep     1s

Configure TCP Server
    [Arguments]    ${tcp_config}
    Select The Application    Virtual COM
    Select The Port Number    4661
    Select The Max Connection    4
    Select The Response Behavior     Transparent Mode

Select Link Mode
    [Arguments]    ${link_mode}
    ${value}    Set Variable If    '${link_mode}'=='TCP Server'    0
    ...    '${link_mode}'=='TCP Client'    1
    ...    '${link_mode}'=='UDP'    2
    Click    css=iframe >>> //input[@name="radLinkMode" and @value=${value}]

Select The Application
    [Arguments]    ${app_mode}
    Select Options By    css=iframe >>> select[name="selApplication"]    text    ${app_mode}

Select The Port Number
    [Arguments]    ${port_number}
    Type Text    css=iframe >>> input[id="txtLocalPort"]    ${port_number}

Select The Max Connection
    [Arguments]    ${number}
    Select Options By    css=iframe >>> select[name="selMaxConn"]    value    ${number}

Select The Response Behavior
    [Arguments]    ${behavior}
    ${id}    Set Variable If    '${behavior}'=='Transparent Mode'    radServerResponseMode1
    ...    '${behavior}'=='Request & Response Mode'    radServerResponseMode0
    ...    '${behavior}'=='Reply to request only'    radServerReqResMode0
    ...    '${behavior}'=='Reply to all'    radServerReqResMode1
    Click    css=iframe >>> input[id="${id}"]

Save And Apply
    Click    css=iframe >>> input[type="submit"]

Check If The Element State Correct
    [Arguments]    ${element}    ${state}
    Get Checkbox State    ${element}    ==    ${state}


    