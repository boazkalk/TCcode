clear all 
close all

%%define paths PC
pathimage = 'C:\Users\boazk\Desktop\team challenge\Algo\Team challenge 2021\Scoliose\';
pathlandm = 'C:\Users\boazk\Desktop\team challenge\Algo\Team challenge 2021\Landmarks\';

%%define paths laptop
% pathimage = 'C:\School\Master\Jaar 2\Q3\TC\Team challenge 2021\Scoliose\';
% pathlandm = 'C:\School\Master\Jaar 2\Q3\TC\Team challenge 2021\Landmarks\';

nameimage = '3preop.nii';
namelandm = '3preop.xml';
s = strcat(pathimage,nameimage);
s2 = strcat(pathlandm,namelandm);

%%read in .nii and landmarks file
nii = niftiread(s);
landmarks_struct = xml2struct(s2);

%%extract landmarks
landmarks = getlandmarks(landmarks_struct);
landmarks = round(landmarks);

%%visualize landmarks
landmark_slice = landmarks(1,3);
slice_interval = 10;

[nii2, Vertebra_body_points, Spinal_canal_points, Side_Vertebra_body_points] = getlandmarkcoordinates(nii, landmark_slice, landmarks, slice_interval);



















