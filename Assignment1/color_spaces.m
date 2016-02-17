function color_spaces(image, color_space)

img = imread(image); % Read image
red = img(:,:,1); % Red channel
green = img(:,:,2); % Green channel
blue = img(:,:,3); % Blue channel
a = zeros(size(img, 1), size(img, 2));%creates a matrix of zeros the size of the image
just_red = cat(3, red, a, a); %this concatenates the red channel with two channels with zeros
just_green = cat(3, a, green, a);%this concatenates the green channel with two channels with zeros
just_blue = cat(3, a, a, blue); %this concatenates the blue channel with two channels with zeros

switch color_space
    case 'RGB'
        figure
        subplot(2,2,1)
        subimage(img)
        title('Original image')

        subplot(2,2,2)
        subimage(just_red)
        title('Red channel')

        subplot(2,2,3)
        subimage(just_green)
        title('Green channel')

        subplot(2,2,4)
        subimage(just_blue)
        title('Blue channel')
    case 'opponent'
        O1 = (red - green)./sqrt(2);
        %the first opponent channel subtracts the green channel from the red channel
        %(elementwise) and devides it by the square root of 2
        O2 = (red+green - 2.*blue)./sqrt(6);
        %the second opponent channel adds the red and green channels
        %together and subtrackts the blue one from it times two
        %the total is devided by the square root of 6
        O3 = (red+green+blue)./sqrt(3);
        %the last one adds all the channels together and devides the total
        %by the square root of 3
        figure
        subplot(2,2,1)
        subimage(O1)
        title('O1')

        subplot(2,2,2)
        subimage(O2)
        title('O2')

        subplot(2,2,3)
        subimage(O3)
        title('O3')
        
    case 'normRGB'
        nomalized_red = red./(red+green+blue);
        nomalized_green = green./(red+green+blue);
        nomalized_blue = blue./(red+green+blue);
        %each channel is normalized by deviding by the channels added
        %together
        just_normalized_red = cat(3, nomalized_red, a, a);
        just_nomalized_green = cat(3, a, nomalized_green, a);
        just_nomalized_blue = cat(3, a, a, nomalized_blue);
        %three seperate matrixes are made out of the normalized channels
        normalized_img = cat(3, nomalized_red, nomalized_green, nomalized_blue);
        %the normalized channels are combined to see how much information
        %is lost by normalizing
        figure
        subplot(2,2,1)
        subimage(just_normalized_red*255)
        title('normalized red * 255')

        subplot(2,2,2)
        subimage(just_nomalized_green*255)
        title('normalized green * 255')

        subplot(2,2,3)
        subimage(just_nomalized_blue*255)
        title('normalized blue * 255')

        subplot(2,2,4)
        subimage(normalized_img*255)
        title('normalized channels combined * 255')
    case 'HSV'
        hsv_image = rgb2hsv(img);
        %the built in function is used to get the hue, saturation and value
        %each of them are plotted separately and also the whole hsv_image
        %is plotted
        figure
        subplot(2,2,1)
        subimage(hsv_image(:,:,1))
        title('hue')

        subplot(2,2,2)
        subimage(hsv_image(:,:,2))
        title('saturation')

        subplot(2,2,3)
        subimage(hsv_image(:,:,3))
        title('value')
        
        subplot(2,2,4)
        subimage(hsv_image)
        title('image in HSV')
        
    otherwise 
        disp('Type either: RGB, opponent, normRGB, HSV')
end

end