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
  huMoments = [];

  for n = 1 : ncards
    fprintf('%3.0f%%', n/ncards * 100);
    im = imread(cards{n});

    [lb, ce, qh, si, su, ka, eu, ar, nc, pe, or, co, ci, hu] = create_descriptor(im);

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
    huMoments = [huMoments; hu];

    fprintf('\b\b\b\b');
  end

  val = unique(labels);

  nlab = numel(val);

  [idx,Cs] = kmeans(sift,nlab*4, MaxIter=128*1000);
  [idxu,Cu] = kmeans(surf,nlab*4, MaxIter=128*1000);
  [idxk,Ck] = kmeans(kaze,nlab*4, MaxIter=128*1000);

  vsift = [];
  vsurf = [];
  vkaze = [];

  for n = 1 : ncards
    im = imread(cards{n});
    gim = imclearborder(imbinarize(rgb2gray(im)));

    sPt = detectSIFTFeatures(gim);
    ssi = extractFeatures(gim,sPt, Method="SIFT");
    ssur = detectSURFFeatures(gim);
    ssu = extractFeatures(gim,ssur, Method="SURF");
    kz = detectKAZEFeatures(gim);
    ssk = extractFeatures(gim,sPt, Method="KAZE");

    [si, su, ka] = calculate_features(ssi, ssu, ssk, nlab, Cs, Cu, Ck);

    vsift = [vsift; si];

    vsurf = [vsurf; su];

    vkaze = [vkaze; ka];

  end

  labelsCard = cellfun(@(S) S(2:end), labels, 'Uniform', 0);
  labelsColor = cellfun(@(S) S(1:end-1), labels, 'Uniform', 0);
  
  save('data_training.mat','lbp', "cedd", "qhist", "cards", "labels", "labelsCard", "labelsColor", "vsift", "vsurf", "vkaze", "eul", "areas", "perimeter", "orientation", "convexArea", "circularity", "nconn", "huMoments");
  save("BagOfFeatures.mat", "nlab", "Cs", "Cu", "Ck");
  
end