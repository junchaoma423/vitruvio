function [reachablePositions] = getRangeofMotion(quadruped)

l_hip(1) = quadruped.hip(1).length;
l_thigh(1) = quadruped.thigh(1).length; 
l_shank(1) = quadruped.shank(1).length; 

l_hip(2) = quadruped.hip(2).length;
l_thigh(2) = quadruped.thigh(2).length; 
l_shank(2) = quadruped.shank(2).length; 

q1_min = quadruped.q1.minAngle;
q1_max = quadruped.q1.maxAngle;
q2_min = quadruped.q2.minAngle;
q2_max = quadruped.q2.maxAngle;
q3_min = quadruped.q3.minAngle;
q3_max = quadruped.q3.maxAngle;
q4_min = quadruped.q4.minAngle;
q4_max = quadruped.q4.maxAngle;

q1 = q1_min:0.1:q1_max; % all possible HAA
q2 = q2_min:0.1:q2_max; % all possible HFE
q3 = q3_min:0.1:q3_max; % all possible KFE
q4 = q4_min:0.1:q4_max;

[THETA2,THETA3] = meshgrid(q2,q3); % generate a grid of theta1 and theta2 values

X_front =  l_thigh(1) * sin(THETA2) + l_shank(1) * sin(THETA2 + THETA3); % compute x coordinates
Z_front = -l_hip(1) + -l_thigh(1) * cos(THETA2) - l_shank(1) * cos(THETA2 + THETA3); % compute z coordinates
X_hind =  l_thigh(2) * sin(THETA2) + l_shank(2) * sin(THETA2 + THETA3); % compute x coordinates
Z_hind = -l_hip(2) + -l_thigh(2) * cos(THETA2) - l_shank(2) * cos(THETA2 + THETA3); % compute z coordinates

% both front feet have same reachable space as do both hind feet
reachablePositions.LF = [X_front(:) Z_front(:)];
reachablePositions.LH = [X_hind(:) Z_hind(:)];

reachablePositions.RF = reachablePositions.LF;
reachablePositions.RH = reachablePositions.LH;