function fig = plotConfusionMat(Y, T, titlePlot, labels)

    u = unique(Y);
    numlabels = size(u, 1); % number of labels
    
    ref = zeros(size(u,1), size(Y,1));
    pred = zeros(size(u,1), size(Y,1));
    
    for i=1:size(u,1)
       ref(i,:) = Y;
       ref(i,Y~=i) = 0;
       pred(i,:) = T;
       pred(i,T~=i) = 0;
    end

    rng default;
    plotconfusion(ref,pred);

    % plotting the colors
    title(titlePlot);
    ly = ylabel('Classificação');     
    lx = xlabel('Referência');
    set(findobj(gca,'type','text'),'fontsize',16) 
    

    % Setting the axis labels
    if exist('labels','var') && ~isempty(labels)
        set(gca,'XTick',1:1:numlabels,...
        'YTick',1:numlabels,...
        'XTickLabel',labels,... 
        'YTickLabel',labels,... 
        'TickLength',[0 0]);
       
    else
        set(gca,'XTick',1:1:numlabels,...
            'YTick',1:numlabels,...
            'TickLength',[0 0]);    
    end
    
    set(gca,'FontSize',13,'fontWeight','bold');
    
    %defining my colors
    f1=[255 255 255]/255;
    f4=[50 205 50]/255;
    f9=[236 0 0]/255;
    f14=[85 26 139]/255;
    
    %colors          
    set(findobj(gca,'color',[0,102,0]./255),'color',f4)
    set(findobj(gca,'color',[102,0,0]./255),'color',f9)
%     set(findobj(gcf,'facecolor',[120,230,180]./255),'facecolor',f4)
%     set(findobj(gcf,'facecolor',[230,140,140]./255),'facecolor',f9)
    set(findobj(gcf,'facecolor',[0.5,0.5,0.5]),'facecolor',f1)
    set(findobj(gcf,'facecolor',[120,150,230]./255),'facecolor',f1)
    

end

