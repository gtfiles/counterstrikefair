library(rvest)

date_begin <- as.character(Sys.Date()-365)
date_end <- as.character(Sys.Date())   

playersurl <- paste0("https://www.hltv.org/stats/players?startDate=", date_begin,"&endDate=", date_end,"&rankingFilter=All")
pistolurl <- paste0("https://www.hltv.org/stats/players/pistols?startDate=", date_begin,"&endDate=", date_end,"&rankingFilter=All")
openingurl <- paste0("https://www.hltv.org/stats/players/openingkills?startDate=", date_begin,"&endDate=", date_end,"&rankingFilter=All")

playerratings <- read_html(playersurl)
playerratings = playerratings %>% html_nodes(xpath = "/html/body/div[2]/div[1]/div[2]/div[1]/div/table") %>%
  html_table()
df.playerratings <- data.frame(playerratings)
df.playerratings <- data.frame(c(df.playerratings[1],df.playerratings[3:7]))
write.csv(playerratings, "data/playerratings.csv")

pistolrounds <- read_html(pistolurl)
pistolrounds = pistolrounds %>% html_nodes(xpath = "/html/body/div[2]/div[1]/div[2]/div[1]/div/table") %>%
  html_table()
df.pistolrounds <- data.frame(pistolrounds)
pistolrounds<- data.frame(c(pistolrounds[1],pistolrounds[3:6]))
write.csv(pistolrounds, "data/pistolrounds.csv")

openingkills <- read_html(openingurl)
openingkills = openingkills %>% html_nodes(xpath = "/html/body/div[2]/div[1]/div[2]/div[1]/div/table") %>%
  html_table()
df.openingkills <- data.frame(openingkills)
write.csv(openingkills, "data/openingkills.csv")

remove(openingkills, pistolrounds, playerratings, openingurl, pistolurl, playersurl)

