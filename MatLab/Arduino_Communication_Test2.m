%Windows - 'COM12'
%Mac - '/dev/cu.usbmodem1421'
MATT=serial('COM5','BaudRate',9600,'Terminator','CR/LF');

a = '';

fopen(MATT);

pause(0.5);

while strcmp(a,'n') == 0
  while MATT.BytesAvailable > 0
    pause(0.001);
    rx = fgetl(MATT);
    disp(rx);
  end
  
  a = input('Enter coordinates: ','s');
  fprintf(MATT,'%s\r\n',a);
  pause(0.1);
end
fclose(MATT);
disp("Port closed");
