function res = myImFill(bwimage)
    [labels, nlabels] = bwlabel(~bwimage);
    maxArea = 0; 
    lMax = 1;
    for r = 1 : nlabels
        area = sum(sum(labels == r));
        if area > maxArea
            maxArea = area;
            lMax = r;
        end
    end
    labels(labels ~= lMax) = 0;
    res = ~(labels > 0);
end