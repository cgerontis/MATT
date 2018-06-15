%Windows - 'COM12'
%Mac - '/dev/cu.usbmodem1421'
MATT=serial('COM5','BaudRate',9600,'Terminator','CR/LF');

a = '';

fopen(MATT);

while MATT.BytesAvailable > 0
    pause(0.005);
    rx = fgetl(MATT);
    disp(rx);
end

pause(0.5);
  
fprintf(MATT,'\r\n');

pause(0.5);

fprintf(MATT,'$X');

pause(0.5);

while strcmp(a,'n') == 0
  while MATT.BytesAvailable > 0
    pause(0.005);
    rx = fgetl(MATT);
    disp(rx);
  end
  
  a = input('Enter command: ','s');
  
  if(strcmp(a,'$?') == 1)
      fprintf(MATT,'%s\r\n',a);
      pause(0.2);
      rx = fgetl(MATT);
      commas = strfind(rx,',');
      colons = strfind(rx,':');
      x = str2num(rx(colons(1)+1:commas(2)-1));
      y = str2num(rx(commas(2)+1:commas(3)-1));
      fprintf('X = %d, Y = %d \n',x,y);
      pause(0.1);
      break;
  else
    fprintf(MATT,'%s\r\n',a);
  end
  
  pause(0.5);
end
fclose(MATT);
disp("Port closed");
