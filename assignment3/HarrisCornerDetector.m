function [H, coordinates] = HarrisCornerDetector()
rawImage  = imread('person_toy/00000001.jpg');
image = im2double(rgb2gray(rawImage));
%image = im2double(rgb2gray(imread('pingpong/0000.jpg')));
sigma = 1;
G = fspecial('gauss',[1, 11], sigma);
Gd = gradient(G);

Ix = conv2(image, Gd, 'same');
%Ix = conv2(Ix.^2, G, 'same');
A = Ix.^2;

Iy = conv2(image, Gd', 'same');
%Iy = conv2(Iy.^2, G', 'same');
C = Iy.^2;

B = Ix.*Iy;
[imageHeight, imageWidth] = size(image);
%imshow(H, []);

windowWidth = 9;
windowHeight = 9;

coordinates = zeros(10, 3);
counter =1;
threshold = 1;
for j = 1:imageHeight - windowHeight + 1
    for i = 1:imageWidth - windowWidth + 1
        window = image(j:j + windowHeight - 1, i:i + windowWidth - 1);
        centrepoint = window(ceil(windowHeight/2), ceil(windowWidth/2));
        windowA = sum(sum(A(j:j + windowHeight - 1, i:i + windowWidth - 1)));
        windowA
        windowB = sum(sum(B(j:j + windowHeight - 1, i:i + windowWidth - 1)));
        windowC = sum(sum(C(j:j + windowHeight - 1, i:i + windowWidth - 1)));
        H = (windowA*windowC - windowB^2) - 0.04*(windowA + windowC)^2;
        %if (centrepoint == max(max(window)) && centrepoint> 0.9)
        if (H > 0.04)
            y_max = j + ceil(windowHeight/2);
            x_max = i + ceil(windowHeight/2);
            coordinates(counter, 1) = y_max;
            coordinates(counter, 2) = x_max;
            coordinates(counter, 3) = H;
            counter = counter+1;
        end
    end
end
coordinates
[ncoordinates, values] = size(coordinates);
for i = 1: ncoordinates
    rawImage(coordinates(i, 1), coordinates(i, 2), 1) = 255;
    rawImage(coordinates(i, 1), coordinates(i, 2), 2) = 0;
    rawImage(coordinates(i, 1), coordinates(i, 2), 3) = 0;
end
figure
imshow(rawImage)
figure
imshow(Ix, [])
figure
imshow(Iy, [])
end