function maintainPosition(natnet, bodyID, MATT, MX, MY)
%calling this function attemps to lock PATT in place by checking the
%optitrack position instead of the MATT position
%x and z are the desired optitrack z and x positions to be maintained
    margin = 2; %margin of error in mm
    
    data = natnet.getFrame;
    desiredX = data.RigidBody(bodyID).x * 1000;
    desiredZ = data.RigidBody(bodyID).z * 1000;
    %main loop, runs for 10000 cycles
    for J = 1:1000
        data = natnet.getFrame;
        %keep checking the optitrack position of the object
        x = data.RigidBody(bodyID).x * 1000;
        z = data.RigidBody(bodyID).z * 1000;
%         fprintf('DesiredX: %d\n',desiredX)
%         fprintf('DesiredZ: %d\n',desiredZ)
%         fprintf('Current X: %d\n',x)
%         fprintf('Current Z: %d\n',z)
     
        if(NatNetIsMoving(natnet,1,1) == 0 && (abs(desiredX-x) > margin || abs(desiredZ-z) > margin))
        
           % MX = MX - (z - desiredZ);
            %MY = MY - (x - desiredX);
             MX = (z-desiredZ);
             MY = (x-desiredX);
            fprintf(MATT,'X%f',num2str(MX))
            fprintf(MATT,'Y%f\r\n',num2str(MY))
            fprintf('MX:%f\tMY:%f\n',[MX,MY])
        end
        pause(0.2)
    end
end