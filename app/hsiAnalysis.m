function [ INDEX, img, pcs, Xcoeff, Xscore, Xlatent, Xtsquared, Xexplained, mu] = hsiAnalysis(CUBE)

    addpath('..\functions\');
    addpath('..\data\');
    
    img = hsiGetImageLayer(CUBE, 50);
    disp('Convertendo HSI em Matriz ...');    
    MATRIZ_X = hsi2matrix(CUBE);
    INDEX = ones(1,size(MATRIZ_X,1));
    opt = 1;
    while opt == 1
        disp('Apresentando layer 50 ...');    
        figure;
        imshow(img);
        opt = input('Deseja aplicar a remoção de fundo? 1 - Sim, 2 - Não -> ');
        if (opt == 1)
            disp('Executando PCA e K-Means para separar fundo e amostra...');        
            INDEX(INDEX~=0) = hsiRemoveBackground(MATRIZ_X(INDEX~=0,:));

            %Centrar na média
            MATRIZ_X = MATRIZ_X - repmat(mean(MATRIZ_X), size(MATRIZ_X,1), 1);

            img1 = showClusterOnImage(img, INDEX, 1, 0, 0, 255); 
            img2 = showClusterOnImage(img, INDEX, 2, 0, 255, 0);

            amostra = input('Qual imagem representa o cluster com amostra? (1 ou 2) -> ');

            if (amostra == 1)
                img = img2;                
            else
                img = img1;
            end            
            INDEX(INDEX~=amostra) = 0;        
        end
        close all;
    end
    
    
    k = input('Deseja agrupar a amostra em quantos clusters? -> ');
    
    %PCA
    disp('Executando PCA ...');    
    [Xcoeff,Xscore, Xlatent, Xtsquared, Xexplained, mu] = pca(MATRIZ_X(INDEX~=0,:));
    
    pcs = 1;
    while (sum(Xexplained(1:pcs,1)) < 95)
        pcs = pcs +1;
    end
    
    disp(strcat('Executando K-Means usando 0',int2str(pcs),' pc(s)'));    
    INDEX(INDEX ~= 0) = getClusters( Xscore, pcs, k );
    
    for i=1:k
       showClusterOnImage(img, INDEX, i, 255, 0, 0); 
    end   
    
end