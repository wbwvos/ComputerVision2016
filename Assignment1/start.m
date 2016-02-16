function start()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%131072 g = 0.1138, 0.0785, -0.0353
sphere1 = imread('sphere1.png');
sphere2 = imread('sphere2.png');
sphere3 = imread('sphere3.png');
sphere4 = imread('sphere4.png');
sphere5 = imread('sphere5.png');

% S = [   0,     0,   -1;
%        -1,     1,   -1;
%         1,     1,   -1;
%        -1,    -1,   -1;
%         1,    -1,   -1];
    
S = [    0,      0,   -1;
        -1,     -1,   -1;
         1,     -1,   -1;
        -1,      1,   -1;
         1,      1,   -1];
    
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
albedo = zeros(height*width, 1);
normal = zeros(height*width, 3);
warning('off','MATLAB:rankDeficientMatrix');
for i = 1:height*width
    diag = construct_diagonal(I(i,:));
    if sum(diag) == 0.0
    else
        Gxy = linsolve(diag*V, diag*transpose(I(i,:))); 
        G(i,:) = Gxy;
        albedoxy = norm(Gxy);
        albedo(i,:) = albedoxy;
        normal(i,:) = (1./albedoxy).*Gxy;
    end
end
warning('on','MATLAB:rankDeficientMatrix');
imshow(reshape(albedo, width, height))
[X,Y] = meshgrid(1:1:width, 1:1:height);
Z = zeros(512,512);
A = reshape(normal(:,1), width, height);
A = -A;
B = reshape(normal(:,2), width, height);
B = -B;
C = reshape(normal(:,3), width, height);
C = -C;

sizeNormal = size(normal);
N = zeros(sizeNormal(1), 3);
P = normal(:,1)./normal(:,3);
P = reshape(P, width, height);
P(find(isnan(P))) = 0.0;
P(find(P > 1)) = 1;
P(find(P < -1)) = -1;
P = P';
Q = normal(:,2)./normal(:,3);
Q = reshape(Q, width, height);
Q(find(isnan(Q))) = 0;
Q(find(Q > 1)) = 1;
Q(find(Q < -1)) = -1;
Q = Q';
H = zeros(width, height);

for y = 2:height
    H(y,1) = H(y - 1, 1) + P(y, 1);
end

for y = 1:height
    for x = 2:width
        H(y, x) = H(y, x - 1) + Q(y, x);
    end
end
H = -H;
sp = 16;
figure
quiver3(X(1:sp:end, 1:sp:end), Y(1:sp:end, 1:sp:end), H(1:sp:end, 1:sp:end), A(1:sp:end, 1:sp:end), B(1:sp:end, 1:sp:end), C(1:sp:end, 1:sp:end), 0.5)

hold on
surf(X(1:sp:end, 1:sp:end),Y(1:sp:end, 1:sp:end),H(1:sp:end, 1:sp:end))
hold off

end

function diagonal = construct_diagonal(array)
diagonal = zeros(size(array));
    for idx = 1:numel(array)
        diagonal(idx, idx) = array(idx);
    end   
end
