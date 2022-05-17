# Hodnotenie

### Celkovo

---
- [ ] Replikovatelnost testu: 0:5    (PASS:FAIL)
---

[N] Problemy, ktore boli si vyriesil, nastal problem, ze 3ti produkt  'Jata GR195' ti neustale prekryva horna lista
  - testovane aj na Windows aj na macOS a nevie to tam kliknut

#### Errors:


- [N] pri spusteni navodom v readme: 
  ```
  [ ERROR ] Error in file '/Users/tomas/Documents/playground/TAA/peter_sulei/final.robot' on line 3: Resource file '../resources/kyewords.resource' does not exist.
  [ ERROR ] Error in file '/Users/tomas/Documents/playground/TAA/peter_sulei/final.robot' on line 4: Resource file '../resources/variables.resource' does not exist.
  ```

- [ ] pri spusteni `robot --pythonpath resources .`
  ```
  WebDriverException: Message: 'chromedriver-101' executable needs to be in PATH. Please see https://chromedriver.chromium.org/home
  ```

- [ ] potrebna uprava keywords.resource a nastavenie spravnej cestly k chromedriver
  - po uprave kod mozne pustit, avsak chyba:
  ```
  [ ERROR ] Error in file '/Users/tomas/Documents/playground/TAA/peter_sulei/final.robot' on line 4: Resource file '../resources/variables.resource' does not exist.
  ```

- Ostatne errory:
  - [x] 5x -> Element 'xpath=//strong[contains(text(),'Grily 50 – 90')]' did not appear in 5 seconds.
  - [N] 5x -> ElementClickInterceptedException: Message: element click intercepted: Element <a class="c-product__link" href="https://grily.heureka.sk/jata-gr-195/">...</a> is not clickable at point (1028, 10). Other element would receive the click: <div class="l-header__wrapper">...</div>

---
  
- Z pohladu testingu:
  - [x] nie je vobec jasne, co test robi na prvy pohlad
  - [x] na dalsie to je lepsie, ale stale neni jasne co je ${prod_1}
    - ako to ako tester zistim? ako manualne overim, ci to je spravne napisane?
    - [N] Mas velmi pomiesanu abstrakciu, raz pouzivas priamo selenium keywordy, raz pouzivas svoje. Je to anglicko slovensky
  - miesanie roznych foriem pisania (detail nizsie v tomto file)

    

- Z pohladu automatizacie:
  - [x] preco by nemohol keyword `pridavame produkt` dostat ako parameter nazov?
    - `Pridavame Produkt    Tefal GC 205012`
    - je to mierne rozumnejsie, a hlavne na prvy pohlad netechnicky clovek vidi o co ide
  - [ ] nerozumiem preco sa tam pridava ${url} ako parameter
  - [ ] nerozumiem preco sa tam aj 3ti parameter dava `Grily 50 - 90`
  - [ ] zbytocne vela variables, je to na ukor citatelnosti tento krat
  - [x] riadky 28, 26 a 30  by sa dali skovat do pridavame produkt, naco su mimo?
  - [N] Preco ziskavame 26-28 riadky, cenu priamo v test-case? preco v ramci kontroly ceny to nerobime?
    - `Product Price Should Be In Interval    Tefal GC 205012    50    90`

- ***Overall***:

  - [ ] Test mi presiel 4x, vyborna uspesnost
    - [N] Tu som spravil chybu ocividne, ani pri prvom rune, ako si mozno pochopil z chyb vyssie a z 0:5 je zrejme, ze test nepresiel
    - [N] Ocividne som to poplietol s inym repository, mrzi ma to
  - [N] Test nepresiel znova ani 1x, vsetko pada pri poslednom grile na problem vyssie

### Keywords subor

- `General`
  - [x] `Set Window Size` - vyborne, ze si to pouzil a nastavila rozlisenie
    - len doporucenie, ak sme na fullhd, je lepsie nastavit o nieco mensie , aby si mal istotu ze to bude na screene
  - [ ] snaz sa drzat 1 upravu, ak pouzivas `Velke Prve Pismeno` pouzivaj ho aj pre svoje KW
  - [x] rozumenjsie nazvy premennych pouzivaj, eg:
    `bad_price`, ona predsa neni bad, iba obsahuje znaky, ktore sa ti nepacia

- [x] Keyword: `check produkt price`
  - parametrizujes (price_range[0]) porovnavanie, avsak do Log-u si pises hardcodnute values
  - porovnanie mozes urobit ako `Should Be True    50 < ${final_price} < 90`
    - pripadne este lepsie v tvojom pripade: `Should Be True    ${price_range[0]} < ${final_price} < ${price_range[1]}`
    - a mas to rovno aj dynamicke pre rozne rozsahy
  - tu by som ako parameter volil nazov produktu, a dynamicky zlozil xpath aby mi vytiahlo cenu tohto produktu
  - [N] posielas cenu produktu, osobne by som posielal aj 'range', cim by si to spravil viac genericke a pouzitelne pre lubovolny test, ktory by siel tymto flow-om

- [ ] Keyword: `pridavame produkt`
  - tu mi nieje jasne, naco je tam tolko parametrov, hlavne ten parameter ${z}
  - teda, naco vobec chceme kontrolovat filter pri cene (alebo teda nejaky text)

- [x] Keyword: `wait and click`
  - ak uz robis 'wait' keyword, bolo by dobre ako parameter tomu poslat aj timeout
  - vyriesil by si tym automaticky to, ked bude nieco trvat dlhsie

  ```
  Wait And Click
      [Arguments]    ${element}    ${timeout}=10 sec
      Wait Until Page Contains Element    ${element}    timeout=${timeout}
      Click Element    ${element}
  ```

  
### Variables subor

- [x] asi by som ich oddelil do samostatneho suboru kvoli prehladnosti
  - hladal by som to na 1 mieste, nie na roznych

- [x] sucast test cases suboru
  - Su asi zbytocne, sice ich pouzivas viac krat, ale ${prod_1} v ***Test Cases*** je daleko menej prehladny ako: 'Tefal GC 205012'
    - v prvom pripade sa treba preklikavat, v druhom je uplne jasne, aky produkt vyberam
    - a zaroven, ak by som chcel test zmenit, zmenim to priamo v test cases, a nemusim riesit variable

- [x] sucast keywords suboru
  - xpathy su v pohodicke, su genericke, daju sa menit a prisposobovat argumentami
  - price_range je zbytocne ako list,  dalo by sa to v pohode spravit ako ${min}, ${max} ale nieje to samozrejme problem ak si zvolil tento styl

- [N] niektore variables su zbytocne dlhe, a neprehladne eg: `${potvrdenie_odstranenia_produktu_z_kosika}`, `${cakanie_na_nacitanie_cien_50-90}` hlavne ak sa pouzivaju v 'main' file

### Test Cases subor

- super je, ze si pouzil normalny nazov pre test
- [x] `Heureka pop-up` je zvlastny nazov a netusim z prveho pohladu co by mal robit
- [x] xpathy treba skovat z main test-cases suboru, nahradit ich variables
  - idealne aj variables nahradit konkretnymi textami, na tejto urovni (***Test Cases***) chceme aby bol test jasny a zrozumitelny
- [x] `wait and click` posielat nieco rozumnejsie ako xpath, napr variable s rozumnym nazvom, aby bolo jasne, na co sa caka
- [ ] miesanie ENG + svk keywordov
- [ ] miesanie `vsetko malym`, `Prve Pismeno Velke` ... taky troska 'designovy problem'
- [x] preco `Check Produkt Price` nerobi to, ze si ten text getne a porovna? preco su to rozlicne riadky kodu?
  - vsetko to ide skovat do toho `check` keywordu a zase zvysis prehladnost suboru
- [ ] 20s sleep na konci filu? 
- [ ] priliz `Sleep`-ov na moj vkus
- [N] ${ziskanie_ceny_1_produktu}, ktory je prvy? nejaky konkretny alebo posledne pridany? alebo prvy v zozname?
- [N] vo vseobecnosti pochopitelny test, vidim tam aspon co sa tam deje, ale je to moc `pre-variablovane` a tazsie sa to cita + kopa sleepov


### Readme.md subor

- [x] `pip install -r requirements.txt`
  - `ERROR: Could not open requirements file: [Errno 2] No such file or directory: 'requirements.txt'`
  - requirements.txt subor sa tu nenachadza
- [ ] netusim co znamena download chromedriver pass to the Artin_final folder
  - ziadny taky folder sa v gite nenachadza
- [N] `to run use: 'robot .'
  ```
  [ ERROR ] Error in file '/Users/tomas/Documents/playground/TAA/peter_sulei/final.robot' on line 3: Resource file '../resources/kyewords.resource' does not exist.
[ ERROR ] Error in file '/Users/tomas/Documents/playground/TAA/peter_sulei/final.robot' on line 4: Resource file '../resources/variables.resource' does not exist.
  ```
  - treba byt troska jasnejsi v instrukciach

### requirements.txt subor
 
- [x] requirements subor chyba, neviem co nainstalovat
- [N] v requirements.txt mas aj `pabot` co je nepotrebna vec aktualne. Nikde ju nespominas, treba drzat requirements co najmensie bez veci co nepotrebujeme

### Git repository

- [x] minimalisticky obsah
- [x] nic zbytocne navyse tam nieje
- [N] mas preklep v `kyewords.resource`