function [C] = hsiCov(CUBE)
[p, N] = size(CUBE);
u = mean(CUBE.').';
for k=1:N
    CUBE(:,k) = CUBE(:,k) - u;
end

C = (CUBE*CUBE.')/(N-1);
