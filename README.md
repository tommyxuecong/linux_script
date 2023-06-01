#based on  chenyubi14 
many thanks!

# linux_script
script used in cluster for  calculation conevience

## modify_INCAR
this function will change certain INCAR key words in current and all subdirectory 

example modify_INCAR NCORE 8

this will set NCORE = 8 to all INCAR file.

## fse and fe
fse find all TOTEN (of course, the last TOTEN) in all OUTCAR file that under directory named scf in current and all subdirectory

fe find all TOTEN in all OUTCAR in current and all subdirectory

##defcal_generate.sh
for SnB package, after generation, prepare INCAR, KPOINTS, POTCAR in root directory and run this in the SnB root directory.Will get ready for each SnB created calculation.
