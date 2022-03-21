function baseimage = getbaseimage2(name)
I = imread(name);
vertebra1 = I(:,:,1);
BW = imbinarize(vertebra1);
BW = imcomplement(BW);
baseimage = im2uint8(BW);
end
