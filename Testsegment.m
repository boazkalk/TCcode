clear all 
close all

%%define paths PC
%pathimage = 'C:\Users\boazk\Desktop\team challenge\Algo\Team challenge 2021\Scoliose\';
%pathlandm = 'C:\Users\boazk\Desktop\team challenge\Algo\Team challenge 2021\Landmarks\';

%%define paths laptop
pathimage = 'C:\School\Master\Jaar 2\Q3\TC\Team challenge 2021\Scoliose\';
pathlandm = 'C:\School\Master\Jaar 2\Q3\TC\Team challenge 2021\Landmarks\';

nameimage = '3preop.nii';
namelandm = '3preop.xml';
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
nrs = [4 5 7];
for i = 1:1:length(nrs)
    tempnr = nrs(i);
    x = landmarks(tempnr,1);
    y = landmarks(tempnr,2);
    slice_nii(x-5:x+5,y-5:y+5) = 2500;
end

nii(:,:,landmark_slice) = slice_nii;

[xnii,ynii,znii] = size(nii);
BW = getbaseimage2('Register_images\vertebra0-clr.png');
lm7 = landmarks(7,:);
lm4 = landmarks(4,:);
lm5 = landmarks(5,:);
nii2=nii;
rotation = 0;
dist_between_end = pdist([lm7(1:2);lm4(1:2)],'euclidean');

% for i = landmark_slice-10:-10:1
% 
%     slice_nii_temp = nii2(:,:,i);
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
%     baseimage = BW_rot;
%     
%     [registeredimage, vertbod, spincan] = image_registration(bin_image_parted, BW_rot, RotatedPoint1, RotatedPoint2);
% 
%     vertbod = vertbod+[ymin,xmin];
%     spincan = spincan+[ymin,xmin];
% 
%     dist_vertbod = pdist([vertbod;lm4(1:2)],'euclidean');
%     dist_spincan = pdist([spincan;lm7(1:2)],'euclidean');
% 
%     dist_between = pdist([vertbod;spincan],'euclidean');
%     ratio_dist_between = dist_between/dist_between_end;
% 
%     
%     if ratio_dist_between > 1.30 || ratio_dist_between < 0.7 || dist_spincan > 25 || dist_vertbod > 25
%         fractions = [5 8 11 12 13 14 15 16 17 18 19 20];
%         counter = 1;
% 
% %         disp(strcat('ratio ' , num2str(ratio_dist_between)));
% %         disp(strcat('spincan ' , num2str(dist_spincan)));
% %         disp(strcat('vertbod ' , num2str(dist_vertbod)));
% 
%         while counter < length(fractions+1)
%             [registeredimage, vertbod, spincan] = image_registration1(bin_image_parted, baseimage, RotatedPoint1, RotatedPoint2, fractions(counter));
%             vertbod = vertbod+[ymin,xmin];
%             spincan = spincan+[ymin,xmin];
% 
%             dist_vertbod = pdist([vertbod;lm4(1:2)],'euclidean');
%             dist_spincan = pdist([spincan;lm7(1:2)],'euclidean');
% 
%             dist_between = pdist([vertbod;spincan],'euclidean');
%             ratio_dist_between = dist_between/dist_between_end;
% 
% %             disp(strcat('ratio ' , num2str(ratio_dist_between)));
% %             disp(strcat('spincan ' , num2str(dist_spincan)));
% %             disp(strcat('vertbod ' , num2str(dist_vertbod)));
% 
%             if ratio_dist_between < 1.30 && ratio_dist_between > 0.70 && dist_spincan < 25 && dist_vertbod < 25
%             disp(num2str(fractions(counter)));
%             counter = 100;
%             else 
%             counter = counter+1;
%             end
%         end
% 
%         if counter == 100
%             coord_vertbod = vertbod;
%             coord_spincan = spincan;
%             lm7 = spincan;
%             lm4 = vertbod;
%             disp('taken retry new')
%         else
%             coord_vertbod = lm4;
%             coord_spincan = lm7;
%             lm4 = lm4(1:2);
%             lm7 = lm7(1:2);
%             disp('taken old')
%         end
%     else
%         coord_vertbod = vertbod;
%         coord_spincan = spincan;
%         lm7 = spincan;
%         lm4 = vertbod;
%         disp('taken new')
%     end
% 
%     dist_between_end = pdist([coord_vertbod;coord_spincan],'euclidean');
%     
%     slice_nii_temp(coord_vertbod(1)-5:coord_vertbod(1)+5,coord_vertbod(2)-5:coord_vertbod(2)+5) = 2500;
%     slice_nii_temp(coord_spincan(1)-5:coord_spincan(1)+5,coord_spincan(2)-5:coord_spincan(2)+5) = 2500;
% 
%     nii2(:,:,i) = slice_nii_temp;
%  
% end

lm7 = landmarks(7,:);
lm4 = landmarks(4,:);
lm5 = landmarks(5,:);
rotation = 0;
dist_between_end = pdist([lm7(1:2);lm4(1:2)],'euclidean');

for i = landmark_slice+10:10:landmark_slice+20

    slice_nii_temp = nii2(:,:,i);
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
    if i == landmark_slice+10
    else 
       if rotationdiff > 8
            rotation = (rotationprev+rotation)/2;
       else
       end
    end
    
    [BW_rot, RotatedPoint1,RotatedPoint2,RotatedPoint3] = rotate_image(BW, rotation);
    baseimage = BW_rot;
    
    [registeredimage, vertbod, spincan, sidevert] = image_registration(bin_image_parted, BW_rot, RotatedPoint1, RotatedPoint2, RotatedPoint3);

    vertbod = vertbod+[ymin,xmin];
    spincan = spincan+[ymin,xmin];
    sidevert = sidevert+[ymin,xmin];

    dist_vertbod = pdist([vertbod;lm4(1:2)],'euclidean');
    dist_spincan = pdist([spincan;lm7(1:2)],'euclidean');

    dist_between = pdist([vertbod;spincan],'euclidean');
    ratio_dist_between = dist_between/dist_between_end;

    
    %if ratio_dist_between > 1.30 || ratio_dist_between < 0.70 || dist_spincan > 25 || dist_vertbod > 25
    if ratio_dist_between > 1.30 || dist_spincan > 25 || dist_vertbod > 25
        fractions = [5 8 12 14 16 18 20 3 1];
        counter = 1;

%         disp(strcat('ratio ' , num2str(ratio_dist_between)));
%         disp(strcat('spincan ' , num2str(dist_spincan)));
%         disp(strcat('vertbod ' , num2str(dist_vertbod)));

        while counter < length(fractions+1)
            [registeredimage, vertbod, spincan, sidevert] = image_registration1(bin_image_parted, baseimage, RotatedPoint1, RotatedPoint2, RotatedPoint3, fractions(counter));
            vertbod = vertbod+[ymin,xmin];
            spincan = spincan+[ymin,xmin];
            sidevert = sidevert+[ymin,xmin];

            dist_vertbod = pdist([vertbod;lm4(1:2)],'euclidean');
            dist_spincan = pdist([spincan;lm7(1:2)],'euclidean');

            dist_between = pdist([vertbod;spincan],'euclidean');
            ratio_dist_between = dist_between/dist_between_end;

%             disp(strcat('ratio ' , num2str(ratio_dist_between)));
%             disp(strcat('spincan ' , num2str(dist_spincan)));
%             disp(strcat('vertbod ' , num2str(dist_vertbod)));

            %if ratio_dist_between < 1.30 && ratio_dist_between > 0.70 && dist_spincan < 25 && dist_vertbod < 25
            if  ratio_dist_between < 1.30 && dist_spincan < 25 && dist_vertbod < 25
            disp(num2str(fractions(counter)));
            counter = 100;
            else 
            counter = counter+1;
            end
        end

        if counter == 100
            coord_vertbod = vertbod;
            coord_spincan = spincan;
            coord_sidevert = sidevert;
            lm7 = spincan;
            lm4 = vertbod;
            lm5 = sidevert;
            disp('taken retry new')
        else
            coord_vertbod = lm4;
            coord_spincan = lm7;
            coord_sidevert = lm5;
            lm4 = lm4(1:2);
            lm7 = lm7(1:2);
            lm5 = lm5(1:2);
            disp('taken old')
        end
    else
        coord_vertbod = vertbod;
        coord_spincan = spincan;
        coord_sidevert = sidevert;
        lm7 = spincan;
        lm4 = vertbod;
        lm5 = sidevert;
        disp('taken new')
    end

    dist_between_end = pdist([coord_vertbod;coord_spincan],'euclidean');
    
    slice_nii_temp(coord_vertbod(1)-5:coord_vertbod(1)+5,coord_vertbod(2)-5:coord_vertbod(2)+5) = 2500;
    slice_nii_temp(coord_spincan(1)-5:coord_spincan(1)+5,coord_spincan(2)-5:coord_spincan(2)+5) = 2500;
    slice_nii_temp(coord_sidevert(1)-5:coord_sidevert(1)+5,coord_sidevert(2)-5:coord_sidevert(2)+5) = 2500;

    nii2(:,:,i) = slice_nii_temp;
 
end

%volumeViewer(nii2);




















