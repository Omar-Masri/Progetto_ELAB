close all;
im = rgb2gray(im2double(imread("CarteSingole/uno-test-01-9.jpg")));
angle = horizon(im);
imshow(imrotate(im, -angle, 'bicubic'));