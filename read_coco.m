function [outputArg1] = read_coco(annotationsFileName, maxImages)
    arguments 
        annotationsFileName string; 
    end
    arguments 
        maxImages=inf; 
    end  % default value
    
    cocoTrainData = jsondecode(fileread(annotationsFileName));
    images = cocoTrainData.images;
    annotations = struct2table(cocoTrainData.annotations);
    categories = struct2table(cocoTrainData.categories);

    for k1 = 1:min(length(images),maxImages)
        imagestruct = images(k1);
        im = imread(imagestruct.path);
        ann = annotations(annotations.image_id == imagestruct.id, :);
    
        figure(imagestruct.id);
        imshow(im);
        
        for row = 1:height(ann)
            cat = categories(categories.id == ann{row,3}, :);
            color = sscanf(cat{1,4}{1}(2:end),'%2x%2x%2x',[1 3])/255;

            p = ann{row,4};
            polygon = p{1,1};
            for Npol = 1:size(polygon, 1)  %% per poligoni spezzati
                pol = reshape(polygon(Npol, :), [2,size(polygon(Npol, :), 2)/2])';
                drawpolygon("Position", pol, "Tag", string(cat{1,1}), "Label", cat{1,2}{1}, "Color", color);  %% piu' poligoni con lo stesso tag per poligoni spezzati
            end
        end   
    end

    outputArg1 = annotationsFileName;
end