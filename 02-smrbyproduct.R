library(lubridate)
library(readxl)
library(dplyr)

araw <- read_rds("data/araw.rds")

# 제품별 파라메터 분석/적용 -----

derma <- araw[which(str_detect(araw$Product, "더마") & !str_detect(araw$Product, "가벼운")),]

etc00 <- araw %>%
  filter(!str_detect(Product, "더마"))

etc2 <- araw[which(str_detect(araw$Product, "버블퐁")),]

etc3 <- araw[which(str_detect(araw$Product, "샴푸")),]

etc4 <- araw[which(str_detect(araw$Product, "가벼운")),]

etc5 <- araw[which(str_detect(araw$Product, "찌든때") & !str_detect(araw$Product, "버블")),]

etc6 <- araw[which(str_detect(araw$Product, "토네이도")),]

etc7 <- araw[which(str_detect(araw$Product, "^3종지압봉")),]

etc8 <- araw[which(str_detect(araw$Product, "^두피")),]

derma$PID <- 1
etc2$PID <- 2
etc3$PID <- 3
etc4$PID <- 4
etc5$PID <- 5
etc6$PID <- 6
etc7$PID <- 9
etc8$PID <- 10

sales <- rbind(derma, etc2)
sales <- rbind(sales, etc3)
sales <- rbind(sales, etc4)
sales <- rbind(sales, etc5)
sales <- rbind(sales, etc6)
sales <- rbind(sales, etc7)
sales <- rbind(sales, etc8)

sales <- left_join(sales, pid, by = "PID")

saveRDS(sales, "data/sales.rds")

# intersect ----



# today
datef <- today() -1

# sales by product -----

s.hp <- sales %>%
  filter(Paiddate == "2018-11-11", Product.y == "힐링패치")

sr.hp <- sum(s.hp$TotalSales)

# marketingcost by product-----
mc <- read_excel("data/mc.xlsx")
colnames(mc) = c("date", "weekday", "product", "mchannel", "mcost")
mc$mcost <- as.integer(mc$mcost)
        

m.hp <- mc %>%
  filter(date == datef) %>%
  group_by(product) %>%
  filter(product == "힐링패치")

mc.hp <- sum(m.hp$mcost)

m.bp <- mc %>%
  filter(date == datef) %>%
  group_by(product) %>%
  filter(product == "버블퐁")

mc.bp <- sum(m.bp$mcost)

m.ls <- mc %>%
  filter(date == datef) %>%
  group_by(product) %>%
  filter(product == "가벼운한잔")

mc.ls <- sum(m.ls$mcost)

m.ss <- mc %>%
  filter(date == datef) %>%
  group_by(product) %>%
  filter(product == "씨솔트샴푸")

mc.ss <- sum(m.ss$mcost)

m.gd <- mc %>%
  filter(date == datef) %>%
  group_by(product) %>%
  filter(product == "굿바이찌든때")

mc.gd <- sum(m.gd$mcost)

m.bt <- mc %>%
  filter(date == datef) %>%
  group_by(product) %>%
  filter(product == "버블토네이도")

mc.bt <- sum(m.bt$mcost)

save.image(file = "data/mc.RData")

# kpi ----

kpibp$date <- datef
















