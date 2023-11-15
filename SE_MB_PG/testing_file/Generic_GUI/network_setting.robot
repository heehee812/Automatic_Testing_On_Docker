*** Settings ***
Library   Browser
Library    SeleniumLibrary

*** Variable ***
${username}    admin
${password}    Aa123456
${IP Address}    http://192.168.4.104/index.html
# ${title}    Network Settings

*** Test Cases ***
Check If IP Address Can Be Changed Manually
    [Documentation]    Test if the ip address of DUT can be changes Manually
    [Tags]    SE52XX
    ${old_timeout} =    Set Browser Timeout    1m 30 seconds
    Go To DUT Webpage    ${IP Address}
    Go To Subwebpage    Serial
    Go To Subwebpage    COM1
    # Change Value Of The Element
    Set Browser Timeout    ${old_timeout}

Test Case 2
    [Tags]    MB59XX
    Log    testcase2

*** Keyword ***
Go to DUT Webpage
    [Arguments]    ${IP}
    New Context     ignoreHTTPSErrors=True    httpCredentials={'username': '$username', 'password': '$password'}
    New Page    ${IP}
    Sleep     3s
    Take Screenshot

Go To Subwebpage
    [Arguments]    ${title}
    Hover    xpath=//a[contains(text(),"${title}")]
    Mouse Button    click
    Sleep     1s
    Take Screenshot

Change Value Of The Element
    Hover    xpath=//div[@id="directory"]
    Mouse Button    click
    # Page Should Contain Element    xpath=//div[@id="directory"]
    Take Screenshot

    