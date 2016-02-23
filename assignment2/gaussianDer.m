function [imOut, Gd] = gaussianDer ( image_path ,G , sigma )
image = im2double(rgb2gray(imread(image_path)));

[n, kernelLength] = size(G);
x = linspace((-(kernelLength-1)/2),((kernelLength-1)/2), kernelLength);
Gd = (-(x)./(sigma^2)).*G;
%Gd = Gd./(sum(Gd));
imOut = conv2(conv2(image, Gd, 'valid'), Gd', 'valid');
%imOut = imOut/sum(sum(imOut));
imshow(im2double(imOut), []);
end