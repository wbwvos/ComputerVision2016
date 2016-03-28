% function histogram = computeHistogram(C, filename)
% im = imread(filename);
% if size(im, 3) > 1
%     im = rgb2gray(im);
% end
% im = single(im);
% 
% histogram = zeros(1, size(C, 2));
% differences = zeros(1, size(C, 2));
% [frames, descriptors] = vl_sift(im);
% descriptors = double(descriptors);
% 
% for i = 1:size(descriptors,2)
%     for j = 1:size(C,2)
%         differences(1,j) = abs(norm(descriptors(:,i) - C(:,j)));
%     end
%     smallest = min(min(differences));
%     if smallest == 0
%         smallest = 1;
%     end
%     differences = normpdf(differences, 0, smallest);
%     histogram = histogram + differences;
% end
% 
% histogram = histogram/sum(histogram);
% end

function histogram = computeHistogram(C, filename)
im = imread(filename);
if size(im, 3) > 1
    im = rgb2gray(im);
end
im = single(im);
histogram = zeros(1, 400);
[frames, descriptors] = vl_sift(im);
descriptors = double(descriptors);

smallest = 10000000;
cluster = 0;
for i = 1:size(descriptors,2)
    for j = 1:size(C,2)
        difference = norm(descriptors(:,i) - C(:,j));
        if difference < smallest
            smallest = difference;
            cluster = j;
        end
        %break
    end
    
    histogram(cluster) = histogram(cluster) + 1;
end

histogram = histogram/sum(histogram);
end