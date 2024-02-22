function [features, labelsColor, T] = ClassificatorColors()
    load("data_training.mat");
    
    features = [cedd];
    T = table(features, labelsColor);
  
end