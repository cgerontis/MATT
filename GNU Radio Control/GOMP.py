import os
import sys
import math
import scipy
import serial
import socket
import os
import sys
import math
import scipy
import serial
import numpy as np
import subprocess
import time

def run_gnuradio(time_length=3, filename='ex.bin', vector=1):
	#runs gnuradio on a timer
	#Time is in seconds. 
	timeout = 1
	if vector == 0:
		file_directory="/vectors/"
	else:
		file_directory="/analogs/"
	FNULL = open(os.devnull, 'w')
	start = time.time()
	if vector==1:
		process = subprocess.Popen(['python' ,'usrp_sink_vector.py',filename], stdout = FNULL, stderr=subprocess.STDOUT)
	else:
		process = subprocess.Popen(['python' ,'usrp_sink.py',filename], stdout = FNULL, stderr=subprocess.STDOUT)
	while (timeout == 1):
		now = time.time()
		if (now-start) > time_length:
			timeout = 0
			process.kill()
	return 0

def Main(): 

	host = "192.168.1.145" 
	port = 5000 

	mySocket = socket.socket() 
	mySocket.bind((host,port)) 

	mySocket.listen(1) 

	conn, addr = mySocket.accept() 

	print ("Connection from: " + str(addr)) 

	d = 0
	while d >= 0:
		try:
			data = conn.recv(1024).decode() 
			if not data: 
				return 0
	 
			print ("from connected  user: " + str(data)) 

			locX = data.find("X")
			x = data[locX+1:]
			x = x[:x.find(",")]

			locZ = data.find("Z")
			z = data[locZ+1:]
			z = z[:z.find(",")]

			locP = data.find("P")
			p = data[locP+1:]
			p = p[:p.find(",")]

			locA = data.find("A")
			a = data[locA+1:]
			a = a[:a.find(",")]

			locT = data.find("T")
			t = data[locT+1:]
			t = t[:t.find(",")]

			locD = data.find("D")
			d = data[locD+1:]
			d = d[:d.find(",")]

			filename = "vlc_"+"X" + str(z) + "_Y" + str(x) + "_P" + str(p) + "_A" + str(a) + "_T" + str(t) + ".bin"

			conn.send(str(filename+ "   " + str(d) + '\r').encode())  

			run_gnuradio(int(d),filename)
		except:
			conn.close()
		
	conn.close()
			

if __name__ == '__main__': 
	Main() 
