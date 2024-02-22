function [features, labelsCard, T] = ClassificatorCards()
    load("data_training.mat");
    
    features = [lbp, areas, eul, perimeter, orientation, convexArea, circularity, nconn];
    T = table(features, labelsCard);
  
end