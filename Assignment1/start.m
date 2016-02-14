function start()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%sphere1 = imread('sphere1.png');
%sphere2 = imread('sphere2.png');
%sphere3 = imread('sphere3.png');
%sphere4 = imread('sphere4.png');
%sphere5 = imread('sphere5.png');

V = [   0,     0,   -1;
       -1,     1,   -1;
        1,     1,   -1;
       -1,    -1,   -1;
        1,    -1,    1]
    
V(1,:) = V(1,:)./norm(V(1,:))
V(2,:) = V(2,:)./norm(V(2,:))
V(3,:) = V(3,:)./norm(V(3,:))
V(4,:) = V(4,:)./norm(V(4,:))
V(5,:) = V(5,:)./norm(V(5,:))

k = 2 %scaling factor


end

