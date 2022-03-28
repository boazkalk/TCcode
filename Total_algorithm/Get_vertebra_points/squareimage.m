function [bin_image_parted, xmin, ymin, xmax, ymax] = squareimage(bin_image, lm4, lm7)
    xmid = round((min(lm4(2), lm7(2))+max(lm4(2), lm7(2)))/2);
    ymid = round((min(lm4(1), lm7(1))+max(lm4(1), lm7(1)))/2);
    if xmid < 151
        xmin = 1;
    else
        xmin = xmid-150;
    end
    if ymid < 151
        ymin = 1;
    else
        ymin = ymid-150;
    end
    xmax = xmid+150;
    ymax = ymid+150;
    
    bin_image_parted = bin_image(ymin:ymax,xmin:xmax);
end