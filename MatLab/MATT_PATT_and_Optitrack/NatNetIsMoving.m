function state = NatNetIsMoving(natnetclient, bodyID, margin)

    model = natnetclient.getModelDescription;
    %initialize position array and then compare values from 
    %frame to frame to see if the position changed
    move = zeros(2,2);
    
	% Poll for the rigid body data
	for i = 1 : 2
        pause(0.05)
        
		data = natnetclient.getFrame; % method to get current frame
		
        move(i,1) = data.RigidBody(bodyID).x * 1000;
        move(i,2) = data.RigidBody(bodyID).z * 1000;			
    end 
	dx = abs(move(1,1)-move(2,1));
    dz = abs(move(1,2)-move(2,2));
    
    if(dx > margin || dz > margin)
        state = 1;
        %disp('is moving')
    else
        state = 0;
        %disp('is not moving')
    end
end
