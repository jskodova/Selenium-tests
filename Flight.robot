/ Jarmila Škodová

*** Settings ***
| Library | SeleniumLibrary
| Library | Collections
| Library | OperatingSystem
| Library | String

Suite Setup     Open browser    ${URL}   ${BROWSER}

*** Variables ***
${URL}          http://blazedemo.com/
${BROWSER}      Chrome
${from}    Departs: Boston
${to}    Arrives: Cairo

*** Test Cases ***
Page Contains Welcome Text
    Maximize Browser Window
    Sleep    3s
    Page Should Contain    Welcome to the Simple Travel Agency!


*** Test Cases ***
Selecting a flight from Boston to Cairo and Submitting
    Select From List By Value   xpath://select[@name='fromPort']  Boston
    Select From List by Value   xpath://select[@name='toPort']    Cairo

    Page Should Contain Button    css:input[type='submit']
    Element Should Be Enabled    css:input[type='submit']
    Click Button    css:input[type='submit']

*** Test Cases ***
Checking if flights are correct    
    @{flights}=    Get WebElements    css:table[class='table']>tbody tr
    Page Should Contain    ${from}
    Page Should Contain    ${to}

*** Test Cases ***
Selecting if a flight option is available and setting the variables
    Page Should Contain Button   xpath://html/body/div[2]/table/tbody/tr[2]/td[1]/input

    ${selectFlightNum}=    Get Text    xpath://html/body/div[2]/table/tbody/tr[1]/td[2]  
    ${flightNum}    Set Variable    ${selectFlightNum}
    Set Global Variable    ${flightNum}

    ${selectFlightAir}=    Get Text    xpath://html/body/div[2]/table/tbody/tr[1]/td[3]
    ${airline}    Set Variable    ${selectFlightAir}
    Set Global Variable    ${airline}

    ${selectFlightPrice}=    Get Text    xpath://html/body/div[2]/table/tbody/tr[1]/td[6]
    ${fprice}    Set Variable    ${selectFlightPrice}
    ${fprice}    Get Substring    ${fprice}    1    4
    Set Global Variable    ${fprice}    


    Click Button    xpath://html/body/div[2]/table/tbody/tr[2]/td[1]/input

*** Test Cases ***
Checking price, number and airline and selecting full price
    ${selectNum}=    Get Text    xpath://html/body/div[2]/p[2]
    ${setNum}    Set Variable    ${selectNum}
    
    ${selectaAir}=    Get Text    xpath://html/body/div[2]/p[1]
    ${setAir}    Set Variable    ${selectaAir}

    ${selectPrice}=    Get Text    xpath://html/body/div[2]/p[3]
    ${setPrice}    Set Variable    ${selectPrice}   

    ${setNum}    Remove String    ${setNum}    Flight Number:
    ${setAir}    Remove String    ${setAir}    Airline:
    ${setPrice}    Remove String   ${setPrice}    Price:

    ${selectFullPrice}=    Get Text    xpath://html/body/div[2]/p[5]/em
    ${fullPrice}    Set Variable    ${selectFullPrice}
    Set Global Variable    ${fullPrice}

    Run Keyword And Continue On Failure    Should Be Equal    ${setAir}    ${airline}
    Log    "Airlines are not equal"
    Run Keyword And Continue On Failure    Should Be Equal    ${setNum}    ${flightNum}
    Log    "Flight Numbers are not equal"
    Run Keyword And Continue On Failure    Should Be Equal    ${setPrice}    ${fPrice}
    Log    "Prices are not equal"
    


*** Test Cases ***
Fill and submit form
    Click Element    id:inputName
    Input Text    id:inputName    Jarka Skodova
    Click Element    id:address
    Input Text    id:address    Hattelmalantie 37-39
    Click Element    id:city
    Input Text    id:city    Hämeenlinna
    Click Element    id:state
    Input Text    id:state    Finland
    Click Element    id:zipCode
    Input Text    id:zipCode    13100
    Click Element    id:cardType
    Click Element    xpath://html/body/div[2]/form/div[6]/div/select/option[3]
    Click Element    id:creditCardNumber
    Input Text    id:creditCardNumber    13100234564
    ${cardMonth}    Set Variable    10   
    Set Global Variable    ${cardMonth}
    Click Element    id:creditCardMonth
    Input Text    id:creditCardMonth    ${cardMonth}
    ${cardYear}    Set Variable    2026   
    Set Global Variable    ${cardYear}
    Click Element    id:creditCardYear
    Input Text    id:creditCardYear    ${cardYear}
    Click Element    id:nameOnCard
    Input Text    id:nameOnCard    Jarmila Skodova

    Select Checkbox    id:rememberMe

    Click Button     xpath://html/body/div[2]/form/div[11]/div/input

*** Test Cases ***
Checking if purchase went through

    Sleep    1s
    Page Should Contain    Thank you for your purchase today!

*** Test Cases ***
Checking date
    
    ${getDate}    Get Text    xpath://html/body/div[2]/div/table/tbody/tr[7]/td[2]
    ${date}    Set Variable    ${getDate}
    ${date}    Get Substring    ${date}    0    22
    Should Be Equal    ${date}    Sun, 09 Oct 2022 21:36

*** Test Cases ***
Checking price

    ${getCheckPrice}    Get Text    xpath://html/body/div[2]/div/table/tbody/tr[3]/td[2]
    ${checkPrice}    Set Variable    ${getCheckPrice}
    ${checkPrice}    Remove String    ${checkPrice}    USD
    Run Keyword And Continue On Failure    Should Be Equal    ${checkPrice}    ${fullPrice}
    Log    Prices are not equal

    Close Browser

    

    
    
    









