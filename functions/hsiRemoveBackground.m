function [Y] = hsiRemoveBackground(X)
    
    %PCA
    [Xcoeff, Xscore, Xlatent, Xtsquared, Xexplained, mu] = pca(X);
    
    pcs = 1;
    while (sum(Xexplained(1:pcs,1)) < 95)
        pcs = pcs +1;
    end
%     disp(strcat('Usando ',int2str(pcs)), 'pcs');
    
    Y = getClusters( Xscore, pcs, 2 );
    
end

