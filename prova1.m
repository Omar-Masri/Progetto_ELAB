close all;
clear all;

%strane
%03 bordo
%04 artefatto
%06 artefatto
%07 artefatto
%08 artefatto -> rimane
%09 artefatto
%10 artefatto -> rimane
%11 artefatto
%13 artefatto



imB = imread("/home/omarm/Desktop/UNIMIB/Elab/Progetto/coco-annotator/datasets/UNO-GT/UNO/uno-test-20.jpg");
imN = imread("/home/omarm/Desktop/UNIMIB/Elab/Progetto/coco-annotator/datasets/UNO-GT/UNO/uno-test-21.jpg");
imL = imread("/home/omarm/Desktop/UNIMIB/Elab/Progetto/coco-annotator/datasets/UNO-GT/UNO/uno-test-22.jpg");
imBg = imread("/home/omarm/Desktop/UNIMIB/Elab/Progetto/coco-annotator/datasets/UNO-GT/UNO/uno-test-23.jpg");

im = imB;

%im = imsharpen(im,'Radius',2,'Amount',4);

imm = rgb2hsv(im);

lab = rgb2lab(im);

ycb = rgb2ycbcr(im);

v = imgaussfilt(imm(:,:,3));
c = imgaussfilt(imm(:,:, 1));
l = imgaussfilt(lab(:,:,1));

value = max(l(:));
l = l - (value/1.35);
%y = imadjust(y,[],[],1.5);

as = adaptthresh(v, Statistic="gaussian", ForegroundPolarity="bright");
ac = adaptthresh(c, Statistic="gaussian", ForegroundPolarity="bright");
al = adaptthresh(l, Statistic="gaussian", ForegroundPolarity="bright");

imbb = imbinarize(v, as);
imbc = imbinarize(c, ac);
imbl = imbinarize(l, al);

imbb= imbb & imbc;
imbb= imbb & imbl;

%imbb = imclearborder(imbb);
imbb = bwareaopen(imbb,1500);

se = strel("square",3);

BW = imclose(imbb,se);

BW = myImFill(BW);

BW = bwareaopen(BW, 25000);
edd = edge(BW, "sobel");
%BW = myImFill(BW);

ed = edge(BW, "sobel", "nothinning");

L = imsegkmeans(im2uint8(imm(:,:,1)),5);
B = labeloverlay(im2uint8(imm),L);

labels = bwlabel(BW);

blobs = regionprops(labels, 'BoundingBox');

figure(1);
subplot(2,2,1);
imagesc(L);
subplot(2,2,2);
imshow(imbb);
rectangle('Position',blobs(5).BoundingBox,'Edgecolor','g');
subplot(2,2,3);
imshow(imbc);
subplot(2,2,4);
imshow(BW);