function Xscore = observationDataToPcs( X, Xcoeff, mu)
    Xscore = (X - repmat(mu, size(X, 1),1)) * inv(Xcoeff');
end

