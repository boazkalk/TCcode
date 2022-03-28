function image = makebin(x)
    image = x;
    for i = 1:1:height(x)
        for j = 1:1:width(x)
            if x(i,j) > 0
                image(i,j) = 255;
            else
            end
        end
    end
end
