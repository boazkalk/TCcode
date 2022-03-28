function [upper1, lower1, leftback1, rightback1] = segmentation_landmarks(image_slice)

%number of slices
[r,c,s] = size(image_slice);

%create mask
mask = get_mask(image_slice)

%rotate because of function convenience
rotated = imrotate(mask,90);

%find desired points

[rows,columns] = find(rotated);
mincolumn = min(columns);
maxcolumn = max(columns);
%find the index of each point of interest
k = find(columns == mincolumn, 1);
l = find(columns == maxcolumn, 1);
upper = [rows(k),mincolumn];
lower = [rows(l),maxcolumn];

m  = round ((mincolumn+maxcolumn)/2);

imageup = rotated(:,mincolumn:m);
imagedown = rotated (:,m+1:maxcolumn);

[rowsup,columnsup] = find(imageup);
[rowsdown,columnsdown] = find(imagedown);

maxrow1 = max(rowsup);
maxrow2 = max(rowsdown) ;
i = find(rows == maxrow1, 1);
j = find(rowsdown == maxrow2 , 1);
    
leftmost2 = [maxrow2,columns(j)+m];
leftmost = [maxrow1,columns(i)];
  

minrow1 = min(rowsup);
minrow2 = min(rowsdown) ;
ii = find(rows == minrow1, 1);
jj = find(rowsdown == minrow2 , 1);
    
rightmost2 = [minrow2,columns(jj)+m];
rightmost = [minrow1,columns(ii)];

if isempty(upper) == 1 || isempty(lower) == 1 || isempty(leftmost) == 1 || isempty(leftmost2) == 1
    upper1 = [1,-1];
    lower1 = [1,-1];
    leftback1 = [1,-1];
    rightback1 = [1,-1];
else

%Because the image was rotated we need new coordinates
upper1 = [upper(2), r-upper(1)];
lower1 = [lower(2), r-lower(1)];
leftback1 = [leftmost(2), r-leftmost(1)];
rightback1 = [leftmost2(2), r-leftmost2(1)];
% rightmost1 = [rightmost(2), r-rightmost(1)];
% rightmost21 = [rightmost2(2), r-rightmost2(1)];

%new_landmarks = [upper1;lower1;leftmost1;leftmost21;rightmost1;rightmost21];
% new_landmarks = [upper1;lower1;leftmost1;leftmost21];
end


end