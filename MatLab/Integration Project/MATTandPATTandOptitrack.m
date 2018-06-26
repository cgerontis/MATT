%Windows - 'COM12'
%Mac - '/dev/cu.usbmodem1421'
try
    MATT=serial('COM5','BaudRate',9600,'Terminator','CR/LF');
    PATT=serial('COM4','BaudRate',9600,'Terminator','CR/LF');
    bodyID = 1; %The bodyID variable is the ID of the Rigid Body which is 
                %attached to PATT in Motive

    %Open the serial line for both MATT and PATTT0
    fopen(MATT);
    fopen(PATT);

    %The following segnment initializes the PATT aperture
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    pause(0.1);

    while PATT.BytesAvailable > 0
        pause(0.005);
        rx = fgetl(PATT);
        disp(rx);
    end

    pause(0.5);

    fprintf(PATT,'H\r\n');
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    
    %The following segnment unlocks MATT commands
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    pause(0.1);

    while MATT.BytesAvailable > 0
        pause(0.005);
        rx = fgetl(MATT);
        disp(rx);
    end

    pause(0.5);

    fprintf(MATT,'\r\n');

    pause(0.5);

    fprintf(MATT,'$X');
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    


    %Initialize string for communication
    command= '';

    %Initialize NatNet
    natnet = NatNetConnect();

    %Short pause to ensure everything is synced
    pause(0.5);

    %Initialize main loop, runs until 'n' is entered
    while strcmp(command,'n') == 0

      %Check for any MATT or PATT output
      checkOutput(MATT,PATT);

      %Check for user input
      command = input('Enter commands: ','s');

      %Call commandFilter to sort and send commands to MATT and PATT
      commandFilter(MATT,PATT,0,command,natnet,bodyID);

      pause(0.5);

      %Print the Optitrack location while MATT is moving
      while(NatNetIsMoving(natnet,1,1) == 1) 
        NatNetCollect(natnet);
      end

    end
    
    %Close MATT and PATT before ending the program if 'n' is entered
    %restarted
    fclose(MATT);
    fclose(PATT);
    fclose('all');

    disp("Ports and files closed");
    
catch ME
    %Close MATT and PATT before ending the program if an error occurs. This
    %is necessary because if any ports are left open, Matlab must be
    %restarted
    fclose(MATT);
    fclose(PATT);
    fclose('all');

    error(ME.message);
end
