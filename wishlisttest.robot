*** Settings ***
| Library | SeleniumLibrary


*** Keywords ***


*** Test Cases ***
Test wishlist
    Open Browser    https://www.verkkokauppa.com/    googlechrome
    Maximize Browser Window
    Sleep    3s
    Page Should Contain    Tuotealueet

    Click Button    id:allow-cookies

    Click Element    xpath://html/body/div[1]/div/header/div[1]/nav/div/span[1]
    Sleep    2s
    Click Element    name:email
    Input Text    name:email    test112@gmail.com
    Click Element    name:password
    Input Text    name:password    password22test
    Click Button    id:login-button-modal


    Click Element    xpath://html/body/div[1]/div/header/div/label
    Sleep    2s
    Click Element    xpath://html/body/div[1]/div/div/aside/nav/div/div[2]/ul/li[4]
    
    Sleep    3s
    Click Button    xpath://html/body/div[1]/div/div/div/main/div[5]/div[2]/div/ol/li[1]/article/div/div[2]/button

    Sleep    3s
    Page Should Contain    Tuote lisättiin suosikkeihin

    Close All Browsers
