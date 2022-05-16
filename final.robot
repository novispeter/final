*** Settings ***
Library    SeleniumLibrary
Resource    ../resources/kyewords.resource
Test Setup    Setup Keyword
Test Teardown     Close Browser

*** Test Cases ***
100 Adding and removing items from cart
    Heureka pop-up
    wait and click     xpath=//a[@href="https://inspiracia.heureka.sk/tipy-na-grilovanie-a-piknik/"]
    Scroll Element Into View    xpath=/html/body/div[3]/div[1]/div/div/div/div[3]/div/div/div[1]/div/div/section/div/div/div[2]/ul/li[3]/section/a[1]
    Click Element    xpath=/html/body/div[3]/div[1]/div/div/div/div[3]/div/div/div[1]/div/div/section/div/div/div[2]/ul/li[3]/section/div/div/div/a
    wait and click     xpath=//label[@for='price-2']
    Wait Until Page Contains Element    xpath=//strong[contains(text(),'Grily 50 – 90')]    timeout=15
    ${url}    Get Location
    log    ${url}
    Pridavame produkt    Tefal GC 205012    ${url}    Grily 50 – 90
    Pridavame produkt    Cattara KEG na drevené uhlie 13031    ${url}    Grily 50 – 90
    Pridavame produkt    Jata GR 195    ${url}    Grily 50 – 90
    Go To    https://www.heureka.sk/kosik/
    Wait Until Page Contains    Tefal GC 205012
    Wait Until Page Contains    Gril Cattara KEG stolný
    Wait Until Page Contains    JATA GR195
    ${prod_1_cena}    Get Text    xpath=(//div[@class='c-product-card__price u-bold'])[1]
    ${prod_2_cena}    Get Text    xpath=(//div[@class='c-product-card__price u-bold'])[2]
    ${prod_3_cena}    Get Text    xpath=(//div[@class='c-product-card__price u-bold'])[3]
    Kontrola ceny produktu    ${prod_1_cena}
    Kontrola ceny produktu    ${prod_2_cena}
    Kontrola ceny produktu    ${prod_3_cena}
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
