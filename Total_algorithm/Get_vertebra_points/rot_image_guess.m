function [baseimage, RotatedPoint1, RotatedPoint2, rotation,angle_approx_array] = rot_image_guess(rotation, lm4, lm7, i, angles, standard_points, landmark_slice, plusmin)
% rotationprev = rotation;
rotation = getinitrotation(lm4, lm7);
% rotationdiff = abs(rotationprev-rotation);
% if i == landmark_slice+plusmin
% else 
%    if rotationdiff > 5
%         rotation = (rotationprev+rotation)/2;
%    else
%    end
% end

angle = 360-rotation;
for n = 1:1:length(angles)
    diff(n) = abs(angles(n)-angle);
end
[~,index] = min(diff);
angle_approx = angles(index);
angle_approx_array = angle_approx;
baseimagename = strcat('Register_images\vertebra-', num2str(angle_approx), '.png');
baseimage = getbaseimage(baseimagename);
baseimage = im2uint8(baseimage);

RotatedPoint1 = standard_points(1:2,index);
RotatedPoint2 = standard_points(3:4,index);
end