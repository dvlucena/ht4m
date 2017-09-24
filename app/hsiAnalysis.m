function [ Y, pcs, Xcoeff, Xscore, Xlatent, Xtsquared, Xexplained, mu] = hsiAnalysis( CUBE)

    hsiShowLayer(CUBE, 50);

    opt = input('Remover fundo? 1 - Sim, 2 - Não -> ');    
    X = hsi2matrix(CUBE);
    
    if (opt == 1)
        [Y] = hsiRemoveBackground(X);

        %Centrar na média
        X = X - repmat(mean(X), size(X,1), 1);

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

        Xamostra = X(Y==opt,:); 
    else
        Xamostra = X; 
        opt = 0;
    end
    
    k = input('Deseja agrupar a amostra em quantos clusters? -> ');
    
    %PCA
    [Xcoeff,Xscore, Xlatent, Xtsquared, Xexplained, mu] = pca(Xamostra);
    
    pcs = 1;
    while (sum(Xexplained(1:pcs,1)) < 95)
        pcs = pcs +1;
    end
    
    Yamostra = getClusters( Xscore, pcs, k );
    
    Y(Y ~= opt) = 0;
    Y(Y == opt) = Yamostra;
    
    for i=1:k
       showClusterOnImage(img_fundo, Y, i, 255, 0, 0); 
    end   
    
end

