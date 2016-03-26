function BoW()
run('vlfeat-0.9.20/toolbox/vl_setup')

im = rgb2gray(imread('Caltech4/ImageData/motorbikes_train/img001.jpg'));
im = single(im);
binSize = 8 ;
magnif = 3 ;
Ismooth = vl_imsmooth(im, sqrt((binSize/magnif)^2 - .25)) ;
[f, d] = vl_dsift(Ismooth, 'size', binSize) ;
f(3,:) = binSize/magnif;
f(4,:) = 0 ;
[f_, d_] = vl_sift(im, 'frames', f);  
[n,m] = size(d_);

[idx, C] = kmeans(double(d), 4);

%x1 = min(X(:,1)):0.01:max(X(:,1));
%x2 = min(X(:,2)):0.01:max(X(:,2));
%[x1G,x2G] = meshgrid(x1,x2);
%XGrid = [x1G(:),x2G(:)]; % Defines a fine grid on the plot

%idx2Region = kmeans(XGrid,3,'MaxIter',1,'Start',C);
    % Assigns each node in the grid to the closest centroid
end