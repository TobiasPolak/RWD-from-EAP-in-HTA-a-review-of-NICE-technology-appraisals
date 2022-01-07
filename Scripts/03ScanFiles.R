

# 1. Installing and loading packages
packages <- list('tabulizer','installr', 'gsheet', 'pdftools', 'rvest', 'stringr', 'urltools',   'RCurl', 'stringr', 'readxl', 'readr', 'stringr', 'dplyr', 'data.table')
lapply(packages, require, character.only = TRUE)
`%notin%` <- Negate(`%in%`)

mainDir <- "C:/Users/31612/Documents/R/ispor/"

words <-  c(
  'compassionate',
  'expanded access',
  'early access',
  'early access to medicines',
  ' ATU ',
  'single patient IND',
  'single-patient IND',
  'named-patient',
  'named patient',
  'pre-approval access',
  'pre approval access',
  'autorisations temporaires utilisation',
  'autorisation termporaire utilisation',
  ' EAP ',
  'special access',
  'managed access'
)

result <- as.data.frame(matrix(0, nrow=1, ncol=7))
colnames(result) <- c('TA', 'doc', 'url', 'page', 'term', 'portfolio', 'context')

folders.portfolio <- list.dirs('C:\\Users\\31612\\Documents\\R\\ispor\\Portfoliettes', recursive = FALSE)
TA.portfolio <- sub(".*/", "", folders.portfolio)
portfolio.file.names <- dir(folders.portfolio, pattern = ".pdf")

folders <- list.dirs('C:\\Users\\31612\\Documents\\R\\ispor\\CombinedAppraisals', recursive = FALSE)
TA.list <- sub(".*/", "", folders)                    
TA.info <- as.data.frame(cbind(TA.list, folders))
TA.info$portfolio <- 0
TA.info$portfolio[which(TA.info$TA.list %in% TA.portfolio)] <- 1
TA.info$documents <- 0
TA.info$pages <- 0
TA.info$error <- 0 

for (folder in 1:length(folders)){
  file.names <- dir(folders[folder], pattern = ".pdf")
  TA.info$documents[folder] <- length(file.names)
  TA <- TA.list[folder]
  pagenumbers <- 0
  for (file in 1:length(file.names)) {
    folder.file <- paste(folders[folder],file.names[file], sep="\\" )
    filecheck <- try(temp <- pdf_text(folder.file))
    if (class(filecheck) == "try-error"){
      TA.info$error[folder] <- TA.info$error[folder] + 1
      print('error')
      next
    } else {}
    pagenumbers.ind <- pdf_info(folder.file)$pages
    for (word in words) {
      a <- grepl(word, temp, ignore.case = TRUE)
      pages <- which(a)
      if (sum(a) > 0) {
        
        for (page in pages) {
          
          lines <- read_lines(temp[page])
          indices <-  grep(word, lines, ignore.case = TRUE)
          for (index in 1:length(indices)) {
            context <-
              lines[min(max(indices[index] - 2,0), indices[index]):min(indices[index] + 2, length(lines))] ## select 2 lines before and after
            result.ind <- as.data.frame(matrix(0, nrow = 1, ncol = 7))
            colnames(result.ind) <-
              c('TA', 'doc','url', 'page', 'term',  'portfolio', 'context')
            
            if (file.names[file] %in% portfolio.file.names){
              portfolio <- 1
              url <- 'portfoliodocument'
            } else{
              portfolio <- 0
              page_url <-
                paste("https://www.nice.org.uk/guidance/",TA, sep = "")
              page_url <- paste(page_url, '/documents/', sep = "")
              page_url <- paste(page_url, sub(".pdf", "", file.names[file]), sep = "")
              page_url <- paste0(page_url, '#page=', page)
              url <- page_url
            }
            doc <- file.names[file]
            result.ind[1,] <- c(TA, doc, url, page, word , portfolio, 'context')
            context <-
              toString(apply(t(context) , 1, paste, collapse = " "))
            result.ind$context[1] <- context
            result <- rbind(result, result.ind)
          }
        }
      } else{
      }
    }
    pagenumbers <- pagenumbers + pagenumbers.ind
  }
  TA.info$pages[folder] <- pagenumbers
  cat('Percentage:', round((folder)/length(folders)*100,1), '% \n')
}

### Write results 
setwd(mainDir)
result_ordered <- (result[order(result[,"TA"], result[,"doc"], result[,"page"], result[,"term"]),])
timestamp <- Sys.Date()
write.csv2(TA.info, paste(timestamp, 'TAinfo.csv', sep="_"))
write.csv2(result_ordered, paste(timestamp, 'Annotated.csv', sep="_"))

EAMS <- grep('early access to medicines', result_ordered$context, ignore.case = TRUE  )
MAA <- which(result_ordered$term == 'managed access')
remove.set <- union(EAMS, MAA)

result_ordered_clean <- result_ordered[-c(remove.set),]
info <- result_ordered_clean %>% group_by(TA) %>% dplyr::summarize(
  count = n()
)
info_ordered <- info[order(info$count, decreasing = TRUE),]
result_final <- setDT(result_ordered_clean)[, freq := .N, by = .(TA)][order(-freq)]
result_final <- result_final[, -c('freq')]

