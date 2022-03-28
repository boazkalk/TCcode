function lm = get_sternum_landmark(slice)
slice = logical(slice);
largest = bwareafilt(slice,1);

[rows, columns] = find(largest);
maxr = max(rows);
minr = min(rows);
middle = round((maxr+minr)/2);
m = find(rows == middle,1);
n = columns(m);

lm = [middle,n];
end