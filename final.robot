*** Settings ***
Library    SeleniumLibrary
Resource    ../resources/kyewords.resource
Resource    ../resources/variables.resource
Test Setup    Setup Keyword
Test Teardown     Close Browser

*** Variables ***
${prod_1}    Tefal GC 205012
${prod_2}    Cattara KEG na drevené uhlie 13031
${prod_3}    Jata GR 195
${cena}    xpath=//div[@class='c-product-card__price u-bold']


*** Test Cases ***
100 Adding and removing items from cart

    Heureka pop-up
    wait and click     xpath=//a[@href="https://inspiracia.heureka.sk/tipy-na-grilovanie-a-piknik/"]
    Scroll Element Into View    xpath=/html/body/div[3]/div[1]/div/div/div/div[3]/div/div/div[1]/div/div/section/div/div/div[2]/ul/li[3]/section/a[1]
    Click Element    xpath=/html/body/div[3]/div[1]/div/div/div/div[3]/div/div/div[1]/div/div/section/div/div/div[2]/ul/li[3]/section/div/div/div/a
    wait and click     xpath=//label[@for='price-2']
    Wait Until Page Contains Element    xpath=//strong[contains(text(),'Grily 50 – 90')]
    ${url}    Get Location
    log    ${url}
    Wait Until Page Contains    ${prod_1} 
    pridavame produkt    ${prod_1}    ${url}    Grily 50 – 90
    Wait Until Page Contains    ${prod_2}
    pridavame produkt    ${prod_2}    ${url}    Grily 50 – 90
    Wait Until Page Contains    ${prod_3}
    pridavame produkt    ${prod_3}    ${url}    Grily 50 – 90
    Go To    https://www.heureka.sk/kosik/
#    Sleep    20
    Wait Until Page Contains    ${prod_1}
    Wait Until Page Contains    Gril Cattara KEG stolný
    Wait Until Page Contains    JATA GR195

    ${prod_1_cena}    Get Text    xpath=(//div[@class='c-product-card__price u-bold'])[1]
    ${prod_2_cena}    Get Text    xpath=(//div[@class='c-product-card__price u-bold'])[2]
    ${prod_3_cena}    Get Text    xpath=(//div[@class='c-product-card__price u-bold'])[3]

    check produkt price    ${prod_1_cena}
    check produkt price    ${prod_2_cena}
    check produkt price    ${prod_3_cena}
    Sleep    5
    Click Element    xpath=(//a[@class="c-product-card__close c-modal__toggle js-modal__toggle e-action"])[1]
    wait and click    xpath=//*[@id="snippet--cart-content-data"]/div[3]/div[1]/div/div[1]/section/div/footer/a
    Sleep    5
    Click Element    xpath=(//a[@class="c-product-card__close c-modal__toggle js-modal__toggle e-action"])[1]
    wait and click    xpath=//*[@id="snippet--cart-content-data"]/div[3]/div[1]/div/div[1]/section/div/footer/a
    Sleep    5
    Click Element    xpath=(//a[@class="c-product-card__close c-modal__toggle js-modal__toggle e-action"])[1]
    wait and click    xpath=//*[@id="snippet--cart-content-data"]/div[3]/div[1]/div/div[1]/section/div/footer/a
    Sleep    5
    Page Should Contain    Váš košík zíva prázdnotou...

    Sleep    20