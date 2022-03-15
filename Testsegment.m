clear all 
close all

%%define paths PC
%pathimage = 'C:\Users\boazk\Desktop\team challenge\Algo\Team challenge 2021\Scoliose\';
%pathlandm = 'C:\Users\boazk\Desktop\team challenge\Algo\Team challenge 2021\Landmarks\';

%%define paths laptop
pathimage = 'C:\School\Master\Jaar 2\Q3\TC\Team challenge 2021\Scoliose\';
pathlandm = 'C:\School\Master\Jaar 2\Q3\TC\Team challenge 2021\Landmarks\';

nameimage = '1preop.nii';
namelandm = '1preop.xml';
s = strcat(pathimage,nameimage);
s2 = strcat(pathlandm,namelandm);

%%read in .nii and landmarks file
nii = niftiread(s);
landmarks_struct = xml2struct(s2);

%%extract landmarks
landmarks = getlandmarks(landmarks_struct);
landmarks = round(landmarks);

%%visualize landmarks
landmark_slice = landmarks(1,3);

slice_nii = nii(:,:,landmark_slice);
% slice_nii = uint8(255 * mat2gray(slice_nii));
for i = 4:3:7
    x = landmarks(i,1);
    y = landmarks(i,2);
    slice_nii(x-5:x+5,y-5:y+5) = 2500;
end

nii(:,:,landmark_slice) = slice_nii;

%%
[xnii,ynii,znii] = size(nii);
% BW = getbaseimage('vertebra-0.png');
% imshow(BW);
lm7 = landmarks(7,:);
lm4 = landmarks(4,:);
rotation = 0;

for i = landmark_slice-10:-10:1

    slice_nii_temp = nii(:,:,i);
    slice_nii = uint8(255 * mat2gray(slice_nii_temp));
    landmark_slice_nii = slice_nii;

    filtered_nii = filterimage(slice_nii);

    bin_image = makebin(filtered_nii);
    
    xmid = round((min(lm4(2), lm7(2))+max(lm4(2), lm7(2)))/2);
    ymid = round((min(lm4(1), lm7(1))+max(lm4(1), lm7(1)))/2);
    if xmid < 151
        xmin = 1;
    else
        xmin = xmid-150;
    end
    if ymid < 151
        ymin = 1;
    else
        ymin = ymid-150;
    end
    xmax = xmid+150;
    ymax = ymid+150;
    
    bin_image_parted = bin_image(ymin:ymax,xmin:xmax);

    %%calculate angle that initial landmarks make and pre-rotate standard image
    %%for better initial guess
    
    rotationprev = rotation;
    rotation = getinitrotation(lm4, lm7);
    rotationdiff = abs(rotationprev-rotation);
    if i == landmark_slice-10
    else 
       if rotationdiff > 8
            rotation = rotationprev;
       else
       end
    end

    angle = 360-rotation;
    angles = []

    baseimage = im2uint8(BW);
    
    [BW_rot, RotatedPoint1,RotatedPoint2] = rotate_image(BW, rotation);
    
    [registeredimage, vertbod, spincan] = image_registration(bin_image_parted, BW_rot, RotatedPoint1, RotatedPoint2);

%     figure()
%     imshowpair(bin_image_parted, BW_rot,'montage');

%     [registeredimage, vertbod, spincan] = image_registration(bin_image, BW_rot, RotatedPoint1, RotatedPoint2);

    vertbod = vertbod+[ymin,xmin];
    spincan = spincan+[ymin,xmin];
    
    slice_nii_temp(vertbod(1)-5:vertbod(1)+5,vertbod(2)-5:vertbod(2)+5) = 2500;
    slice_nii_temp(spincan(1)-5:spincan(1)+5,spincan(2)-5:spincan(2)+5) = 2500;

    nii(:,:,i) = slice_nii_temp;

    lm7 = spincan;
    lm4 = vertbod;

end



%%INITIAL WORKING WITH SINGLE MOVING IMAGE AND ROTATION
% [xnii,ynii,znii] = size(nii);
% BW = getbaseimage('vertebra0.png');
% lm7 = landmarks(7,:);
% lm4 = landmarks(4,:);
% rotation = 0;
%
% for i = landmark_slice-10:-10:1
% 
%     slice_nii_temp = nii(:,:,i);
%     slice_nii = uint8(255 * mat2gray(slice_nii_temp));
%     landmark_slice_nii = slice_nii;
% 
%     filtered_nii = filterimage(slice_nii);
% 
%     bin_image = makebin(filtered_nii);
%     
%     xmid = round((min(lm4(2), lm7(2))+max(lm4(2), lm7(2)))/2);
%     ymid = round((min(lm4(1), lm7(1))+max(lm4(1), lm7(1)))/2);
%     if xmid < 151
%         xmin = 1;
%     else
%         xmin = xmid-150;
%     end
%     if ymid < 151
%         ymin = 1;
%     else
%         ymin = ymid-150;
%     end
%     xmax = xmid+150;
%     ymax = ymid+150;
%     
%     bin_image_parted = bin_image(ymin:ymax,xmin:xmax);
% 
%     %%calculate angle that initial landmarks make and pre-rotate standard image
%     %%for better initial guess
%     
%     rotationprev = rotation;
%     rotation = getinitrotation(lm4, lm7);
%     rotationdiff = abs(rotationprev-rotation);
%     if i == landmark_slice-10
%     else 
%        if rotationdiff > 8
%             rotation = rotationprev;
%        else
%        end
%     end
%     
%     [BW_rot, RotatedPoint1,RotatedPoint2] = rotate_image(BW, rotation);
%     
%     [registeredimage, vertbod, spincan] = image_registration(bin_image_parted, BW_rot, RotatedPoint1, RotatedPoint2);
% 
% %     figure()
% %     imshowpair(bin_image_parted, BW_rot,'montage');
% 
% %     [registeredimage, vertbod, spincan] = image_registration(bin_image, BW_rot, RotatedPoint1, RotatedPoint2);
% 
%     vertbod = vertbod+[ymin,xmin];
%     spincan = spincan+[ymin,xmin];
%     
%     slice_nii_temp(vertbod(1)-5:vertbod(1)+5,vertbod(2)-5:vertbod(2)+5) = 2500;
%     slice_nii_temp(spincan(1)-5:spincan(1)+5,spincan(2)-5:spincan(2)+5) = 2500;
% 
%     nii(:,:,i) = slice_nii_temp;
% 
%     lm7 = spincan;
%     lm4 = vertbod;
% 
% end
%
% lm7 = landmarks(7,:);
% lm4 = landmarks(4,:);
% rotation = 0;
% 
% for i = landmark_slice+10:10:znii
% 
%     slice_nii_temp = nii(:,:,i);
%     slice_nii = uint8(255 * mat2gray(slice_nii_temp));
%     landmark_slice_nii = slice_nii;
% 
%     filtered_nii = filterimage(slice_nii);
% 
%     bin_image = makebin(filtered_nii);
% 
%     xmid = round((min(lm4(2), lm7(2))+max(lm4(2), lm7(2)))/2);
%     ymid = round((min(lm4(1), lm7(1))+max(lm4(1), lm7(1)))/2);
%     if xmid < 151
%         xmin = 1;
%     else
%         xmin = xmid-150;
%     end
%     if ymid < 151
%         ymin = 1;
%     else
%         ymin = ymid-150;
%     end
%     xmax = xmid+150;
%     ymax = ymid+150;
%     
%     bin_image_parted = bin_image(ymin:ymax,xmin:xmax);
% 
%     %calculate angle that initial landmarks make and pre-rotate standard image
%     %for better initial guess
%     
%     rotationprev = rotation;
%     rotation = getinitrotation(lm4, lm7);
%     rotationdiff = abs(rotationprev-rotation);
%     if i == landmark_slice+10
%     else 
%        if rotationdiff > 8
%             rotation = rotationprev;
%        else
%        end
%     end
%     
%     [BW_rot, RotatedPoint1,RotatedPoint2] = rotate_image(BW, rotation);
%     
%     [registeredimage, vertbod, spincan] = image_registration(bin_image_parted, BW_rot, RotatedPoint1, RotatedPoint2);
% 
%     vertbod = vertbod+[ymin,xmin];
%     spincan = spincan+[ymin,xmin];
%     
%     slice_nii_temp(vertbod(1)-5:vertbod(1)+5,vertbod(2)-5:vertbod(2)+5) = 2500;
%     slice_nii_temp(spincan(1)-5:spincan(1)+5,spincan(2)-5:spincan(2)+5) = 2500;
% 
%     nii(:,:,i) = slice_nii_temp;
% 
%     lm7 = spincan;
%     lm4 = vertbod;
% 
% end

volumeViewer(nii)

%%
[Boundaries,L] = bwboundaries(bin_image,'noholes');

%%
% figure()
% subplot(1,2,1)
% imshow(L)
% hold on
% for k = 1:length(Boundaries)
%    boundary = Boundaries{k};
%    plot(boundary(:,2), boundary(:,1), 'b', 'LineWidth', 2)
% end
% hold on
% for k = 1:length(Boundaries)
% temp = Boundaries{k};
% x1 = temp(:,1);
% y1 = temp(:,2);
% polyin = polyshape({x1},{y1});
% [x,y] = centroid(polyin);
% hold on
% plot(y,x,'r*')
% coords(k,:) = [x,y];
% axis on
% end
% subplot(1,2,2)
% imshow(slice_nii)

% j = 1;
% for i = 1:length(coords)
%     if isnan(coords(i,1)) == 1
%         nan(j) = i;
%         j=j+1;
%     else 
%     end
% end
% coords(nan,:) = [];



function image = makebin(x)
    image = x;
    for i = 1:1:height(x)
        for j = 1:1:width(x)
            if x(i,j) > 0
                image(i,j) = 255;
            else
            end
        end
    end
end

function filtered_nii = filterimage(image)
nii_filtered = [];
for i = 1:1:height(image)
    for j = 1:1:width(image)        
        if image(i,j) > 128
            nii_filtered(i,j) = image(i,j);
        else
            nii_filtered(i,j) = 0;
        end
    end
end

% figure()
% subplot(1,3,1)
% imshow(nii_filtered)
% %%
se2 = strel("disk", 2); 
close = imclose(nii_filtered, se2);
% subplot(1,3,2)
% imshow(close)
se2 = strel("disk", 2); 
temp = imopen(close, se2);
% subplot(1,3,3)
% imshow(temp)
filtered_nii = temp;
end

function landmarks = getlandmarks(x)
j=1;
for i = 2:2:16
temp = x.Children(2).Children(6).Children(i).Children(4).Children.Data;
temp = str2num(temp);
landmarks(j,:) = temp(1,1:3);
j=j+1;
end
end

function baseimage = getbaseimage(name)
I = imread(name);
% vertebra1 = I(:,:,1);
% BW = imbinarize(vertebra1);
% BW = imcomplement(BW);
% baseimage = im2uint8(BW);
baseimage = im2uint8(I);
end

function rotation = getinitrotation(lm4, lm7)
spincanpoint1 = lm7;
vertpoint2 = lm4;
vect = [(spincanpoint1(1,1)-vertpoint2(1,1)), (spincanpoint1(1,2)-vertpoint2(1,2))];
angle1=angle(vect(1)+1i*vect(2));
rotation = 360+angle1*180/pi;
end

function [BW_rot, RotatedPoint1,RotatedPoint2] = rotate_image(BW, alpha)
landmarks_standard = [93,93;5,117];
BW_rot = imrotate(BW,alpha);
ImCenterA = (size(BW)/2)'; 
ImCenterB = (size(BW_rot)/2)';
P1 = landmarks_standard(:,1);
P2 = landmarks_standard(:,2);
RotMatrix = [cosd(-alpha) -sind(-alpha); sind(-alpha) cosd(-alpha)]; 
RotatedPoint1 = RotMatrix*(P1-ImCenterA)+ImCenterB;
RotatedPoint2 = RotMatrix*(P2-ImCenterA)+ImCenterB;
end

function [registeredimage, vertbod, spincan] = image_registration(fixed, moving, RotatedPoint1, RotatedPoint2)

[optimizer,metric] = imregconfig('multimodal');
optimizer.InitialRadius = optimizer.InitialRadius/3.5;
%optimizer.GrowthFactor = 1;
optimizer.MaximumIterations = 500;
registeredimage = imregister(moving,fixed,'similarity',optimizer,metric);
tform = imregtform(moving, fixed, 'similarity', optimizer, metric);

%%new coordinates 
[vertbod(1,2),vertbod(1,1)] = transformPointsForward(tform,RotatedPoint1(1),RotatedPoint1(2));
[spincan(1,2),spincan(1,1)] = transformPointsForward(tform,RotatedPoint2(1),RotatedPoint2(2));

vertbod = round(vertbod);
spincan = round(spincan);

%%plot
% figure,imshowpair(registeredimage,fixed)
% hold on
% plot(vertbod(1,2) , vertbod(1,1),'s','MarkerEdgeColor','red','MarkerFaceColor','red')
% hold on
% plot(spincan(1,2), spincan(1,1),'s','MarkerEdgeColor','blue','MarkerFaceColor','blue')
end