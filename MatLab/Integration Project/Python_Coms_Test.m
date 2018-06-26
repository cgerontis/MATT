    t = tcpip('192.168.1.145', 5000,'Terminator','CR'); 

    fopen(t); 
    for i = 1:5
        serverdata= "X56,Z6,P17,A13,T99,D5,"

        fprintf(t, "%s", serverdata); 

        pause(5); 

        data=fgetl(t); 

        pause(0.1) 

        disp(data); 
    end
    fclose(t)