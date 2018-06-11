%Windows - 'COM12'
%Mac - '/dev/cu.usbmodem1421'
MATT=serial('COM5','BaudRate',9600,'Terminator','CR/LF');
PAT=serial('COM4','BaudRate',9600,'Terminator','CR/LF');

entered(5) = zeros;

pause(0.5);

while strcmp(entered,'n') == 0
    
  fopen(MATT);
  while MATT.BytesAvailable > 0
    rx = fgetl(MATT);
    disp(rx);
  end
  fclose(MATT);
  fopen(PAT);
  while PAT.BytesAvailable > 0
    rx = fgetl(PAT);
    disp(rx);
  end
  fclose(PAT);
  
  entered = entered('Enter coordinates: ','s');
  
  f = entered(1);
  if(f == 'X' || f == 'Y' ||f == '$')
    fopen(MATT);
    fprintf(MATT,'%s\r\n',entered);
    fclose(MATT);
  elseif(f == 'P' || f == 'A' ||f == 'T'||f == '?')
    fopen(PAT);
    fprintf(PAT,'%s\r\n',entered);
    fclose(PAT);
  end
  
  pause(0.1);
end
fclose('all');
disp("Ports closed");
