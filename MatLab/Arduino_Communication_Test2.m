
s=serial('COM12','BaudRate',9600);

a = ['X-5'];

fopen(s);

pause(2.5);

for i = 1:5
  fwrite(s, a(i),'char', 'sync');
  rx(i) = char(fread(s, 1));
end
fclose(s);

disp(rx');
