close all;
clear all;

%%read_coco('coco-1702319905.5630996.json');

imB = imread("/home/omarm/Desktop/UNIMIB/Elab/Progetto/coco-annotator/datasets/UNO-GT/UNO/uno-test-01.jpg");
imN = imread("/home/omarm/Desktop/UNIMIB/Elab/Progetto/coco-annotator/datasets/UNO-GT/UNO/uno-test-10.jpg");
imL = imread("/home/omarm/Desktop/UNIMIB/Elab/Progetto/coco-annotator/datasets/UNO-GT/UNO/uno-test-24.jpg");


%% SPAZI COLORE BUIO
% RGB
figure(1);
subplot(3,3,1);
imshow(imB(:,:,1));
subplot(3,3,2);
imshow(imB(:,:,2));
subplot(3,3,3);
imshow(imB(:,:,3));

%HSV
im1 = rgb2hsv(imB);
subplot(3,3,4);
imshow(im1(:,:,1));
subplot(3,3,5);
imshow(im1(:,:,2));
subplot(3,3,6);
imshow(im1(:,:,3));

%Ycbcr
im2 = rgb2ycbcr(imB);
subplot(3,3,7);
imshow(im2(:,:,1));
subplot(3,3,8);
imshow(im2(:,:,2));
subplot(3,3,9);
imshow(im2(:,:,3));



%% SPAZI COLORE NORMALE
% RGB
figure(2);
subplot(3,3,1);
imshow(imN(:,:,1));
subplot(3,3,2);
imshow(imN(:,:,2));
subplot(3,3,3);
imshow(imN(:,:,3));

%HSV
im1 = rgb2hsv(imN);
subplot(3,3,4);
imshow(im1(:,:,1));
subplot(3,3,5);
imshow(im1(:,:,2));
subplot(3,3,6);
imshow(im1(:,:,3));

%Ycbcr
im2 = rgb2ycbcr(imN);
subplot(3,3,7);
imshow(im2(:,:,1));
subplot(3,3,8);
imshow(im2(:,:,2));
subplot(3,3,9);
imshow(im2(:,:,3));



%% SPAZI COLORE LAMPADA
% RGB
figure(3);
subplot(3,3,1);
imshow(imL(:,:,1));
subplot(3,3,2);
imshow(imL(:,:,2));
subplot(3,3,3);
imshow(imL(:,:,3));

%HSV
im1 = rgb2hsv(imL);
subplot(3,3,4);
imshow(im1(:,:,1));
subplot(3,3,5);
imshow(im1(:,:,2));
subplot(3,3,6);
imshow(im1(:,:,3));

%Ycbcr
im2 = rgb2ycbcr(imL);
subplot(3,3,7);
imshow(im2(:,:,1));
subplot(3,3,8);
imshow(im2(:,:,2));
subplot(3,3,9);
imshow(im2(:,:,3));