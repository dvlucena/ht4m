function exportToOPFTrainingData(filename, X, Y)        
    if (~exist('Y', 'var') || isempty(Y))
        C = 0:size(X,1)-1;
        Y = zeros(size(X,1),1);
        nc = 0;
        dlmwrite(filename,cat(2, C', Y, X),'delimiter',' ','precision',12);
    else
        Y = matrix2vector(Y);
        C = 0:size(Y(Y~=0),1)-1;
        if (isempty(find(unique(Y) == 0, 1)))
            nc = size(unique(Y),1);
        else
            nc = size(unique(Y),1) - 1;
        end
        dlmwrite(filename,cat(2, C', Y(Y~=0), X(Y~=0,:)),'delimiter',' ','precision',12);
    end
    
    Str = fileread(filename);
    fid = fopen(filename, 'w');
    if fid == -1
      error('Cannot open file for writing.');
    end
    fprintf(fid,'%s ',num2str(size(C,2)));
    fprintf(fid,'%s ',num2str(nc));
    fprintf(fid,'%s\n',num2str(size(X,2)));
    fwrite(fid, Str, 'char');
    fclose(fid);
end

