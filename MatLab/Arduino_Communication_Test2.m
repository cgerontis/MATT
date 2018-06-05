
s=serial('COM12','BaudRate',9600);

a = '';

fopen(s);

pause(2.5);

while strcmp(a,'n') == 0
  
  while s.BytesAvailable > 0
    rx = fgetl(s, 1);
    disp(rx);
  end
  
  a = input('Enter coordinates: ','s');
  
  fwrite(s, a,'char', 'sync');
  
  
end
fclose(s);

