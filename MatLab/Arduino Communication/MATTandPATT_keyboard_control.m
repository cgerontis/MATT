%Windows - 'COM12'
%Mac - '/dev/cu.usbmodem1421'
MATT=serial('COM5','BaudRate',9600,'Terminator','CR/LF');
PATT=serial('COM4','BaudRate',9600,'Terminator','CR/LF');

%Open the serial line for both MATT and PATT
fopen(MATT);
fopen(PATT);

%Initialize string for communication
entered= '';

%Initialize command counter
counter = 0;

%Short pause to ensure everything is synced
pause(0.5);

while strcmp(entered,'n') == 0
    
  %Unlock control of MATT if first time running loop
  if(counter == 0)
      fprintf(MATT,'$X\r\n'); %Unlocks control
      counter = 1;
  end
     
  %Check MATT output
  while MATT.BytesAvailable > 0
    rx = fgetl(MATT);
    disp(rx);
  end
  pause(0.1);
  
  %Check PATT output
  while PATT.BytesAvailable > 0
    rx = fgetl(PATT);
    disp(rx);
  end
  pause(0.1);
  
  %Check for user input
  entered = input('Enter coordinates: ','s');
  
  %Check first character
  if(length(entered)>=1) 
      f = entered(1);
  end
     
  %Filter commands to send to MATT or PATT
  if(f == 'X' || f == 'Y' ||f == '$')
    pause(0.1);
    
    fprintf(MATT,'%s\r\n',entered);

    pause(0.1);
  end
  
  if(f == 'P' || f == 'A' ||f == 'T'||f == '?'||f == 'H')

    pause(0.1);
    
    fprintf(PATT,'%s\r\n',entered);
 
    pause(0.1);
  end

end

%Close MATT and PATT before ending the program
fclose(MATT);
fclose(PATT);
disp("Ports closed");