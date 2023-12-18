close all;
im1 = imread("uno-test-01.jpg");
im2 = imread("uno-test-24.jpg");
im2 = rgb2ycbcr(im2);
im1 = rgb2ycbcr(im1);

g1 = graythresh(im1);
%imb1 = im2double(im1(:,:,2)) <= g1;
g2 = graythresh(im2);
%imb2 = im2double(im2(:,:,2)) <= g2;
imb1 = imbinarize(im1(:,:,3));
imb2 = imbinarize(im2(:,:,3));
figure;
% 2 significativamente diverso da 3?????
subplot(1,2,1), imshow(imb2), title("lampada");
subplot(1,2,2), imshow(imb1), title("scura");
%HoughDemo();
