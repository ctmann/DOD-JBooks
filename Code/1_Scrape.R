
# Header ------------------------------------------------------------------
#' Navy and USMC annual budget justification document liniks
#' 
#' Note: I was unable to scrape the headings (h3) into the final dataframe
#' and so did an extended str_detect...a poor solution.
#' 
#' Problems: FY2018 is not included (yet)...unlike all other years, it's different

# Libraries ---------------------------------------------------------------
library(tidyverse)
library(rvest)
library(stringr)

navy_function <- function(my.site){
  x <- read_html(my.site) %>% 
  html_nodes(".s4-wpcell-plain") %>% 
  map_df(~{
    titles <- .x %>% html_nodes('li') %>% html_text()
    links <- .x %>% html_nodes('a') %>% html_attr("href")
    data_frame( titles, links)
  })
  return(x) }

#Create a df
# FY2018 is HOSED, so I've eliminated it for now

navy <- tibble(FY = as.character(c(2001:2017, 2019)),
              hyperlink = str_c("http://www.secnav.navy.mil/fmc/fmb/Pages/Fiscal-Year-", c(2001:2017, 2019), ".aspx"),
              Department = "Navy")

navy <- navy %>%
  mutate(data = map(hyperlink, navy_function)) %>% unnest() %>%
  mutate(
    service = case_when(
      str_detect(titles, "Navy") ~ "Navy",
      str_detect(titles, "Marine") ~ "Marine.Corps"
    ),
    program = case_when(
      str_detect(titles, "Personnel") ~ "Military.Personnel",
      str_detect(titles, "Operation") ~ "O.M",
      str_detect(titles, "Capital") ~ "NWCF",
      str_detect(titles,
        "Weapons|Shipbuilding|Sealift|Procurement Marine Corps|Consolidated"
      ) ~ "Procurement.General",
      str_detect(titles, "Aircraft") ~ "Procurement.Aircraft",
      str_detect(titles, "Other Procurement") ~ "Procurement.Other",
      str_detect(titles, "Ammunition") ~ "Procurement.Ammunition",
      str_detect(titles, "Realignment") ~ "BRAC",
      #str_detect(titles, "Family") ~ "Family.Housing",
      str_detect(titles, "Construction") ~ "Military.Construction",
      str_detect(titles, "Research") ~ "RDT.E",
      str_detect(titles, "Contingency") ~ "OCO",
      TRUE ~ "summary.docs"),
    reserve.or.not = if_else(
      str_detect(titles, "Reserve"), "reserve","not.reserve")) %>% 
  group_by(program) %>% 
  mutate(amended.or.not = if_else(
    any(str_detect(titles, "Amend")), "PBR.for.this.program.was.amended", "not.amended")) %>% ungroup() %>%
  group_by(FY) %>%  mutate(sorting.id = row_number() ) %>% ungroup() %>% 
  select(sorting.id, everything())


# Export ------------------------------------------------------------------
write_csv(navy, "./Data/Processed/navy_FY2001-FY2019.csv")
library(feather)
write_feather(navy, "./Data/Processed/navy_FY2001-FY2019.feather")  
  
  
  
  
  












