function serialStart(id)
%serialStart(id)
%id is the id of the serial device, for example:
%id = serial('COM12,'BaudRate',9600,'Terminator','CR/LF');
%
%This function starts the serial communication between the computer
%and the device with the given id
  

fopen(id);
fprintf('Port ''%s'' opened',id.port)

pause(0.5);

while s.BytesAvailable > 0
  rx = fgetl(id);
  disp(rx);
end
 
end
