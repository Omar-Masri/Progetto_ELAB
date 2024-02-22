function [train_perf, test_perf] = test_classifier(descriptor, labels, cv)

  
  train_values = descriptor(cv.training,:);
  train_labels = labels(cv.training);
  
  test_values  = descriptor(cv.test,:);
  test_labels  = labels(cv.test);
  
  c = fitcknn(train_values, train_labels,'NumNeighbors',7);% ADDESTRARE IL CLASSIFICATORE
  
  train_predicted = predict(c, train_values);
  train_perf = confmat(train_labels, train_predicted);

  test_predicted = predict(c, test_values);
  test_perf = confmat(test_labels, test_predicted);
    
end