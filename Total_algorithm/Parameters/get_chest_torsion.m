function chest_tors = get_chest_torsion(landmarks)
    x7 = landmarks(7, 1);
    y7 = landmarks(7, 2);
    x4 = landmarks(4, 1);
    y4 = landmarks(4, 2);
    x2 = landmarks(2, 1);
    y2 = landmarks(2, 2);

    %%slope of lines
    m1 = (y4-y7)/(x4-x7);
    m2 = (y2-y7)/(x2 - x7);

    %%intercept of lines
    n1 = y7 - m1 * x7;
    n2 = y7 - m2 * x7;

    %%angle between lines
    chest_tors = atand(m1-m2)/(1+m1*m2);
end