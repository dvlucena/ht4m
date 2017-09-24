function [ gray_image, rgb_image, fig ] = showClusterOnImage( image, idx, cluster, r, g, b)
    rng(123); 
    idx = vec2mat(idx, size(image,2));
    [rows, cols] = find(idx==cluster);
    mypoints = arrayfun(@(x) [cols(x) rows(x)], 1:size(rows), 'uni', 0);
    pixels = vertcat(mypoints{:});
    ind = sub2ind(size(image), pixels(:,2), pixels(:,1));
    red = image;
    red(ind) = r;
    green = image;
    green(ind) = g;
    blue = image;
    blue(ind) = b;
    rgb_image = cat(3, red, green, blue);
    gray_image = rgb2gray(rgb_image);
    fig = figure;
    imshow(rgb_image);    
end

