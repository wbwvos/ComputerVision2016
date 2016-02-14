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
I = [reshape(im2double(sphere1), width* height, 1), reshape(im2double(sphere2), width* height, 1), reshape(im2double(sphere3), width* height, 1), reshape(im2double(sphere4), width* height, 1), reshape(im2double(sphere5), width* height, 1)];

k = 1; %scaling factor

V = k*S;

G = zeros(height*width, 3);
albedo = zeros(height*width, 3);
normal = zeros(height*width, 3);
warning('off','MATLAB:rankDeficientMatrix');
for i = 1:height*width
    diag = construct_diagonal(I(i,:));
    if sum(diag) == 0.0
    else
        Gxy = linsolve(diag*V, diag*transpose(I(i,:))); 
        G(i,:) = Gxy;
        albedoxy = Gxy./norm(Gxy);
        albedo(i,:) = albedoxy;
        normal(i,:) = (1./albedoxy).*Gxy;
    end
end
warning('on','MATLAB:rankDeficientMatrix');

[X,Y] = meshgrid(0:1:width, 0:1:height);
Z = zeros(512,512)
size(Z)
figure
U = reshape(normal(:,1), width, height);
size(U)
V = reshape(normal(:,2), width, height);
size(V)
W = reshape(normal(:,3), width, height);
size(W)
quiver3(Z,U,V,W)
view(0, 512)
% 
% figure
% quiver3(X,Y,Z,U,V,W,0.1)
% 
% hold on
% surf(X,Y,Z)
% view(0,512)
% hold off

end

function diagonal = construct_diagonal(array)
diagonal = zeros(size(array));
    for idx = 1:numel(array)
        diagonal(idx, idx) = array(idx);
    end   
end
