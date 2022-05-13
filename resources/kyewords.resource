*** Settings ***
Library    SeleniumLibrary
Library    String

*** Variables ***

${contains}    xpath=//a[contains(text(), '{}')]
${contains_2}    xpath=//strong[contains(text(), '{}')]
${price_check}    xpath=//div[@id="snippet--cart-content-data"]//div[@class="c-product-card__price u-bold"]
@{Price_range}      50    90

*** Keywords ***
Setup Keyword
    Open Browser    https://www.heureka.sk    gc    executable_path=chromedriver-101
    Set Window Size    1920    1080
    Accept Cookies
#    Reload Page

Accept Cookies
    Wait Until Page Contains Element    xpath=//a[@class="c-privacy-prompt__cta e-button e-button--simple e-button--small"]
    Click Element    xpath=//a[@class="c-privacy-prompt__cta e-button e-button--simple e-button--small"]

Heureka pop-up
    Sleep    10
    Wait Until Page Contains Element    xpath=//button[@id="onesignal-slidedown-cancel-button"]
    Click Element    xpath=//button[@id="onesignal-slidedown-cancel-button"]

wait and click
    [Arguments]    ${x}
    Wait Until Page Contains Element    ${x}
    Click Element    ${x}

pridavame produkt
    [Arguments]     ${PRODUKT}    ${URL}    ${z}
    ${prod}    Format String     ${contains}     ${PRODUKT}
    Wait Until Page Contains Element    ${prod}    timeout=15
    Click Element    ${prod}
    Wait Until Page Contains    ${PRODUKT}
    wait and click    xpath=//span[contains(text(), 'Kúpiť na Heureke')]
    Wait Until Page Contains Element    xpath=//p[contains(text(), 'Tovar sme pridali do košíka')]
    Go To    ${URL}
    ${50-90}    Format String    ${contains_2}    ${z}
    Wait Until Page Contains Element    ${50-90}

check produkt price
    [Arguments]    ${bad_price}
    ${final_price}=     Remove String   ${bad_price}    €
    ${final_price}=    Replace String    ${final_price}    ,    .
    Log    ${final_price}
    Log    ${bad_price}
    ${final_price}=     Convert To Number   ${final_price}
    IF    ${final_price} > ${Price_range[0]}
        Log    cena je vacsia ako 50
    ELSE
        Fail
    END
    IF    ${final_price} < ${Price_range[1]}
        Log    cena je mensia ako 90
    ELSE
        Fail
    END
