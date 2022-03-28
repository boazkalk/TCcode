function parameters = get_parameters(landmarks)
%     s2 = strcat(path,patient);
%     landmarks_struct = xml2struct(s2);
%     landmarks = getlandmarks(landmarks_struct);
%     landmarks = round(landmarks);
    parameters = [];
    rhi = get_RHi(landmarks);
    parameters(1) = rhi;
    hwr = get_HWr(landmarks);
    parameters(2) = hwr;
    ehr = get_EHr(landmarks);
    parameters(3) = ehr;
    chest_tors = get_chest_torsion(landmarks);
    parameters(4) = chest_tors;
end
