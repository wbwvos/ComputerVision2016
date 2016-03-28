function histogram = computeHistogram(C, filename)
im = imread(filename);
if size(im, 3) > 1
    im = rgb2gray(im);
end
im = single(im);
histogram = zeros(1, 400);
differences = zeros(size(C));
[frames, descriptors] = vl_sift(im);
descriptors = double(descriptors);

for i = 1:size(descriptors,2)
    for j = 1:size(C,2)
        differences(1,j) = norm(descriptors(:,i) - C(:,j));
    end
    smallest = min(differences);
    normpdf(differences, 0, smallest);
    histogram = histogram+differences;
end

histogram = histogram/sum(histogram);
end