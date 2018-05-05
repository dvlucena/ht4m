function X = pcsToObservationData( Xscore, Xcoeff, mu)
    X = (Xscore*Xcoeff')  + repmat(mu, size(Xscore, 1),1);
end

