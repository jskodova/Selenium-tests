*** Settings ***
| Library | OperatingSystem
| Library | String
| Library | Collections

*** Keywords ***

*** Test Cases ***
Read web from file
    @{time_list}    Create List
    @{web_list}    Create List
    ${path}=    Set Variable    C:/Users/Dell Latitude 7390/Downloads/webpages.txt
    Create File    C:/Users/Dell Latitude 7390/Downloads/websites.txt
    ${file_output}=    Get File    ${path}
    @{web_list}    Split String    ${file_output}
    Create File    C:/Users/Dell Latitude 7390/Downloads/weblist.txt
    Create File    C:/Users/Dell Latitude 7390/Downloads/ping.txt
    Create File    C:/Users/Dell Latitude 7390/Downloads/ip.txt
    Create File    C:/Users/Dell Latitude 7390/Downloads/avg.txt 
    Set Global Variable    @{web_list}
    Set Global Variable    @{time_list}

*** Test Cases ***
Read IPs and Avg time  
    FOR    ${index}    IN    @{web_list}
        ${website}=    Set Variable    ${index}
        ${output}=    Run And Return Rc And Output    ping ${website}
        ${pings}=    Split String    ${output}[1]
        ${index}=    Get Index From List    ${pings}    with
        ${index}=    Evaluate    ${index}-1
        ${IPAdress}=    Set Variable    ${pings}[${index}]
        Append to File    C:/Users/Dell Latitude 7390/Downloads/ping.txt    IP Address: ${IPAdress}, Average ping time: 
        Append to File    C:/Users/Dell Latitude 7390/Downloads/ip.txt    IP Address: ${IPAdress}
        ${index}=    Get Index From List    ${pings}    Average
        ${index}=    Evaluate    ${index}+2
        ${AvgTime}=    Set Variable    ${pings}[${index}]
        Append to File    C:/Users/Dell Latitude 7390/Downloads/ping.txt    ${AvgTime}\n   
        Append to File    C:/Users/Dell Latitude 7390/Downloads/avg.txt    ${AvgTime}\n   
    END   

*** Test Cases ***
Test Avg time
    ${path}=    Set Variable    C:/Users/Dell Latitude 7390/Downloads/avg.txt
    ${file_output}=    Get File    ${path}
    @{time_list}    Split String    ${file_output}

    FOR    ${index}    IN RANGE    0    3
        ${AvgTime}=    Set Variable    ${time_list}[${index}]
        ${AvgTime}=    Remove String    ${AvgTime}    ms
        ${result}=    Convert To Integer    ${AvgTime}
        Log    ${result}
        Should Be True    ${result} < 50    msg="Avg ping time is less than 50ms"
    END
        
    