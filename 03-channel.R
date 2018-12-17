library(dplyr)
library(lubridate)

#tsbc
datef <- today()-1

c.med <- tsbc %>%
  filter(date == datef, Site == "카페24(신)") %>%
  ungroup() %>%
  select(Totalsales)

c.tm <- tsbc %>%
  filter(date == datef, Site == "티켓몬스터") %>%
  ungroup() %>%
  select(Totalsales)

c.cp <- tsbc %>%
  filter(date == datef, Site == "쿠팡(신)") %>%
  ungroup() %>%
  select(Totalsales)

c.el <- tsbc %>%
  filter(date == datef, Site == "11번가") %>%
  ungroup() %>%
  select(Totalsales)

c.gm <- tsbc %>%
  filter(date == datef, Site == "G마켓") %>%
  ungroup() %>%
  select(Totalsales)

c.au <- tsbc %>%
  filter(date == datef, Site == "옥션") %>%
  ungroup() %>%
  select(Totalsales)

c.gs <- tsbc %>%
  filter(date == datef, Site == "GS이숍") %>%
  ungroup() %>%
  select(Totalsales)
  
wm <- c("위메프(신)", "위메프2.0")
c.wm <- tsbc %>%
  filter(date == datef, Site %in% wm) %>%
  ungroup() %>%
  summarise(ts = sum(Totalsales))


#























tsbc %>% filter(Site == "카페24(신)") %>% select(Totalsales)%>%pull()%>%as.integer()%>%prettyNum(big.mark=",")