function ehr = get_EHr(landmarks)
    x6 = landmarks(6, 1);
    y6 = landmarks(6, 2);
    x8 = landmarks(8, 1);
    y8 = landmarks(8, 2);
    x5 = landmarks(4, 1);
    y5 = landmarks(4, 2);
    x2 = landmarks(2, 1);
    y2 = landmarks(2, 2);
    
    %%slope of parallel lines
    m = (y8-y6)/(x8-x6);

    %%intercepts
    n3 = y8-m*x8;
    n2 = y5-m*x5;

    %%slope and intercept perpendicular line
    m_perp = -1/m;
    n_perp1 = y2 - m_perp*x2;
    
    %%point on first, second and third line
    p1_y = y2;
    p1_x = x2;
    p2_x = (n2-n_perp1)/(m_perp-m);
    p2_y = m_perp*p2_x + n_perp1;
    p3_x = (n3-n_perp1)/(m_perp-m);
    p3_y = m_perp*p3_x + n_perp1;

    d1 = sqrt((p2_y^2 - p3_y^2) + (p2_x^2 - p3_x^2));
    d2 = sqrt((p1_y^2 - p2_y^2) + (p1_x^2 - p2_x^2));

    ehr = d1/d2;    
end