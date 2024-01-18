function [features, labels, T] = Classificator()
    load("data_training.mat");
    
    features = [lbp, areas, eul, perimeter, orientation, convexArea, circularity, nconn];
    T = table(features, labels);
  
end