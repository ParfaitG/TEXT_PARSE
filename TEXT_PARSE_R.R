
setwd("C:\\Path\\To\\Working\\Directory")

# READ IN INPUT
file <- paste0(getwd(), "\\TEXT\\Input.txt")
con <- file(description=file, open="r")
contents <- readLines(con, n=-1L, warn=FALSE)
close(con)

# REPLACE SPECIAL CHARACTERS AND NUMBERS
contents <- lapply(contents, function(x){
  
  x <- gsub("[^A-Za-z]", " ", x)
  x <- gsub("^\\s+|\\s+$", "", x)
  x <- gsub(" s ", "'s", x)
  x <- gsub("o er", "o'er", x)
  x <- gsub("\\s+", " ", x)
  
})

contents <- Filter(nchar, contents)

# OUTPUT FILE
file <-  paste0(getwd(), "\\TEXT\\Output_R.txt")
con <- file(description=file, open="w")
contents <- lapply(contents, function(i) writeLines(i, con))
close(con)

print("Successfully parsed and outputted text file!")
