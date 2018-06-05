function serialWrite(id,msg)
%serialWrite(id,msg)
%id is the id of the serial device, for example:
%id = serial('COM12,'BaudRate',9600,'Terminator','CR/LF');
%
%msg is the message you would like to send to the device
  
fprintf(id,'%s\r\n',msg);
pause(0.1);
  

while id.BytesAvailable > 0
    rx = fgetl(id);
    disp(rx);
end
  
end
