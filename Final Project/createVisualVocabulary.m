function createVisualVocabulary(vocabularySize, noTrainingImages)

allDescriptors = []; 

folder = 'Caltech4\ImageData';
directory = strcat(pwd, '\',folder,'\');

subdirs = dir(directory);
for i=1:length(subdirs)
    path = strcat(directory ,subdirs(i).name);
    fileCheck = strcat(path, '\img400.jpg');
    if exist(fileCheck) == 2
        files = dir(path);
        for j=1:noTrainingImages %length(files) 
            filename = strcat(path, '\', files(j+3).name)
            im = imread(filename);
            if size(im, 3) > 1
                im = rgb2gray(im);
            end
            im = single(im);

            %Is = vl_imsmooth(im, sigma) ;
            %[frames, descriptors] = vl_dsift(Is) ;

            [frames, descriptors] = vl_sift(im);  

            if i == 1 && j == 1
                allDescriptors = descriptors;
            else
                allDescriptors = [allDescriptors descriptors];
            end
        end
    end
end
allDescriptors = double(allDescriptors');
totalDescriptors = size(allDescriptors, 1)
[idx, C] = kmeans(allDescriptors, vocabularySize);
save('codebook.mat','C', 'vocabularySize', 'noTrainingImages');
end