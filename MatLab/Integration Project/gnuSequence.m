function gnuSequence(natnet, bodyID, MATT, PATT, GNU,filename)
%This function reads an excel file and  runs through the specified path
%The columnd should be in the following order:
%(A-X coordinate)(B-Z coordinate)(C-Pitch angle)(D-Aperture diam.)
%(E-Tilt angle)(F-delay before next step in seconds)
%Check file named "Format.xlsx" in "Sequences" folder
matrix = xlsread("Sequences/"+filename);

fopen(GNU)

readX = matrix(1:end,1);
readZ = matrix(1:end,2);
readP = matrix(1:end,3);
readA = matrix(1:end,4);
readT = matrix(1:end,5);
readDelay = matrix(1:end,6);

readX(find(isnan(readX)))=[];
readZ(find(isnan(readZ)))=[];
readP(find(isnan(readP)))=[];
readA(find(isnan(readA)))=[];
readT(find(isnan(readT)))=[];
readDelay(find(isnan(readDelay)))=[];


X = [];
Z = [];
P = [];
A = [];
T = [];
delay = [];

for x = 1:length(readX)
    for z = 1:length(readZ)
        for p = 1:length(readP)
            for a = 1:length(readA)
                for t = 1:length(readT)
                    for d = 1:length(readDelay)
                       X(end+1) = readX(x);
                       Z(end+1) = readZ(z);
                       P(end+1) = readP(p);
                       A(end+1) = readA(a);
                       T(end+1) = readT(t);
                       delay(end+1) = readDelay(d);
                    end
                end
            end
        end
    end
end

%THIS SECTION CREATES THE S SHAPE INSTEAD OF THE Z SHAPE,
%IF YOU'D LIKE THE REGULAR Z SHAPE (ROW BY ROW), COMMENT THIS SECTION OUT
len =  length(readZ) * length(readP) * length(readA) * length(readT) * length(readDelay);

if(length(Z) > len*2)
    for i = 1:len*2:length(Z)
        Z(i+len:i+len*2-1) = fliplr(Z(i+len:i+len*2-1));   
    end
end

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
%    xlswrite(filename,timestamp',timestampLocation);
    quit = "quit";
    fprintf(GNU,"%s",quit)
    pause(0.5)
    fclose(GNU)
    fclose('all')
end