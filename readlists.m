function [cards, labels] = readlists(annotationsFileName, createCards )
    arguments 
        annotationsFileName string; 
    end
    arguments 
        createCards logical = false; 
    end
    arguments 
    end  % default value
    cards = {};
    labels = {};
    cocoTrainData = jsondecode(fileread(annotationsFileName));
    images = cocoTrainData.images;
    annotations = struct2table(cocoTrainData.annotations);
    categories = struct2table(cocoTrainData.categories);

    for k1 = 1:min(length(images))
        imagestruct = images(k1);
        im = imread(imagestruct.path);
        ann = annotations(annotations.image_id == imagestruct.id, :);
    
        %figure(imagestruct.id);
        %imshow(im);
        counter = 1;
        for row = 1:height(ann)
            catto = categories(categories.id == ann{row,3}, :);
            %color = sscanf(catto{1,4}{1}(2:end),'%2x%2x%2x',[1 3])/255;

            p = ann{row,4};
            polygon = p{1,1};
            
           
          
            substr =  strlength(imagestruct.file_name) - 3;
            path = "CarteSingole/" + extractBefore(imagestruct.file_name, substr) + "-" + counter + ".jpg";
            cards = [cards; path];            
            labels = [labels; catto{1,2}{1}];

            if(createCards)
                 BW = zeros(size(im, 1), size(im, 2)); 
              
                for Npol = 1:size(polygon, 1)  %% per poligoni spezzati
                    pol = reshape(polygon(Npol, :), [2,size(polygon(Npol, :), 2)/2])';
                   
                    BW = BW | poly2mask(pol(:,1), pol(:,2), size(im, 1), size(im, 2));                           
                   
                    %drawpolygon("Position", pol, "Tag", string(catto{1,1}), "Label", catto{1,2}{1}, "Color", color);  %% piu' poligoni con lo stesso tag per poligoni spezzati
                   
                end
                res = immultiply(im, cat(3, BW, BW, BW)); 

                %%%%%%
                [r, c] = find(BW);
                row1 = min(r);
                row2 = max(r);
                col1 = min(c);
                col2 = max(c);
                croppedIm = res(row1:row2, col1:col2, :);
                %%%%%% < ricordati di imcrop
                %croppedIm = imresize(croppedIm, 0.5);
                imwrite(croppedIm, path);
            end

            counter = counter + 1;
        end 
    end

    %outputArg1 = annotationsFileName;
end