######################################
# Adatok beolvasása és kiírása       #
# Programozás I.                     #
# 2. óra                             #
# 2017-02-21                         #
######################################

#----R-hez, package-ekhez tartozó adatfájlok------------------------------------

## R alap datasetjei
# RStudio-ban külön ablakban nyílik meg
data()

## iris dataset
# R-hez tartozó dataset, mint pl. az mtcars is
# iris dataset betöltése
data(iris)
head(iris)

## diamonds dataset
# ggplot2 package-hez tartozó dataset
# ggplot2 installálása, ha szükséges, majd behívás
if (!("ggplot2" %in% installed.packages())) {
  install.packages(ggplot2)
}
library(ggplot2)

# ggplot2 datasetjei
# RStudio-ban külön ablakban nyílik meg
data(package = "ggplot2")

# diamonds data set betöltése
data(diamonds)
head(diamonds)

## loldata datasetjei
# loldata installálása, behívása
if (!("devtools" %in% installed.packages())) {
  install.packages(devtools)
}
if (!("loldata" %in% installed.packages())) {
  devtools::install_github("tadaadata/loldata")
}
library(loldata)

# loldata datasetjei
# RStudio-ban külön ablakban nyílik meg
data(package = "loldata")


#----CSV-k, TSV-k beolvasása, kiírása-------------------------------------------

# iris csv beolvasása
iris_csv <-
  read.table(
    file = "data/iris_import/iris.csv",
    header = T,
    sep = ",",
    dec = ".",
    fileEncoding = "utf-8"
  )

# iris tsv beolvasása
iris_tsv <-
  read.table(
    file = "data/iris_import/iris.tsv",
    header = T,
    sep = "\t",
    dec = ".",
    fileEncoding = "utf-8"
  )

# data frame-ek első 5 sora
head(iris)
head(iris_csv)
head(iris_tsv)

# felesleges data frame-ek törlése
rm(iris_csv)
rm(iris_tsv)

# csv kiírása
# új data frame a setosa faj adataival
setosa <- subset(iris, Species == "setosa")
write.table(
  setosa,
  file = "data/iris_export/setosa.csv",
  sep = ",",
  row.names = F,
  fileEncoding = "utf-8"
)

# tsv kiírása
# új data frame a versicolor faj adataival
versicolor <- subset(iris, Species == "versicolor")
write.table(
  versicolor,
  file = "data/iris_export/versicolor.tsv",
  sep = "\t",
  row.names = F,
  fileEncoding = "utf-8"
)

# felesleges data frame-ek törlése
rm(setosa)
rm(versicolor)


#----Excel fájlok beolvasása, kiírása-------------------------------------------

# rio package installálása, ha szükséges, majd behívása
if (!("rio" %in% installed.packages())) {
  install.packages(rio)
}
library(rio)

# iris xlsx beolvasása
iris_xlsx <- import(file = "data/iris_import/iris.xlsx")

# data frame-ek első 5 sora
head(iris)
head(iris_xlsx)

# xlsx kiírása
# új data frame a virginica faj adataival
virginica <- subset(iris, Species == "virginica")
export(virginica, "data/iris_export/virginica.xlsx")

# felesleges data frame-ek törlése
rm(iris_xlsx)
rm(virginica)


#----SAV fájlok beolvasása, kiírása---------------------------------------------

# rio package installálása, ha szükséges, majd behívása
# if (!("rio" %in% installed.packages())){
#   install.packages(rio)
# }
# library(rio)

# iris sav beolvasása
iris_sav <- import(file = "data/iris_import/iris.sav")

# data frame-ek első 5 sora
head(iris)
head(iris_sav)

# sav kiírása
# új data frame a setosa faj adataival
setosa <- subset(iris_sav, Species == 1)
export(setosa, "data/iris_export/setosa.sav")

# felesleges data frame-ek törlése
rm(iris_sav)
rm(setosa)


#----DTA fájlok beolvasása, kiírása---------------------------------------------

# rio package installálása, ha szükséges, majd behívása
# if (!("rio" %in% installed.packages())){
#   install.packages(rio)
# }
# library(rio)

# iris dta beolvasása
iris_dta <- import(file = "data/iris_import/iris.dta")

# data frame-ek első 5 sora
head(iris)
head(iris_dta)

# dta kiírása
# új data frame a setosa faj adataival
setosa <- subset(iris_dta, iris == 1)
export(setosa, "data/iris_export/setosa.dta")

# felesleges data frame-ek törlése
rm(iris_dta)
rm(setosa)


#----SQlite fájlból adatbeolvasás-----------------------------------------------

# RSQLite package installálása, ha szükséges, majd behívása
if (!("RSQLite" %in% installed.packages())) {
  install.packages(RSQLite)
}
library("RSQLite")

# kapcsolódás az sqlite fájlhoz
RSQLite::SQLite()
drv <- SQLite()
con <- dbConnect(drv, dbname = "data/iris_import/iris.sqlite")

# táblák listája
tables <- dbListTables(con)

# Iris tábla kiválasztása
iris_sqlite <- dbGetQuery(con, 'select * from Iris')
head(iris_sqlite)

# setosa faj adatainak kiválasztása az Iris tábláról
setosa <-
  dbGetQuery(con, "SELECT * from Iris WHERE Species == 'Iris-setosa'")
setosa

# lekapcsolódás
dbDisconnect(con)

# felesleges data frame-ek törlése
rm(iris_sqlite)


#----R bináris fájlok kiírása, beolvasása---------------------------------------

# iris dataset kiírása rdata-ba
save(setosa, file = "data/iris_export/setosa.rdata")

# iris változó törlése
rm(setosa)
head(setosa)

# iris rdata beolvasása
load("data/iris_export/setosa.rdata")
head(setosa)
