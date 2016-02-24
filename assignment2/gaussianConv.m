function imOut = gaussianConv ( im_path , sigma_x , sigma_y )
image = imread(im_path);
image = rgb2gray(image);
image = im2double(image);

kernel_x = gaussian(sigma_x, 11);
kernel_y = gaussian(sigma_y, 11);

image = conv2(image, kernel_x, 'same');
imOut = conv2(image, transpose(kernel_y), 'same');

imshow(imOut)

end
