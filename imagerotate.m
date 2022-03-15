clear all
close all

temp = getbaseimage('vertebra0-clr.png');
tempbw = makebin(temp);

imshow(tempbw);

alpha = 360-180;
vert_rot = imrotate(tempbw,alpha);

imshow(vert_rot);

imwrite(vert_rot, 'vertebra-180.png');

function image = makebin(x)
    image = x;
    for i = 1:1:height(x)
        for j = 1:1:width(x)
            if x(i,j) > 0
                image(i,j) = 255;
            else
            end
        end
    end
end

function baseimage = getbaseimage(name)
I = imread(name);
vertebra1 = I(:,:,1);
BW = imbinarize(vertebra1);
BW = imcomplement(BW);
baseimage = im2uint8(BW);
end