function lambda = arg1(R)
Pitch = atan2(-R( 3,1),sqrt(R(1,1)^2 + R(2,1)^2));
Yaw = atan2(R(2,1)/cos(Pitch),R(1,1)/cos(Pitch));
Roll = atan2(R(3,2)/cos(Pitch),R(3,3)/cos(Pitch));
lambda = [Roll;Pitch;Yaw];
end