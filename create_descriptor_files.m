function create_descriptor_files()
  % Calcola i descrittori delle immagini e li salva su file.

  [cards, labels] = readlists("UNO-GT.json");
    
  ncards = size(cards, 1);
  
  lbp =[];
  cedd = [];
  qhist = [];
  sift = [];
  hog = [];
  hu = [];
  for n = 1 : ncards
    disp(n);
    im = imread(cards{n});
    lbp   = [lbp;compute_lbp(im)];
    cedd  = [cedd;compute_CEDD(im)];
    qhist = [qhist;compute_qhist(im)];
    %im = im2double(im);
    %sPt = detectSIFTFeatures(rgb2gray(im)).selectStrongest(6);
    %tmp = [sPt.Scale, sPt.Orientation, sPt.Octave, sPt.Layer, sPt.Location, sPt.Metric];
    %tmp = reshape(tmp, 1, []);
    %sift = cat(1, sift, tmp);
    hu = [hu; hu_moments(rgb2gray(im))];
    %sift = [sift; detectSIFTFeatures(rgb2gray(im))];
    %surf = [surf; detectSURFTeatures(rgb2gray(im))];
    
    %per ora non fattibile così>>>>>>>>>>>
    %hog = [hog; extractHOGFeatures(im, "CellSize", [10, 10])];
    %hog =extractHOGFeatures(im, "CellSize", [20, 20]);

  end
  
  save('data','lbp', "cedd", "qhist", "cards", "labels", "sift", "hu");
  
end