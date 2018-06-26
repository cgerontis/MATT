function serialStop(id)
%serialStop(id)
%id is the id of the serial device, for example:
%id = serial('COM12,'BaudRate',9600,'Terminator','CR/LF');
%
%This function safely ends the serial communication between the computer
%and the device with the given id
  
fclose(id);

fprintf('Port ''%s'' closed',id.port)

end


