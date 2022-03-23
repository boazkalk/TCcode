function [nii2, Vertebra_body_points, Spinal_canal_points, Side_Vertebra_body_points] = getlandmarkcoordinates(nii, landmark_slice, landmarks, slice_interval)

slice_nii = nii(:,:,landmark_slice);
slicecount = 1;
% slice_nii = uint8(255 * mat2gray(slice_nii));
nrs = [4 5 7];
for i = 1:1:length(nrs)
    tempnr = nrs(i);
    x = landmarks(tempnr,1);
    y = landmarks(tempnr,2);
    slice_nii(x-5:x+5,y-5:y+5) = 2500;
end

Vertebra_body_points(slicecount, :) = [landmark_slice, landmarks(4,1:2)];
Spinal_canal_points(slicecount, :) = [landmark_slice, landmarks(7,1:2)];
Side_Vertebra_body_points(slicecount, :) = [landmark_slice, landmarks(5,1:2)];

nii(:,:,landmark_slice) = slice_nii;

[xnii,ynii,znii] = size(nii);
BW = getbaseimage2('Register_images\vertebra0-clr.png');
lm7 = landmarks(7,:);
lm4 = landmarks(4,:);
lm5 = landmarks(5,:);
nii2=nii;
rotation = 0;
dist_between_end = pdist([lm7(1:2);lm4(1:2)],'euclidean');

% for i = landmark_slice-slice_interval:-slice_interval:1
% 
%     slice_nii_temp = nii2(:,:,i);
%     slice_nii = uint8(255 * mat2gray(slice_nii_temp));
% 
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
%     if i == landmark_slice-slice_interval
%     else 
%        if rotationdiff > 8
%             rotation = (rotationprev+rotation)/2;
%        else
%        end
%     end
%     
%     [BW_rot, RotatedPoint1,RotatedPoint2,RotatedPoint3] = rotate_image(BW, rotation);
%     baseimage = BW_rot;
%     
%     [registeredimage, vertbod, spincan, sidevert] = image_registration(bin_image_parted, BW_rot, RotatedPoint1, RotatedPoint2, RotatedPoint3);
% 
%     vertbod = vertbod+[ymin,xmin];
%     spincan = spincan+[ymin,xmin];
%     sidevert = sidevert+[ymin,xmin];
% 
%     dist_vertbod = pdist([vertbod;lm4(1:2)],'euclidean');
%     dist_spincan = pdist([spincan;lm7(1:2)],'euclidean');
% 
%     dist_between = pdist([vertbod;spincan],'euclidean');
%     ratio_dist_between = dist_between/dist_between_end;
% 
%     
%     if ratio_dist_between > 1.30 || ratio_dist_between < 0.70 || dist_spincan > 25 || dist_vertbod > 25
%     if ratio_dist_between > 1.20 || dist_spincan > 20 || dist_vertbod > 20
%         fractions = [5 8 12 15 17 20 1];
%         counter = 1;
% 
%         disp(strcat('ratio ' , num2str(ratio_dist_between)));
%         disp(strcat('spincan ' , num2str(dist_spincan)));
%         disp(strcat('vertbod ' , num2str(dist_vertbod)));
% 
%         while counter < length(fractions+1)
%             [registeredimage, vertbod, spincan, sidevert] = image_registration1(bin_image_parted, baseimage, RotatedPoint1, RotatedPoint2, RotatedPoint3, fractions(counter));
%             vertbod = vertbod+[ymin,xmin];
%             spincan = spincan+[ymin,xmin];
%             sidevert = sidevert+[ymin,xmin];
% 
%             dist_vertbod = pdist([vertbod;lm4(1:2)],'euclidean');
%             dist_spincan = pdist([spincan;lm7(1:2)],'euclidean');
% 
%             dist_between = pdist([vertbod;spincan],'euclidean');
%             ratio_dist_between = dist_between/dist_between_end;
% 
%             disp(strcat('ratio ' , num2str(ratio_dist_between)));
%             disp(strcat('spincan ' , num2str(dist_spincan)));
%             disp(strcat('vertbod ' , num2str(dist_vertbod)));
% 
%             if ratio_dist_between < 1.30 && ratio_dist_between > 0.70 && dist_spincan < 25 && dist_vertbod < 25
%             if  ratio_dist_between < 1.20 && dist_spincan < 20 && dist_vertbod < 20
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
%             coord_sidevert = sidevert;
%             lm7 = spincan;
%             lm4 = vertbod;
%             lm5 = sidevert;
%            disp('taken retry new')
%         else
%             pts = readPoints(slice_nii, 3);
%             vertbod_temp = round(flip(transpose(pts(:,2))));
%             spincan_temp = round(flip(transpose(pts(:,1))));
%             sidevert_temp = round(flip(transpose(pts(:,3))));
%             coord_vertbod = vertbod_temp;
%             coord_spincan = spincan_temp;
%             coord_sidevert = sidevert_temp;
%             lm4 = vertbod_temp;
%             lm7 = spincan_temp;
%             lm5 = sidevert_temp;
% 
% 
%             coord_vertbod = lm4;
%             coord_spincan = lm7;
%             coord_sidevert = lm5;
%             lm4 = lm4(1:2);
%             lm7 = lm7(1:2);
%             lm5 = lm5(1:2);
%             disp('taken old')
%         end
%     else
%         coord_vertbod = vertbod;
%         coord_spincan = spincan;
%         coord_sidevert = sidevert;
%         lm7 = spincan;
%         lm4 = vertbod;
%         lm5 = sidevert;
%         disp('taken new')
%     end
% 
%     dist_between_end = pdist([coord_vertbod;coord_spincan],'euclidean');
%     
%     slice_nii_temp(coord_vertbod(1)-5:coord_vertbod(1)+5,coord_vertbod(2)-5:coord_vertbod(2)+5) = 2500;
%     slice_nii_temp(coord_spincan(1)-5:coord_spincan(1)+5,coord_spincan(2)-5:coord_spincan(2)+5) = 2500;
%     slice_nii_temp(coord_sidevert(1)-5:coord_sidevert(1)+5,coord_sidevert(2)-5:coord_sidevert(2)+5) = 2500;
% 
%     nii2(:,:,i) = slice_nii_temp;
%  
%     slicecount = slicecount+1;    
%     Vertebra_body_points(slicecount, :) = [i, coord_vertbod];
%     Spinal_canal_points(slicecount, :) = [i, coord_spincan];
%     Side_Vertebra_body_points(slicecount, :) = [i, coord_sidevert];
% end

lm7 = landmarks(7,:);
lm4 = landmarks(4,:);
lm5 = landmarks(5,:);
rotation = 0;
dist_between_end = pdist([lm7(1:2);lm4(1:2)],'euclidean');
for i = landmark_slice+slice_interval:slice_interval:znii*0.7

    disp(num2str(i));

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
    if i == landmark_slice+slice_interval
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
    if ratio_dist_between > 1.20 || dist_spincan > 20 || dist_vertbod > 20
        fractions = [5 8 12 15 17 20 1];
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
            if  ratio_dist_between < 1.20 && dist_spincan < 20 && dist_vertbod < 20
            %disp(num2str(fractions(counter)));
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
            pts = readPoints(slice_nii, 3);
            vertbod_temp = round(flip(transpose(pts(:,2))));
            spincan_temp = round(flip(transpose(pts(:,1))));
            sidevert_temp = round(flip(transpose(pts(:,3))));
            coord_vertbod = vertbod_temp;
            coord_spincan = spincan_temp;
            coord_sidevert = sidevert_temp;
            lm4 = vertbod_temp;
            lm7 = spincan_temp;
            lm5 = sidevert_temp;


%             coord_vertbod = lm4;
%             coord_spincan = lm7;
%             coord_sidevert = lm5;
%             lm4 = lm4(1:2);
%             lm7 = lm7(1:2);
%             lm5 = lm5(1:2);
%             disp('taken old')
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
% 
%     figure()
%     imshow(slice_nii_temp);
 
    slicecount = slicecount+1;    
    Vertebra_body_points(slicecount, :) = [i, coord_vertbod];
    Spinal_canal_points(slicecount, :) = [i, coord_spincan];
    Side_Vertebra_body_points(slicecount, :) = [i, coord_sidevert];

   
end

% [~,idx] = sort(Vertebra_body_points(:,1));
% Vertebra_body_points = Vertebra_body_points(idx,:);
% [~,idx] = sort(Spinal_canal_points(:,1));
% Spinal_canal_points = Spinal_canal_points(idx,:);
% [~,idx] = sort(Side_Vertebra_body_points(:,1));
% Side_Vertebra_body_points = Side_Vertebra_body_points(idx,:);

end