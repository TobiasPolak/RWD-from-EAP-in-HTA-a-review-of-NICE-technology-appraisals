# 1. Installing and loading packages
packages <-
  list(
    'tabulizer',
    'installr',
    'gsheet',
    'pdftools',
    'tidyr',
    'readr',
    'rvest',
    'stringr',
    'urltools',
    'RCurl',
    'stringr',
    'readxl',
    'stringr',
    'dplyr'
  )
lapply(packages, require, character.only = TRUE)

# Specify first TA, last TA, first HST and last HST
first.TA.test <- 185
last.TA.test <- 667
first.HST.test <- 1
last.HST.test <- 13

# Create dataframe to store TA, URL, Title, Publication dates, number of documents, number of pages within documents, whether or not contains a portfolio PDF.
nrow = length(first.TA.test:last.TA.test) + length(first.HST.test:last.HST.test)
TA.test <- as.data.frame(matrix(0, ncol = 8, nrow = nrow))
TA.test[1:length(first.TA.test:last.TA.test), 1] <-
  paste('TA', sep = "", first.TA.test:last.TA.test)
TA.test[(length(first.TA.test:last.TA.test)+1):nrow, 1] <-
  paste('HST', sep = "", first.HST.test:last.HST.test)
colnames(TA.test) <-
  c('TA', 'URL', 'Title', 'First Date', 'Last Date', 'Documents', 'Pages', 'Portfolio')

# Create list to store URL information
pdf_storage_test <- list()

for (i in 1:length(TA.test$TA)) {
  page_url <-
    paste("https://www.nice.org.uk/guidance/", TA.test$TA[i], sep = "")
  page_url <- paste(page_url, '/history', sep = "")
  TA.test$URL[i] <- page_url
  
  page <- read_html(page_url)
  
  title <-
    page %>%
    html_nodes('h1') %>%
    html_text()
  
  TA.test$Title[i] <- title
  
  date <-
    page %>%
    html_nodes('span.published-date') %>%
    html_text()
  
  TA.test$`First Date`[i] <- first(date)
  TA.test$`Last Date`[i] <- last(date)
  
  raw_list <-
    page %>% # takes the page above for which we've read the html
    html_nodes("a") %>%  # find all links in the page
    html_attr("href") %>% # only look for href links
    str_subset("documents") %>% #NICE uses /documents/  tag
    str_c("https://www.nice.org.uk", .) # append the original URL again
  
  pdf_list <- vector()
  for (url in 1:length(raw_list)) {
    headers <- curlGetHeaders(raw_list[url])
    ct <-
      headers[grep("Content-Type", headers, ignore.case = TRUE)] #get the content-headers
    if ((grepl('pdf', x = ct[1]))) {
      #check whether it is an application/pdf
      pdf_list <- append(pdf_list, raw_list[url])
    } else{
      
    }
  }
  TA.test$Documents[i] <- length(pdf_list)
  pdf_storage_test$url[[i]] <- pdf_list
  pdf_storage_test$name[[i]] <- TA.test$TA[i]
  print(i)
  print(paste(round(i / length(TA.test$TA) * 100, 3), "%"))
}

cup_test <- pdf_storage_test

