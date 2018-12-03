#----library packages----
library(dplyr)
library(readxl)
library(lubridate)
library(data.table)
library(stringr)
library(readr)

# raw <- read_excel("[2]Inventory/Musel inventory_181113.xlsx")
# raw <- read_excel("~/Documents/RProject/[2]Inventory/inv_1127.xlsx")
raw <- read_rds("data/raw.rds")

#-----data preprocessing----
araw <- raw %>%
  select(주문고유번호,판매사이트명,판매사이트코드,결제일,상품명,주문선택사항,판매가,`총판매가(묶음후)`,배송비금액,`판매가+배송비`)
# araw$TotalSales <- araw$배송비금액 + araw$판매가
# araw$Product <- paste(araw$상품명, ifelse(is.na(araw$주문선택사항), " ",araw$주문선택사항))
araw$결제일 <- as.Date(araw$결제일)

# colnames(araw) = c("Orderid", "Site", "Sitecode", "Paiddate", "Product", "Option", "Sales","Psales", "Shipping", "TotalSales")
# araw <- raw[, c(2,3,8,9,29,22)]
# araw$TotalSales <- raw$배송비금액 + raw$판매가
# araw$Product <- paste(raw$상품명, ifelse(is.na(raw$주문선택사항), " ",raw$주문선택사항))
# colnames(araw) = c("Site", "Sitecode", "date", "Shippingdate","Shippingpaid", "Sales", "TotalSales", "Product")
# colnames(raw10to11) = c("Orderid", "Site", "Sitecode", "Paiddate", "Product", "Sales","Psales", "Shipping", "TotalSales")
# araw <- araw[, c(8,3,4,5,6,7,1,2)]
# araw$date <- as.Date(araw$date)



#-----fix shipping----

gsraw <- araw %>%
  filter(판매사이트코드 == "A011", `총판매가(묶음후)` < 35000) %>%
  mutate(배송비금액 = 2500)

weraw <- araw %>%
  filter(판매사이트코드 == "B719",`총판매가(묶음후)` < 35000) %>%
  mutate(배송비금액 = 2500)

gongraw <- araw %>%
  filter(상품명 == "[공구]") %>%
  mutate(배송비금액 = 2500)

tmonraw <- araw %>%
  filter(판매사이트코드 == "B956", `총판매가(묶음후)` < 35000) %>%
  mutate(배송비금액 = 2500)

bokraw <- araw %>%
  filter(상품명 == "[임직원복지]", `총판매가(묶음후)` < 35000) %>%
  mutate(배송비금액 = 2500)

fs.araw <- gsraw %>%
  bind_rows(list(weraw, gongraw, tmonraw, bokraw))

# raw$배송비금액 <- as.character(raw$배송비금액)
# raw1$배송비금액 <- as.character(raw1$배송비금액)

fsh.araw <- merge(araw, fs.araw, by = c(1:8), all.x = T, no.dups = F) %>%
  mutate(배송비금액 = ifelse(!is.na(배송비금액.y), 배송비금액.y, 배송비금액.x))
# select(1:8, 배송비금액)

# raw3 <- merge(raw, raw2, all.y = TRUE)

araw1 <- fsh.araw %>%
  select(1:8, 배송비금액)

#handling duplicates----
# idx <- duplicated(araw) | duplicated(araw, fromLast = TRUE)
# dup.raw <- araw[idx, ]
# idx2 <- duplicated(raw2) | duplicated(raw2, fromLast = TRUE) 
# dup.raw2 <- raw2[idx2, ] 
# raw2.rm <- raw2[!duplicated(raw2[,c(1:13)]),]

idx1 <- duplicated(araw1) | duplicated(araw1, fromLast = TRUE) 
dup.araw1 <- araw1[idx1, ] 
raw.rm <- araw1[!duplicated(araw1[,c(1:9)]),]

araw <- raw.rm

araw$TotalSales <- araw$배송비금액 + araw$판매가
araw$Product <- paste(araw$상품명, ifelse(is.na(araw$주문선택사항), " ",araw$주문선택사항))
araw <- araw[, c(1:4, 11 , 7:10)]
colnames(araw) = c("Orderid", "Site", "Sitecode", "date", "Product","Sales", "Psales", "Shipping", "TotalSales")

saveRDS(araw, "data/araw.rds")

# total sales by date -----
tsbd <- araw %>%
  group_by(date) %>%
  summarise(Totalsales = sum(TotalSales), ordercount = n()) %>%
  na.omit()

tsbd$date <- tsbd$결제일

# saveRDS(tsbd, "data/tsbd.rds")

tmc <- read_excel("data/tmc.xlsx")
tmc$date <- as.Date(tmc$date)

kpi <- tsbd %>%
  left_join(tmc) %>%
  mutate(roas = Totalsales/marketingcost * 100)

kpi$Totalsales <- as.integer(kpi$Totalsales)
kpi$marketingcost <- as.integer(kpi$marketingcost)

saveRDS(kpi, "data/kpi.rds")


