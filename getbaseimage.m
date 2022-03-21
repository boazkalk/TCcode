function baseimage = getbaseimage(name)
I = imread(name);
baseimage = im2uint8(I);
end