%Windows - 'COM12'
%Mac - '/dev/cu.usbmodem1421'
MATT=serial('COM5','BaudRate',9600,'Terminator','CR/LF');
PATT=serial('COM4','BaudRate',9600,'Terminator','CR/LF');

%Open the serial line for both MATT and PATT
fopen(MATT);
fopen(PATT);

%The following segnment unlocks MATT commands
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pause(0.1);

while MATT.BytesAvailable > 0
    pause(0.005);
    rx = fgetl(MATT);
    disp(rx);
end

pause(0.5);
  
fprintf(MATT,'\r\n');

pause(0.5);

fprintf(MATT,'$X');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%Initialize string for communication
command= '';

%Initialize command counter
counter = 0;

%Short pause to ensure everything is synced
pause(0.5);

while strcmp(command,'n') == 0
    
  %Unlock control of MATT if first time running loop and connect to natnet
  if(counter == 0)
      fprintf(MATT,'$X'); %Unlocks control
      %natnet = NatNetConnect();
      counter = 1;
  end
     
  checkOutput(MATT,PATT);
  
  %Check for user input
  command = input('Enter commands: ','s');
     
  %Call commandFilter to sort and send commands
  commandFilter(MATT,PATT,command);
  pause(0.1);
  %NatNetCollect(natnet);
  

end

%Close MATT and PATT before ending the program
fclose(MATT);
fclose(PATT);
disp("Ports closed");
