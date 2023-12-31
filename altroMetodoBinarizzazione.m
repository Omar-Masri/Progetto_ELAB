close all;
mrgb = imread(".\UNO\uno-test-01.jpg");
mn = load("mean.mat");
test = im2double(mrgb) - mn.ans;
test = imbinarize(im2gray(test));
imbb = bwareaopen(test,1500);
se = strel("square",3);
    
BW = imclose(imbb,se);
BW = myImFill(BW);
BW = bwareaopen(BW, 25000);

figure, imshow(BW);