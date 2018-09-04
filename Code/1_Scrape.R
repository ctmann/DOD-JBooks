
# Libraries ---------------------------------------------------------------
library(tidyverse)
library(rvest)

# Create Refs

# Navy
# Example with one year

my.url <- read_html("http://www.secnav.navy.mil/fmc/fmb/Pages/Fiscal-Year-2019.aspx")

title <- my.url %>% 
  html_nodes("#sharePointMainContent") %>% 
  html_nodes("li") %>% 
  html_text()

hyperlink <- my.url %>% 
  html_nodes("#sharePointMainContent") %>% 
  html_nodes("li") %>% 
  html_nodes("a") %>% 
  html_attr("href")

df <- tibble(title, hyperlink)



# Notepad-------------------------
# my.url %>% 
#   html_node("#sharePointMainContent") %>% 
#   html_nodes("table") %>% 
#   html_table(fill = T, header = T)

# ms-standardheader ms-WPTitle


# https://github.com/hadley/rvest/issues/12
# nodes <- "http://pyvideo.org/category/50/pycon-us-2014" %>%
#   html %>%
#   html_nodes("div.video-summary-data")
# 
# column <- function(x) nodes %>% html_node(xpath = x) %>% html_text()
# 
# df <- data.frame(
#   title = column("div[1]//a"),
#   author = column("div[3]//a"),
#   date = column("div[4]//small[1]"),
#   language = column("div[4]//small[2]"),
#   description = column("div[5]//p"),
#   stringsAsFactors = FALSE
# )

