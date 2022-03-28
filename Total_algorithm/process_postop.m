function nii_new = process_postop (nii) 
    value = max(max(max(nii)));
    value = value - 1500;
    [~, ~, nr_slices] = size(nii);
    for i = 1:1:nr_slices
    
        niislice = nii(:,:,i);
        niislice(niislice>=value) = 1500;
        nii_new_temp(:,:,i) = niislice;
    end
    nii_new = nii_new_temp;
    %niftiwrite(nii_new,new_name)
end 