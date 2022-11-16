*** Settings ***
| Library | SeleniumLibrary
| Library | String



*** Keywords ***


*** Test Cases ***
Test adding product
    Open Browser    https://www.verkkokauppa.com/    googlechrome
    Maximize Browser Window
    Sleep    3s
    Page Should Contain    Tuotealueet

    Click Button    id:allow-cookies

    Click Element    name:query
    Input Text    name:query    kamera
    Sleep    3s
    Click Button    name:submit

    Sleep    5s
    Page Should Contain    Lisää ostoskoriin
    
    Click Element    xpath://html/body/div[1]/div/div/div/main/div/div[1]/div[1]/div/span/div/button[2]
    Sleep    3s
    Click Element    xpath://html/body/div[1]/div/div/div/main/div/div[1]/div[1]/div/div/div[4]/div/div/div/div[3]/section/ol[1]/li[1]/label
    Click Button    xpath://html/body/div[1]/div/div/div/main/div/div[1]/div[1]/div/div[2]/div[4]/div/div/footer/button[2]
    Sleep    3s
    Page Should Contain    Adobe Creative Cloud


    

    ${getDate}    Get Text    xpath://html/body/div[2]/div/table/tbody/tr[7]/td[2]
    ${date}    Set Variable    ${getDate}
    ${date}    Get Substring    0    21
    Should Be Equal    ${date}    Sun, 09 Oct 2022 20:34
    Close Browser