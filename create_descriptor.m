function [lbp, cedd, qhist, si, su, ka, eul, areas, nconn, perimeter, orientation, convexArea, circularity] = create_descriptor(im)
    gim = imclearborder(imbinarize(rgb2gray(im)));

    lbp   = compute_lbp(im);
    cedd  = compute_CEDD(im);
    qhist = compute_qhist(im);

    sPt = detectSIFTFeatures(gim);
    ssur = detectSURFFeatures(gim);
    kz = detectKAZEFeatures(gim);

    si = extractFeatures(gim,sPt, Method="SIFT");
    su = extractFeatures(gim,ssur, Method="SURF");
    ka = extractFeatures(gim,kz, Method="KAZE");
    
    eul = bweuler(gim);
    areas = bwarea(gim);
    nconn = bwconncomp(gim).NumObjects;

    gim = bwareafilt(gim, 1);

    perimeter = cell2mat(struct2cell(regionprops(gim,"Perimeter")));
    orientation = cell2mat(struct2cell(regionprops(gim,"Orientation")));
    convexArea = cell2mat(struct2cell(regionprops(gim,"ConvexArea")));
    circularity = cell2mat(struct2cell(regionprops(gim,"Circularity")));

    if(isempty(perimeter)) perimeter = 0; end
    if(isempty(orientation)) orientation = 0; end
    if(isempty(convexArea)) convexArea = 0; end
    if(isempty(circularity)) circularity = 0; end

end