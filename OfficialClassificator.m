clear all;
close all;

load("data.mat");

cv = cvpartition(labels, 'holdout', 0.2);

train.cards = cards(cv.training(1));
train.labels = labels(cv.training(1));
train.lbp = lbp(cv.training(1), :);
train.qhist = qhist(cv.training(1), :);
%train.cedd = cedd(cv.training(1), :);
train.vsift = vsift(cv.training(1), :);
train.vsurf = vsurf(cv.training(1), :);

test.cards = cards(cv.test(1));
test.labels = labels(cv.test(1));
test.lbp = lbp(cv.test(1), :);
test.qhist = qhist(cv.test(1), :);
%test.cedd = cedd(cv.test(1), :);
test.vsift = vsift(cv.test(1), :);
test.vsurf = vsurf(cv.test(1), :);

aaa = [cedd];
T = table(aaa, labels);
% SIFT
% HOG

save("trainingData.mat", "test", "train");