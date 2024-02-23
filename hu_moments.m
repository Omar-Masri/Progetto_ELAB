% The skeleton of the code was taken from Mathworks.inc but there are several mistakes in that code, including mistakes in formula itself.
% The errors were corrected and code was further improved (made more efficient and robust for further analysis).
% Tejas K
% Jan 2018




%% Hu's Invariant Moments 

function  hu_moments_vector  = hu_moments( image )
%close all;
%% Take the Input - image/audio/matrix/bag
image = im2double(image);
% Displaying the image before speckle noise
%figure, imshow(image); title('Before speckle Noise');
%Adding noise to check the variance in the moments for a given noise.
image = imnoise(image,'speckle');
%figure, imshow(image); title('After speckle Noise');
%image = imresize(image, [256 256]);
%image = imrotate(image, 45);
[height, width] = size(image);

%% Calculate the required parameters
% define a co-ordinate system for image 
xgrid = repmat((-floor(height/2):1:ceil(height/2)-1)',1,width);
ygrid = repmat(-floor(width/2):1:ceil(width/2)-1,height,1);

[x_bar, y_bar] = centerOfMass(image,xgrid,ygrid);

% normalize coordinate system by subtracting mean
xnorm = x_bar - xgrid;
ynorm = y_bar - ygrid;

%% Calculate the central moments
% central moments
mu_11 = central_moments( image ,xnorm,ynorm,1,1);
mu_20 = central_moments( image ,xnorm,ynorm,2,0);
mu_02 = central_moments( image ,xnorm,ynorm,0,2);
mu_21 = central_moments( image ,xnorm,ynorm,2,1);
mu_12 = central_moments( image ,xnorm,ynorm,1,2);
mu_03 = central_moments( image ,xnorm,ynorm,0,3);
mu_30 = central_moments( image ,xnorm,ynorm,3,0);

%% Calculate Hu's Invariant moments
%central_moment = [mu_11, mu_20, mu_02, mu_21, mu_12, mu_03, mu_30];
%calculate first 8 hu moments of order 3
I_one   = mu_20 + mu_02;
I_two   = (mu_20 - mu_02)^2 + 4*(mu_11)^2;
I_three = (mu_30 - 3*mu_12)^2 + (mu_03 - 3*mu_21)^2;
I_four  = (mu_30 + mu_12)^2 + (mu_03 + mu_21)^2;
I_five  = (mu_30 - 3*mu_12)*(mu_30 + mu_12)*((mu_30 + mu_12)^2 - 3*(mu_21 + mu_03)^2) + (3*mu_21 - mu_03)*(mu_21 + mu_03)*(3*(mu_30 + mu_12)^2 - (mu_03 + mu_21)^2);
I_six   = (mu_20 - mu_02)*((mu_30 + mu_12)^2 - (mu_21 + mu_03)^2) + 4*mu_11*(mu_30 + mu_12)*(mu_21 + mu_03);
I_seven = (3*mu_21 - mu_03)*(mu_30 + mu_12)*((mu_30 + mu_12)^2 - 3*(mu_21 + mu_03)^2) + (mu_30 - 3*mu_12)*(mu_21 + mu_03)*(3*(mu_30 + mu_12)^2 - (mu_03 + mu_21)^2);
I_eight = mu_11*(mu_30 + mu_12)^2 - (mu_03 + mu_21)^2 - (mu_20 - mu_02)*(mu_30 + mu_12)*(mu_21 + mu_03);

%% Apply log, and view the results.
hu_moments_vector = [I_one, I_two, I_three,I_four,I_five,I_six,I_seven,I_eight];
hu_moments_vector_norm= -sign(hu_moments_vector).*(log10(abs(hu_moments_vector)));
hu_moments_vector;
%hu_moments_vector_norm
end
% the eight I_ values are the final Hu's moments obtained. These are the features of the image/ Audio that was given as input.
% These features can be used to recognise this image during facerecognition/ copy move forgerydetection etc etc. 
% The advantage is that, the entire matrix of elements are now reduced to 8 features which reduces computational cost.

% Also we can apply log transform to all 8 moments and then add them to get one feature for the entire image/ audio signal.
