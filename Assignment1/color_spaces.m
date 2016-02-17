function color_spaces(image, color_space)

img = imread(image); % Read image
red = img(:,:,1); % Red channel
green = img(:,:,2); % Green channel
blue = img(:,:,3); % Blue channel
a = zeros(size(img, 1), size(img, 2));
just_red = cat(3, red, a, a);
just_green = cat(3, a, green, a);
just_blue = cat(3, a, a, blue);

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
        O2 = (red+green - 2.*blue)./sqrt(6);
        O3 = (red+green+blue)./sqrt(3);
        
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
        just_normalized_red = cat(3, nomalized_red, a, a);
        just_nomalized_green = cat(3, a, nomalized_green, a);
        just_nomalized_blue = cat(3, a, a, nomalized_blue);
        normalized_img = cat(3, nomalized_red, nomalized_green, nomalized_blue);

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