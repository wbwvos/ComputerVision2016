G1=fspecial('gauss',[11, 1], 3);
[Gx] = gradient(G1);
img = im2double(rgb2gray(imread('zebra.png')));
Gx

Cx = conv2(img, Gx, 'valid');
Cy = conv2(img, Gy, 'valid');
size(Cx)
size(Cy)
figure
imshow(Cx, []);
figure
imshow(Cy, []);

imOut = sqrt(Cx.^2 + Cy.^2);
figure
imshow(imOut, []);