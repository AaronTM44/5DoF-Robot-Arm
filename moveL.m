function moveL(clientID, target ,pos,speed)
vrep=remApi('remoteApi');
%get target position and orintation
[r,p]=vrep.simxGetObjectPosition(clientID,target, -1,vrep.simx_opmode_blocking);
[r,o]=vrep.simxGetObjectOrientation(clientID,target, -1,vrep.simx_opmode_blocking);

for i=1:3
    if ((abs(pos(i+3)-o(i))<pi) && (o(i)>0))
        o(i) = o(i)+2*pi;
    elseif ((abs(pos(i+3)-o(i))>pi) && (o(i)>0))
        o(i) = o(i) -2*pi;
    end
end
old_pos = [p o];
delta_pos = pos-old_pos;
distance = norm(delta_pos);
sample_number = round(distance*50);
for i= 1:sample_number;
    intermidiate_pos=old_pos + (delta_pos/sample_number);
    %pause
    tic
    while(toc<(distance/(speed*sample_number)))
    end
    %set the intermidiate pos
   vrep.simxSetObjectPosition(clientID,target, -1,intermidiate_pos,vrep.simx_opmode_blocking);
   vrep.simxSetObjectOrientation(clientID,target, -1,intermidiate_pos(4:6),vrep.simx_opmode_blocking);
   old_pos = intermidiate_pos;
    
    


end