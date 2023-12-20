function [BW] = Binarize(im)
    imm = rgb2hsv(im);
    
    lab = rgb2lab(im);
    
    v = imgaussfilt(imm(:,:,3));
    c = imgaussfilt(imm(:,:, 1));
    l = imgaussfilt(lab(:,:,1));
    
    value = max(l(:));
    l = l - (value/1.35);
    
    as = adaptthresh(v, Statistic="gaussian", ForegroundPolarity="bright");
    ac = adaptthresh(c, Statistic="gaussian", ForegroundPolarity="bright");
    al = adaptthresh(l, Statistic="gaussian", ForegroundPolarity="bright");
    
    imbb = imbinarize(v, as);
    imbc = imbinarize(c, ac);
    imbl = imbinarize(l, al);
    
    imbb= imbb & imbc;
    imbb= imbb & imbl;
    
    imbb = bwareaopen(imbb,1500);
    
    se = strel("square",3);
    
    BW = myImFill(imbb);
    BW = bwareaopen(BW, 25000);
    BW = imclose(BW,se);
end

