clear all 
close all

%%define paths PC
pathimage = 'Scoliose\';
pathlandm = 'Landmarks\';

%%define paths laptop
addpath("Geometric_points\");
addpath("Get_vertebra_points\");
addpath("Sternum\");
addpath("Parameters\");

%%Define patient number
patient_number = 4;

%% PRE-OP-------------------------------------------------------------------------------------
nameimage = strcat(num2str(patient_number),'preop.nii');
namelandm = strcat(num2str(patient_number),'preop.xml');
s_pre = strcat(pathimage,nameimage);
s2_pre = strcat(pathlandm,namelandm);

%%read in .nii_pre and landmarks file
nii_pre = niftiread(s_pre);
landmarks_struct_pre = xml2struct(s2_pre);

%%extract landmarks
landmarks_pre = getlandmarks(landmarks_struct_pre);
landmarks_pre = round(landmarks_pre);

%%Get manual landmark slice
landmark_slice = landmarks_pre(1,3);
slice_interval = 10;

%%Vertebra landmarks
[nii_pre2, Vertebra_body_points, Spinal_canal_points, Side_Vertebra_body_points] = getlandmarkcoordinates(nii_pre, landmark_slice, landmarks_pre, slice_interval);

%%Sternum landmark
sternum = sternum_function(landmarks_pre,nii_pre, landmark_slice, slice_interval);

%%Geometrical landmark
[upper, lower, leftback, rightback] = getgeolandmarks(nii_pre, slice_interval, landmark_slice);

%%Cut matrices to same slices
[upper, lower, leftback, rightback, sternum, Vertebra_body_points, Spinal_canal_points, Side_Vertebra_body_points] = cutmatrices(upper, lower, leftback, rightback, sternum, Vertebra_body_points, Spinal_canal_points, Side_Vertebra_body_points);

%%Calculate parameters for all slices and store in matrix
parameters_total_pre = getparam(upper, lower, leftback, rightback, sternum, Vertebra_body_points, Spinal_canal_points, Side_Vertebra_body_points);

%% POST-OP-------------------------------------------------------------------------------------
nameimage = strcat(num2str(patient_number),'postop.nii');
namelandm = strcat(num2str(patient_number),'postop.xml');
s_post = strcat(pathimage,nameimage);
s2_post = strcat(pathlandm,namelandm);

%%read in .nii_pre and landmarks file
nii_post = niftiread(s_post);
nii_post_proc = process_postop(nii_post); 
landmarks_struct_post = xml2struct(s2_post);

%%extract landmarks
landmarks_post = getlandmarks(landmarks_struct_post);
landmarks_post = round(landmarks_post);

%%Get manual landmark slice
landmark_slice = landmarks_post(1,3);
slice_interval = 10;

%%Vertebra landmarks
[nii_post2, Vertebra_body_points, Spinal_canal_points, Side_Vertebra_body_points] = getlandmarkcoordinates(nii_post_proc, landmark_slice, landmarks_post, slice_interval);

%%Sternum landmark
sternum = sternum_function(landmarks_post,nii_post_proc, landmark_slice, slice_interval);

%%Geometrical landmark
[upper, lower, leftback, rightback] = getgeolandmarks(nii_post_proc, slice_interval, landmark_slice);

%%Cut matrices to same slices
[upper, lower, leftback, rightback, sternum, Vertebra_body_points, Spinal_canal_points, Side_Vertebra_body_points] = cutmatrices(upper, lower, leftback, rightback, sternum, Vertebra_body_points, Spinal_canal_points, Side_Vertebra_body_points);

%%Calculate parameters for all slices and store in matrix
parameters_total = getparam(upper, lower, leftback, rightback, sternum, Vertebra_body_points, Spinal_canal_points, Side_Vertebra_body_points);








