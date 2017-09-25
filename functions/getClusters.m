function [Y,C,sumd,D] = getClusters( PCAscore, pcs, k )
    [Y,C,sumd,D] = kmeans(PCAscore(:, 1:pcs), k);
end