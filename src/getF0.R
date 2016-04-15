# This is R

# This function takes care of F0 analysis through praat
# It makes it possible to call:
#   Rscript <scriptName> 60 750 1 <fileName>
# where
#   scriptName is the name of the script
#   fileName is the name of the speech file
# You only need to source the file, then the function takes care of command line args etc,
# so you just need:
#   source("getF0.R")
#   f0<-getF0()
# at the top

getF0 <- function() {
    minPitch<-60
    maxPitch<-750
    analyzePitch<-1
    if (analyzePitch==1) {
        inFile="default.wav"
    } else {
        inFile="default.txt"
    }
    # commandArgs() - position if argument are for use with Rscript
    #print(commandArgs())
    mod<-0
    # if we have '--save' in the command args then move one step right
    if (commandArgs()[4]=="--save") {
        mod<-1
    }
    if (length(commandArgs())>5+mod) {
        minPitch<-as.integer(commandArgs()[6+mod])
        maxPitch<-as.integer(commandArgs()[7+mod])
        minPitch<<-as.integer(commandArgs()[6+mod])
        maxPitch<<-as.integer(commandArgs()[7+mod])
        analyzePitch<-as.integer(commandArgs()[8+mod]) # not used anymore
        inFile<-commandArgs()[9+mod]
        inFile<<-commandArgs()[9+mod]
    }

    inFile<-paste(getwd(), inFile, sep="/")
        
    system(paste(praatexec,
    "--run",
    "Get_pitch_to_f0file.psc",
    "60",
    "750",
    inFile))
    
    inFileWoExt<-sub("(.+)[.][^.]+$", "\\1", inFile)
    newName<-paste(inFileWoExt, ".f0", sep="")
    rawF0table <- read.table(newName)
    
    # remove values outside praat's analysis range
    f0table <- subset(rawF0table, rawF0table[[1]]>=minPitch & rawF0table[[1]]<=maxPitch)
    f0<-f0table[,1]
}
