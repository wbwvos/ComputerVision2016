function newImage = transform(X, ima, imb)
% This function will stitch the right image on the left image. 

[n1, m1] = size(ima);
[n, m] = size(imb);
diagonal = round(sqrt(n^2+m^2));

[left, right] = matchHeight(ima, imb);
right = zeros(size(ima));
concat1 = cat(2, left, right);


emptyImage = zeros(diagonal+n1, diagonal+m1);
M = [X(1,1), X(2, 1); X(3,1),  X(4,1)];
T = [X(5,1); X(6,1)];

% 
cornerLB = round(M*[1; 1]+ T);
cornerRB = round(M*[m; 1]+ T);
cornerLO = round(M*[1; n]+ T);
cornerRO = round(M*[m; n]+ T);
corners = horzcat(cornerLB, cornerRB, cornerLO, cornerRO);

% get the min and max of the x and y coordinates
minX = min(corners(1,:))
minY = min(corners(2,:))
maxX = max(corners(1,:));
maxY = max(corners(1,:));

 
 % the transformation and interpolation
for y = 1:n
    for x = 1:m
        newC = round(M*[x; y]+T);
        concat1(newC(2,1), newC(1,1)) = imb(y, x);
    end
end

%newImage = emptyImage;
newImage = concat1;
figure
imshow(concat1(:,1:maxY));
%imshow(newImage./255);
end