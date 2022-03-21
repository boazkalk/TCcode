function [registeredimage, vertbod, spincan, sidevert] = image_registration(fixed, moving, RotatedPoint1, RotatedPoint2, RotatedPoint3)

[~,metric] = imregconfig('multimodal');

%% Optimizer (stand)
optimizer = registration.optimizer.OnePlusOneEvolutionary;
optimizer.InitialRadius = 6.25e-3/10; %smaller initial radius = less deviation from moving rotated input image
optimizer.GrowthFactor = 1.07;
optimizer.Epsilon = 1.5e-6;
optimizer.MaximumIterations = 250;

registeredimage = imregister(moving,fixed,'similarity',optimizer,metric);
tform = imregtform(moving, fixed, 'similarity', optimizer, metric);

%%new coordinates 
[vertbod(1,2),vertbod(1,1)] = transformPointsForward(tform,RotatedPoint1(1),RotatedPoint1(2));
[spincan(1,2),spincan(1,1)] = transformPointsForward(tform,RotatedPoint2(1),RotatedPoint2(2));
[sidevert(1,2),sidevert(1,1)] = transformPointsForward(tform,RotatedPoint3(1),RotatedPoint3(2));

vertbod = round(vertbod);
spincan = round(spincan);
sidevert = round(sidevert);

%%plot
figure()
subplot(1,2,1)
imshowpair(registeredimage,fixed)
hold on
plot(vertbod(1,2) , vertbod(1,1),'s','MarkerEdgeColor','red','MarkerFaceColor','red')
hold on
plot(spincan(1,2), spincan(1,1),'s','MarkerEdgeColor','blue','MarkerFaceColor','blue')
subplot(1,2,2)
imshow(moving)
end