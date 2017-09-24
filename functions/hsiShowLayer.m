function [ image ] = hsiShowLayer(CUBE, layer)
    image = hsiGetImageLayer(CUBE, layer);
    figure;
    imshow(image);
end

