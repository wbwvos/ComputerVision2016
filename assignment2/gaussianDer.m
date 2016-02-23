function [imOut, Gd] = gaussianDer ( image_path ,G , sigma )
image = im2double(rgb2gray(imread(image_path)));

[n, kernelLength] = size(G);
x = linspace((-(kernelLength-1)/2),((kernelLength-1)/2), kernelLength);
Gd = (-(x)./(sigma^2)).*G;
%Gd = Gd./(sum(Gd));
imOutX = conv2(image, Gd, 'valid');
imOutY = conv2(image, Gd', 'valid');
size(imOutX)
size(imOutY)
%imOut = sqrt(imOutX.^2 + imOutY.^2);

imshow(im2double(imOutX), []);
figure
imshow(im2double(imOutY), []);
figure
imshow(im2double(imOut), []);
end