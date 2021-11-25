# Please make sure to run 01loadURL.r first.

# Installing and loading packages
packages <- list('tabulizer','installr', 'gsheet', 'pdftools', 'rvest', 'stringr', 'urltools',   'RCurl', 'stringr', 'readxl', 'stringr', 'dplyr')
lapply(packages, require, character.only = TRUE)

# Create dataframe to store information of downloaded documents from URL.
download.info <- as.data.frame(unlist(cup_test$name))
colnames(download.info) <- 'TA'
download.info$error <- 0
download.info$portfolio <- 0 
download.info$documents <- 0

# We will save all appraisal documentation as a subdirectory of your chosen main directory (see 'mainDir' and 'subDir' inside below loop). We will set the file name equal to the last part of the URL and add '.pdf'. The URL may exceed the maximum amount of allowed characters of PathFiles. In that case, we will have to replace the URL with a different file name. 
replaceURL <- as.data.frame(matrix(0, nrow=1, ncol=5))
colnames(replaceURL) <- c('TA', 'url', 'old', 'length', 'new')

for (TA in 1:length(cup_test$name)) {
  for (url in 1:lengths(cup_test$url[TA])) {
    nrow <- length(cup_test$url[[TA]])
    if (nrow == 0) {
      next
    }else{
      download.info$documents[TA] <- nrow
    }
    
    mainDir <- "ENTER YOUR MAIN WORKING DIRECTORY"
    subDir = paste0("SUBFOLDERNAME/", cup_test$name[TA],"/")
    dir.create(file.path(mainDir, subDir), showWarnings = FALSE)
    setwd(file.path(mainDir, subDir))
    
    temp <- tempfile()
    
    destfile = paste0(sub(".*/", "", cup_test$url[[TA]][url]), ".pdf")
    path.length <- nchar(destfile)
    if (path.length > 185){
      old <- destfile
      destfile <- substr(destfile, start = path.length - 185, stop = nchar(destfile))
      destfile <- paste0('TL',cup_test$name[TA],url, destfile)
      new <- destfile
      
      replaceURL.ind <- as.data.frame(matrix(0, nrow=1, ncol=5))
      colnames(replaceURL.ind) <- c('TA', 'url', 'old', 'length', 'new')
      replaceURL.ind[1,] <- (c(cup_test$name[TA], url, old, path.length, new))
      replaceURL <- rbind(replaceURL, replaceURL.ind)
    }
    
    downloadcheck <- try({
      download.file(url = cup_test$url[[TA]][url],
                    destfile = destfile,
                    mode = 'wb',
                    verbose = F,
                    quiet = T)
      
      temp <- pdf_text(destfile)
    }) 
    if (class(downloadcheck) == "try-error"){
      download.info$error[TA] <- download.info$error[TA] + 1
      print('error')
      print(cup_test$url[[TA]][url])
      print(TA)
      print(url)
      next
    } else {}
    
    if (temp == "For the best experience, open this PDF portfolio in\r\n      Acrobat 9 or Adobe Reader 9, or later.\r\n                Get Adobe Reader Now!\r\n") {
      TA.test$Portfolio[which(TA.test$TA == cup_test$name[[TA]])] <- 1
      print(url)
      print('portfolio')
      download.info$portfolio[TA] <- download.info$portfolio[TA] + 1
      next
    }
    
  }
  print(cup_test$name[[TA]])
  cat('Percentage:', round((TA)/length(cup_test$name)*100,1), '% \n')
}

# Write time-stamped results to files in this folder
setwd(mainDir)
timestamp <- Sys.Date()
write.csv2(replaceURL, paste(timestamp, 'replaceURL.csv', sep="_"))
write.csv2(download.info, paste(timestamp, 'downloadInfo.csv', sep="_"))
