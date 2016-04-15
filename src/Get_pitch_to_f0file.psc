form Get pitch
    positive minPitch 75
    positive maxPitch 600
    word inFile default.wav
endform

##########################
### Process file names ###
##########################
inFileLength=length(inFile$)
outFile$=inFile$-"wav"+"f0"

########################
### Analyse and save ###
########################
Read from file... 'inFile$'
To Pitch... 0.01 'minPitch' 'maxPitch'
To Matrix
Transpose
Write to headerless spreadsheet file... 'outFile$'


