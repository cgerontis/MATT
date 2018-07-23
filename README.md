# SLURP-Integration-Project
SLURP Testbed Integration Project Code
Author: Constantinos Gerontis
email:  cgeron@bu.edu
github: cgerontis


Notes:This README includes general descriptions of the contents of each major folder of the integration
      project. For more detailed descriptions there are README files in each of the major folders. The
      major folders are the following:

Folders:
1)Arduino
2)GNU Radio Control
3)Matlab
4)Optitrack Files
5)PATT Control
6)PATT Design

1)Arduino
The contents of this folder are the ArbotiX Sketches, drivers, hardware, and libraries.
Some of these contents may be redundant but I placed all of the files I have in those 
folders just in case. These folders should be placed in the arduino folder of your computer
if you wish to update the firmware on PATT. You don't have to replace your files with these
but you must ensure that you have at least all of the files from these folders in the corresponding
folders on your computer, along with whatever other files you had.

2)GNU Radio Control
The files in GNU Radio Control are the necessary scripts to have on whatever computer will be 
running GNU Radio. The two files must be placed in the same folder and you must have GNU radio 
companion installed in the Ubuntu environment you'll be using. Whatever folder contains these two files
will also be automatically filled with the files created at each point during data collection.

3)Matlab
This folder has 2 sub-folders:1)Arduino Communication and 2)Integration Project. 
  Arduino Communication:
  The files in this folder are used to communicate directly with MATT and PATT, and do not
  need optitrack to be running. The capabilities are pretty limited but work for moving around
  the turret. 

  Integration Project:
  The files in this folder are used to run the testbed with optitrack and GNU Radio. This folder
  also contains all of the NatNet files which are required to be in the same folder for Optitrack
  to work. The two main scripts you should use are 1)"MATTandPATTandOptitrack" and 2)"GOMP". 
  "MATTandPATTandOptitrack" is used to control the testbed with Optitrack positioning for confirmation.
  "GOMP" is the more advanced version which includes communication with another computer running GNU 
  Radio. The script "MATTandPATT_keyboard_control_2.m" can also be used to control MATT and PATT using
  individual commands through the keyboard without Optitrack.
  
4)Optitrack Files
This folder contains the necessarry calibration files for GOMP to run. These files are to be used with
the "Motive" software

5)PATT Control
This folder includes the arduino files necessary for PATT(Pan Aperture Tilt Turret) to run. This code
requires folder 1(Arduino) to be installed properly. The three files included in PATT Control are:
1)Aperture_Control,2)Pan_Control,3)Serial_Communication. 
  Aperture Control:
  This file specifies how the aperture should be controled and defines the homing sequence
  
  Pan Control:
  This file specifies how the pan-axis should be controled
  
  Serial Communication:
  This file initiates and maintains serial communication with a connected device or computer and also
  controls the tilt axis and specifies the offset.
  
6)PATT Design
This folder has the PATT solidworks design as well as the corresponding STL files. This includes
PATT Mk1 and PATT Mk2. PATT Mk1 used the 75mm "Zero-aperture" iris, and Mk2 uses the 50mm iris.

