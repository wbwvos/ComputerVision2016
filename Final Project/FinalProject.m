function FinalProject()
    run('vlfeat-0.9.20/toolbox/vl_setup')
    if exist('codebook.mat', 'file') ~= 2
        'no codebook.mat file found. Creating a visualVocabulary with:'
        vocabularySize = 400
        noTrainingImages = 100
        createVisualVocabulary(vocabularySize, noTrainingImages);
    end
    trainingImagePerClass = 20
    train = 1;
    if train == 1
        'Training airplanes SVM classifier'
        airplanesSVM = compact(trainSVM('airplanes', trainingImagePerClass));
        save('airplanesSVM.mat', 'airplanesSVM');

        'Training cars SVM classifier'
        carsSVM = trainSVM('cars', trainingImagePerClass);
        save('carsSVM.mat', 'carsSVM');

        'Training faces SVM classifier'
        facesSVM = trainSVM('faces', trainingImagePerClass);
        save('facesSVM.mat', 'facesSVM');

        'Training motorbikes SVM classifier'
        motorbikesSVM = trainSVM('motorbikes', trainingImagePerClass);
        save('motorbikesSVM.mat', 'motorbikesSVM');
    else
        airplanesSVM = load('airplanesSVM.mat', 'airplanesSVM');
        airplanesSVM = airplanesSVM.airplanesSVM
        carsSVM = load('carsSVM.mat', 'carsSVM');
        carsSVM = carsSVM.carsSVM
        facesSVM = load('facesSVM.mat', 'facesSVM');
        facesSVM = facesSVM.facesSVM
        motorbikesSVM = load('motorbikesSVM.mat', 'motorbikesSVM');
        motorbikesSVM = motorbikesSVM.motorbikesSVM
    end
    'Classifying images'
    [airplanesLabels, airplanesScores] = classifySVM(airplanesSVM);
    airplanesScores = airplanesScores(:,2);
    save('airplanesScores.mat', 'airplanesScores');
    
    [carsLabels, carsScores] = classifySVM(carsSVM);
    carsScores = carsScores(:,2);
    save('carsScores.mat', 'carsScores');
    
    [facesLabels, facesScores] = classifySVM(facesSVM);
    facesScores = facesScores(:,2);
    save('facesScores.mat', 'facesScores');
    
    [motorbikesLabels, motorbikesScores] = classifySVM(motorbikesSVM);
    motorbikesScores = motorbikesScores(:,2);
    save('motorbikesScores.mat', 'motorbikesScores');
    
end







