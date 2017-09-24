function [ image ] = hsiGetImageLayer(CUBE, layer)
    image = mat2gray(hsiGetLayer(CUBE, layer));
end

