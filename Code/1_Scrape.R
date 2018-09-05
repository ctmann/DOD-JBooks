
# Libraries ---------------------------------------------------------------
library(tidyverse)
library(rvest)

# Create Refs

# Navy
# Example with one year
library(tidyverse)
library(rvest)

my.url <- read_html("http://www.secnav.navy.mil/fmc/fmb/Pages/Fiscal-Year-2019.aspx") %>% 
  html_nodes("#sharePointMainContent") 

hyperlink.title <- my.url %>% 
  html_nodes("li") %>% 
  html_text()

hyperlink <- my.url %>% 
  html_nodes("li") %>% 
  html_nodes("a") %>% 
  html_attr("href")

df <- tibble(title, hyperlink.title)
df


View(df)

library(tidyverse)
library(rvest)

my.url <- read_html("http://www.secnav.navy.mil/fmc/fmb/Pages/Fiscal-Year-2019.aspx") %>% 
  html_nodes("#sharePointMainContent") 


subject.heading <- my.url %>% 
  html_nodes("h3") %>% 
  html_text() %>% str_trim()

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

