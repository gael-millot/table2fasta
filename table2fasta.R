#!/usr/bin/env Rscript

#########################################################################
##                                                                     ##
##     table2fasta.R                                                   ##
##                                                                     ##
##     Gael A. Millot                                                  ##
##     Bioinformatics and Biostatistics Hub                            ##
##     Computational Biology Department                                ##
##     Institut Pasteur Paris                                          ##
##                                                                     ##
#########################################################################




################################ Aim


# Creates all the fasta files from a table file (.xlsx, .csv, .tsv and .txt).


################################ End Aim


################################ Introduction


################################ End Introduction


################################ Acknowlegments


################################ End Acknowlegments


################################ Initialization


# R version checking
if(version$version.string != "R version 4.4.2 (2024-10-31 ucrt)"){
    cat(paste0("\n\nWARNING: THE ", version$version.string, " IS NOT THE 4.4.2 (2024-10-31 ucrt) RECOMMANDED\n\n"))
}
# other initializations
erase.objects = TRUE # write TRUE to erase all the existing objects in R before starting the algorithm and FALSE otherwise. Beginners should use TRUE
if(erase.objects == TRUE){
    rm(list = ls(all.names = TRUE))
    erase.objects = TRUE
}
erase.graphs = TRUE # write TRUE to erase all the graphic windows in R before starting the algorithm and FALSE otherwise
script <- "table2fasta"
cute <- "https://gitlab.pasteur.fr/gmillot/cute_little_R_functions/-/raw/v11.4.0/cute_little_R_functions.R" # single character string indicating the path of the cute_little_R_functions.R file required for this script. Example: cute <- "https://gitlab.pasteur.fr/gmillot/cute_little_R_functions/-/raw/v11.4.0/cute_little_R_functions.R"
log <- "table2fasta.log" # single character string indicating the name of the log file. Example: log <- "table2fasta.log"


################################ End Initialization



#########################################################################
##                                                                     ##
##     Parameters that need to be set by the user                      ##
##                                                                     ##
#########################################################################


path <- "https://zenodo.org/records/10844886/files/ig_sequences.xlsx" # single character string indicating the full path of the table file. Example: path <- "C:/Users/gmillot/Documents/Git_projects/repertoire_profiler/dataset/table2fasta_test_2/ig_sequences.xlsx". Example: path <- "C:/Users/gmillot/Desktop/metadata.tsv"
Name <- "Name" # single character string indicating the column name of the sequence names. Example: Name <- "Name"
Seq <- c("VH", "VL") # vector of character strings indicating the column names of the table file containing sequences. Example: Seq <- c("VH", "VL"). Example: Seq <- c("VH").
categ <- c("Patient", "Sample") # vector of character strings indicating additional names of qualitative columns of the table file. A specific folder will be generated for each class of each of these columns, with the fasta sequence in it when non NA or empty cells are present in this column. Write "NULL" if not required. Example: categ <- c("Patient", "Sample"). Example: categ <- c("Patient")
out.path <- "C:/Users/gmillot/Desktop" # single character string indicating the path of the output folder. Example: out.path <- "C:/Users/gmillot/Desktop"
file.kind <- "multi" # single character string indicating kind of fasta file returned. Either "single" (each sequence in a different fasta file) or "multi" (all the sequences in a single fasta file). file.kind <- "multi"


#########################################################################
##                                                                     ##
##     End Parameters that need to be set by the user                  ##
##                                                                     ##
#########################################################################




################################ Config import


tempo.cat <- "KIND OF RUN (SCRIPT, COPY-PASTE OR SOURCE): "
if(interactive() == FALSE){ # if(grepl(x = commandArgs(trailingOnly = FALSE), pattern = "R\\.exe$|\\/R$|Rcmd\\.exe$|Rcmd$|Rgui\\.exe$|Rgui$|Rscript\\.exe$|Rscript$|Rterm\\.exe$|Rterm$")){ # detection of script usage
    run.way <- "SCRIPT"
    cat(paste0("\n\n", tempo.cat, run.way, "\n\n"))
    command <- paste0(commandArgs(trailingOnly = FALSE), collapse = ",") # recover the full command
    args <- commandArgs(trailingOnly = TRUE) # recover arguments written after the call of the R script
    if(any(is.na(args))){
        stop(paste0("\n\n================\n\nERROR IN ", script, ".R\nTHE args OBJECT HAS NA\n\n================\n\n"), call. = FALSE)
    }
    tempo.arg.names <- c(
        "path", 
        "Name", 
        "Seq", 
        "categ", 
        "out.path", 
        "file.kind", 
        "cute", 
        "log"
    ) # objects names exactly in the same order as in the bash code and recovered in args. Here only one, because only the path of the config file to indicate after the table2fasta.R script execution
    if(length(args) != length(tempo.arg.names)){
        stop(paste0("\n\n================\n\nERROR IN ", script, ".R\nTHE NUMBER OF ELEMENTS IN args (", length(args),") IS DIFFERENT FROM THE NUMBER OF ELEMENTS IN tempo.arg.names (", length(tempo.arg.names),")\nargs:", paste0(args, collapse = ","), "\ntempo.arg.names:", paste0(tempo.arg.names, collapse = ","), "\n\n================\n\n"), call. = FALSE)
    }
    for(i1 in 1:length(tempo.arg.names)){
        assign(tempo.arg.names[i1], args[i1])
    }
    rm(tempo.arg.names, args, i1)
}else if(sys.nframe() == 0L){ # detection of copy-paste/direct execution (for debugging). With script it is also 0, with source, it is 4
    run.way <- "COPY-PASTE"
    cat(paste0("\n\n", tempo.cat, run.way, "\n\n"))
}else{
    run.way <- "SOURCE" # using source(), sys.nframe() is 4
    cat(paste0("\n\n", tempo.cat, run.way, "\n\n"))
}
rm(tempo.cat)


################################ End Config import

################################ Test

# No need because the parameter settings are not in another file but above

################################ end Test

################################ Recording of the initial parameters


param.list <- c(
    "erase.objects", 
    "erase.graphs", 
    "script", 
    "run.way",
    if(run.way == "SCRIPT"){"command"}, 
    "path", 
    "Name", 
    "Seq", 
    "categ", 
    "out.path",
    "file.kind", 
    "cute", 
    "log"
)
if(any(duplicated(param.list))){
    stop(paste0("\n\n================\n\nINTERNAL CODE ERROR 1 IN ", script, ".R\nTHE param.list OBJECT CONTAINS DUPLICATED ELEMENTS:\n", paste(param.list[duplicated(param.list)], collapse = " "), "\n\n================\n\n"), call. = FALSE) # message for developers
}
if(erase.objects == TRUE){
    created.object.control <- ls()[ ! ls() %in% "param.list"]
    if( ! (all(created.object.control %in% param.list) & all(param.list %in% created.object.control))){
        stop(paste0("\n\n================\n\nINTERNAL CODE ERROR 2 IN ", script, ".R\nINCONSISTENCIES BETWEEN THE ARGUMENTS USED AND THE PARAMETERS REQUIRED IN THE EXECUTABLE CODE FILE\nTHE ARGUMENTS NOT PRESENT IN THE EXECUTABLE FILE (", script, ".R) ARE:\n", paste(created.object.control[ ! created.object.control %in% param.list], collapse = " "), "\nTHE PARAMETERS OF THE EXECUTABLE FILE (", script, ".R) NOT PRESENT IN THE ARGUMENTS ARE:\n", paste(param.list[ ! param.list %in% created.object.control], collapse = " "), "\n\n================\n\n"), call. = FALSE) # message for developers
    }
}
char.length <- nchar(param.list)
space.add <- max(char.length) - char.length + 5
param.ini.settings <- character(length = length(param.list))
for(i in 1:length(param.list)){
    param.ini.settings[i] <- paste0("\n", param.list[i], paste0(rep(" ", space.add[i]), collapse = ""), paste0(get(param.list[i]), collapse = ",")) # no env = sys.nframe(), inherit = FALSE in get() because look for function in the classical scope
}


################################ End Recording of the initial parameters


################################ Functions


# Functions are built such that they should have no direct use of Global objects (going through the R scope), and only use function arguments
# 1) Cute little function is sourced for the moment into the .GlobalEnv environment, but may be interesting to put it into a new environement just above .GlobalEnv environment. See https://stackoverflow.com/questions/9002544/how-to-add-functions-in-an-existing-environment
# 2) Argument names of each function must not be a name of Global objects (error message otherwise)
# 3) Argument name of each function ends with "_fun" in the first function, "_2fun" in the second, etc. This prevent conflicts with the argument partial names when using these functions, notably when they are imbricated

fun_source_test <- function(path, script){ # do not write script = script: can produce recursive error if script argument is not specified thenafter
# AIM
# Test if one path exists (url or local)
# ARGUMENTS
# path: single character string of the path to test
# script: single character string of the current script file
# RETURN
# An error message if the path does not exists, nothing otherwise
# EXAMPLES
# fun_source_test(path = "caca", script = "test")
# DEBUGGING
# path = "https://zenodo.org/records/10814482/files/ig_sequences.xlsx" ; script = "test"
    name <- deparse(substitute(path))
    if(length(path) != 1){
        stop(paste0("\n\n============\n\nERROR IN ", script, ".R\n", name, " PARAMETER MUST BE LENGTH 1: ", paste(path, collapse = " "), "\n\n============\n\n"), call. = FALSE)
    }else if(grepl(x = path, pattern = "^http")){
        tempo.name <- paste0("tmp_table2fasta.R_", as.integer(Sys.time()))
        if(file.exists(tempo.name)){
            stop(paste0("\n\n============\n\nERROR IN ", script, ".R\nTHE TEMPORARY FILE USED BY THE ", script, " SCRIPT ALREADY EXISTS:\n", file.path(tempo.name), "\n\n. PLEASE, RERUN.\n\n============\n\n"), call. = FALSE)
        }else{
            tempo.try <- try(suppressWarnings(suppressMessages(download.file(path, tempo.name, method="auto", quiet=TRUE))), silent = TRUE)
            if(file.exists(tempo.name)){
                file.remove(tempo.name)
            }
            if(any(grepl(x = tempo.try, pattern = "^[Ee]rror"))){
                stop(paste0("\n\n============\n\nERROR IN ", script, ".R\nHTTP INDICATED IN THE ", name, " PARAMETER DOES NOT EXISTS: ", path, "\n\n============\n\n"), call. = FALSE)
            }
        }
    }else if( ! grepl(x = path, pattern = "^http")){
        if( ! file.exists(path)){
            stop(paste0("\n\n============\n\nERROR IN ", script, ".R\nFILE INDICATED IN THE ", name, " PARAMETER DOES NOT EXISTS: ", path, "\n\n============\n\n"), call. = FALSE)
        }
    }else{
        tempo.cat <- paste0("\n\n================\n\nINTERNAL CODE ERROR 3 IN ", script, ".R: CODE HAS TO BE MODIFIED\n\n============\n\n")
        stop(tempo.cat, call. = FALSE)
    }
}



################ import functions from cute little functions toolbox

fun_source_test(path = cute, script = script)
source(cute, local = .GlobalEnv)

# required cute function checking
req.function <- c(
    "fun_check", 
    "fun_pack", 
    "fun_report"
)
tempo <- NULL
for(i1 in req.function){
    if(length(find(i1, mode = "function")) == 0L){
        tempo <- c(tempo, i1)
    }
}
if( ! is.null(tempo)){
    tempo.cat <- paste0("ERROR IN ", script, ".R\nREQUIRED cute FUNCTION", ifelse(length(tempo) > 1, "S ARE", " IS"), " MISSING IN THE R ENVIRONMENT:\n", paste0(tempo, collapse = "()\n"))
    stop(paste0("\n\n================\n\n", tempo.cat, "\n\n================\n\n"), call. = FALSE) # == in stop() to be able to add several messages between ==
}
# end required function checking

################ end import functions from cute little functions toolbox

################ local function: package import

# R Packages required
req.package.list <- c(
    "lubridate", 
    # "rJava", # dependency of xlsx. Warning: requires the install of java 64.bit, not 32, using https://www.java.com/fr/download/manual.jsp. Otherwise, error message: le chargement du package ou de l'espace de noms a échoué pour ‘xlsx’ :.onLoad a échoué dans loadNamespace() pour 'rJava', détails
    "openxlsx"
)
# for(i in 1:length(req.package.list)){suppressMessages(library(req.package.list[i], character.only = TRUE))}
fun_pack(req.package = req.package.list, load = TRUE, lib.path = NULL) # packages are imported even if inside functions are written as package.name::function() in the present code

################ end local function: package import

################ other functions

################ end other functions

################################ End Functions

################################ Ignition

ini.date <- Sys.time()
ini.time <- as.numeric(ini.date) # time of process begin, converted into seconds

################################ End ignition

################################ Checking


# reserved words
# end reserved words
# argument primary checking
arg.check <- NULL #
text.check <- NULL #
checked.arg.names <- NULL # for function debbuging: used by r_debugging_tools
ee <- expression(arg.check <- c(arg.check, tempo$problem) , text.check <- c(text.check, tempo$text) , checked.arg.names <- c(checked.arg.names, tempo$object.name))
tempo <- fun_check(data = path, class = "vector", typeof = "character", length = 1) ; eval(ee)
tempo <- fun_check(data = Name, class = "vector", typeof = "character", length = 1) ; eval(ee)
tempo <- fun_check(data = Seq, class = "vector", typeof = "character") ; eval(ee)
tempo <- fun_check(data = categ, class = "vector", typeof = "character") ; eval(ee)
tempo <- fun_check(data = out.path, class = "vector", typeof = "character", length = 1) ; eval(ee)
tempo <- fun_check(data = file.kind, options = c("single", "multi"), length = 1) ; eval(ee)
# cute already tested above
tempo <- fun_check(data = log, class = "vector", typeof = "character", length = 1) ; eval(ee)
if(any(arg.check) == TRUE){ # normally no NA
    stop(paste0("\n\n================\n\n", paste(text.check[arg.check], collapse = "\n"), "\n\n================\n\n"), call. = FALSE) # == in stop() to be able to add several messages between == #
}
# end argument primary checking
# second round of checking and data preparation
# management of NA arguments
# end management of NA arguments
# management of NULL arguments
tempo.arg <-c(
    "path", 
    "out.path",
    "file.kind",
    "cute", 
    "log"
)
tempo.log <- sapply(lapply(tempo.arg, FUN = get, env = sys.nframe(), inherit = FALSE), FUN = is.null)
if(any(tempo.log) == TRUE){# normally no NA with is.null()
    tempo.cat <- paste0("ERROR IN ", script, ".R:\n", ifelse(sum(tempo.log, na.rm = TRUE) > 1, "THESE ARGUMENTS\n", "THIS ARGUMENT\n"), paste0(tempo.arg[tempo.log], collapse = "\n"),"\nCANNOT BE NULL")
    stop(paste0("\n\n================\n\n", tempo.cat, "\n\n================\n\n"), call. = FALSE) # == in stop() to be able to add several messages between ==
}
# end management of NULL arguments
# management of ""
tempo.arg <-c(
    "path", 
    "out.path",
    "file.kind",
    "cute", 
    "log"
)
tempo.log <- sapply(lapply(tempo.arg, FUN = get, env = sys.nframe(), inherit = FALSE), FUN = function(x){any(x == "")})
if(any(tempo.log) == TRUE){# normally no NA with is.null()
    tempo.cat <- paste0("ERROR IN ", script, ".R:\n", ifelse(sum(tempo.log, na.rm = TRUE) > 1, "THESE ARGUMENTS\n", "THIS ARGUMENT\n"), paste0(tempo.arg[tempo.log], collapse = "\n"),"\nCANNOT BE \"\"")
    stop(paste0("\n\n================\n\n", tempo.cat, "\n\n================\n\n"), call. = FALSE) # == in stop() to be able to add several messages between ==
}
# end management of ""
# code that protects set.seed() in the global environment
# end code that protects set.seed() in the global environment
# warning initiation
ini.warning.length <- options()$warning.length
options(warning.length = 8170)
warn <- NULL
# warn.count <- 0 # not required
# end warning initiation
# other checkings

fun_source_test(path = path, script = script)

if(all(categ == "NULL")){
    categ <- NULL
}

if( ! dir.exists(out.path)){
    stop(paste0("\n\n============\n\nERROR IN ", script, ".R\nTHE DIRECTORY INDICATED IN THE out.path PARAMETER DOES NOT EXISTS:\n", out.path, "\n\n============\n\n"), call. = FALSE)
}

# end other checkings
# reserved word checking
# end reserved word checking
# end second round of checking and data preparation
# package checking
# end package checking


################################ End Checking


################################ Main code


################ Ignition


out.path <- paste0(out.path, "/table2fasta_", as.integer(ini.time))
dir.create(out.path)
fun_report(data = paste0("\n\n################################################################ ", script, " PROCESS\n\n"), output = log, path = out.path, overwrite = TRUE)
fun_report(data = paste0("\n\n################################ RUNNING DATE AND STARTING TIME"), output = log, path = out.path, overwrite = FALSE)
fun_report(data = paste0(ini.date, "\n\n"), output = log, path = out.path, overwrite = FALSE)
fun_report(data = paste0("\n\n################################ RUNNING"), output = log, path = out.path, overwrite = FALSE)


################ End ignition


################ Graphical parameter initialization


################ End graphical parameter initialization


################ Data import

#if(grepl(x = path, pattern = "^http")){
#    tempo.name <- paste0("tmp_table2fasta.R_", ini.time)
#    if(file.exists(tempo.name)){
#        stop(paste0("\n\n============\n\nERROR IN ", script, ".R\nTHE TEMPORARY FILE USED BY THE ", script, " SCRIPT ALREADY EXISTS:\n", file.path(tempo.name), "\n\n. PLEASE, RERUN.\n\n============\n\n"), call. = FALSE)
#    }else{
#        download.file(path, destfile = tempo.name, method="auto", quiet=TRUE)
#        path2 <- file.path(tempo.name)
#        if(file.exists(path2)){
#            file.remove(path2) # idem file.remove(tempo.name)
#        }
#    }
#}

if(grepl("\\.xlsx$", path)) {
    obs <- openxlsx::read.xlsx(path, sheet = 1, colNames = TRUE) # accept http file
}else if(grepl("\\.csv$", path)) {
    obs <- read.table(path, header = TRUE, sep = ",") # accept http file
}else if(grepl("\\.tsv$", path)) {
    obs <- read.table(path, header = TRUE, sep = "\t")
}else if(grepl("\\.txt$", path)) {
    obs <- read.table(path, header = TRUE, sep = "\t| ")
}else{
    stop(paste0("\n\n============\n\nERROR IN ", script, ".R\nTHE path PARAMETER POINTS TO A FILE WITH WRONG EXTENSION.\n ONLY .xlsx, .csv, .tsv and .txt ARE ACCEPTED.\nPATH INDICATED:\n", path, "\n\n============\n\n"), call. = FALSE)
}


################ end Data import


############ check

if(length(obs) == 0 || nrow(obs) == 0){
    stop(paste0("\n\n============\n\nERROR IN ", script, ".R\nFILE INDICATED IN THE path PARAMETER IS EMPTY:\n", path, "\n\n============\n\n"), call. = FALSE)
}

if( ! Name %in% names(obs)){
    stop(paste0("\n\n============\n\nERROR IN ", script, ".R\n\nTHE Name PARAMETER MUST BE A COLUMN NAME OF THE IMPORTED FILE:\n", path, "\n\nHERE IT IS Name:\n", Name, "\n\nCOLUMN NAMES:\n", paste(names(obs), collapse = "\n"), "\n\n============\n\n"), call. = FALSE)
}

if(any(duplicated(obs[, Name]))){
    stop(paste0("\n\n============\n\nERROR IN ", script, ".R\n\nDUPLICATED VALUE NOT AUTHORIZED IN THE COLUMN OF THE Name PARAMETER\n\nDUPLICATED VALUES ARE:\n", obs[duplicated(obs[, Name]), Name], "\n\nIN POSITIONS:\n", paste(which(obs[ , Name] %in% obs[duplicated(obs[, Name]), Name]), collapse = "\n"), "\n\n============\n\n"), call. = FALSE)
}

if( ! all(Seq %in% names(obs))){
    stop(paste0("\n\n============\n\nERROR IN ", script, ".R\n\nTHE Seq PARAMETER MUST BE COLUMN NAMES OF THE IMPORTED FILE:\n", path, "\n\nHERE IT IS Seq:\n", paste(Seq, collapse = "\n"), "\n\nCOLUMN NAMES:\n", paste(names(obs), collapse = "\n"), "\n\n============\n\n"), call. = FALSE)
}

if( ! is.null(categ)){
    if( ! all(categ %in% names(obs))){
        stop(paste0("\n\n============\n\nERROR IN ", script, ".R\n\nTHE categ PARAMETER MUST BE COLUMN NAMES OF THE IMPORTED FILE:\n", path, "\n\nHERE IT IS categ:\n", paste(categ, collapse = "\n"), "\n\nCOLUMN NAMES:\n", paste(names(obs), collapse = "\n"), "\n\n============\n\n"), call. = FALSE)
    }
}

if( ! all(categ %in% names(obs))){
    stop(paste0("\n\n============\n\nERROR IN ", script, ".R\n\nTHE categ PARAMETER MUST BE COLUMN NAMES OF THE IMPORTED FILE:\n", path, "\n\nHERE IT IS categ:\n", paste(categ, collapse = "\n"), "\n\nCOLUMN NAMES:\n", paste(names(obs), collapse = "\n"), "\n\n============\n\n"), call. = FALSE)
}

tempo.log <- is.na(obs[ , Name]) | obs[ , Name] == ""
if(any(tempo.log)){
    stop(paste0("\n\n============\n\nERROR IN ", script, ".R\nIMPORTED FILE:\n", path, "\nHAS AN EMPTY CELL IN THE ", Name, " COLUMN IN LINES:\n", paste(which(tempo.log), collapse = "\n"), "\n\n============\n\n"), call. = FALSE)
}

for(i0 in names(obs)){ # NA in xlsx file become "NA". Thus, has to be replaced by NA
    tempo.log <- obs[ , i0] == "NA" & ! is.na(obs[ , i0])
    if(any(tempo.log, na.rm = TRUE)){
        obs[tempo.log, i0] <- NA
    }
}


############ end check


############ main


path.all <- paste0(out.path, "/All")
dir.create(path.all)
for(i0 in Seq){
    tempo.log <- is.na(obs[ , i0]) | obs[ , i0] == ""
    if(any(tempo.log)){
        tempo.warn <- paste0("IMPORTED FILE:\n", path, "\nHAS ", sum(tempo.log, na.rm = TRUE), " AMONG ", nrow(obs), " EMPTY SEQUENCES (NA OR \"\") IN THE ", i0, " COLUMN IN LINES:\n", paste(which(tempo.log), collapse = "\n"))
        cat(paste0("\nWARNING: ", tempo.warn, "\n\n"))
        fun_report(data = paste0("WARNING\n", tempo.warn), output = log, path = out.path, overwrite = FALSE)
        warn <- paste0(ifelse(is.null(warn), tempo.warn, paste0(warn, "\n\n", tempo.warn)))
    }else{
        tempo.cat <- paste0("\nIMPORTED FILE:\n", path, "\nHAS NO EMPTY SEQUENCES (NA OR \"\") AMONG ", nrow(obs), " IN THE ", i0, " COLUMN\n")
        fun_report(data = tempo.cat, output = log, path = out.path, overwrite = FALSE)
    }
    if(file.kind == "single"){
        dir.create(paste0(path.all, "/", i0))
    }
    if( ! all(tempo.log)){
        tempo.df <- obs[ ! tempo.log, ]
        for(i1 in 1:nrow(tempo.df)){
            if(file.kind == "single"){
                tempo.name <- paste0(i0, "/", tempo.df[i1, Name], ".fasta")
            }else{
                tempo.name <- paste0(i0, ".fasta")
            }
            tempo.cat <- paste0(">", tempo.df[i1, Name], "\n", tempo.df[i1, i0], "\n")
            cat(tempo.cat, file = paste0(path.all,  "/", tempo.name), append = TRUE)
        }
    }else{
        tempo.warn <- paste0("EMPTY ", i0, " FOLDER CREATED BECAUSE THE IMPORTED FILE:\n", path, "\nHAS ONLY EMPTY SEQUENCES (NA OR \"\") IN THE ", i0, " COLUMN")
        cat(paste0("\nWARNING: ", tempo.warn, "\n\n"))
        fun_report(data = paste0("WARNING\n", tempo.warn), output = log, path = out.path, overwrite = FALSE)
        warn <- paste0(ifelse(is.null(warn), tempo.warn, paste0(warn, "\n\n", tempo.warn)))
    }
}

if( ! is.null(categ)){
    for(i1 in categ){ # if several column to use
        if(all(is.na(obs[ , i1]))){
            stop(paste0("\n\n============\n\nERROR IN ", script, ".R\n\nTHE ", i1, " COLUMN NAME IN THE categ PARAMETER CANNOT BE A COLUMN MADE OF NA ONLY.", "\n\n============\n\n"), call. = FALSE)
        }
        tempo_names <- as.character(na.omit(unique(obs[ , i1])))
        for(i2 in tempo_names){ # names of each patient for instance
            tempo.path <- paste0(out.path, "/", i1, "_", i2)
            dir.create(tempo.path)
            tempo.df <- obs[obs[ , i1] == i2 & ! is.na(obs[ , i1]), ]
            for(i3 in Seq){
                tempo.log <- is.na(tempo.df[ , i3]) | tempo.df[ , i3] == ""
                if(any(tempo.log)){
                    tempo.warn <- paste0("IMPORTED FILE:\n", path, "\nHAS ", sum(tempo.log, na.rm = TRUE), " AMONG ",  nrow(tempo.df), " EMPTY SEQUENCES (NA OR \"\") IN THE ", i3, " COLUMN OF THE CLASS ", i2, " OF THE CATEG ", i1)
                    cat(paste0("\nWARNING: ", tempo.warn, "\n\n"))
                    fun_report(data = paste0("WARNING\n", tempo.warn), output = log, path = out.path, overwrite = FALSE)
                    warn <- paste0(ifelse(is.null(warn), tempo.warn, paste0(warn, "\n\n", tempo.warn)))
                }else{
                    tempo.cat <- paste0("\nIMPORTED FILE:\n", path, "\nHAS NO EMPTY SEQUENCES (NA OR \"\") AMONG ", nrow(tempo.df), " IN THE ", i3, " COLUMN OF THE CLASS ", i2, " OF THE CATEG ", i1, "\n")
                    fun_report(data = tempo.cat, output = log, path = out.path, overwrite = FALSE)
                }
                if(file.kind == "single"){
                    dir.create(paste0(tempo.path, "/", i3))
                }
                if( ! all(tempo.log)){
                    tempo.df2 <- tempo.df[ ! tempo.log, ]
                    for(i5 in 1:nrow(tempo.df2)){
                        if(file.kind == "single"){
                            tempo.name <- paste0(i3, "/", tempo.df2[i5, Name], ".fasta")
                        }else{
                            tempo.name <- paste0(i3, ".fasta")
                        }
                        tempo.cat <- paste0(">", tempo.df2[i5, Name], "\n", tempo.df2[i5, i3], "\n")
                        cat(tempo.cat, file = paste0(tempo.path,  "/", tempo.name), append = TRUE)
                    }
                }else{
                    tempo.warn <- paste0("EMPTY ", i3, " FOLDER CREATED FOR THE CLASS ", i2, " OF THE CATEG ", i1, " BECAUSE THE IMPORTED FILE:\n", path, "\nHAS ONLY EMPTY SEQUENCES IN THE ", i3, " COLUMN")
                    cat(paste0("\nWARNING: ", tempo.warn, "\n\n"))
                    fun_report(data = paste0("WARNING\n", tempo.warn), output = log, path = out.path, overwrite = FALSE)
                    warn <- paste0(ifelse(is.null(warn), tempo.warn, paste0(warn, "\n\n", tempo.warn)))
                }
            }
        }
    }
}
fun_report(data = paste0("\n\n################################ RUNNING END"), output = log, path = out.path, overwrite = FALSE)

############ end main


################ Seeding inactivation


################ end Seeding inactivation


################ Environment saving


################ end Environment saving


################ Warning messages


fun_report(data = paste0("\n\n################################ RECAPITULATION OF WARNING MESSAGES"), output = log, path = out.path, overwrite = FALSE)
if( ! is.null(warn)){
    fun_report(data = paste0("\n\n", warn), output = log, path = out.path, overwrite = FALSE)
}else{
    fun_report(data = paste0("\n\nNO WARNING MESSAGE TO REPORT"), output = log, path = out.path, overwrite = FALSE)
}


################ end Warning messages


################ Parameter printing


fun_report(data = paste0("\n\n################################ INITIAL SETTINGS OF PARAMETERS"), output = log, path = out.path, overwrite = FALSE, sep = 1)
fun_report(data = param.ini.settings, output = log, path = out.path, overwrite = FALSE, , vector.cat = TRUE)
fun_report(data = paste0("\n\n################################ R SYSTEM AND PACKAGES"), output = log, path = out.path, overwrite = FALSE)
tempo <- sessionInfo()
tempo$otherPkgs <- tempo$otherPkgs[order(names(tempo$otherPkgs))] # sort the packages
tempo$loadedOnly <- tempo$loadedOnly[order(names(tempo$loadedOnly))] # sort the packages
fun_report(data = tempo, output = log, path = out.path, overwrite = FALSE, , vector.cat = TRUE)
end.date <- Sys.time()
end.time <- as.numeric(end.date)
total.lapse <- round(lubridate::seconds_to_period(end.time - ini.time))
fun_report(data = paste0("\n\n################################ JOB END\n\n\nTIME: ", end.date, "\n\nTOTAL TIME LAPSE: ", total.lapse, "\n"), output = log, path = out.path, overwrite = FALSE)


################ end Parameter printing


################################ End Main code







