*** Settings ***
Library   Browser
Library    SeleniumLibrary
Library    BuiltIn

*** Keywords ***
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

Save And Apply
    Click    css=iframe >>> input[type="submit"]