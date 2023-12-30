close all;
clear all;
%togliere tutto bianco e dilatare dopo per staccare carte (provare)
% 15 <- non c'è il coso che non è una carta se f
imrgb = imread("C:\Users\pirov\Desktop\UNIMIB\elaborazione immagini\dataset\uno-test-08.jpg");
BW = Binarize(imrgb);

labels = bwlabel(BW);

%labels(labels ~= 1) = 0;
imedge = edge(labels,'sobel', "nothinning");
%figure,imshow(imedge),title('Immagine degli edge');

[H,T,R] = hough(imedge);

val = ceil(size(H)./20);
if(mod(val(1), 2) == 0)
val(1) = val(1) + 1;
end
if(mod(val(2), 2) == 0);
val(2) = val(2) + 1;
end

P = houghpeaks(H, 100, Threshold=0, NHoodSize=val);

% lines = houghlines(imedge,T,R,P,'FillGap',20,'MinLength',70);
% figure, imshow(imedge), hold on
% max_len = 0;
% for k = 1:length(lines)
%    xy = [lines(k).point1; lines(k).point2];
%    plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
% 
%    % Plot beginnings and ends of lines
%    plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
%    plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
% 
% end

%%%%% test rotation
%u = lines(3).point1 - lines(3).point2; % vector along the vertical left edge.
%v = [-1 0]; % vector along the vertical, oriented up.
%theta = acos( u*v' / (norm(u) * norm(v)) );
%imrgb = im2double(imrgb) .* cat(3, labels, labels, labels);
%B = imrotate(imrgb, theta * 180 / pi);

%figure, imshow(B);

%%%%% BB

%%%%% start staccamento con erode
%se = strel("square", 5);
%BW = imerode(BW, se)
%BW = bwmorph(BW, "skeleton", 20);
%BW = bwmorph(BW, "endpoints");
%BW = imfill(BW, "holes");
%BW = imdilate(BW, se);
%se = strel('square',11);
%BW = ~imdilate(BW,se); %fare erode
%%%%% end

% kmeansTest = immultiply(imrgb, cat(3, BW, BW, BW));
% HSVt = rgb2hsv(kmeansTest);
% %im = imsegkmeans(HSVt, 5);
% %figure, imagesc(im);
% gray = im2gray(imrgb);
% adapt = adaptthresh(gray);
% gamma = 5;
% adapt = adapt.^gamma;
% figure, imagesc(adapt);
% resV = HSVt(:, :, 3) .* (1 - adapt);
% resS = HSVt(:, :, 2) .* (1 - adapt);
% HSVt(:,:,3) = histeq(resV); 
% HSVt(:,:,2) = resS; 
% figure, imshow(immultiply(hsv2rgb(HSVt), cat(3, BW, BW, BW)));
% im = imsegkmeans(im2uint8(HSVt), 3);
% figure, imagesc(im);
imrgb = im2double(imrgb);
R = imrgb(:, :, 1);
G = imrgb(:, :, 2);
B = imrgb(:, :, 3);

RO = imbinarize(R);
GO = imbinarize(G);
BO = imbinarize(B);

res = immultiply(immultiply(RO, GO), BO);

newimg = immultiply(imrgb, cat(3, res, res, res));
figure, imshow(newimg);

 %[B,L] = bwboundaries(BW, 'noholes');
 %figure; imshow(HSVt); hold on;
 %for k = 1 : length(B)
  %  boundary = B{k};
   % plot(boundary(:,2),boundary(:,1),'g','LineWidth',2);
 %end
%%%%% rectangular BB
%st = regionprops(BW, 'BoundingBox', 'Area' );
% fprintf("\n----------------\n");
% for k = 1 : length(st)
%   thisBB = st(k).BoundingBox;
%   %boundingBoxArea = thisBB(3) * thisBB(4);
%   %rectangularity = st(k).Area / boundingBoxArea
%   if(st(k).Area < 32500)
%     rectangle('Position', [thisBB(1),thisBB(2),thisBB(3),thisBB(4)],...
%     'EdgeColor','r','LineWidth',2 )
%   end
%    fprintf("%d\n", st(k).Area);
% end
% fprintf("\n----------------\n");