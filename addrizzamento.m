close all;
clear all;

data = importdata('singlecardsnames.txt') ;  
ct = 1;
for x = 1 : size(data, 1)
im = im2double(imread(data{x}));


if size(im, 1) < size(im, 2)
    im = imrotate(im, 90);
end

% binarizzo

BW = rgb2gray(im) > 0.5;
BW = padarray(BW, [10,10], 0, "both");
BW = myImFill(BW);

% edges
BW = edge(BW, "canny");

[H,theta, rho] = hough(BW);
peaks = houghpeaks(H, 100);
lines = houghlines(BW, theta, rho, peaks);
% 
% figure, imshow(BW),
% hold on
% for k = 1:length(lines)
%   xy = [lines(k).point1; lines(k).point2];
%   plot(xy(:,1), xy(:,2), 'LineWidth', 2, 'Color', 'red');
% end
% title('Detected lines')

u = lines(1).point1 - lines(1).point2; % vector along the vertical left edge.
v = [0 1]; % vector along the vertical, oriented up.
theta = acos( u*v' / (norm(u) * norm(v)) );



B = imrotate(im, theta * 180 / pi);
BW = rgb2gray(B) > 0.5;
BW = myImFill(BW);
[r, c] = find(BW);
row1 = min(r);
row2 = max(r);
col1 = min(c);
col2 = max(c);
croppedIm = B(row1:row2, col1:col2, :);

%figure,
%imshow(croppedIm),
%title('Rotated image');
path = "FotoDritte/" + ct + ".jpg";
imwrite(croppedIm, path);
ct = ct + 1;
end

