*** Settings ***
| Library | SeleniumLibrary


*** Keywords ***


*** Test Cases ***
Test register
    Open Browser    https://www.verkkokauppa.com/    googlechrome
    Maximize Browser Window
    Sleep    3s
    Page Should Contain    Tuotealueet

    Click Button    id:allow-cookies
    Click Element    xpath://html/body/div[1]/div[1]/header/div/nav/div/span[1]
    
    Sleep    3s
    Click Element    xpath://html/body/div[1]/div/header/div[2]/div[3]/div[3]/div/a[2]

    Sleep    3s
    Click Element    name:email
    Input Text    name:email    test112@gmail.com
    Click Element    name:password
    Input Text    name:password    password22test
    Click Element    name:firstname
    Input Text    name:firstname    Jarmila
    Click Element    name:lastname
    Input Text    name:lastname    Skodova
    Click Element    name:phoneMobile
    Input Text    name:phoneMobile    123456789
    Click Element    xpath://html/body/div[1]/div/div/div/div/form/fieldset/div[7]/label

    Click Button    id:create-account-button

    Sleep    3s
    Page Should Contain    Tilinhallinta
    Close All Browsers
