# 6.1 Navigating and managing the filesystem
# The first step when importing data from a spreadsheet is to locate the file containing the data.
# Although we do not recommend it, you can use an approach similar to what you do to open files
# in Microsoft Excel by clicking on the RStudio “File” menu, clicking “Import Dataset”

# 6.1.1 The filesystem
# You can think of your computer’s filesystem as a series of nested folders,
# each containing other folders and files. We refer to folders as `directories`.
# `root directory` - the folder that contains all other folders.
# `working directory` - the directory in which we are currently located.

# 6.1.2 Relative and full paths
# The path of a file is a list of directory names that can be thought of as instructions on
# what folders to click on, and in what order, to find the file. If these instructions are for
# finding the file from the root directory, we refer to it as the `full path`. If the
# instructions are for finding the file starting in the working directory, we refer to it as
# a `relative pat`

system.file(package = "dslabs")
# full path under linux: [1] "/home/{username}/R/x86_64-pc-linux-gnu-library/4.6/dslabs"

# We can use the function `list.files` to show the names of files and directories in any
# directory

dir <- system.file(package = "dslabs")
list.files(dir)

# 6.1.3 The working directory
# If you want to know the full path of your working directory using the `getwd` function
getwd()
#  If you need to change your working directory, you can use the function `setwd`
# or you can change it through RStudio by clicking on “Session”.

# changes nothing, but triggers no error just as na example of the function call
# instead of the interface interaction
setwd(getwd())

# 6.1.4 Generating path names
# The `file.path` function combines characters to form a complete path, ensuring
# compatibility with the respective operating system.

dir <- system.file(package = "dslabs")
# points towards the /{dir}/extdata/murders.csv
file_path <- file.path(dir, "extdata", "murders.csv")

file.copy(file_path, "murders.csv")
list.files(getwd())
# If the file is copied successfully, this function will return TRUE
# for overwrite use the parameter overwrite
file.copy(file_path, "murders.csv", overwrite = TRUE)

# ------------------------------------

# 6.2 File types

# 6.2.1 Text files
# . You can look at any number of lines from within R using the `readLines` function
# in order to understand the structure:

# keep in mind that resolution of your screen my yield weird formatting
# in RStudio
readLines('murders.csv', n = 5)

# 6.2.2 Binary files
# not covered by the book. A function `readBin` is mentioned which
# is able to read any binay file.

# 6.2.3 Encoding
# RStudio typically uses UTF-8 as its default

# non UTF-8 encoded file example
fn <- "calificaciones.csv"

file.copy(file.path(system.file("extdata", package = "dslabs"), fn), fn)

readLines(fn, n = 1)
# result:
# [1] "\"nombre\",\"f.n.\",\"estampa\",\"puntuaci\xf3n\""
# notice the final element in the result 
