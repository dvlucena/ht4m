function [idx,C,sumd,D] = getClusters( PCAscore, PCs, k )
    [idx,C,sumd,D] = kmeans(PCAscore(:, 1:PCs), k);
end