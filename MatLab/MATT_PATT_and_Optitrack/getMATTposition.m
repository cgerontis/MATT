function [x,y,z] = getMATTposition(MATT)
%Returns MATT's XYZ coordinates as variables

    %Clear anything MATT has to say
    while MATT.BytesAvailable > 0
    pause(0.01);
    rx = fgetl(MATT);
    disp(rx);
    end
    
    pause(0.1);
    
    %Ask MATT its current position, to pass into the maintain function
    fprintf(MATT,'?');
      pause(0.2);
      rx = fgetl(MATT);
      commas = strfind(rx,',');
      colons = strfind(rx,':');
      x = str2num(rx(colons(1)+1:commas(2)-1));
      y = str2num(rx(commas(2)+1:commas(3)-1));
      z = str2num(rx(commas(3)+1:commas(4)-1));
%       fprintf('X = %d, Y = %d \n',x,y);
end