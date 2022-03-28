function parameters_total = getparam(upper, lower, leftback, rightback, sternum, Vertebra_body_points, Spinal_canal_points, Side_Vertebra_body_points)

for i = 1:1:length(upper)
    
    landmarks_slice = [upper(i,2:3); sternum(i,2:3) ; lower(i,2:3);  Vertebra_body_points(i,2:3); Side_Vertebra_body_points(i,2:3); leftback(i,2:3); Spinal_canal_points(i,2:3); rightback(i,2:3)];

    parameters = get_parameters(landmarks_slice);

    temp(i,:) =  [upper(i,1), parameters];

end

parameters_total = temp;

end