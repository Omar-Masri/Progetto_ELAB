close all;
% Vogliamo trovare il cartello stradale nell'immagine

% Carichiamo l'immagine RGB e ridimensioniamola al 50%
%imrgb = imresize(imread('uno-test-03.jpg'),0.5);
imrgb = imread("/home/omarm/Desktop/UNIMIB/Elab/Progetto/coco-annotator/datasets/UNO-GT/UNO/uno-test-20.jpg");
% Convertiamo l'immagine a livelli di grigio e a valori tra 0 e 1
imgray = rgb2ycbcr(imrgb);
imgray = imgray(:,:,2);
imgray = imbinarize(imgray);
%imgray = imfill(imgray,"holes");

[rows,cols,ch] = size(imgray);

figure,imshow(imgray),title('Immagine di input');

% Calcoliamo gli edge usando Canny
% Modifichiamo la sigma del filtro Gaussiano di canny 
% I valori di soglia dei gradienti, a e b, li facciamo calcolare in automatico 
% Vogliamo avere pochi edge e non perdere quelli del cartello stradale
imedge = edge(imgray,'Canny', [], 3);
%imedge = imgray;
imedge = imfill(imedge, "holes");
imedge = bwareaopen(imedge,1500);
imedge = edge(imedge,'sobel', "nothinning");
figure,imshow(imedge),title('Immagine degli edge');


% Applichiamo la trasformata di hough per le linee
% H è l'immagine dello spazio dei parametri (rho,theta)==(y,x)
% H contiene le evidenze che una coppia (rho, theta) corrisponda ad una
% linea presente nell'immagine degli edge. Valori alti significano forti
% evidenze.
% T contiene i valori di theta corrispondenti alle coordinate x di H
% R contiene i valori di rho corrispondenti alle coordinate y di H
[H,T,R] = hough(imedge);

figure,imagesc(H),colorbar,title('Spazio dei parametri della trasformata di Hough');

% Cerchiamo i massimi nella matrice H. Dato che ci interessano 4 linee, 
% ci facciamo ritornare 4 valori (va bene se siamo ragionevolmente sicuri che 
% nell'immagine degli edge ci sono 4 linee dominanti). 
% La funzione houghpeaks ritorna le coordinate (y,x) della matrice dove
% ci sono i massimi. Per sapere a che parametri corrispondono, dobbiamo 
% prelevare i valori di rho e theta da R e T.
val = ceil(size(H)./20);
if(mod(val(1), 2) == 0)
val(1) = val(1) + 1;
end
if(mod(val(2), 2) == 0);
val(2) = val(2) + 1;
end
P = houghpeaks(H, 100, Threshold=0, NHoodSize=val);



lines = houghlines(imedge,T,R,P,'FillGap',20,'MinLength',70);
figure, imshow(imedge), hold on
max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

end
