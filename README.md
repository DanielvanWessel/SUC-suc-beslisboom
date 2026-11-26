# SUC-beslisboom

Web-app voor de beoordeling van shops in de SUC Report (Shop URL Checker) van Beslist.
De app stelt per shop een reviewstatus voor met de SUC-beslisboom, laat zien waarop dat
voorstel is gebaseerd en wat het doet met de werkvoorraad, de SUC-KPI en Jira. Na
akkoord zet de app de statussen zelf in de SUC Report.

## Starten

1. Download `start.bat` (alleen dit bestand is nodig) en dubbelklik erop.
2. De app opent in je standaardbrowser. Bij elke start haalt `start.bat` de nieuwste
   versie van GitHub op. Is GitHub niet bereikbaar, dan opent de vorige versie.

Er is niets te installeren: geen git, Python of Node. `start.bat` gebruikt alleen
`curl`, dat standaard in Windows 10 en 11 zit. De app zelf staat daarna in
`%LOCALAPPDATA%\suc-beslisboom\index.html`.

## Werkwijze

1. **Ophalen.** Sleep de knop *SUC ophalen* één keer naar je bladwijzerbalk. Klik in de
   app op *Open SUC Report*, log zo nodig in, en klik daar op de bladwijzer. Kies in het
   paneel rechtsonder *Ophalen*. De gegevens komen vanzelf terug in de app.
   - *Nieuwe shops*: alle shops op (not set yet), ongeveer 2 minuten.
   - *Alles + hercontrole*: ook shops waarvan de status mogelijk niet meer klopt, 5 tot 10 minuten.
2. **Beoordelen.** Per shop zie je het voorstel, de regel uit de beslisboom die het
   bepaalde, de cijfers erachter en de prijsafwijkingen met links naar de pagina van de
   shop. Gele blokken vragen een controle op de site voordat je akkoord kunt geven.
3. **Doorvoeren.** *Stuur naar SUC* zet de goedgekeurde besluiten klaar in het SUC-paneel.
   Daar zie je de lijst nog één keer en klik je zelf op *Doorvoeren*. Het paneel gebruikt
   *Bulk status* van de SUC Report: per shop controleert het eerst of de huidige status nog
   is wat de app verwacht, en na het opslaan leest het de nieuwe status terug. Met
   *Proef* zie je wat er zou gebeuren zonder iets op te slaan.

Tickets maak je via de knop *Create Jira ticket* in de SUC Report, zodat de Jira-badge
klopt. *Voorbereiden* in het paneel opent de shop met het juiste subject en de
voorbeelden al aangevinkt; aanmaken doe je zelf.

## Privacy

De bladwijzer leest de SUC Report in jouw browser, met jouw inlog. Shopdata gaat
alleen tussen dat tabblad en de app op je eigen computer heen en weer. Er staat geen
shopdata in deze repository en de app stuurt niets naar een server.

## De regels in het kort

| Regel | Voorwaarde (eerste die past, wint) | Voorstel |
|---|---|---|
| N0 | < 3 samples in het venster | wachten |
| N1 | varianten op één URL (note, of ≥ 2 gedeelde URL's in de steekproef) | Dataedis issue - not yet reported |
| N2 | affiliate | OK |
| N3 | fetch < 30% | Dataedis issue - not yet reported |
| N4 | ≥ 80% Inventory MISMATCH (steekproef op de site verplicht) | Dataedis issue - not yet reported |
| N5 | ≥ 50% van de afwijkingen factor > 3 (controle verplicht) | Dataedis issue - not yet reported |
| N6 | alle afwijkingen timing en die drukken de prijs onder 93% | Beslist Issue |
| N7 | prijs excl. timing ≤ 93% | Shop Issue (+ CMDASH-ticket als het aanhoudt en er ≥ 3 voorbeelden zijn) |
| N8 | anders | OK |

Hercontrole (H1–H12) controleert shops die al een status hebben, bijvoorbeeld een
Shop Issue waarvan de prijzen weer kloppen, of een Dataedis Issue waarbij Dataedis weer
goed uitleest. De volledige lijst staat onder *Uitleg* in de app.

Venster: de laatste 3 volle dagen (vandaag telt nooit mee).

## Onderhoud

- Alles zit in één bestand: `index.html` (HTML, CSS en JavaScript, geen build-stap).
- De bladwijzercode is de functie `sucCollector()` in dat bestand. Verander je die, verhoog
  dan `APP_VERSION`. Gebruikers zien dan dat hun bladwijzer verouderd is en slepen die opnieuw.
- De drempels staan in `T`, de regels in `ladder()` (nieuw) en `recheck()` (hercontrole).
- Wijzigingen naar `main` pushen; `start.bat` haalt ze bij de volgende start op.
- De app leunt op de opbouw van de SUC Report-pagina (tabel met kop *Num Samples*, de
  tooltip per rij, de Shop details-popup en *Bulk status*). Verandert die pagina, dan
  meldt het paneel een fout bij ophalen of doorvoeren.
