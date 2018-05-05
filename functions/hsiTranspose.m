function [ HSI, Ylabels ] = hsiTranspose( HSI, Ylabels)

    if (exist('Ylabels','var') && ~isempty(Ylabels))        
%         Ylabels = vec2mat(Ylabels,size(HSI,2));
%         Ylabels = Ylabels(:);
%         Ylabels = Ylabels';
        if (~isvector(Ylabels) && ismatrix(Ylabels))
            Ylabels = Ylabels';
        elseif isvector(Ylabels)
            Ylabels = vec2mat(Ylabels,size(HSI,2));
            Ylabels = Ylabels(:);
%             Ylabels = Ylabels';
            Ylabels = vector2matrix(Ylabels,size(HSI,2));
        end
    end
    
    HSI = permute(HSI, [2 1 3]);    
    
end

