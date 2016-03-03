function Lucas_Kanade()
rawImage1 = imread('sphere1.ppm');
image1 = im2double(rgb2gray(rawImage1));

rawImage2 = imread('sphere2.ppm');
image2 = im2double(rgb2gray(rawImage2));

[imageHeight, imageWidth] = size(image1);
windowHeight = 20;
windowWidth = 20;

G = fspecial('gauss',[1, 7], 1);
Gd = gradient(G);

Ix = conv2(image2, Gd, 'same');
Iy = conv2(image2, Gd', 'same');
It = image2 - image1;

for j = 1:imageHeight/windowHeight
    for i = 1:imageWidth/windowWidth
        %Wimage1 = image1((j*windowHeight)-windowHeight +1:j*windowHeight -1, (i*windowWidth)-windowWidth+1:i*windowWidth -1);
        %Wimage2 = image2((j*windowHeight)-windowHeight +1:j*windowHeight -1, (i*windowWidth)-windowWidth+1:i*windowWidth -1);
        WIx2 = Ix((j*windowHeight)-windowHeight +1:j*windowHeight, (i*windowWidth)-windowWidth+1:i*windowWidth);
        WIy2 = Iy((j*windowHeight)-windowHeight +1:j*windowHeight, (i*windowWidth)-windowWidth+1:i*windowWidth);
        WIt = It((j*windowHeight)-windowHeight +1:j*windowHeight, (i*windowWidth)-windowWidth+1:i*windowWidth);
        A = [reshape(WIx2, [windowHeight*windowWidth, 1]), reshape(WIy2, [windowHeight*windowWidth, 1])];
        b = reshape(-WIt, [windowHeight*windowWidth, 1]);
        v = pinv(A' * A) * A' * b
    end
end

end