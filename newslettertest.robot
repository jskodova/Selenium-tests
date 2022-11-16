*** Settings ***
| Library | SeleniumLibrary


*** Keywords ***


*** Test Cases ***
Test newsletter
    Open Browser    https://www.verkkokauppa.com/fi/uutiskirje    googlechrome
    Maximize Browser Window
    Sleep    3s
    Page Should Contain    uutiskirje

    Click Button    id:allow-cookies

    Sleep    2s
    Click Element    xpath://html/body/div[1]/div/div/div/main/div/div/div[1]/div[3]/div[1]/div/form/div/label
    Input Text    id:email    test112@gmail.com
    Click Button    xpath://html/body/div[1]/div/div/div/main/div/div/div[1]/div[3]/div[1]/div/form/button

    Sleep    3s
    Page Should Contain    Kiitos uutiskirjeen tilaamisesta!