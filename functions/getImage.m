function [gray_image, rgb_image] = getImage(HSI, Ylabels, layerIndex)
    image = mat2gray(getLayer(HSI, layerIndex));    
    
    rng(123); 
    redChannel = image;
    greenChannel = image;
    blueChannel = image;    
    
    % Eliminando pixels descartados (cluster zero).
    [rows, cols] = find(Ylabels==0);
    mypoints = arrayfun(@(x) [cols(x) rows(x)], 1:size(rows), 'uni', 0);
    pixels = vertcat(mypoints{:});
    if (~isempty(pixels))
        ind = sub2ind(size(image), pixels(:,2), pixels(:,1));
        redChannel(ind) = 255;
        greenChannel(ind) = 255;
        blueChannel(ind) = 255;
    end
        
    rgb_image = cat(3, redChannel, greenChannel, blueChannel);
    gray_image = rgb2gray(rgb_image);   
    
end

