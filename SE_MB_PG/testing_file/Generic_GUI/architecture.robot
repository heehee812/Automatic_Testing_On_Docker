*** Settings ***
Library   Browser
Library    SeleniumLibrary

*** Variables ***
${username}    admin
${password}    Aa123456
${IP Address}    http://192.168.4.104/index.html

*** Test Cases ***
Test Case 1: Open DUT Webpage
    [Documentation]    This testcase aims to check if the webpage can be opne properly.
    [Tags]    SE52XX    SE59XX
    New Context     ignoreHTTPSErrors=True    httpCredentials={'username': '$username', 'password': '$password'}
    New Page    ${IP Address}
    Sleep     3s
    Take Screenshot

Test Case 2: Check the mode of the Serial Port
    [Documentation]    This testcase aims to check if the Serial COM port display correct.
    [Tags]    SE52XX
    Print the Message    testcase2

Test Case 3: Check the page of the modbus
    [Documentation]    This testcase aims to check the page of modbus ***modebus only.
    [Tags]    MB59XX
    Print the Message    testcase3

Test Case 4: Check if TCPtest can connect to DUT
    [Documentation]    This testcase aims to check if TCP works properly on DUT
    [Tags]    SE5201B
    Print the Message    testcase4

*** Keywords ***
Print the Message
    [Arguments]    ${message}
    Log    ${message}