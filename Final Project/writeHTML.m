function writeHTML()
%
AirplanesOrder = load('airplanesScores.mat');
CarOrder = load('carsScores.mat');
FaceOrder = load('facesScores.mat');
MotorbikeOrder = load('motorbikesScores.mat');


for j = 1:50
AirplaneNames = strcat('airplanes_test/','img' , sprintf('%03d', j), '.jpg'); 
CarNames = strcat('cars_test/','img' , sprintf('%03d', j), '.jpg'); 
FaceNames = strcat('faces_test/','img' , sprintf('%03d', j), '.jpg'); 
MotorbikeNames = strcat('motorbikes_test/','img' , sprintf('%03d', j), '.jpg'); 
end
names = [AirplaneNames; CarNames; FaceNames; MotorbikeNames];

[values, order] = sort(AirplaneOrder);
AirplanesSorted = names(order,:)
[values, order] = sort(CarOrder);
CarSorted = names(order,:)
[values, order] = sort(FaceOrder);
FaceSorted = names(order,:)
[values, order] = sort(MotorbikeOrder);
MotorbikeSorted = names(order,:)

fileID = fopen('exp.txt','w');
for i = 1:size(Airplanes, 2)
fprintf(fileID,'<tr><td><img src="Caltech4/ImageData/%s" /></td><td><img src="Caltech4/ImageData/%s" /></td><td><img src="Caltech4/ImageData/%s" /></td><td><img src="Caltech4/ImageData/%s" /></td></tr>\r\n',Airplanes(1,i),Cars(1,i),Faces(1,i),Motorbikes(1,i));
end
fclose(fileID);


end