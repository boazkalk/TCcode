function hwr = get_HWr(landmarks)
    x1 = landmarks(1, 1);
    x4 = landmarks(4, 1);
    x3 = landmarks(3, 1);
    
    l1 = x4-x1;
    l2 = x3-x4; 
    hwr = l1/l2;
end
