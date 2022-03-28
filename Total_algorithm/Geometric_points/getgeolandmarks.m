function [upper, lower, leftback, rightback] = getgeolandmarks(nii, slice_interval, landmark_slice)

[~,~,znii] = size(nii);
j=1;

for i = landmark_slice:slice_interval:znii*0.8
    
    image_slice = nii(:,:,i);
    [upper1, lower1, leftback1, rightback1] = segmentation_landmarks(image_slice);

    if isequal(upper1, [1,-1]) || isequal(lower1, [1,-1]) || isequal(leftback1, [1,-1]) || isequal(rightback1, [1,-1])
        break
    else
    
    upper(j,:) = [i,upper1];
    lower(j,:) = [i,lower1];
    leftback(j,:) = [i,leftback1];
    rightback(j,:) = [i,rightback1];
    j=j+1;
    end

end

for i = landmark_slice-slice_interval:-slice_interval:1
    
    image_slice = nii(:,:,i);
    [upper1, lower1, leftback1, rightback1] = segmentation_landmarks(image_slice);

    if isequal(upper1, [1,-1]) || isequal(lower1, [1,-1]) || isequal(leftback1, [1,-1]) || isequal(rightback1, [1,-1])
        break
    else

    upper(j,:) = [i,upper1];
    lower(j,:) = [i,lower1];
    leftback(j,:) = [i,leftback1];
    rightback(j,:) = [i,rightback1];
    j=j+1;

    end

end

[~,idx] = sort(upper(:,1));
upper = upper(idx,:);
[~,idx] = sort(lower(:,1));
lower = lower(idx,:);
[~,idx] = sort(leftback(:,1));
leftback = leftback(idx,:);
[~,idx] = sort(rightback(:,1));
rightback = rightback(idx,:);

end