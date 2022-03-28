function landmark_list =  sternum_function(landmarks,image, landmark_slice, slice_interval)

lm2 = landmarks(2,:);
slice_nii = image(:,:,landmark_slice);

x = landmarks(2,1);
y = landmarks(2,2);

[xnii, ynii, znii] = size(image);

%make array of slices that are used
sn = [];
for i =landmark_slice:-slice_interval:1
    sn = [i,sn];
end

for i=landmark_slice+slice_interval:slice_interval:znii
    sn = [sn,i];
end
%%
size_sn = size(sn);
middle_slice_index = round(size_sn(2)*0.5);
middle_slice = sn(middle_slice_index);
upper_slice_index = round(size_sn(2)*0.66);
upper_slice = sn(upper_slice_index);
lower_slice_index = round(size_sn(2)*0.33);
lower_slice = sn(lower_slice_index);

%%

landmark_list = [];
%for the lower slices we use the same lm as the given one
for i= lower_slice-slice_interval:-slice_interval:1
    %disp(i)
    %addto lm list
    landmark_list = [i,landmarks(2,1),landmarks(2,2);landmark_list];
end
%%disp(landmark_list)
%for the middle slices we use the sternum in the image
landmark_list1 = [];
for i = middle_slice:-slice_interval:lower_slice
    %%disp(i)
    slice_nii_temp = image(:,:,i);
    slice_nii = uint8(255 * mat2gray(slice_nii_temp));
    filtered_nii = filterimage(slice_nii);
    %figure();
    %imshow(filtered_nii)
    bin_image = makebin(filtered_nii);
   
    xmid = lm2(2);
    ymid = lm2(1);
    if xmid < 76
        xmin = 1;
    else
        xmin = xmid-75;
    end
    if ymid < 76
        ymin = 1;
    else
        ymin = ymid-75;
    end
    if xmid > 437
       xmax = 512;
    else 
       xmax = xmid +75;
    end
    if ymid > 437
       ymax = 512;
    else
        ymax = ymid + 75;
    end 
    
    bin_image_parted = bin_image(ymin:ymax,xmin:xmax);
    sternum= get_sternum_landmark(bin_image_parted);

    sternum = sternum+[ymin,xmin];
    x = sternum(1);
    y = sternum(2);

    landmark_list1 = [i,x,y;landmark_list1];
    lm2 = sternum;

end
%disp(landmark_list1)
landmark_list = [landmark_list;landmark_list1];

landmark_list2 = [];
for i = middle_slice+slice_interval:slice_interval:upper_slice
    %disp(i)
    slice_nii_temp = image(:,:,i);
    slice_nii = uint8(255 * mat2gray(slice_nii_temp));
    filtered_nii = filterimage(slice_nii);
    bin_image = makebin(filtered_nii);
   
    xmid = lm2(2);
    ymid = lm2(1);
    if xmid < 76
        xmin = 1;
    else
        xmin = xmid-75;
    end
    if ymid < 76
        ymin = 1;
    else
        ymin = ymid-75;
    end
    if xmid > 437
       xmax = 512;
    else 
       xmax = xmid +75;
    end
    if ymid > 437
       ymax = 512;
    else
        ymax = ymid + 75;
    end 
    
    bin_image_parted = bin_image(ymin:ymax,xmin:xmax);
    sternum= get_sternum_landmark(bin_image_parted);

    sternum = sternum+[ymin,xmin];
    x = sternum(1);
    y = sternum(2);

    landmark_list2 = [landmark_list2;i,x,y];
    lm2 = sternum;
end
%disp(landmark_list2)
landmark_list = [landmark_list;landmark_list2];

ax = landmark_list(upper_slice_index,2)- landmark_list(lower_slice_index,2);
ay = landmark_list(upper_slice_index,3)- landmark_list(lower_slice_index,3);
n = upper_slice_index-lower_slice_index;

%for the upper slices we fit a line
for i= upper_slice+slice_interval:slice_interval:znii
    lm2(1) = round(lm2(1)+ax/n);
    lm2(2) = round(lm2(2)+ay/n);
    %addto lm list
    landmark_list = [landmark_list;i,lm2(1),lm2(2)];
end



end