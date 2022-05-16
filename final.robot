*** Settings ***
Library    SeleniumLibrary
Resource    ../resources/kyewords.resource
Resource    ../resources/variables.resource

Test Setup    Setup Keyword
Test Teardown     Close Browser

*** Test Cases ***
100 Adding and removing items from cart
    Heureka notifikacia
    Pockaj a klikaj     ${tipy_na_grilovanie_a_piknik}
    Scroll Element Into View    ${scroll_na_prenosne_grily}
    Click Element     ${prenosne_grily}
    Pockaj a klikaj     ${cena_50-90}
    Wait Until Page Contains Element    ${cakanie_na_nacitanie_cien_50-90}    timeout=15
    ${url}    Get Location
    log    ${url}
    Pridavame produkt    Tefal GC 205012    ${url}    Grily 50 – 90
    Pridavame produkt    Cattara KEG na drevené uhlie 13031    ${url}    Grily 50 – 90
    Pridavame produkt    Jata GR 195    ${url}    Grily 50 – 90
    Go To    https://www.heureka.sk/kosik/
    Wait Until Page Contains    Tefal GC 205012
    Wait Until Page Contains    Gril Cattara KEG stolný
    Wait Until Page Contains    JATA GR195
    ${prod_1_cena}    Get Text    ${ziskanie_ceny_1_produktu}
    ${prod_2_cena}    Get Text    ${ziskanie_ceny_2_produktu}
    ${prod_3_cena}    Get Text    ${ziskanie_ceny_3_produktu}
    Kontrola ceny produktu    ${prod_1_cena}
    Kontrola ceny produktu    ${prod_2_cena}
    Kontrola ceny produktu    ${prod_3_cena}
    Sleep    5
    Click Element    ${odstranenie_produktu_z_kosika}
    Pockaj a klikaj    ${potvrdenie_odstranenia_produktu_z_kosika}
    Sleep    5
    Click Element    ${odstranenie_produktu_z_kosika}
    Pockaj a klikaj    ${potvrdenie_odstranenia_produktu_z_kosika}
    Sleep    5
    Click Element    ${odstranenie_produktu_z_kosika}
    Pockaj a klikaj    ${potvrdenie_odstranenia_produktu_z_kosika}
    Sleep    5
    Page Should Contain    Váš košík zíva prázdnotou...

    Sleep    20
