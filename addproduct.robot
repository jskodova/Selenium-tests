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
    Input Text    name:query    koiranruoka
    Sleep    3s
    Click Button    name:submit

    Sleep    5s
    Page Should Contain    Lisää ostoskoriin
    
    Click Button    xpath:/html/body/div[1]/div[1]/div/div/main/div/div[2]/div/ol/li/article/div/div[1]/div/div[2]/div/button
    Sleep    3s
    Page Should Contain    Siirry kassalle
    Click Element    id:checkout
    Page Should Contain    1 tuote, yhteensä


    

    ${getDate}    Get Text    xpath://html/body/div[2]/div/table/tbody/tr[7]/td[2]
    ${date}    Set Variable    ${getDate}
    ${date}    Get Substring    0    21
    Should Be Equal    ${date}    Sun, 09 Oct 2022 20:34
    Close Browser