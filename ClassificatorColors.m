function [features, labelsColor, T] = ClassificatorColors()
    load("data_training.mat");
    
    features = [qhist];
    T = table(features, labelsColor);
  
end