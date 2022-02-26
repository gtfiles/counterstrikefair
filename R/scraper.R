library(rvest)

date_begin <- Sys.Date()-365
date_end <- Sys.Date()

url_players <- paste0(
  "https://www.hltv.org/stats/players?startDate=",
                      date_begin,"&endDate=", date_end,"&rankingFilter=All")
url_pistolrounds <- paste0(
  "https://www.hltv.org/stats/players/pistols?startDate=",
                           date_begin,"&endDate=", date_end,"&rankingFilter=All")
url_opening <- paste0(
  "https://www.hltv.org/stats/players/openingkills?startDate=",
                      date_begin,"&endDate=", date_end,"&rankingFilter=All")

df.players <- read_html(url_players)
df.players <- df.players %>% html_nodes(
  xpath = "/html/body/div[2]/div/div[2]/div[1]/div[2]/table/tbody") %>%
  html_table()
df.players <- data.frame(df.players)
df.players <- data.frame(df.players$X1, df.players$X3, df.players$X4,
                         df.players$X5, df.players$X6, df.players$X7)
colnames(df.players) <- c("Player",
                          "Maps",
                          "Rounds",
                          "KDdiff",
                          "K/D",
                          "Rating2.0")
write.csv(df.players, "data/players.csv")

df.pistolrounds <- read_html(url_pistolrounds)
df.pistolrounds <- df.pistolrounds %>% html_nodes(
  xpath = "/html/body/div[2]/div/div[2]/div[1]/div[2]/table/tbody") %>%
  html_table()
df.pistolrounds <- data.frame(df.pistolrounds)
df.pistolrounds <- data.frame(df.pistolrounds$X1, df.pistolrounds$X3,
                              df.pistolrounds$X4, df.pistolrounds$X5,
                              df.pistolrounds$X6)
colnames(df.pistolrounds) <- c("Player",
                               "Maps",
                               "KDdiff",
                               "K/D",
                               "Rating2.0")
write.csv(df.pistolrounds, "data/pistols.csv")

df.opening <- read_html(url_opening)
df.opening <- df.opening %>% html_nodes(
  xpath = "/html/body/div[2]/div/div[2]/div[1]/div[2]/table/tbody") %>%
  html_table()
df.opening <- data.frame(df.opening)
colnames(df.opening) <- c("Player",
                          "Maps",
                          "Rounds",
                          "KPR",
                          "DPR",
                          "Attempts",
                          "Success",
                          "Rating")
write.csv(df.opening, "data/opening.csv")


