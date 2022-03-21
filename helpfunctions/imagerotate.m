clear all
close all

temp = getbaseimage('vertebra0-clr.png');
tempbw = makebin(temp);

imshow(tempbw);

for i = 1:5:181

angle = i-1;

alpha = 360-angle;
vert_rot = imrotate(tempbw,alpha);

imshow(vert_rot);

name = strcat('vertebra-', num2str(angle), '.png');

imwrite(vert_rot, name);

end

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