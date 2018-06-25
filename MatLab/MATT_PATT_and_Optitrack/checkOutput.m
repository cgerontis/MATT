function output = checkOutput(MATT,PATT)
%Checks output for MATT and PATT

%Initialize output
  output = '';
  
  %Check MATT output
  while MATT.BytesAvailable > 0
    rx = fgetl(MATT);
    disp(rx);
    output = strcat(output,rx);
  end
  pause(0.1);
  
  %Check PATT output
  while PATT.BytesAvailable > 0
    rx = fgetl(PATT);
    disp(rx);
    output = strcat(output,rx);
  end
  pause(0.1);

end