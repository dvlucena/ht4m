function S = createHSIStruct(HSI, labels, layers, id)
    
    % HSI
    if (ndims(HSI) == 3)
        S(1).HSI = HSI;
    else
        error('A variável "HSI" deve possuir 3 dimensões.');
    end

    % labels
    if (exist('labels', 'var') && ~isempty(labels))
        if (~isvector(labels) && ismatrix(labels))
            if (size(labels,1) == size(HSI,1) && size(labels,2) == size(HSI,2))
                S(1).labels = labels;
            else
                error('As dimensões da variável de referência "labels" é incompatível com as dimensões espaciais da HSI.');    
            end
        else
            error('A variável "labels" deve possuir 2 dimensões.');
        end
    else
        S(1).labels = ones(size(HSI,1),size(HSI,2));
    end
    
    % layers    
    if (exist('layers', 'var') && ~isempty(layers))
        if (ischar(layers))
            layers = str2num(layers);
        end
        
        % Transformando em vetor linha;
        if (size(layers,2) == size(HSI,3))
            layers = layers';
        end
        
        if (size(layers,1) == size(HSI,3))
            S(1).layers = layers;
        else
            error('O número de identificação das camadas da HSI a quantidade de camadas presente na HSI.');
        end
    else
        S(1).layers = [1:size(HSI,3)];
    end
    
    % id
    if (exist('id', 'var') && ~isempty(id))
        if (ischar(id))
            S(1).id = id;
        else
            S(1).id = '';
        end
    else
        S(1).id = '';
    end
    
    %Subgroups    
    S(1).subgroups(1).id = 'default';
    S(1).subgroups(1).selectedLayers = S(1).layers;
    S(1).subgroups(1).initialLine = 1;
    S(1).subgroups(1).finalLine = size(HSI,1);
    S(1).subgroups(1).initialColumn = 1;
    S(1).subgroups(1).finalColumn = size(HSI,2);
    S(1).subgroups(1).labels = 1;       
    
end

