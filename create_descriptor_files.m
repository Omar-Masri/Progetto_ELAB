function create_descriptor_files()
  % Calcola i descrittori delle immagini e li salva su file.
  %nlab*nlab

  [cards, labels] = readlists("UNO-GT-nocolor.json");
    
  ncards = size(cards, 1);
  
  lbp =[];
  cedd = [];
  qhist = [];
  sift = [];
  surf = [];
  kaze = [];
  hog = [];

  for n = 1 : ncards
    disp(n);
    im = imread(cards{n});

    resim = imresize(im, [150,150]);

    gim = rgb2gray(im);

    lbp   = [lbp;compute_lbp(im)];
    cedd  = [cedd;compute_CEDD(im)];
    qhist = [qhist;compute_qhist(im)];
    %im = im2double(im);

    sPt = detectSIFTFeatures(rgb2gray(im));
    ssur = detectSURFFeatures(rgb2gray(im));
    kz = detectKAZEFeatures(rgb2gray(im));

    sift = [sift;extractFeatures(gim,sPt, Method="SIFT")];
    surf = [surf;extractFeatures(gim,ssur, Method="SURF")];
    kaze = [kaze;extractFeatures(gim,kz, Method="KAZE")];

    %sift = [sift; detectSIFTFeatures(rgb2gray(im))];
    %surf = [surf; detectSURFTeatures(rgb2gray(im))];
    
    %per ora non fattibile così>>>>>>>>>>>
    %hog = [hog; extractHOGFeatures(im, "CellSize", [10, 10])];
    g = size(gim, 1);
    s = floor(size(gim, 1)/ 10);
    %hog =extractHOGFeatures(resim, "CellSize", [ceil(size(gim, 1)/ 10), ceil(size(gim, 2)/ 10)]);

  end

  val = unique(labels);

  nlab = numel(val);

  [idx,C] = kmeans(sift,nlab*nlab, MaxIter=128*1000);
  [idxu,Cu] = kmeans(surf,nlab*nlab, MaxIter=128*1000);
  [idxk,Ck] = kmeans(kaze,nlab*nlab, MaxIter=128*1000);

  vsift = [];
  vsurf = [];
  vkaze = [];

  for n = 1 : ncards
    im = imread(cards{n});

    sPt = detectSIFTFeatures(rgb2gray(im));
    ss = extractFeatures(gim,sPt, Method="SIFT");

    [~,idx_test] = pdist2(C,ss,'euclidean','Smallest',1);

    idx_test = idx_test';

    norm = size(idx_test,1);

    v = accumarray(idx_test, 1, [nlab*nlab 1])' ./ norm;

    vsift = [vsift; v];


    ssur = detectSURFFeatures(rgb2gray(im));
    ss = extractFeatures(gim,ssur, Method="SURF");

    [~,idx_test] = pdist2(Cu,ss,'euclidean','Smallest',1);

    idx_test = idx_test';

    norm = size(idx_test,1);

    v = accumarray(idx_test, 1, [nlab*nlab 1])' ./ norm;

    vsurf = [vsurf; v];


    kz = detectKAZEFeatures(rgb2gray(im));
    ss = extractFeatures(gim,sPt, Method="KAZE");

    [~,idx_test] = pdist2(Ck,ss,'euclidean','Smallest',1);

    idx_test = idx_test';

    norm = size(idx_test,1);

    v = accumarray(idx_test, 1, [nlab*nlab 1])' ./ norm;

    vkaze = [vkaze; v];

  end
  
  save('data','lbp', "cedd", "qhist", "cards", "labels", "vsift", "vsurf", "vkaze");
  
end