function [train_perf, test_perf] = test_classifier(descriptor, labels, cv)
  % Testa un classificatore con i dati descrittori e partizionamento.
  % Paramnetri: 
  %   descriptor : descrittore/i da usareper la classificazione
  %   labels : etichette dell eimmagini
  %   cv : output di cvpartition con le partizioni train set / test set
  %
  %   Ritorna le performance del classificatore in fase di training e in
  %   fase di test
  
  
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