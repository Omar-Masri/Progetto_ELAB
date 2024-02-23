function [features, labelsCard, T] = ClassificatorCards()
    load("data_training.mat");
    
    features = [areas, eul, perimeter, orientation, convexArea, circularity, nconn, huMoments];
    T = table(features, labelsCard);
  
end