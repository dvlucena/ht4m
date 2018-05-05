function fig = plotConfusionMatrix( titlePlot, C, labels)

    % labels = {'Dog', 'Cat', 'Horse'};
    numlabels = size(C, 1); % number of labels

    % calculate the percentage accuracies
    confpercent = 100*C./repmat(sum(C, 1),numlabels,1);

    fig = figure;
    % plotting the colors
    imagesc(confpercent);
    title(titlePlot);
    ylabel('Classificação'); xlabel('Referência');

    % set the colormap
    %colormap(flipud(gray));
    colormap prism(4);

    % Create strings from the matrix values and remove spaces
    textStrings = num2str([confpercent(:), C(:)], '%.1f%%\n%d\n');
    textStrings = strtrim(cellstr(textStrings));

    % Create x and y coordinates for the strings and plot them
    [x,y] = meshgrid(1:numlabels);
    hStrings = text(x(:),y(:),textStrings(:), ...
        'HorizontalAlignment','center');

    % Get the middle value of the color range
    midValue = mean(get(gca,'CLim'));

    % Choose white or black for the text color of the strings so
    % they can be easily seen over the background color
    %textColors = repmat(confpercent(:) > midValue,1,3);
    %set(hStrings,{'Color'},num2cell(textColors,2));
    set(hStrings,'FontSize',16,'fontWeight','bold');

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
    

    set(gca,'FontSize',16,'fontWeight','bold');

end

