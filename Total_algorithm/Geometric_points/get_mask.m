function mask = get_mask(slice_nii)

%binarize
bw_image = slice_nii > 700;

%open
se = strel("disk", 5);
open = imopen(bw_image, se);

%complement and clearborders
complement = imcomplement(open);
clear = imclearborder(complement) ;

%close
se2 = strel("disk", 15);
closed = imclose(clear, se2);

mask = closed;
end