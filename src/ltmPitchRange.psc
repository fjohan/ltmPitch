
#rscript_exec$="""C:/Program Files/R/R-3.1.0/bin/Rscript"""
#tm_script$="C:/Users/your_department-you/dev/ltmPitch/src/sonmezLTMnographics.R"
#rscript_exec$="""Rscript"""
#ltm_script$="/home/user_name/dev/ltmPitch/src/sonmezLTMnographics.R"
exit You *need* to change rscript_exec$ and ltm_script$ and then comment out this line

s1=selected("Sound")
editorType$="Sound"

ntg=numberOfSelected("TextGrid")
if ntg>0
  tg1=selected("TextGrid")
  editorType$="TextGrid"
endif

select 's1'
Write to WAV file... _tmp_ltmFloorCeiling.wav
runSystem: rscript_exec$, " ", ltm_script$, " 60 750 1 _tmp_ltmFloorCeiling.wav"
m1=Read Matrix from raw text file... _tmp_ltmFloorCeiling.txt
minHz=Get value in cell... 1 1
maxHz=Get value in cell... 1 2

printline Guessing pitch range: 'minHz:0' 'maxHz:0'
select 's1'
p4=noprogress To Pitch... 0 minHz maxHz

measMin=Get minimum... 0 0 Hertz Parabolic
measMax=Get maximum... 0 0 Hertz Parabolic
printline Measured pitch range: 'measMin:0' 'measMax:0'

vMin=floor(measMin/50)*50
vMax=ceiling(measMax/50)*50

printline Visible pitch range: 'vMin:0' 'vMax:0'

select 's1'
editorName$=selected$("Sound")
if ntg>0
	  plus tg1
	  editorName$=selected$("TextGrid")
endif
Edit
editor 'editorType$' 'editorName$'
	  Show analyses... no yes no no no 10
	  Advanced pitch settings... vMin vMax no 15 0.03 0.45 0.01 0.35 0.14
	  Pitch settings... minHz maxHz Hertz autocorrelation automatic
endeditor

select 'm1'
Remove
