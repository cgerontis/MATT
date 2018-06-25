import os
import sys
import math
import scipy
import serial
import subprocess
import time
import numpy as np
from openpyxl import load_workbook
from openpyxl import Workbook
from openpyxl.compat import range
import openpyxl.utils

#Offset between the origin and the origin of the MATT
offset = 0
#Step-length of mat
x_step = 1 #1.8cm x steps
y_step = 1 #1.8cm steps
#Delta X and Delta Y, aka precision
delta_x = 5
delta_y = 5
#Serial Port
#Use 0 for /dev/ttyACM0, 1 for /dev/ttyACM1, and if its another port, just input the actual port-name as a string
#Default to 0
port=0
#Timeout
#Time length of data recording
timeout=3
#MAKE SURE YOU MAKE A /bin DIRECTORY wherever you run this script


def serial_test(port=0):
	if port == 0 :
		ser = serial.Serial("/dev/ttyACM0", 9600)
	elif port == 1:
		ser = serial.Serial("/dev/ttyACM1", 9600)
	else:
		serial.Serial(port, 9600)
		
	print ser
	ser.write("$h\r")
	raw_input("Press Enter to continue...")
	
	ser.write("x-20\r")
	raw_input("Press Enter to continue...")
	
	ser.write("y-30\r")
	raw_input("Press Enter to continue...")
	
	print ser.readline()
	ser.close()
	
	return 0

	
def calculate(offset_x, offset_y, in_x , in_y,x_step=2.2,y_step=1.6):
	#given offset from the origin, calculates the actual coordinates of the receiver
	#step is the measured step between coordinates
	#returned as a list in the form [x,y]
	out_x=offset_x+(in_x*x_step)
	out_y=offset_y+(-in_y*y_step)
	
	return [out_x,out_y]
	
def estimate_position(offset_x, offset_y, in_x, in_y):
	out_x = (2.0166667*in_x) + 10.26 + offset_x
	out_y = 147.94 - (1.56667*in_y) + offset_y
	
	return [out_x,out_y]

def run_matt(offset_x=0, offset_y=0, delta_x=5, delta_y=5,x_min=10,y_min=10, x_max=50, y_max=50, port=0,timeout=5):
	#offset is used to keep the data points from each'run' consistent with others
	#delta_x, delta_y is used to describe the distance between measurements
	#xlimit, ylimit is the limit as to which the receiver the go
	x_coord=x_min
	y_coord=y_min
	calibrated = 1
	calibrate = 0
	if port == 0 :
		ser = serial.Serial("/dev/ttyACM0", 9600)
	elif port == 1:
		ser = serial.Serial("/dev/ttyACM1", 9600)
	else:
		new_port= "/dev/ttyACM" + str(port)
		serial.Serial(port, 9600)
	if (ser.isOpen()):
		ser.close()
	ser.open()
	print ser
	#print ser.readline()
	print "Homing"
	ser.write("$x\r")
	ser.write("$h\r") #used to home the receiver
	
	raw_input("Press Enter to continue...")
	#raw_input->enter to go forward	
	print "Starting Data collection"
	
	for x_axis in np.arange(x_min, x_max, delta_x):
		#print str(-x_axis),"\n"
		ser.write( "x"+str(-x_axis) + "\r")
		time.sleep(delta_x)
		for y_axis in np.arange(y_min, y_max, delta_y):
			#move and update y coords
			#print str(-y_axis),"\n"
			ser.write( "y"+str(-y_axis)+"\r")
			time.sleep(delta_y)
			if (y_axis==y_min):
				time.sleep(delta_y*2)
			#if (y_axis==y_min and calibrated == 0):
			#	time.sleep(y_max)
			#raw_input("Press Enter to continue...")
			#run gnuradio
			#ex filename: vlp_RSS_analog_capture_hn_t0_fn_xX_yY.bin
			[x_coord,y_coord] = estimate_position(offset_x, offset_y, x_axis,y_axis)
			filename = "vlp_RSS_analog_capture_hn_t0_fn_x"+str(x_coord)+"_y"+str(y_coord)+".bin"
			print x_axis, x_coord, y_coord, y_axis, filename
			ser.write("?\r")
			print ser.readline()
			print "Running Data Collection"
			run_gnuradio(timeout, filename)
			print "Data Collected"
			print ser.isOpen()
			print "\n"
		"""if (calibrated):
			print "Homing"
			ser.write("$h\r") #used to home the receiver
			calibrated = 0
			raw_input("Press Enter to continue...")
			
		else:
			calibrated = 1"""
			
		
	
	
	
	ser.close()
	return 0

def run_gnuradio(time_length=3, filename='ex.bin', file_directory="/bin/"):
	#runs gnuradio on a timer
	#Time is in seconds. 
	timeout = 1
	FNULL = open(os.devnull, 'w')
	start = time.time()
	process = subprocess.Popen(['python' ,'usrp_sink.py',file_directory+filename], stdout = FNULL, stderr=subprocess.STDOUT)
	while (timeout == 1):
		now = time.time()
		if (now-start) > time_length:
			timeout = 0
			process.kill()
	return 0

	
"""
$0=100.000 (x, step/mm)
$1=100.000 (y, step/mm)
$2=250.000 (z, step/mm)
$3=10 (step pulse, usec)
$4=250.000 (default feed, mm/min)
$5=400.000 (default seek, mm/min)
$6=192 (step port invert mask, int:11000000)
$7=25 (step idle delay, msec)
$8=10.000 (acceleration, mm/sec^2)
$9=0.050 (junction deviation, mm)
$10=0.100 (arc, mm/segment)
$11=25 (n-arc correction, int)
$12=3 (n-decimals, int)
$13=0 (report inches, bool)
$14=1 (auto start, bool)
$15=0 (invert step enable, bool)
$16=1 (hard limits, bool)
$17=1 (homing cycle, bool)
$18=0 (homing dir invert mask, int:00000000)
$19=25.000 (homing feed, mm/min)
$20=250.000 (homing seek, mm/min)
$21=100 (homing debounce, msec)
$22=1.000 (homing pull-off, mm
"""
#run_gnuradio(10)
#(70-10)*1.8=108cm	
#run_matt(152,146,x_min=5, x_max=70,y_max=70)

#y offset -7cm
#x offset 17
#run_matt(137,-6,delta_x=5, delta_y=5, x_min=70, x_max=100,y_max=70)

run_matt(offset_x, offset_y, delta_x, delta_y, x_min, y_min, x_max, y_max, port, timeout)

