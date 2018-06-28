function gnuSequenceComplex(natnet, bodyID, MATT, PATT, GNU,filename)
%This function reads an excel file and  runs through the specified path
%The columnd should be in the following order:
%(A-X coordinate)(B-Z coordinate)(C-Pitch angle)(D-Aperture diam.)
%(E-Tilt angle)(F-delay before next step in seconds)
matrix = xlsread(filename);

fopen(GNU)

X = matrix(1:end,1);
Z = matrix(1:end,2);
P = matrix(1:end,3);
A = matrix(1:end,4);
T = matrix(1:end,5);
delay = matrix(1:end,6);

%Define the location where the timestamp will be saved in the excel sheet
timestampLocation = strcat('G',num2str(2),':G',num2str(length(X)+1));

    command = '';

 
    for i = 1:length(X)
        
        % PATT Positioning %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        command = '';
        command = strcat('P',num2str(P(i)),'A',num2str(A(i)),'T',num2str(T(i)));
        commandFilter(MATT,PATT,GNU,command,natnet,bodyID)
        
        pause(0.05)

        % MATT Positioning loop %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        command = '';
        command = strcat('O',num2str(X(i)),',',num2str(Z(i)));
        commandFilter(MATT,PATT,GNU,command,natnet,bodyID);
        
        pause(0.5)
        
        %Keep checking if PATT got to the right position yet
        %The last input is the margin for PATT location
        while NatNetIsMoving(natnet, bodyID, 5)
            pause(0.1)
        end
        
        sendData = "X" + X(i) + ",Z" + Z(i) + ",P" + P(i) + ",A" + A(i) ...
            + ",T" + T(i) + ",D" + delay(i) + ",";
        
        fprintf(GNU, "%s", sendData); 
        
        data = "null";
        
        pause(delay(i))
        
        %Create a timestamp at the end of each step
        timestamp(i) = exceltime(datetime('now','TimeZone','local',...
            'Format','d-MMM-y HH:mm:ss:ms'));
        
    end
    %Write the timestamp array next to the sequence in the sheet
    xlswrite(filename,timestamp',timestampLocation);
    quit = "quit";
    fprintf(GNU,"%s",quit)
    pause(0.5)
    fclose(GNU)
    fclose('all')
end