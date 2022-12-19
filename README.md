# DDRT-projektas

# Motyvacija
Projekto tikslas yra automatizuoti paskolų išdavimo sprendimo pagrindimo procesą, nustatant rizikingus klientus, kuriems neturėtų būti suteiktos paskolos.

# Priklausomybės
* R kernel
* R paketai:
  - install.packages("h2o")
  - install.packages("shiny")
  - install.packages("tidyverse")

# Projekto struktūra
    ├───1-data
    ├───2-report
    ├───3-R
    ├───4-model
    ├───5-predictions
    └───app

# Rezultatai
Geriausiai pasirodė gbm modelis pasiekęs AUC = 0.8147 ištestuotas ant bandomųjų duomenų rinkinio.
