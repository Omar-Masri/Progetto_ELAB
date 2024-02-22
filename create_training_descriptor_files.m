function create_training_descriptor_files(cards, labels)
  % Calcola i descrittori delle immagini e li salva su file.
  %nlab*nlab
    
  ncards = size(cards, 1);
  
  lbp =[];
  cedd = [];
  qhist = [];
  sift = [];
  surf = [];
  kaze = [];
  eul = [];
  areas = [];
  nconn = [];
  perimeter = [];
  orientation = [];
  convexArea = [];
  circularity = [];

  for n = 1 : ncards
    fprintf('%3.0f%%', n/ncards * 100);
    im = imread(cards{n});

    [lb, ce, qh, si, su, ka, eu, ar, nc, pe, or, co, ci] = create_descriptor(im);

    lbp   = [lbp; lb];
    cedd  = [cedd; ce];
    qhist = [qhist; qh];
    sift = [sift; si];
    surf = [surf; su];
    kaze = [kaze; ka];
    eul = [eul; eu];
    areas = [areas; ar];
    nconn = [nconn; nc];
    perimeter = [perimeter; pe];
    orientation = [orientation; or];
    convexArea = [convexArea; co];
    circularity = [circularity; ci];

    fprintf('\b\b\b\b');
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

  labelsCard = cellfun(@(S) S(2:end), labels, 'Uniform', 0);
  labelsColor = cellfun(@(S) S(1:end-1), labels, 'Uniform', 0);
  
  save('data_training','lbp', "cedd", "qhist", "cards", "labels", "labelsCard", "labelsColor", "vsift", "vsurf", "vkaze", "eul", "areas", "perimeter", "orientation", "convexArea", "circularity", "nconn");
  
end