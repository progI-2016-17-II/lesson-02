#####################
# Feladatok         #
# Programozás I.    #
# 2. óra            #
# Balogh Kitti      #
# 2017-02-21        #
#####################

#----II. feladat----------------------------------------------------------------
# 1. Loblobby dataset beolvasása
data("Loblolly") 

# 2. szűrés a legmagasabb seedre
Loblolly$Seed[which.max(Loblolly$height)]

# 3. szűrés a legmagasabb seedre 15 év után
Loblolly15 <- subset(Loblolly, age == 15)
Loblolly15$Seed[which.max(Loblolly15$height)]


#----III. feladat---------------------------------------------------------------
# 1. credit.csv beolvasása
credit <- read.table(file = "data/assignments/credit.csv", header = T, 
                     sep = ",", dec = ".", fileEncoding = "utf-8")

# 2. kritikus hiteltörténetű egyének leggyakoribb hitelfelvételi célja
credit_critical <- subset(credit, credit_history == "critical")
sort(summary(credit_critical$purpose), decreasing = T)

# 3. kritikus hiteltörténetű egyének átlagosan felvett hitelösszege
mean(credit_critical$amount)

# 4. tökéletes hiteltörténetű egyének leggyakoribb hitelfelvételi célja
credit_perfect <- subset(credit, credit_history == "perfect")
sort(summary(credit_perfect$purpose), decreasing = T)

# 5. tökéletes hiteltörténetű egyének átlagosan felvett hitelösszege
mean(credit_perfect$amount)


#----IV. feladat----------------------------------------------------------------
# 1. sms_spam.tsv beolvasása
sms <- read.delim2(file = "data/assignments/sms_spam.tsv", header = T, 
                     sep = "\t", dec = ".", fileEncoding = "utf-8",
                     stringsAsFactors = F)
sms$type <- as.factor(sms$type)

# 2. spamek és hamek átlagos hossza
mean(nchar(subset(sms, type == "spam")$text))
mean(nchar(subset(sms, type == "ham")$text))


#----V. feladat-----------------------------------------------------------------
# 1.
# rio package installálása, ha szükséges, majd behívása
if (!("rio" %in% installed.packages())){
  install.packages("rio")
}
library(rio)

# redwines.xlsx beolvasása
red <- import(file = "data/assignments/redwines.xlsx")
# whitewines.xlsx beolvasása
white <- import(file = "data/assignments/whitewines.xlsx")

# 2. két data frame összekapcsolása új type oszloppal
red$type <- as.factor("red")
white$type <- as.factor("white")
wines <- rbind(red, white)

# 3. vörös borok savasabbak-e, mint a fehérek
wines$fixed_acidity <- as.numeric(wines$fixed_acidity)
mean(subset(wines, type == "red")$fixed_acidity, na.rm = T) > 
  mean(subset(wines, type == "white")$fixed_acidity, na.rm = T)