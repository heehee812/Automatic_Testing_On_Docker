*** Settings ***
Library    SeleniumLibrary
Library    AppiumLibrary

*** Test Cases ***
Change IP Manually
    [Tags]    SE52XX
    Sleep    1s
    Capture Element Screenshot    name.png

# *** Keywords ***