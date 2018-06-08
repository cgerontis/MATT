%Windows - 'COM12'
%Mac - '/dev/cu.usbmodem1421'
s=serial('COM4','BaudRate',9600,'Terminator','CR/LF');

a = '';

fopen(s);

pause(0.5);

while strcmp(a,'n') == 0
  while s.BytesAvailable > 0
    rx = fgetl(s);
    disp(rx);
  end
  
  a = input('Enter coordinates: ','s');
  fprintf(s,'%s\r\n',a);
  pause(0.1);
end
fclose(s);
disp("Port closed");
