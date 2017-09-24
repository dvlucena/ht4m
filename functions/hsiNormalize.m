function [ normalizedCUBE] = hsiNormalize( CUBE )

minVal = min(CUBE(:));
maxVal = max(CUBE(:));

normalizedCUBE = CUBE - minVal;
if (maxVal ~= minVal)
    normalizedCUBE = normalizedCUBE ./ (maxVal-minVal);
end

end

