*** Variables ***
${tipy_na_grilovanie_a_piknik}    xpath=//a[@href="https://inspiracia.heureka.sk/tipy-na-grilovanie-a-piknik/"]
${scroll_na_prenosne_grily}    xpath=/html/body/div[3]/div[1]/div/div/div/div[3]/div/div/div[1]/div/div/section/div/div/div[2]/ul/li[3]/section/a[1]
${prenosne_grily}    xpath=/html/body/div[3]/div[1]/div/div/div/div[3]/div/div/div[1]/div/div/section/div/div/div[2]/ul/li[3]/section/div/div/div/a
${cena_50-90}    xpath=//label[@for='price-2']
${cakanie_na_nacitanie_cien_50-90}    xpath=//strong[contains(text(),'Grily 50 – 90')]
${ziskanie_ceny_1_produktu}    xpath=(//div[@class='c-product-card__price u-bold'])[1]
${ziskanie_ceny_2_produktu}    xpath=(//div[@class='c-product-card__price u-bold'])[2]
${ziskanie_ceny_3_produktu}    xpath=(//div[@class='c-product-card__price u-bold'])[3]
${odstranenie_produktu_z_kosika}    xpath=(//a[@class="c-product-card__close c-modal__toggle js-modal__toggle e-action"])[1]
${potvrdenie_odstranenia_produktu_z_kosika}    xpath=//*[@id="snippet--cart-content-data"]/div[3]/div[1]/div/div[1]/section/div/footer/a

${contains}    xpath=//a[contains(text(), '{}')]
${price_check}    xpath=//div[@id="snippet--cart-content-data"]//div[@class="c-product-card__price u-bold"]
${cookies_suhlas}    xpath=//a[@class="c-privacy-prompt__cta e-button e-button--simple e-button--small"]
${neskor}    xpath=//button[@id="onesignal-slidedown-cancel-button"]
${kupit_na_heureke}    xpath=//span[contains(text(), 'Kúpiť na Heureke')]
${pridaj_do_kosika}    xpath=//p[contains(text(), 'Tovar sme pridali do košíka')]

