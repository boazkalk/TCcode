clear all 
close all

%%define paths PC
pathimage = 'C:\Users\boazk\Desktop\team challenge\Algo\Team challenge 2021\Scoliose\';
pathlandm = 'C:\Users\boazk\Desktop\team challenge\Algo\Team challenge 2021\Landmarks\';

%%define paths laptop
addpath("Geometric_points\");
addpath("Get_vertebra_points\");
addpath("Sternum\");
addpath("Parameters\");

nameimage = '1preop.nii';
namelandm = '1preop.xml';
s = strcat(pathimage,nameimage);
s2 = strcat(pathlandm,namelandm);

%%read in .nii and landmarks file
nii = niftiread(s);
landmarks_struct = xml2struct(s2);

%%extract landmarks
landmarks = getlandmarks(landmarks_struct);
landmarks = round(landmarks);

%%Get manual landmark slice
landmark_slice = landmarks(1,3);
slice_interval = 10;

%%Vertebra landmarks
[nii2, Vertebra_body_points, Spinal_canal_points, Side_Vertebra_body_points] = getlandmarkcoordinates(nii, landmark_slice, landmarks, slice_interval);

%%Sternum landmark
sternum = sternum_function(landmarks,nii, landmark_slice, slice_interval);

%%Geometrical landmark
[upper, lower, leftback, rightback] = getgeolandmarks(nii, slice_interval, landmark_slice);

%%Cut matrices to same slices
[upper, lower, leftback, rightback, sternum, Vertebra_body_points, Spinal_canal_points, Side_Vertebra_body_points] = cutmatrices(upper, lower, leftback, rightback, sternum, Vertebra_body_points, Spinal_canal_points, Side_Vertebra_body_points);

%%Calculate parameters for all slices and store in matrix
parameters_total = getparam(upper, lower, leftback, rightback, sternum, Vertebra_body_points, Spinal_canal_points, Side_Vertebra_body_points);










