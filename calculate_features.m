function [si, su, ka] = calculate_features(ssi, ssu, ssk, nlab, Cs, Cu, Ck)
    [~,idx_test] = pdist2(Cs,ssi,'euclidean','Smallest',1);

    idx_test = idx_test';

    norm = size(idx_test,1);

    si = accumarray(idx_test, 1, [nlab*4 1])' ./ norm;

    [~,idx_test] = pdist2(Cu,ssu,'euclidean','Smallest',1);

    idx_test = idx_test';

    norm = size(idx_test,1);

    su = accumarray(idx_test, 1, [nlab*4 1])' ./ norm;

    [~,idx_test] = pdist2(Ck,ssk,'euclidean','Smallest',1);

    idx_test = idx_test';

    norm = size(idx_test,1);

    ka = accumarray(idx_test, 1, [nlab*4 1])' ./ norm;

end

