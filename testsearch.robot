*** Settings ***
| Library | SeleniumLibrary


*** Keywords ***


*** Test Cases ***
Test search
    Open Browser    https://www.verkkokauppa.com/    googlechrome
    Maximize Browser Window
    Sleep    3s
    Page Should Contain    Tuotealueet

    Click Button    id:allow-cookies

    Click Element    name:query
    Input Text    name:query    ps5
    Sleep    3s
    Click Button    name:submit

    Sleep    3s
    Click Button    id:allow-cookies
    Sleep    2s
    Capture Element Screenshot    xpath://html/body/div[1]/div/div/div/main/div/div[2]/div[1]/ol/li[1]    C:/Users/Dell Latitude 7390/Documents/GitHub/robotframework/ps5.png
    
    Click Element    xpath://html/body/div[1]/div/div/div/main/div/div[2]/div[1]/ol/li[1]
    Sleep    3s
    Page Should Contain    ps5
    Close Browser
