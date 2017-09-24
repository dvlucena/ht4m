function [ CUBE ] = matrix2hsi(X, n, p )
    
    if (~ismatrix(X))
        error('A entrada deve possuir 2 dimensões n x p.');
    end
    
    if ((n * p ) ~= size(X,1))
        error('As novas dimensões informadas (n e p) são incompatíveis com a entrada matriz.');
    end
    
    wavelength = size(X,2);    
    CUBE = reshape(X, n, p, wavelength);    
    
end

