*** Settings ***
Library   Browser
Library    SeleniumLibrary
Library    BuiltIn
Suite Setup    Go to The Serial Page

*** Variable ***
${USERNAME}    admin
${PASSWORD}    Aa123456
${IP_ADDRESS}    http://192.168.4.106/index.html

*** Test Cases ***
Check If Application Mode Can Be Changed To The TCP Server Porperly
    [Documentation]    Test if the application mode can be changed properly.
    [Tags]    Serial
    Select Link Mode    TCP Server
    &{tcp_config}=    Create Dictionary    app_mode=RAW    port=4660    max_con=4   behavior=Transparent Mode
    Configure TCP Server    ${tcp_config}
    Take Screenshot
    Save And Apply

Check If Sereial Setting Can Be Changed Properly
    [Documentation]    Tewt if the serial setting can be changed properly
    [Tags]    Serial
    &{serial_config}=    Create Dictionary    serial_interface=RS485    baud_rate=1200    parity=None   data_bit=8    stop_bit=1    flow_control=None
    Configure Serial Settings    ${serial_config}
    Take Screenshot
    Save And Apply

*** Keyword ***
Go to The Serial Page 
    &{web_path}=    Create Dictionary    ip=${IP_ADDRESS}    title=Serial    subtitle=COM1
    Go To ATOP Webpage    ${web_path}

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
    Select The Application    ${tcp_config.app_mode}
    Select The Port Number    ${tcp_config.port}
    Select The Max Connection    ${tcp_config.max_con}
    Select The Response Behavior     ${tcp_config.behavior}

Configure Serial Settings
    [Arguments]    ${serial_config}
    Select The Serial Interface    ${serial_config.serial_interface}
    Select The Baud Rate    ${serial_config.baud_rate}
    Select The Parity    ${serial_config.parity}
    Select The Data Bit     ${serial_config.data_bit}
    Select The Stop Bit     ${serial_config.stop_bit}
    Select The Flow Control     ${serial_config.flow_control}

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
Select The Serial Interface
    [Arguments]    ${serial_interface}
    ${value}    Set Variable If    '${serial_interface}'=='RS232'    0
    ...    '${serial_interface}'=='RS422'    1
    ...    '${serial_interface}'=='RS485'    2
    Click    css=iframe >>> //input[@name="radSerialMode" and @value=${value}]

Select The Baud Rate
    [Arguments]    ${baud_rate}
    Select Options By    css=iframe >>> select[name="selBaudRate"]    value    ${baud_rate}

Select The Parity
    [Arguments]    ${parity}
    ${value}    Set Variable If    '${parity}'=='None'    0
    ...    '${parity}'=='Odd'    1
    ...    '${parity}'=='Even'    2
    ...    '${parity}'=='Mark'    3
    ...    '${parity}'=='Space'    4
    Click    css=iframe >>> //input[@name="radSerialParity" and @value=${value}]

Select The Data Bit
    [Arguments]    ${data_bit}
    Click    css=iframe >>> //input[@name="radSerialDataBit" and @value=${data_bit}]

Select The Stop Bit
    [Arguments]    ${stop_bit}
    Click    css=iframe >>> //input[@name="radSerialStopBit" and @value=${stop_bit}]

Select The Flow Control
    [Arguments]    ${flow_control}
    ${value}    Set Variable If    '${flow_control}'=='None'    0
    ...    '${flow_control}'=='Xon/Xoff'    1
    ...    '${flow_control}'=='RTS/CTS'    2
    Click    css=iframe >>> //input[@name="radSerialFlowCtrl" and @value=${value}]

Save And Apply
    Click    css=iframe >>> input[type="submit"]

Check If The Element State Correct
    [Arguments]    ${element}    ${state}
    Get Checkbox State    ${element}    ==    ${state}