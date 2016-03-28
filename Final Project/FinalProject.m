function FinalProject()
    run('vlfeat-0.9.20/toolbox/vl_setup')
    if exist('codebook.mat', 'file') ~= 2
        'no codebook.mat file found. Creating a visualVocabulary with:'
        vocabularySize = 400
        noTrainingImages = 50
        createVisualVocabulary(vocabularySize, noTrainingImages);
    end
    trainingImagePerClass = 10
    train = 0;
    if train == 1
        'Training airplanes SVM classifier'
        airplanesSVM = compact(trainSVM('airplanes', trainingImagePerClass));
        save('airplanesSVM.mat', 'airplanesSVM');

%         'Training cars SVM classifier'
%         carsSVM = trainSVM('cars', trainingImagePerClass);
%         save('carsSVM.mat', 'carsSVM');
% 
%         'Training faces SVM classifier'
%         facesSVM = trainSVM('faces', trainingImagePerClass);
%         save('facesSVM.mat', 'facesSVM');
% 
%         'Training motorbikes SVM classifier'
%         motorbikesSVM = trainSVM('motorbikes', trainingImagePerClass);
%         save('motorbikesSVM.mat', 'motorbikesSVM');
    else
        airplanesSVM = load('airplanesSVM.mat', 'airplanesSVM');
        airplanesSVM = airplanesSVM.airplanesSVM
        
    end
    'Classifying images'
    [airplanesLabels, airplanesScores] = classifySVM(airplanesSVM);
%     carsResult = classifySVM(carsSVM);
%     facesResult = classifySVM(facesSVM);
%     motorbikesResult = classifySVM(motorbikesSVM);
    
end







