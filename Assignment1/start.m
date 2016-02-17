function start()
% loading the images
sphere1 = im2double(imread('sphere1.png'));
sphere2 = im2double(imread('sphere2.png'));
sphere3 = im2double(imread('sphere3.png'));
sphere4 = im2double(imread('sphere4.png'));
sphere5 = im2double(imread('sphere5.png'));

% The S (light origins)
S = [    0,      0,   -1;
        -1,     -1,   -1;
         1,     -1,   -1;
        -1,      1,   -1;
         1,      1,   -1];

%normalize the S matrix
S(1,:) = S(1,:)./norm(S(1,:));
S(2,:) = S(2,:)./norm(S(2,:));
S(3,:) = S(3,:)./norm(S(3,:));
S(4,:) = S(4,:)./norm(S(4,:));
S(5,:) = S(5,:)./norm(S(5,:));

[width, height] = size(sphere1);
%creating the I matrix
I = [reshape(sphere1, width* height, 1), reshape(sphere2, width* height, 1), reshape(sphere3, width* height, 1), reshape(sphere4, width* height, 1), reshape(sphere5, width* height, 1)];

k = 1; %scaling factor

V = k*S;

G = zeros(height*width, 3);
albedo = zeros(height*width, 1);
normal = zeros(height*width, 3);
warning('off','MATLAB:rankDeficientMatrix');

for i = 1:height*width
    diag = construct_diagonal(I(i,:));
    if sum(diag) == 0.0
        %nothing happens since the result is always zeros, as is specified
        %in the instantiation.
    else
        % solve the linear system, this returns a 3-dimensional vector
        Gxy = linsolve(diag*V, diag*transpose(I(i,:))); 
        %save the Gxy in the G matrix
        G(i,:) = Gxy;
        %pixel albedo is the norm of the Gxy (scalar)
        albedoxy = norm(Gxy);
        %save it in the albedo vector
        albedo(i,:) = albedoxy;
        %the normal is the normalized 
        normal(i,:) = (1./albedoxy).*Gxy;
    end
end
warning('on','MATLAB:rankDeficientMatrix');
%print the surface albedo (it looks much like the original image sphere1)
imshow(reshape(albedo, width, height))

[X,Y] = meshgrid(1:1:width, 1:1:height);
Z = zeros(512,512);
A = reshape(normal(:,1), width, height);
A = -A;
B = reshape(normal(:,2), width, height);
B = -B;
C = reshape(normal(:,3), width, height);
C = -C;
%stepsize of prints (we only print 1 in every 16 points in order for it to
%be clearly visible.
sp = 16;
figure
%plot the surface normals
quiver3(Z(1:sp:end, 1:sp:end), A(1:sp:end, 1:sp:end), B(1:sp:end, 1:sp:end), C(1:sp:end, 1:sp:end), 0.5)

sizeNormal = size(normal);
N = zeros(sizeNormal(1), 3);
%compute P
P = normal(:,1)./normal(:,3);
P = reshape(P, width, height);
% 0/0 is impossible and gives NaN, 1 + NaN will result in NaN so we turned
% all the NaN into 0
P(find(isnan(P))) = 0.0;
%if P is larger than 1 or smaller than -1 it will be reduced to 1 and -1
%respectively
P(find(P > 1)) = 1;
P(find(P < -1)) = -1;
P = P';

%compute Q
Q = normal(:,2)./normal(:,3);
Q = reshape(Q, width, height);
% 0/0 is impossible and gives NaN, 1 + NaN will result in NaN so we turned
% all the NaN into 0
Q(find(isnan(Q))) = 0;
%if Q is larger than 1 or smaller than -1 it will be reduced to 1 and -1
%respectively
Q(find(Q > 1)) = 1;
Q(find(Q < -1)) = -1;
Q = Q';
H = zeros(width, height);

%construct the height of the first column
for y = 2:height
    H(y,1) = H(y - 1, 1) + P(y, 1);
end

%construct the height of the other pixels
for y = 1:height
    for x = 2:width
        H(y, x) = H(y, x - 1) + Q(y, x);
    end
end
H = -H;


figure
quiver3(X(1:sp:end, 1:sp:end), Y(1:sp:end, 1:sp:end), H(1:sp:end, 1:sp:end), A(1:sp:end, 1:sp:end), B(1:sp:end, 1:sp:end), C(1:sp:end, 1:sp:end), 0.5)

hold on
surf(X(1:sp:end, 1:sp:end),Y(1:sp:end, 1:sp:end),H(1:sp:end, 1:sp:end))
hold off

end

%function to create a diagonal matrix from a vector (this does exactly what
%diag() does.
function diagonal = construct_diagonal(array)
diagonal = zeros(size(array));
    for idx = 1:numel(array)
        diagonal(idx, idx) = array(idx);
    end   
end
