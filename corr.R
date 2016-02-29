corr <- function(directory, threshold=0) {
  source("pollutant.R")
  ## directory - character vector of length 1 indicating location of the files
  num_records = complete(directory)
  # filter records where threshold is not passed
  num_records <- num_records[num_records$nobs>threshold,]
  file_ids <- num_records$id
  
  data_dir = paste(c(getwd(),directory),collapse="/")[[1]];

  result <- vector()  
  all_files <- list.files(data_dir)
  
  for (x in 1:length(all_files)) {
    if (x %in% file_ids) {
      filename = paste (c (data_dir, all_files[x]), collapse="/")
      myt <- read.table(filename, header=TRUE, sep=",")
      result <- c(result, cor(myt$nitrate, myt$sulfate, use="pairwise.complete.obs"))
    }
  }
  
  result
  
      
      
      
      
  
}