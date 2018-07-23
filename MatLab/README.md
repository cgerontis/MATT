This file explains the use of GOMP(GNU_Radio Optitrack MATT and PATT)

The first thing you have to do to ensure a connection is to start Optitrack, connect the
main laptop (the one MATLAB will run on) to the network Optitrack is connected to through
ethernet, an enter your IP adress in the ClientIP (in NatNetConnect.m). Then connect to 
MATT and PATT through USB and enter the correct serial ports at the top of GOMP.m. Lastly,
enter the correct IP adress for the computer running GNU-Radio, which should also be on the 
same network and running GOMP.py

The two folders in this folder are "Arduino communication" and "Integration project":

Arduino communication:
This folder has some scripts for communicating directly to MATT and PATT through MATLAB. Since there are scripts
in the second folder that can also do this this folder is mostly for documentation purposes and is not really
usefull to anyone else

Integration Project:
This folder contains pretty much everything useful for the main computer. The main file to be used for data collection
is "GOMP.m". This script communicates directly with GNU-Radio,Optitrack,MATT,and PATT. The entire "Integration Project"
folder is necessary to run this because it contains the necessary functions and the NatNet SDK which is how communication 
to Optitrack is established. GOMP uses a command prompt interface and accepts the following commands:
(Note: The lowercase "x" and "y" are placeholders for numbers, don't actually enter an "x" or you'll confuse GOMP)

"$$"    -Displays MATT settings
"$x=y"  -Changes MATT's setting "x" to equal "y"
"$?"    -Displays MATT's current position in millimeters
"?"     -Displays PATT's orientation
"H"	-Initiates PATT's homing sequence (by default it thinks the 50mm aperture is mounted)
"H50"	-Initiates PATT's homing sequence for the 50mm aperture (only necessarry if you ran H75 in the same MATLAB instance)
"H75"	-Initiates PATT's homing sequence for the 75mm aperture (this only needs to be done once each instance)
"$H"    -Initiates MATT's homing sequence 
"$X"    -Unlocks MATT commands (This must be done every time MATT is started normally but GOMP takes care of it)
"Xx"    -Commands MATT to move to the position X=x millimeters(eg. "X42 moves to X=42)
"Yx"    -Commands MATT to move to the position Y=x millimeters(eg. "Y42 moves to Y=42)
"Px"    -Commands PATT's Pan axis to "x" degrees(eg. "P17" rotates Pan axis to 17 degrees from origin. Range is 180 degrees)
"Ax"    -Commands PATT's Aperture to open "x" millimeters(eg. "A35" makes aperture diameter 35 mm. Range is 1.8 to 50mm)
"Tx"    -Commands PATT's Tilt axis to "x" degrees(eg. "T-17" rotates Tilt axis to -17 degrees from origin. Range is 90 to -90)
"M"     -Maintain's PATT's position using Optitrack even when pushed. Neat for demos
"Ox,y"  -Moves PATT to optitrack position Z="x" and X="y" centimeters. Yes, the axes are switched but it makes sense once you use it
"GFilename" -Initiates the sequence specified in the "Filename" excel sheet(eg. "Gpotato.xlsx" initiates the "potato.xlsx" sequence)
"CFilename" -Similar to above command, but each line in excel is a unique command. This is helpful if you don't want a pattern
"SFilename" -Similar to "GFilename", but this sequence doesn't record data using GNU-Radio. This is more helpful for demos

/////////////////////////IMPORTANT\\\\\\\\\\\\\\\\\\\\\\\\\\\\
WHEN TRYING TO RUN A SEQUENCE, YOU MUST PLACE THE EXCEL SHEETS
WITH THE INSTRUCTIONS IN THE "SEQUENCES" FOLDER, WITHIN THE 
MATLAB "INTEGRATION PROJECT" FOLDER. THERE IS AN EXAMPLE WITH
THE PROPER FORMAT IN THE FOLDER ALREADY NAMED "FORMAT.XLSX"

