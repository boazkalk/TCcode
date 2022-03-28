function filtered_nii = filterimage(image)
nii_filtered = [];
for i = 1:1:height(image)
    for j = 1:1:width(image)        
        if image(i,j) > 120
            nii_filtered(i,j) = image(i,j);
        else
            nii_filtered(i,j) = 0;
        end
    end
end

%% open-close
% figure()
% subplot(1,3,1)
% imshow(nii_filtered)
se2 = strel("disk", 2); 
open = imopen(nii_filtered, se2);
% subplot(1,3,2)
% imshow(open)
se2 = strel("disk", 5); 
temp = imclose(open, se2);
% subplot(1,3,3)
% imshow(temp)
filtered_nii = temp;

% %% close-open
% figure()
% subplot(1,3,1)
% imshow(nii_filtered)
% se2 = strel("disk", 2); 
% close = imclose(nii_filtered, se2);
% subplot(1,3,2)
% imshow(close)
% se2 = strel("disk", 3); 
% temp = imopen(close, se2);
% subplot(1,3,3)
% imshow(temp)
% filtered_nii = temp;
end