function commandFilter(MATT,PATT,GNU,command,natnet, bodyID)
  %Filter commands to send to MATT or PATT
  
  %Check first character
  if(length(command)>=1) 
      letter = command(1);
  else
      %If no character is entered,letter becomes '~' to avoid comparisson
      %problems later on. '~' was chosen because it isn't used
      letter = '~';
  end
  
  %Define commands to be sent to MATT
  if(letter == 'X' || letter == 'Y' || letter == '$')
    pause(0.1);
    
    fprintf(MATT,'%s\r\n',command);

    pause(0.1);
  end
  
  %Define commands to be sent to PATT
  if(letter == 'P' || letter == 'A' ||letter == 'T'||letter == '?'||letter == 'H')

    pause(0.1);
    
    fprintf(PATT,'%s\r\n',command);
 
    pause(0.1);
  end
  
  %Calls 'maintainPosition' function (rarely used)
  if(letter == 'M')

    pause(0.1);
    
    %Calls function to maintain position
    maintainPosition(natnet,bodyID,MATT,str2num(command(2:end)))
 
    pause(0.1);
  end
  
  %Calls optitrack position function(Moves to specified optitrack position)
  if(letter == 'O')

    pause(0.1);
    
    %Checks input for desired location. The format must be the following:
    %(letter O, not zero)-> 'OZ,X'
    %Example:
    %'O42,17' would result in the Optitrack position X=170,Z=420
    %(centimeters)
    desiredZ = str2num(command(strfind(command,'O')+1:strfind(command,',')))*10;
    desiredX = str2num(command(strfind(command,',')+1:end))*10;
    
    %Calls function to maintain position
    optitrackPosition(natnet,bodyID,MATT,desiredX,desiredZ)
 
    pause(0.1);
  end
  
  %Calls 'optitrackSequence' function(Moves through a sequence of locations
  %and orientations). The format must be the following:
  %'Sfilename'
  %Example:
  %'STest.xlsx' would run the sequence specified in the file 'Test.xlsx'
  if(letter == 'S')

    pause(0.1);
    
    if length(command) > 1
        filename = command(2:end);
        disp('Running')
        disp(filename)
    else 
        disp('You forgot to enter a filename');
    end
    
    %Calls function to start sequence
    optitrackSequence(natnet, bodyID, MATT, PATT, filename)
 
    pause(0.1);
  end
  
  if(letter == 'G')

    pause(0.1);
    
    if length(command) > 1
        filename = command(2:end);
        disp('Running')
        disp(filename)
    else 
        disp('You forgot to enter a filename');
    end
    
    %Calls function to start sequence
    gnuSequence(natnet, bodyID, MATT, PATT, GNU, filename)
 
    pause(0.1);
  end
  
  if(letter == 'C')

    pause(0.1);
    
    if length(command) > 1
        filename = command(2:end);
        disp('Running')
        disp(filename)
    else 
        disp('You forgot to enter a filename');
    end
    
    %Calls function to start sequence
    gnuSequenceComplex(natnet, bodyID, MATT, PATT, GNU, filename)
 
    pause(0.1);
  end
  
end


