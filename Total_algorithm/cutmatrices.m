function [upper, lower, leftback, rightback, sternum, Vertebra_body_points, Spinal_canal_points, Side_Vertebra_body_points] = cutmatrices(upper, lower, leftback, rightback, sternum, Vertebra_body_points, Spinal_canal_points, Side_Vertebra_body_points)

tempmin = max([upper(1,1) lower(1,1) leftback(1,1) rightback(1,1) sternum(1,1), Vertebra_body_points(1,1), Spinal_canal_points(1,1), Side_Vertebra_body_points(1,1)]);
tempmax = min([upper(end,1) lower(end,1) leftback(end,1) rightback(end,1) sternum(end,1), Vertebra_body_points(end,1), Spinal_canal_points(end,1), Side_Vertebra_body_points(end,1)]);

[ind,~] = find(sternum(:,1) >= tempmin & sternum(:,1) <= tempmax);
sternum = sternum(ind,:);
[ind,~] = find(upper(:,1) >= tempmin & upper(:,1) <= tempmax);
upper = upper(ind,:);
[ind,~] = find(lower(:,1) >= tempmin & lower(:,1) <= tempmax);
lower = lower(ind,:);
[ind,~] = find(leftback(:,1) >= tempmin & leftback(:,1) <= tempmax);
leftback = leftback(ind,:);
[ind,~] = find(rightback(:,1) >= tempmin & rightback(:,1) <= tempmax);
rightback = rightback(ind,:);
[ind,~] = find(Vertebra_body_points(:,1) >= tempmin & Vertebra_body_points(:,1) <= tempmax);
Vertebra_body_points = Vertebra_body_points(ind,:);
[ind,~] = find(Spinal_canal_points(:,1) >= tempmin & Spinal_canal_points(:,1) <= tempmax);
Spinal_canal_points = Spinal_canal_points(ind,:);
[ind,~] = find(Side_Vertebra_body_points(:,1) >= tempmin & Side_Vertebra_body_points(:,1) <= tempmax);
Side_Vertebra_body_points = Side_Vertebra_body_points(ind,:);

end