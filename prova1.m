close all;
clear all;

%strane
%03 bordo
%04 artefatto
%06 artefatto
%07 artefatto
%08 artefatto
%09 artefatto
%10 artefatto
%11 artefatto
%13 artefatto



imB = imread("/home/omarm/Desktop/UNIMIB/Elab/Progetto/coco-annotator/datasets/UNO-GT/UNO/uno-test-03.jpg");
imN = imread("/home/omarm/Desktop/UNIMIB/Elab/Progetto/coco-annotator/datasets/UNO-GT/UNO/uno-test-10.jpg");
imL = imread("/home/omarm/Desktop/UNIMIB/Elab/Progetto/coco-annotator/datasets/UNO-GT/UNO/uno-test-24.jpg");
imBg = imread("/home/omarm/Desktop/UNIMIB/Elab/Progetto/coco-annotator/datasets/UNO-GT/UNO/uno-test-16.jpg");

im = imB;

imm = rgb2hsv(im);

lab = rgb2lab(im);

ycb = rgb2ycbcr(im);


v = imm(:,:,3);
c = imm(:,:, 1);
l = lab(:,:,1);
value = max(l(:));
l = l - (value/1.35);
%y = imadjust(y,[],[],1.5);

as = adaptthresh(v, Statistic="gaussian", ForegroundPolarity="bright");
ac = adaptthresh(c, Statistic="gaussian", ForegroundPolarity="bright");
ay = adaptthresh(l, ForegroundPolarity="bright");

imbb = imbinarize(v, as);
imbc = imbinarize(c);
imby = imbinarize(l);

imbb= imbb & imbc;
imbb= imbb & imby;

%imbb = imclearborder(imbb);
imbb = bwareaopen(imbb,1500);

ed = edge(imbb, "sobel");

se = strel("square",3);
closeBW = imclose(imbb,se);


BW = imfill(closeBW,"holes");
edd = edge(BW, "sobel");
pv = imfill(imbb,"holes");

gg = repmat(BW,[1,1,3]);

figure(1);
subplot(2,2,1);
imshow(immultiply(im, repmat(BW,[1,1,3])));
subplot(2,2,2);
imshow(imbb);
subplot(2,2,3);
imshow(imbc);
subplot(2,2,4);
imshow(BW);