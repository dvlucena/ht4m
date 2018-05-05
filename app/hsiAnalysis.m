function [ INDEX, img, pcs, Xcoeff, Xscore, Xlatent, Xtsquared, Xexplained, mu] = hsiAnalysis(HSI, Y, img, path, bgRemove, clusters, sample_cluster)   

    %configura��o dos diret�rios do toolbox
    addpath('..\functions\');
    addpath('..\data\');
    
    %solicita��o do diret�rio de trabalho, onde ser�o armazenados os
    %arquivos resultantes da an�lise.
    if (~exist('path','var') || isempty(path))
        path = input('Digite o caminho da pasta de trabalho ou pressione ENTER continuar: ','s');
    end
    
    % evitar erro por n�o inserir o caminho.
    if isempty(path)
        path = 'C:\';
        disp('Caminho: C:\');
    end
    
    %verifica��o do par�metro 'img'.
    if (~exist('img','var') || isempty(img))
        img = hsiGetImageLayer(HSI, 50);
    end
    
    %armazendando imagem original
    if ~isempty(path)
        imwrite(img,strcat(path,'hsi_original.png'));
    end
    
    %convers�o da HSI em matriz bidimensional
    disp('Convertendo HSI em Matriz ...');
    MATRIZ_X = hsi2matrix(HSI);
    
    %verifica��o da exist�ncia da vari�vel de refer�ncia Y
    if (~exist('Y','var') && ~isempty(Y))
        INDEX = ones(1,size(MATRIZ_X,1));
    else
        if (size(Y,2) == size(MATRIZ_X,1))
            INDEX = Y;
        else
            INDEX = ones(1,size(MATRIZ_X,1));
        end            
    end
    
    if ~exist('bgRemove','var')
        bgRemove = -1;
    end
    
    % rotina para remo��o de sinais espectrais indesejados. Essa rotina � 
    % em an�lise de agrupamento, portanto, n�o � um m�todo preciso e o 
    % resultado � sens�vel ao contexto. Podem ser necess�rias mais de uma 
    % execu��o dessa rotina para se atingir o objetivo desejado.
    opt = 1;
    amostra = 0;
    exec = 0;
    remove = bgRemove;
    while opt == 1
        disp('Apresentando layer 50 ...');    
        figure;
        imshow(img);       
        
        if remove == -1            
            opt = input('Deseja aplicar a remo��o de fundo? 1 - Sim, 2 - N�o -> ');
        else
            if remove > 0
                opt = 1;
                remove = remove -1;
            else
                opt = 2;
            end
        end
        if (opt == 1)
            exec = exec + 1;
            disp('Executando PCA e K-Means para separar fundo e amostra...');        
            INDEX(INDEX~=0) = hsiRemoveBackground(MATRIZ_X(INDEX~=0,:));

            %Centrar na m�dia
            MATRIZ_X = MATRIZ_X - repmat(mean(MATRIZ_X), size(MATRIZ_X,1), 1);

            img1 = showClusterOnImage(img, INDEX, 1, 0, 0, 255); 
            img2 = showClusterOnImage(img, INDEX, 2, 0, 255, 0);
            
            if (~exist('sample_cluster','var') || isempty(sample_cluster))
                amostra = input('Qual imagem representa o cluster com amostra? (1 ou 2) -> ');
            else
                if (size(sample_cluster,2) == bgRemove)
                    amostra = sample_cluster(1,exec);
                else
                    amostra = input('Qual imagem representa o cluster com amostra? (1 ou 2) -> ');
                end
            end

            if (amostra == 1)
                img = img2;                
            else
                img = img1;
            end            
            INDEX(INDEX~=amostra) = 0;        
        end
        close all;
    end
    
    if (isempty(path) == 0 && exist('img1','var') && exist('img2','var'))  
        if (amostra == 1)
            imwrite(img2,strcat(path,'hsi_amostra.png'));
            imwrite(img1,strcat(path,'hsi_fundo.png'));
        else
            imwrite(img1,strcat(path,'hsi_amostra.png'));
            imwrite(img2,strcat(path,'hsi_fundo.png'));
        end        
    end
    
    if ~exist('clusters','var')
        k = input('Deseja agrupar a amostra em quantos clusters? -> ');
    else
        k = clusters;
    end
    
    
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
       [gray_image, rgb_image] = showClusterOnImage(img, INDEX, i, 255, 0, 0); 
       if isempty(path) == 0
            imwrite(rgb_image,strcat(path,'hsi_cluster_',num2str(i),'.png'));
        end
    end       
    
    disp('Armazenando Vari�veis... Aguarde!');        
    Y = INDEX;
    X = MATRIZ_X;
    save(strcat(path,'hsiAnalysis.mat'), 'HSI', 'X', 'Y', 'img', 'pcs', 'Xcoeff', 'Xscore', 'Xlatent', 'Xtsquared', 'Xexplained', 'mu');
    
    close all;
    disp('Finalizado!');    
end