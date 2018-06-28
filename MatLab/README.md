This file explains the use of GOMP(GNU_Radio Optitrack MATT and PATT)

The two folders in this folder are "Arduino communication" and "Integration project":

Arduino communication:
This folder has some scripts for communicating directly to MATT and PATT through MATLAB. Since there are scripts
in the second folder that can also do this this folder is mostly for documentation purposes and is not really
usefull to anyone else

Integration Project:
This folder contains pretty much everythin useful for the main computer. The main file to be used for data collection
is "GOMP.m". This script communicates directly with GNU-Radio,Optitrack,MATT,and PATT. The entire "Integration Project"
folder is necessary to run this because it contains the necessary functions and the NatNet SDK which is how communication 
to Optitrack is established. GOMP uses a command prompt interface and accepts the following commands:
(Note: The lowercase "x" and "y" are placeholders for numbers, don't actually enter an "x" or you'll confuse GOMP)

"$$"    -Displays MATT settings
"$x=y"  -Changes MATT's setting "x" to equal "y"
"$?"    -Displays MATT's current position in millimeters
"?"     -Displays PATT's orientation
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
