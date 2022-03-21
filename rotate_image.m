function [BW_rot, RotatedPoint1,RotatedPoint2,RotatedPoint3] = rotate_image(BW, alpha)
landmarks_standard = [93,93,130;5,117,18];
BW_rot = imrotate(BW,alpha);
ImCenterA = (size(BW)/2)'; 
ImCenterB = (size(BW_rot)/2)';
P1 = landmarks_standard(:,1);
P2 = landmarks_standard(:,2);
P3 = landmarks_standard(:,3);
RotMatrix = [cosd(-alpha) -sind(-alpha); sind(-alpha) cosd(-alpha)]; 
RotatedPoint1 = RotMatrix*(P1-ImCenterA)+ImCenterB;
RotatedPoint2 = RotMatrix*(P2-ImCenterA)+ImCenterB;
RotatedPoint3 = RotMatrix*(P3-ImCenterA)+ImCenterB;
end