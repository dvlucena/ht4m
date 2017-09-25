function [ Y, img, pcs, Xcoeff, Xscore, Xlatent, Xtsquared, Xexplained, mu] = hsiAnalysis(CUBE)
    img = hsiGetImageLayer(CUBE, 50);
    disp('Convertendo HSI em Matriz ...');    
    X = hsi2matrix(CUBE);
    Y = ones(1,size(X,1));
    opt = 1;
    while opt == 1
        disp('Apresentando layer 50 ...');    
        figure;
        imshow(img);
        opt = input('Deseja aplicar a remoção de fundo? 1 - Sim, 2 - Não -> ');
        if (opt == 1)
            disp('Executando PCA e K-Means para separar fundo e amostra...');        
            Y(Y~=0) = hsiRemoveBackground(X(Y~=0,:));

            %Centrar na média
            X = X - repmat(mean(X), size(X,1), 1);

            img1 = showClusterOnImage(img, Y, 1, 0, 0, 255); 
            img2 = showClusterOnImage(img, Y, 2, 0, 255, 0);

            amostra = input('Qual imagem representa o cluster com amostra? (1 ou 2) -> ');

            if (amostra == 1)
                img_fundo = img2;                
            else
                img_fundo = img1;
            end
            
            img = img_fundo;
            Y(Y~=amostra) = 0;        
        end
        close all;
    end
    
    
    k = input('Deseja agrupar a amostra em quantos clusters? -> ');
    
    %PCA
    disp('Executando PCA ...');    
    [Xcoeff,Xscore, Xlatent, Xtsquared, Xexplained, mu] = pca(X(Y~=0,:));
    
    pcs = 1;
    while (sum(Xexplained(1:pcs,1)) < 95)
        pcs = pcs +1;
    end
    
    disp(strcat('Executando K-Means usando 0',int2str(pcs),' pc(s)'));    
    Y(Y ~= 0) = getClusters( Xscore, pcs, k );
    
    for i=1:k
       showClusterOnImage(img_fundo, Y, i, 255, 0, 0); 
    end   
    
end