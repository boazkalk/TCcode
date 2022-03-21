%%
% [xnii,ynii,znii] = size(nii);
% lm7 = landmarks(7,:);
% lm4 = landmarks(4,:);
% rotation = 0;
% nii1 = nii;
% dist_between_end = pdist([lm7(1:2);lm4(1:2)],'euclidean');
% 
% % for i = landmark_slice-10:-10:1
% % 
% %     slice_nii_temp = nii1(:,:,i);
% %     slice_nii = uint8(255 * mat2gray(slice_nii_temp));
% %     landmark_slice_nii = slice_nii;
% % 
% %     filtered_nii = filterimage(slice_nii);
% % 
% %     bin_image = makebin(filtered_nii);
% %     
% %     [bin_image_parted, xmin, ymin, xmax, ymax] = squareimage(bin_image, lm4, lm7);    
% % 
% %     %%calculate angle that initial landmarks make and pre-rotate standard image
% %     %%for better initial guess
% %     [baseimage, RotatedPoint1, RotatedPoint2, rotation] = rot_image_guess(rotation, lm4, lm7, i, angles, standard_points, landmark_slice, -10);
% %     
% %     %rot point 1 = vert bod, rot point 2 = spin can
% %     [registeredimage, vertbod, spincan] = image_registration(bin_image_parted, baseimage, RotatedPoint1, RotatedPoint2);
% % 
% %     vertbod = vertbod+[ymin,xmin];
% %     spincan = spincan+[ymin,xmin];
% % 
% %     dist_vertbod = pdist([vertbod;lm4(1:2)],'euclidean');
% %     dist_spincan = pdist([spincan;lm7(1:2)],'euclidean');
% % 
% %     dist_between = pdist([vertbod;spincan],'euclidean');
% %     ratio_dist_between = dist_between/dist_between_end;
% % 
% %     
% %     if ratio_dist_between > 1.3 || ratio_dist_between < 0.7 || dist_spincan > 25 || dist_vertbod > 25
% %         fractions = [5 8 11 12 13 14 15 16 17 18 19 20];
% %         counter = 1;
% %         while counter < length(fractions+1)
% %             [registeredimage, vertbod, spincan] = image_registration1(bin_image_parted, baseimage, RotatedPoint1, RotatedPoint2, fractions(counter));
% %             vertbod = vertbod+[ymin,xmin];
% %             spincan = spincan+[ymin,xmin];
% % 
% %             dist_vertbod = pdist([vertbod;lm4(1:2)],'euclidean');
% %             dist_spincan = pdist([spincan;lm7(1:2)],'euclidean');
% % 
% %             dist_between = pdist([vertbod;spincan],'euclidean');
% %             ratio_dist_between = dist_between/dist_between_end;
% % 
% %             if ratio_dist_between < 1.3 && ratio_dist_between > 0.7 && dist_spincan < 25 && dist_vertbod < 25
% %             counter = 100;
% %             else 
% %             counter = counter+1;
% %             end
% %         end
% % 
% %         if counter == 100
% %             coord_vertbod = vertbod;
% %             coord_spincan = spincan;
% %             lm7 = spincan;
% %             lm4 = vertbod;
% %             disp('taken retry new')
% %         else
% %             coord_vertbod = lm4;
% %             coord_spincan = lm7;
% %             lm4 = lm4(1:2);
% %             lm7 = lm7(1:2);
% %             disp('taken old')
% %         end
% %     else
% %         coord_vertbod = vertbod;
% %         coord_spincan = spincan;
% %         lm7 = spincan;
% %         lm4 = vertbod;
% %         disp('taken new')
% %     end
% % 
% %     dist_between_end = pdist([coord_vertbod;coord_spincan],'euclidean');
% %     
% %     slice_nii_temp(coord_vertbod(1)-5:coord_vertbod(1)+5,coord_vertbod(2)-5:coord_vertbod(2)+5) = 2500;
% %     slice_nii_temp(coord_spincan(1)-5:coord_spincan(1)+5,coord_spincan(2)-5:coord_spincan(2)+5) = 2500;
% % 
% %     nii1(:,:,i) = slice_nii_temp;
% %  
% % end
% 
% lm7 = landmarks(7,:);
% lm4 = landmarks(4,:);
% rotation = 0;
% dist_between_end = pdist([lm7(1:2);lm4(1:2)],'euclidean');
% v=1;
% 
% for i = landmark_slice+5:5:landmark_slice+80
% 
%     slice_nii_temp = nii1(:,:,i);
%     slice_nii = uint8(255 * mat2gray(slice_nii_temp));
%     landmark_slice_nii = slice_nii;
% 
%     filtered_nii = filterimage(slice_nii);
% 
%     bin_image = makebin(filtered_nii);
%     
%     [bin_image_parted, xmin, ymin, xmax, ymax] = squareimage(bin_image, lm4, lm7);    
% 
%     %%calculate angle that initial landmarks make and pre-rotate standard image
%     %%for better initial guess
%     [baseimage, RotatedPoint1, RotatedPoint2, rotation(v),angle_approx_array(v)] = rot_image_guess(rotation, lm4, lm7, i, angles, standard_points, landmark_slice, 5);
%     
%     %rot point 1 = vert bod, rot point 2 = spin can
%     [registeredimage, vertbod, spincan] = image_registration(bin_image_parted, baseimage, RotatedPoint1, RotatedPoint2);
% 
%     vertbod = vertbod+[ymin,xmin];
%     spincan = spincan+[ymin,xmin];
% 
%     dist_vertbod = pdist([vertbod;lm4(1:2)],'euclidean');
%     dist_spincan = pdist([spincan;lm7(1:2)],'euclidean');
% 
%     dist_between = pdist([vertbod;spincan],'euclidean');
%     ratio_dist_between = dist_between/dist_between_end;
% 
%     
%     if ratio_dist_between > 1.15 || ratio_dist_between < 0.85 || dist_spincan > 25 || dist_vertbod > 25
%         fractions = [5 8 11 12 13 14 15 16 17 18 19 20];
%         counter = 1;
% 
% %         disp(strcat('ratio ' , num2str(ratio_dist_between)));
% %         disp(strcat('spincan ' , num2str(dist_spincan)));
% %         disp(strcat('vertbod ' , num2str(dist_vertbod)));
% 
%         while counter < length(fractions+1)
%             [registeredimage, vertbod, spincan] = image_registration1(bin_image_parted, baseimage, RotatedPoint1, RotatedPoint2, fractions(counter));
%             vertbod = vertbod+[ymin,xmin];
%             spincan = spincan+[ymin,xmin];
% 
%             dist_vertbod = pdist([vertbod;lm4(1:2)],'euclidean');
%             dist_spincan = pdist([spincan;lm7(1:2)],'euclidean');
% 
%             dist_between = pdist([vertbod;spincan],'euclidean');
%             ratio_dist_between = dist_between/dist_between_end;
% 
% %             disp(strcat('ratio ' , num2str(ratio_dist_between)));
% %             disp(strcat('spincan ' , num2str(dist_spincan)));
% %             disp(strcat('vertbod ' , num2str(dist_vertbod)));
% 
%             if ratio_dist_between < 1.15 && ratio_dist_between > 0.85 && dist_spincan < 25 && dist_vertbod < 25
%             disp(num2str(fractions(counter)));
%             counter = 100;
%             else 
%             counter = counter+1;
%             end
%         end
% 
%         if counter == 100
%             coord_vertbod = vertbod;
%             coord_spincan = spincan;
%             lm7 = spincan;
%             lm4 = vertbod;
%             disp('taken retry new')
%         else
%             coord_vertbod = lm4;
%             coord_spincan = lm7;
%             lm4 = lm4(1:2);
%             lm7 = lm7(1:2);
%             disp('taken old')
%         end
%     else
%         coord_vertbod = vertbod;
%         coord_spincan = spincan;
%         lm7 = spincan;
%         lm4 = vertbod;
%         disp('taken new')
%     end
% 
%     dist_between_end = pdist([coord_vertbod;coord_spincan],'euclidean');
%     
%     slice_nii_temp(coord_vertbod(1)-5:coord_vertbod(1)+5,coord_vertbod(2)-5:coord_vertbod(2)+5) = 2500;
%     slice_nii_temp(coord_spincan(1)-5:coord_spincan(1)+5,coord_spincan(2)-5:coord_spincan(2)+5) = 2500;
% 
%     nii1(:,:,i) = slice_nii_temp;
%     v = v+1;
%  
% end
% 
% figure()
% plot(angle_approx_array);
% volumeViewer(nii1)

% % %%INITIAL WORKING WITH SINGLE MOVING IMAGE AND ROTATION
% [xnii,ynii,znii] = size(nii);
% BW = getbaseimage2('Register_images\vertebra0-clr.png');
% lm7 = landmarks(7,:);
% lm4 = landmarks(4,:);
% nii2=nii;
% rotation = 0;
% 
% for i = landmark_slice-10:-10:1
% 
%     slice_nii_temp = nii2(:,:,i);
%     slice_nii = uint8(255 * mat2gray(slice_nii_temp));
%     landmark_slice_nii = slice_nii;
% 
%     filtered_nii = filterimage(slice_nii);
% 
%     bin_image = makebin(filtered_nii);
%     
%     xmid = round((min(lm4(2), lm7(2))+max(lm4(2), lm7(2)))/2);
%     ymid = round((min(lm4(1), lm7(1))+max(lm4(1), lm7(1)))/2);
%     if xmid < 151
%         xmin = 1;
%     else
%         xmin = xmid-150;
%     end
%     if ymid < 151
%         ymin = 1;
%     else
%         ymin = ymid-150;
%     end
%     xmax = xmid+150;
%     ymax = ymid+150;
%     
%     bin_image_parted = bin_image(ymin:ymax,xmin:xmax);
% 
%     %%calculate angle that initial landmarks make and pre-rotate standard image
%     %%for better initial guess
%     
%     rotationprev = rotation;
%     rotation = getinitrotation(lm4, lm7);
%     rotationdiff = abs(rotationprev-rotation);
%     if i == landmark_slice-10
%     else 
%        if rotationdiff > 8
%             rotation = rotationprev;
%        else
%        end
%     end
%     
%     [BW_rot, RotatedPoint1,RotatedPoint2] = rotate_image(BW, rotation);
%     
%     [registeredimage, vertbod, spincan] = image_registration(bin_image_parted, BW_rot, RotatedPoint1, RotatedPoint2);
% 
%     vertbod = vertbod+[ymin,xmin];
%     spincan = spincan+[ymin,xmin];
%     
%     slice_nii_temp(vertbod(1)-5:vertbod(1)+5,vertbod(2)-5:vertbod(2)+5) = 2500;
%     slice_nii_temp(spincan(1)-5:spincan(1)+5,spincan(2)-5:spincan(2)+5) = 2500;
% 
%     nii2(:,:,i) = slice_nii_temp;
% 
%     lm7 = spincan;
%     lm4 = vertbod;
% 
% end
% 
% lm7 = landmarks(7,:);
% lm4 = landmarks(4,:);
% rotation = 0;
% 
% for i = landmark_slice+10:10:znii
% 
%     slice_nii_temp = nii2(:,:,i);
%     slice_nii = uint8(255 * mat2gray(slice_nii_temp));
%     landmark_slice_nii = slice_nii;
% 
%     filtered_nii = filterimage(slice_nii);
% 
%     bin_image = makebin(filtered_nii);
%     
%     xmid = round((min(lm4(2), lm7(2))+max(lm4(2), lm7(2)))/2);
%     ymid = round((min(lm4(1), lm7(1))+max(lm4(1), lm7(1)))/2);
%     if xmid < 151
%         xmin = 1;
%     else
%         xmin = xmid-150;
%     end
%     if ymid < 151
%         ymin = 1;
%     else
%         ymin = ymid-150;
%     end
%     xmax = xmid+150;
%     ymax = ymid+150;
%     
%     bin_image_parted = bin_image(ymin:ymax,xmin:xmax);
% 
%     %%calculate angle that initial landmarks make and pre-rotate standard image
%     %%for better initial guess
%     
%     rotationprev = rotation;
%     rotation = getinitrotation(lm4, lm7);
%     rotationdiff = abs(rotationprev-rotation);
%     if i == landmark_slice+10
%     else 
%        if rotationdiff > 8
%             rotation = rotationprev;
%        else
%        end
%     end
%     
%     [BW_rot, RotatedPoint1,RotatedPoint2] = rotate_image(BW, rotation);
%     
%     [registeredimage, vertbod, spincan] = image_registration(bin_image_parted, BW_rot, RotatedPoint1, RotatedPoint2);
% 
%     vertbod = vertbod+[ymin,xmin];
%     spincan = spincan+[ymin,xmin];
%     
%     slice_nii_temp(vertbod(1)-5:vertbod(1)+5,vertbod(2)-5:vertbod(2)+5) = 2500;
%     slice_nii_temp(spincan(1)-5:spincan(1)+5,spincan(2)-5:spincan(2)+5) = 2500;
% 
%     nii2(:,:,i) = slice_nii_temp;
% 
%     lm7 = spincan;
%     lm4 = vertbod;
% 
% end