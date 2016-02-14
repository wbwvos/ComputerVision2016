function start()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%131072 g = 0.1138, 0.0785, -0.0353
sphere1 = imread('sphere1.png');
sphere2 = imread('sphere2.png');
sphere3 = imread('sphere3.png');
sphere4 = imread('sphere4.png');
sphere5 = imread('sphere5.png');

S = [   0,     0,   -1;
       -1,     1,   -1;
        1,     1,   -1;
       -1,    -1,   -1;
        1,    -1,    1];
    
S(1,:) = S(1,:)./norm(S(1,:));
S(2,:) = S(2,:)./norm(S(2,:));
S(3,:) = S(3,:)./norm(S(3,:));
S(4,:) = S(4,:)./norm(S(4,:));
S(5,:) = S(5,:)./norm(S(5,:));

[width, height] = size(sphere1);
I = [reshape(im2double(sphere1), width* height, 1), reshape(im2double(sphere2), width* height, 1), reshape(im2double(sphere3), width* height, 1), reshape(im2double(sphere4), width* height, 1), reshape(im2double(sphere2), width* height, 1)];

k = 2; %scaling factor

V = k*S;

%G = zeros(height*width, 3);
%    for i = 1:height*width
%        diag = construct_diagonal(I(i,:));
%        G = linsolve(diag*V, diag*transpose(I(i,:)))
%    end 
diag = construct_diagonal(I(131072,:));
voor = diag*V
na = diag*transpose(I(131071,:))
size(voor)
size(na)
%diag = construct_diagonal(I(131072,:));
%G = linsolve(diag*V, diag*transpose(I(131071,:)))
%G2 = inv(diag*V) * (diag*transpose(I(131071,:)))
end

function diagonal = construct_diagonal(array)
diagonal = zeros(size(array));
    for idx = 1:numel(array)
        diagonal(idx, idx) = array(idx);
    end   
end
