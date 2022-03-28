function RHi = get_RHi(landmarks)
    x6 = landmarks(6, 1);
    y6 = landmarks(6, 2);
    x7 = landmarks(7, 1);
    y8 = landmarks(8, 2);
    
    h1 = y8-y6;
    h2 = x7-x6;
    
    RHi = h1/h2;
end