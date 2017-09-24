function [Y, img_amostra, img_fundo, opt, X] = hsiRemoveBackground3D( CUBE, excludeIndex )

    X = hsi2matrix(CUBE);
%     
%     if (~isempty(excludeIndex))
%         X1 = zeros(size(X,1) - size (
%     end
    
    %Centrar na média
    X = X - repmat(mean(X), size(X,1), 1);
    
    %PCA
    [Xcoeff,Xscore, Xlatent, Xtsquared, Xexplained, mu] = pca(X);
    
    pcs = 1;
    while (sum(Xexplained(1:pcs,1)) < 95)
        pcs = pcs +1;
    end
%     disp(strcat('Usando ',int2str(pcs)), 'pcs');
    
    Y = getClusters( Xscore, pcs, 2 );
    
    img1 = showClusterOnImage(hsiGetImageLayer(CUBE, 50), Y, 1, 0, 0, 255); 
    img2 = showClusterOnImage(hsiGetImageLayer(CUBE, 50), Y, 2, 0, 255, 0);
    
    opt = input('Qual imagem representa a amostra? -> ');
    
    if (opt == 1)
        img_amostra = img1;
        img_fundo = img2;
    else
        img_amostra = img2;
        img_fundo = img1;
    end

end

