function tracking()
close all
contents = dir('C:\Users\Kasper\Documents\GitHub\ComputerVision2016\assignment3\pingpong');
windowWidth  = 11;
windowHeight = 11;
windowBorder = floor(windowHeight/2);
imcounter = 0;
coordinates = 0;
for i = 1:numel(contents)-1
  filename = contents(i).name;
  [path, name, ext] = fileparts(filename);
  
  filename2 = contents(i+1).name;
  [path2, name2, ext2] = fileparts(filename2);
  
  if ext == '.jpeg'
      imcounter = imcounter + 1;
      if imcounter == 1
        [H, coordinates] = HarrisCornerDetector(strcat('\pingpong\',name, ext));
      end
  image1 = strcat('\pingpong\',name, ext);
  image2 = strcat('\pingpong\',name2, ext2);
  newcoordinates = Lucas_Kanade2(image1, image2, coordinates);   
  coordinates = newcoordinates;
  end
  %if i == 10
  %    break
  %end
end


end


function newcoordinates = Lucas_Kanade2(image1, image2, coordinates)

rawImage1 = imread(image1);
image1 = im2double(rgb2gray(rawImage1));

rawImage2 = imread(image2);
image2 = im2double(rgb2gray(rawImage2));

[imageHeight, imageWidth] = size(image2);
windowHeight = 41;
windowWidth = 41;
windowBorder = floor(windowHeight/2);

G = fspecial('gauss',[1, 7], 1);
Gd = gradient(G);

Ix = conv2(image2, Gd, 'same');
Iy = conv2(image2, Gd', 'same');
It = image2 - image1;

[m,n] = size(coordinates);

Vx = zeros([m,1]);
Vy = zeros([m,1]);
  
for i = 1:m
  WIx2 = Ix(coordinates(i, 1)- windowBorder: coordinates(i, 1)+ windowBorder, coordinates(i, 2)- windowBorder: coordinates(i, 2)+ windowBorder);
  WIy2 = Iy(coordinates(i, 1)- windowBorder: coordinates(i, 1)+ windowBorder, coordinates(i, 2)- windowBorder: coordinates(i, 2)+ windowBorder);
  WIt = It(coordinates(i, 1)- windowBorder: coordinates(i, 1)+ windowBorder, coordinates(i, 2)- windowBorder: coordinates(i, 2)+ windowBorder);
  A = [reshape(WIx2, [windowHeight*windowWidth, 1]), reshape(WIy2, [windowHeight*windowWidth, 1])];
  b = reshape(-WIt, [windowHeight*windowWidth, 1]);
  v = pinv(A' * A) * A' * b;
  Vx(i,1) = v(1);
  Vy(i,1) = v(2);
end
figure
imshow(rawImage2);
hold on
quiver(coordinates(:,2), coordinates(:,1), Vx, Vy)

coordinates(:, 1) = coordinates(:,1)+ round(Vy);
coordinates(:, 2) = coordinates(:,2)+ round(Vx);
Vy
Vx
newcoordinates = coordinates
end