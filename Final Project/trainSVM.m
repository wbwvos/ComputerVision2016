function [SVMModel] = trainSVM(trainingClass, noTrainingImages)
classes = {'airplanes', 'cars', 'faces', 'motorbikes'};

folder = 'Caltech4\ImageData';

C = cell2mat(struct2cell(load('codebook.mat', 'C')));

data = zeros(noTrainingImages * length(classes), size(C, 1));
labels = zeros(noTrainingImages * length(classes), 1);

for i = 1:length(classes)
    directory = strcat(pwd, '\',folder,'\', classes{i}, '_train\');
    for j = 1:noTrainingImages
        filename = strcat(directory, 'img' , sprintf('%03d', j), '.jpg');
        
        histogram = computeHistogram(C', filename);
        
        data(j,:) = histogram;
        if strcmp(trainingClass, classes(i))
           labels(j + noTrainingImages*(i-1), 1) = 1;
        end

        
    end
end  
        size(labels)
SVMModel = fitcsvm(data,labels)
%svmStruct = svmtrain(data, labels);

end