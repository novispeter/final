*** Settings ***
Library    SeleniumLibrary
Library    String

*** Variables ***

${contains}    xpath=//a[contains(text(), '{}')]
${price_check}    xpath=//div[@id="snippet--cart-content-data"]//div[@class="c-product-card__price u-bold"]
@{Price_range}      50    90

*** Keywords ***
Setup Keyword
    Open Browser    https://www.heureka.sk    gc    executable_path=chromedriver-101
    Set Window Size    1800    1000
    Accept Cookies

Accept Cookies
    Wait Until Page Contains Element    xpath=//a[@class="c-privacy-prompt__cta e-button e-button--simple e-button--small"]
    Click Element    xpath=//a[@class="c-privacy-prompt__cta e-button e-button--simple e-button--small"]

Heureka pop-up
    Sleep    10
    Wait Until Page Contains Element    xpath=//button[@id="onesignal-slidedown-cancel-button"]
    Click Element    xpath=//button[@id="onesignal-slidedown-cancel-button"]

Wait and click
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
    wait and click    xpath=//span[contains(text(), 'Kúpiť na Heureke')]
    Wait Until Page Contains Element    xpath=//p[contains(text(), 'Tovar sme pridali do košíka')]
    Go To    ${URL}

Kontrola ceny produktu
    [Arguments]    ${price}
    ${final_price}=     Remove String   ${price}    €
    ${final_price}=    Replace String    ${final_price}    ,    .
    Log    ${final_price}
    Log    ${price}
    ${final_price}=     Convert To Number   ${final_price}
    Should Be True    ${price_range[0]} < ${final_price} < ${price_range[1]}
