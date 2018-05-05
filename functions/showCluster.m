function [ gray_image, rgb_image, fig ] = showCluster( image, Ylabels, clusterNumber, r, g, b)
    %grayscale image
    if size(image, 3) == 1    
        rng(123); 
        redChannel = image;
        greenChannel = image;
        blueChannel = image;
        Ylabels = vec2mat(Ylabels, size(image,2));        
    end
    %rgb image
    if size(image, 3) == 3
        redChannel = image(:, :, 1);
        greenChannel = image(:, :, 2);
        blueChannel = image(:, :, 3);        
        Ylabels = vec2mat(Ylabels, size(redChannel,2));        
    end
    [rows, cols] = find(Ylabels==clusterNumber);
    mypoints = arrayfun(@(x) [cols(x) rows(x)], 1:size(rows), 'uni', 0);
    pixels = vertcat(mypoints{:});
    ind = sub2ind(size(image), pixels(:,2), pixels(:,1));
    redChannel(ind) = r;
    greenChannel(ind) = g;
    blueChannel(ind) = b;
    rgb_image = cat(3, redChannel, greenChannel, blueChannel);
    gray_image = rgb2gray(rgb_image);
    fig = figure;
    imshow(rgb_image);    
end

