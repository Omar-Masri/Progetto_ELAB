function create_descriptor_files()
  % Calcola i descrittori delle immagini e li salva su file.
  %nlab*nlab

  [cards, labels] = readlists("UNO-GT-onlycolor.json");
    
  ncards = size(cards, 1);
  
  lbp =[];
  cedd = [];
  qhist = [];
  sift = [];
  surf = [];
  kaze = [];
  eul = [];
  area = [];
  nconn = [];
  perimeter = [];
  orientation = [];
  convexArea = [];
  circularity = [];

  for n = 1 : ncards
    disp(n);
    im = imread(cards{n});

    [lb, ce, qh, si, su, ka, eu, ar, nc, pe, or, co, ci] = create_descriptor(im);

    lbp   = [lbp; lb];
    cedd  = [cedd; ce];
    qhist = [qhist; qh];
    sift = [sift; si];
    surf = [surf; su];
    kaze = [kaze; ka];
    eul = [eul; eu];
    area = [area; ar];
    nconn = [nconn; nc];
    perimeter = [perimeter; pe];
    orientation = [orientation; or];
    convexArea = [convexArea; co];
    circularity = [circularity; ci];

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
    gim = imclearborder(imbinarize(rgb2gray(im)));

    sPt = detectSIFTFeatures(gim);
    ss = extractFeatures(gim,sPt, Method="SIFT");

    [~,idx_test] = pdist2(C,ss,'euclidean','Smallest',1);

    idx_test = idx_test';

    norm = size(idx_test,1);

    v = accumarray(idx_test, 1, [nlab*nlab 1])' ./ norm;

    vsift = [vsift; v];


    ssur = detectSURFFeatures(gim);
    ss = extractFeatures(gim,ssur, Method="SURF");

    [~,idx_test] = pdist2(Cu,ss,'euclidean','Smallest',1);

    idx_test = idx_test';

    norm = size(idx_test,1);

    v = accumarray(idx_test, 1, [nlab*nlab 1])' ./ norm;

    vsurf = [vsurf; v];


    kz = detectKAZEFeatures(gim);
    ss = extractFeatures(gim,sPt, Method="KAZE");

    [~,idx_test] = pdist2(Ck,ss,'euclidean','Smallest',1);

    idx_test = idx_test';

    norm = size(idx_test,1);

    v = accumarray(idx_test, 1, [nlab*nlab 1])' ./ norm;

    vkaze = [vkaze; v];

  end

  
  
  save('data','lbp', "cedd", "qhist", "cards", "labels", "vsift", "vsurf", "vkaze", "eul", "area", "perimeter", "orientation", "convexArea", "circularity", "nconn");
  
end