*** Settings ***
Library    SeleniumLibrary
Library    String
Resource    ../resources/variables.resource

*** Variables ***
@{Price_range}      50    90

*** Keywords ***
Setup Keyword
    Open Browser    https://www.heureka.sk    gc    executable_path=chromedriver-101
    Set Window Size    1800    1000
    Accept Cookies

Accept Cookies
    Wait Until Page Contains Element    ${cookies_suhlas}
    Click Element    ${cookies_suhlas}

Heureka notifikacia
    Sleep    10
    Wait Until Page Contains Element    ${neskor}
    Click Element    ${neskor}

Pockaj a klikaj
    [Arguments]    ${x}    ${timeout}=10 sec
    Wait Until Page Contains Element    ${x}    timeout=${timeout}
    Click Element    ${x}

Pridavame produkt
    [Arguments]     ${PRODUKT}    ${URL}    ${z}
    Wait Until Page Contains     ${PRODUKT}
    ${prod}    Format String     ${contains}     ${PRODUKT}
    Wait Until Page Contains Element    ${prod}    timeout=15
    Click Element    ${prod}
    Wait Until Page Contains    ${PRODUKT}
    Pockaj a klikaj    ${kupit_na_heureke}
    Wait Until Page Contains Element    ${pridaj_do_kosika}
    Go To    ${URL}

Kontrola ceny produktu
    [Arguments]    ${price}
    ${final_price}=     Remove String   ${price}    €
    ${final_price}=    Replace String    ${final_price}    ,    .
    Log    ${final_price}
    Log    ${price}
    ${final_price}=     Convert To Number   ${final_price}
    Should Be True    ${price_range[0]} < ${final_price} < ${price_range[1]}
