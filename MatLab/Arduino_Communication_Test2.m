%Windows - 'COM12'
%Mac - '/dev/cu.usbmodem1421'
PAT=serial('COM4','BaudRate',9600,'Terminator','CR/LF');

a = '';

fopen(PAT);

pause(0.5);

while strcmp(a,'n') == 0
  while PAT.BytesAvailable > 0
    rx = fgetl(PAT);
    disp(rx);
  end
  
  a = input('Enter coordinates: ','s');
  fprintf(PAT,'%s\r\n',a);
  pause(0.1);
end
fclose(PAT);
disp("Port closed");
