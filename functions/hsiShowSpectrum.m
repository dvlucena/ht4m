function [] = hsiShowSpectrum( CUBE, x, y )
figure;
plot(hsi2matrix(CUBE(x:x,y:y,:)));
end

