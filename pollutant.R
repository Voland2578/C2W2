pollutantmean <- function(directory, pollutant, id=1:332) {
   ## director - character vector of length 1 indicating location of the files
   ## pollutant - character vector of length 1 indicating the name of the pollutant (sulfite or nitrate)
   ## id - vector id indicating monitors to be used
   ## return mean of pollutant accross all monitors minus na
   data_dir = paste(c(getwd(),directory),collapse="/")[[1]];
   
   ## list all the files in the directory
   all_files <- list.files(data_dir)
   for (x in 1:length(all_files)) {
     ##print ( cat("Checking", x, "\n"))
     if (x %in% id) {
          filename = paste (c (data_dir, all_files[x]), collapse="/")
          myt <- read.table(filename, header=TRUE, sep=",")
          #print (cat ( c( "Loading ", filename, " with ", nrow(myt), "records\n"), sep=""))
          if (exists("merged_data")) {
            merged_data <- rbind(merged_data, myt);
          }
          else { 
            merged_data <- myt
          }
          
     }
   }
   if (! (pollutant %in% colnames(merged_data) )) {
     stop(" type %s is not found", pollutant)
   }
   
   data <- merged_data[,pollutant]
   data <- data[!is.na(data)]
   mean(data)

   
  }