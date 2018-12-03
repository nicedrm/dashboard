library(dplyr)
library(readxl)
library(readr)
library(lubridate)

inv_1107 <- read_csv("data/inv.1107.csv")

#Preprocessing from Raw 
sraw <- Raw[, c(2,3,8,9,29,22)]
sraw$TotalSales <- Raw$배송비금액 + Raw$판매가
sraw$product <- paste(Raw$상품명, ifelse(is.na(Raw$주문선택사항), " ",Raw$주문선택사항))
colnames(sraw) = c("Site", "Sitecode", "Paiddate", "Shippingdate","Shippingpaid", "Sales", "TotalSales", "Product")
sraw <- sraw[, c(8,3,4,5,6,7,1,2)]

sraw$Paiddate <- as.Date(sraw$Paiddate)

tsbd <- sraw %>%
  group_by(Paiddate) %>%
  summarise(Totalsales = sum(TotalSales), ordercount = n())

names(tsbd) <- c("N", "날짜", "총매출", "주문수")

saveRDS(tsbd, "data/tsbd.rds")

#kpi-----
names(kpi_1113) <- c("날짜", "총매출", "주문수", "요일", "광고지출", "ROAS")
kpi_1113$총매출 <- format(kpi_1113$총매출, big.mark = ",")
kpi_1113$광고지출 <- format(kpi_1113$광고지출, big.mark = ",")
kpi_1113$날짜 <- as.Date(kpi_1113$날짜)

saveRDS(kpi_1113, "data/kpi.1113.rds")
