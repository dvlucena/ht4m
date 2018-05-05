function X = vector2matrix(Y, cols )
    if (isvector(Y))
        if (mod(size(Y,2), cols) == 0)
            X = vec2mat(Y, cols);
        else
            error('Número de colunas incompatível para a conversão do vetor em matrix.');
        end
    else
        error('A variável Y não é um vetor.');
    end
end

