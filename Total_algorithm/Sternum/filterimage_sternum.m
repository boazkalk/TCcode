function filtered = filterimage(slice)
binary = slice>120;
se2 = strel("disk", 1); 
open= imopen(binary, se2);
se2 = strel("disk", 5); 
temp = imclose(open, se2);
se2 = strel("disk", 2); 
temp= imopen(temp, se2);
filtered = temp;

end