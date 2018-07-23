# SLURP-Integration-Project
SLURP Testbed Integration Project Code
Author: Constantinos Gerontis
email:  cgeron@bu.edu
github: cgerontis

Files:
1)GOMP.py
2)usrp_sink.py
3)usrp_sink_vector.py
4)vector_sink.py

Note:
The files in this folder are the necessary scripts to have on whatever computer will be 
running GNU Radio. The files must be placed in the same folder and you must have GNU radio 
companion installed in the Ubuntu environment you'll be using. Whatever folder contains these files
will also be automatically filled with the files created at each point during data collection.

Running the system:
To use the entire system (GNU Radio, MATT, PATT, and Optitrack) you must connect the computer
you wish to use for data collection to the photodetector(on PATT) USRP via ethernet, as well
as connecting it to the same network as the main computer(running MATLAB) using an ethernet 
cable and a gigabit ethernet-to-usb adapter. Once this is done and the photodetector is turned 
on you must run "GOMP.py" (look below for actual command) in the command shell and enter the 
appropriate command in the MATLAB program on the central computer.

ENTER THE FOLLOWING IN THE COMMAND SHELL:
python GOMP.py
