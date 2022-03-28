clear all 
close all

pathimage = 'C:\Users\boazk\Desktop\team challenge\Algo\Team challenge 2021\Scoliose\';
pathlandm = 'C:\Users\boazk\Desktop\team challenge\Algo\Team challenge 2021\Landmarks\';

nameimage = '2preop.nii';
namelandm = '2preop.xml';
s = strcat(pathimage,nameimage);
s2 = strcat(pathlandm,namelandm);

%%read in .nii and landmarks file
nii = niftiread(s);
landmarks_struct = xml2struct(s2);

%%extract landmarks
landmarks = getlandmarks(landmarks_struct);
landmarks = round(landmarks);
landmark_slice = landmarks(1,3);
slice_interval = 5;

landmark_list =  sternum_function(landmarks,nii, landmark_slice, slice_interval);
size = size(landmark_list);
b = landmark_list(size(1),1);
a = landmark_list(1,1);
%%
nii1=nii;
j = 1;
for i = a:10:b
    slice = nii(:,:,i);
    slice = uint8(255 * mat2gray(slice));
    lm = [landmark_list(j,2),landmark_list(j,3)];
    slice = place_lm(lm,slice);
    nii1(:,:,i) = slice;
    j = j+1;
end

volumeViewer(nii1)


















% %%visualize landmarks
% landmark_slice = landmarks(1,3);
% lm2 = landmarks(2,:);
% slice_nii = nii(:,:,landmark_slice);
% 
% % slice_nii = uint8(255 * mat2gray(slice_nii));
% x = landmarks(2,1);
% y = landmarks(2,2);
% slice_nii(x-5:x+5,y-5:y+5) = 2500;
% 
% %imshow(slice_nii);
% nii1 = nii;
% [xnii, ynii, znii] = size(nii);
% 
% %make array of slices that are used
% sn = [];
% for i =landmark_slice:-10:1
%     sn = [i,sn];
% end
% 
% for i=landmark_slice+10:10:znii
%     sn = [sn,i];
% end
% %%
% size_sn = size(sn);
% middle_slice_index = round(size_sn(2)*0.5);
% middle_slice = sn(middle_slice_index);
% upper_slice_index = round(size_sn(2)*0.66);
% upper_slice = sn(upper_slice_index);
% lower_slice_index = round(size_sn(2)*0.33);
% lower_slice = sn(lower_slice_index);
% 
% %%
% 
% landmark_list = [];
% for i= lower_slice-10:-10:1
%     disp(i);
%     %for visualization
%     slice_nii_temp = nii1(:,:,i);
%     slice_nii = uint8(255 * mat2gray(slice_nii_temp));
%     slice_nii = place_lm([x,y],slice_nii);
%     nii1(:,:,i) = slice_nii;
%     %addto lm list
%     landmark_list = [i,landmarks(2,1),landmarks(2,2);landmark_list];
% end
% 
% for i = lower_slice:10:upper_slice
%     
%     slice_nii_temp = nii1(:,:,i);
%     slice_nii = uint8(255 * mat2gray(slice_nii_temp));
%     filtered_nii = filterimage(slice_nii);
%     bin_image = makebin(filtered_nii);
%     figure();
%     imshow(bin_image);
% 
%    
%     xmid = lm2(2);
%     ymid = lm2(1);
%     if xmid < 76
%         xmin = 1;
%     else
%         xmin = xmid-75;
%     end
%     if ymid < 76
%         ymin = 1;
%     else
%         ymin = ymid-75;
%     end
%     if xmid > 437
%        xmax = 512;
%     else 
%        xmax = xmid +75;
%     end
%     if ymid > 437
%        ymax = 512;
%     else
%         ymax = ymid + 75;
%     end 
%     
%     bin_image_parted = bin_image(ymin:ymax,xmin:xmax);
%     figure();
%     imshow(bin_image_parted);
%     sternum= get_landmark(bin_image_parted);
% 
% 
%     sternum = sternum+[ymin,xmin];
%     %visualization
%     x = sternum(1);
%     y = sternum(2);
% %     if (x>=507)
% %         slice_nii_temp(x-5:512,y-5:y+5) = 2500;
% %     elseif (x<=5)
% %         slice_nii_temp(1:x+5,y-5:y+5) = 2500;
% %     elseif (y>=507)
% %         slice_nii_temp(x-5:x+5,y-5:512) = 2500;
% %     elseif (y<=5)
% %         slice_nii_temp(x-5:x+5,1:y+5) = 2500;
% %     else 
% %         slice_nii_temp(x-5:x+5,y-5:y+5) = 2500;
% %     end
%    
%     slice_nii = place_lm(sternum,slice_nii);
%     landmark_list = [landmark_list;i,sternum(1),sternum(2)];
% 
%     nii1(:,:,i) = slice_nii;
%     lm2 = sternum;
% 
% end
% 
% ax = landmark_list(upper_slice_index,2)- landmark_list(lower_slice_index,2);
% ay = landmark_list(upper_slice_index,3)- landmark_list(lower_slice_index,3);
% n = upper_slice_index-lower_slice_index;
% 
% for i= upper_slice+10:10:znii
%     disp(i);
%     %for visualization
%     slice_nii_temp = nii1(:,:,i);
%     slice_nii = uint8(255 * mat2gray(slice_nii_temp));
%     lm2(1) = round(lm2(1)+ax/n);
%     lm2(2) = round(lm2(2)+ay/n);
%     slice_nii = place_lm(lm2,slice_nii);
%     nii1(:,:,i) = slice_nii;
%     %addto lm list
%     landmark_list = [landmark_list;i,lm2(1),lm2(2)];
% end
% %%
% volumeViewer(nii1)
% 
% 
% function filtered = filterimage(slice)
% binary = slice>120;
% se2 = strel("disk", 1); 
% open= imopen(binary, se2);
% se2 = strel("disk", 5); 
% temp = imclose(open, se2);
% se2 = strel("disk", 2); 
% temp= imopen(temp, se2);
% filtered = temp;
% end
% 
% function lm = get_landmark(slice)
% largest = bwareafilt(slice,1);
% figure();
% imshow(largest);
% [rows, columns] = find(largest);
% maxr = max(rows);
% minr = min(rows);
% middle = round((maxr+minr)/2);
% m = find(rows == middle,1);
% n = columns(m);
% 
% lm = [middle,n];
% end
% 
% function image = makebin(x)
%     image = x;
%     for i = 1:1:height(x)
%         for j = 1:1:width(x)
%             if x(i,j) > 0
%                 image(i,j) = 255;
%             else
%             end
%         end
%     end
% end
% 
function slice2 = place_lm(lm,slice)
x = lm(1);
y = lm(2);
slice2 = slice;

    if (x>=507)
        slice2(x-5:512,y-5:y+5) = 255;
    elseif (x<=5)
        slice2(1:x+5,y-5:y+5) = 255;
    elseif (y>=507)
        slice2(x-5:x+5,y-5:512) = 255;
    elseif (y<=5)
        slice2(x-5:x+5,1:y+5) = 255;
    else 
        slice2(x-5:x+5,y-5:y+5) = 255;
    end
figure()
imshow(slice2)
end