function chest_tors = get_chest_torsion(landmarks)
    x7 = landmarks(7, 1);
    y7 = landmarks(7, 2);
    x4 = landmarks(4, 1);
    y4 = landmarks(4, 2);
    x2 = landmarks(2, 1);
    y2 = landmarks(2, 2);

    %% vector 
    vector1x = x4 - x7;
    vector1y = y4 - y7;
    vector2x = x2 - x7;
    vector2y = y2 - y7;

    u = [vector1x, vector1y];
    v = [vector2x, vector2y];

    CosTheta = max(min(dot(u,v)/(norm(u)*norm(v)),1),-1);
    chest_tors = real(acosd(CosTheta));
end