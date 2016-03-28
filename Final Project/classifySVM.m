function [label, score] = classifySVM(SVMModel)
classes = {'airplanes', 'cars', 'faces', 'motorbikes'};
noTestImages = 50;
folder = 'Caltech4\ImageData';

C = cell2mat(struct2cell(load('codebook.mat', 'C')));

data = zeros(noTestImages * length(classes), size(C, 1));

for i = 1:length(classes)
    directory = strcat(pwd, '\',folder,'\', classes{i}, '_test\');
    for j = 1:noTestImages
        filename = strcat(directory, 'img' , sprintf('%03d', j), '.jpg');
        histogram = computeHistogram(C', filename);
        data(j,:) = histogram;
    end
end                
    %class = svmclassify(svmStruct, data);
    [label, score] = predict(SVMModel, data);
end

