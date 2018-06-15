function commandFilter(MATT,PATT,command,natnet)
  %Filter commands to send to MATT or PATT
  
  
  %Check first character
  if(length(command)>=1) 
      letter = command(1);
  else
      letter = '';
  end
  
  if(letter == 'X' || letter == 'Y' || letter == '$')
    pause(0.1);
    
    fprintf(MATT,'%s\r\n',command);

    pause(0.1);
  end
  
  if(letter == 'P' || letter == 'A' ||letter == 'T'||letter == '?'||letter == 'H')

    pause(0.1);
    
    fprintf(PATT,'%s\r\n',command);
 
    pause(0.1);
  end
  
  if(letter == 'M')

    pause(0.1);
    
    %Clear anything MATT has to say
    while MATT.BytesAvailable > 0
    pause(0.005);
    rx = fgetl(MATT);
    disp(rx);
    end
    
    pause(0.1);
    
    %Ask MATT its current position, to pass into the maintain function
    fprintf(MATT,'$?');
      pause(0.2);
      rx = fgetl(MATT);
      commas = strfind(rx,',');
      colons = strfind(rx,':');
      x = str2num(rx(colons(1)+1:commas(2)-1));
      y = str2num(rx(commas(2)+1:commas(3)-1));
      fprintf('X = %d, Y = %d \n',x,y);
      pause(0.1);
    
      
    maintainPosition(natnet,1,MATT, x, y)
 
    
    pause(0.1);
  end
  
  
end

%  %Check first character
%   if(length(entered)>=1) 
%       f = entered(1);
%   end
%      
%   %Filter commands to send to MATT or PATT
%   if(f == 'X' || f == 'Y' ||f == '$')
%     pause(0.1);
%     
%     fprintf(MATT,'%s\r\n',entered);
% 
%     pause(0.1);
%   end
%   
%   if(f == 'P' || f == 'A' ||f == 'T'||f == '?'||f == 'H')
% 
%     pause(0.1);
%     
%     fprintf(PATT,'%s\r\n',entered);
%  
%     pause(0.1);
%   end
