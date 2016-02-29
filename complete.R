complete <- function(directory, id=1:332) {
  ## director - character vector of length 1 indicating location of the files
  ## pollutant - character vector of length 1 indicating the name of the pollutant (sulfite or nitrate)
  ## id - vector id indicating monitors to be used
  ## return mean of pollutant accross all monitors minus na
  data_dir = paste(c(getwd(),directory),collapse="/")[[1]];
  result <- data.frame(id=id)
  nobs <- vector()
  
  ## list all the files in the directory
  all_files <- list.files(data_dir)
  for (x in 1:length(all_files)) {
    if (x %in% id) {
      filename = paste (c (data_dir, all_files[x]), collapse="/")
      myt <- read.table(filename, header=TRUE, sep=",")
      # retrive data where all columns are available
      full_data = myt[ !( is.na(myt$sulfate) | is.na(myt$nitrate) ),]
      nobs <- c(nobs, nrow(full_data))
    }
  }
  cbind(result, nobs=nobs)
  
  
}