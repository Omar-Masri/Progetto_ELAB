function [outim] = medianim(annotationsFileName)
    arguments 
        annotationsFileName string; 
    end
    
    cocoTrainData = jsondecode(fileread(annotationsFileName));
    images = cocoTrainData.images;
    annotations = struct2table(cocoTrainData.annotations);
    categories = struct2table(cocoTrainData.categories);

    for k1 = 1:length(images)
        imagestruct = images(k1);
        im = imread(imagestruct.path);

        X(:,:,:,k1) = im;
    end
    X = im2double(X);
    outim = median(X,4);
end