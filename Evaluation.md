# Hodnotenie

### Celkovo

---
- Replikovatelnost testu: 0:5    (PASS:FAIL)
---

#### Errors:


- pri spusteni navodom v readme: 
  ```
  [ ERROR ] Error in file '/Users/tomas/Documents/playground/TAA/peter_sulei/final.robot' on line 3: Resource file '../resources/kyewords.resource' does not exist.
  [ ERROR ] Error in file '/Users/tomas/Documents/playground/TAA/peter_sulei/final.robot' on line 4: Resource file '../resources/variables.resource' does not exist.
  ```

- pri spusteni `robot --pythonpath resources .`
  ```
  WebDriverException: Message: 'chromedriver-101' executable needs to be in PATH. Please see https://chromedriver.chromium.org/home
  ```

- potrebna uprava keywords.resource a nastavenie spravnej cestly k chromedriver
  - po uprave kod mozne pustit, avsak chyba:
  ```
  [ ERROR ] Error in file '/Users/tomas/Documents/playground/TAA/peter_sulei/final.robot' on line 4: Resource file '../resources/variables.resource' does not exist.
  ```

- Ostatne errory:
  - 5x -> Element 'xpath=//strong[contains(text(),'Grily 50 – 90')]' did not appear in 5 seconds.
---
  
- Z pohladu testingu:
  - nie je vobec jasne, co test robi na prvy pohlad
  - na dalsie to je lepsie, ale stale neni jasne co je ${prod_1}
    - ako to ako tester zistim? ako manualne overim, ci to je spravne napisane?
  - miesanie roznych foriem pisania (detail nizsie v tomto file)

    

- Z pohladu automatizacie:
  - preco by nemohol keyword `pridavame produkt` dostat ako parameter nazov?
    - `Pridavame Produkt    Tefal GC 205012`
    - je to mierne rozumnejsie, a hlavne na prvy pohlad netechnicky clovek vidi o co ide
  - nerozumiem preco sa tam pridava ${url} ako parameter
  - nerozumiem preco sa tam aj 3ti parameter dava `Grily 50 - 90`
  - zbytocne vela variables, je to na ukor citatelnosti tento krat
  - riadky 28, 26 a 30  by sa dali skovat do pridavame produkt, naco su mimo?

- ***Overall***:
  - Test mi presiel 4x, vyborna uspesnost

### Keywords subor

- `General`
  - `Set Window Size` - vyborne, ze si to pouzil a nastavila rozlisenie
    - len doporucenie, ak sme na fullhd, je lepsie nastavit o nieco mensie , aby si mal istotu ze to bude na screene
  - snaz sa drzat 1 upravu, ak pouzivas `Velke Prve Pismeno` pouzivaj ho aj pre svoje KW
  - rozumenjsie nazvy premennych pouzivaj, eg:
    `bad_price`, ona predsa neni bad, iba obsahuje znaky, ktore sa ti nepacia

- Keyword: `check produkt price`
  - parametrizujes (price_range[0]) porovnavanie, avsak do Log-u si pises hardcodnute values
  - porovnanie mozes urobit ako `Should Be True    50 < ${final_price} < 90`
    - pripadne este lepsie v tvojom pripade: `Should Be True    ${price_range[0]} < ${final_price} < ${price_range[1]}`
    - a mas to rovno aj dynamicke pre rozne rozsahy
  - tu by som ako parameter volil nazov produktu, a dynamicky zlozil xpath aby mi vytiahlo cenu tohto produktu

- Keyword: `pridavame produkt`
  - tu mi nieje jasne, naco je tam tolko parametrov, hlavne ten parameter ${z}
  - teda, naco vobec chceme kontrolovat filter pri cene (alebo teda nejaky text)

- Keyword: `wait and click`
  - ak uz robis 'wait' keyword, bolo by dobre ako parameter tomu poslat aj timeout
  - vyriesil by si tym automaticky to, ked bude nieco trvat dlhsie

  ```
  Wait And Click
      [Arguments]    ${element}    ${timeout}=10 sec
      Wait Until Page Contains Element    ${element}    timeout=${timeout}
      Click Element    ${element}
  ```

  
### Variables subor

- asi by som ich oddelil do samostatneho suboru kvoli prehladnosti
  - hladal by som to na 1 mieste, nie na roznych

- sucast test cases suboru
  - Su asi zbytocne, sice ich pouzivas viac krat, ale ${prod_1} v ***Test Cases*** je daleko menej prehladny ako: 'Tefal GC 205012'
    - v prvom pripade sa treba preklikavat, v druhom je uplne jasne, aky produkt vyberam
    - a zaroven, ak by som chcel test zmenit, zmenim to priamo v test cases, a nemusim riesit variable

- sucast keywords suboru
  - xpathy su v pohodicke, su genericke, daju sa menit a prisposobovat argumentami
  - price_range je zbytocne ako list,  dalo by sa to v pohode spravit ako ${min}, ${max} ale nieje to samozrejme problem ak si zvolil tento styl

### Test Cases subor

- super je, ze si pouzil normalny nazov pre test
- `Heureka pop-up` je zvlastny nazov a netusim z prveho pohladu co by mal robit
- xpathy treba skovat z main test-cases suboru, nahradit ich variables
  - idealne aj variables nahradit konkretnymi textami, na tejto urovni (***Test Cases***) chceme aby bol test jasny a zrozumitelny
- `wait and click` posielat nieco rozumnejsie ako xpath, napr variable s rozumnym nazvom, aby bolo jasne, na co sa caka
- miesanie ENG + svk keywordov
- miesanie `vsetko malym`, `Prve Pismeno Velke` ... taky troska 'designovy problem'
- preco `Check Produkt Price` nerobi to, ze si ten text getne a porovna? preco su to rozlicne riadky kodu?
  - vsetko to ide skovat do toho `check` keywordu a zase zvysis prehladnost suboru
- 20s sleep na konci filu? 
- priliz `Sleep`-ov na moj vkus


### Readme.md subor

- `pip install -r requirements.txt`
  - `ERROR: Could not open requirements file: [Errno 2] No such file or directory: 'requirements.txt'`
  - requirements.txt subor sa tu nenachadza
- netusim co znamena download chromedriver pass to the Artin_final folder
  - ziadny taky folder sa v gite nenachadza

### requirements.txt subor
 
- requirements subor chyba, neviem co nainstalovat

### Git repository

- minimalisticky obsah
- nic zbytocne navyse tam nieje