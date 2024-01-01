close all;
clear all;

im = im2double(imread("CarteSingole/uno-test-01-1.jpg"));


BW = rgb2gray(im) > 0.5;
BW = padarray(BW, [10,10], 0, "both");

se = strel("square", 6);
BW = imopen(BW, se);
BW = bwareaopen(BW, 500);

figure, imshow(BW);