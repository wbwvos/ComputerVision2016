function BoW()
run('vlfeat-0.9.20/toolbox/vl_setup')
sigma = 1;
k = 2;

allDescriptors = []; 

folder = 'ImageData';
directory = strcat(pwd, '\',folder,'\');

subdirs = dir(directory);
for i=1:length(subdirs)
    path = strcat(directory ,subdirs(i).name);
    fileCheck = strcat(path, '\img400.jpg');
    if exist(fileCheck) == 2
        files = dir(path);
        for j=1:length(files) 
            filename = strcat(path, '\', files(j+3).name)
            im = rgb2gray(imread(filename));
            im = single(im);
            
            Is = vl_imsmooth(im, sigma) ;
            [frames, descriptors] = vl_dsift(Is) ;

            %[frames, descriptors] = vl_sift(im);  
            if i == 4 && j == 1
                allDescriptors = descriptors;
            else
            allDescriptors = [allDescriptors descriptors];
            end
            break
            
        end
    end
end
descriptors = double(allDescriptors);
[idx, C] = kmeans(allDescriptors, k);
end