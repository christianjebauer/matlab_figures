%% Exports a 3D tiledlayout plot
function exportTileTVOe(figure, tile, axArray, lgdArray, zoomBox, figure_high, figurePathArray, fileName, cropping, varargin)

    % Some general settings
    try 
        settings.expFactor = cell2mat(varargin{1, 1}{1, 1});
    catch
        settings.expFactor = [  1, 1;
                                0.9, 1.005;
                                1, 1];
    end
    settings.font = 'Calibri';
    settings.fontSize = 9;
    settings.MarkerSize = 8;
    try
        tile.TileSpacing = 'compact';
        tile.Padding = 'tight';
    end
    set(gcf, 'units', 'centimeters', 'position', [0 0 14.8 figure_high]);
    for i = 1:length(axArray)
        ax = axArray(i);
        exponentValue(:,i) = [ax.XAxis.Exponent; ax.YAxis.Exponent; ax.ZAxis.Exponent];
        decimalComma3D(ax);
    end

    % Some settings for every axis
    for ax = axArray
        ax.XGrid = 'on';
        ax.YGrid = 'on';
        ax.ZGrid = 'on';
        ax.XMinorGrid = 'on';
        ax.YMinorGrid = 'on';
        ax.ZMinorGrid = 'on';
        ax.Box = 'on';
        ax.BoxStyle = 'full';
        ax.LabelFontSizeMultiplier = 1;
        ax.TitleFontSizeMultiplier = 1;
        ax.FontSizeMode = 'manual';
        ax.FontSize = settings.fontSize;
        ax.FontName = settings.font;
        try
            for indexChildren = 1 : length(ax.Children)
                ax.Children(indexChildren,1).MarkerSize = settings.MarkerSize;
            end
        end
    end

    % Adapt the legend accordingly
    for lgd = lgdArray
        lgd.FontSize = 6.5;
        lgd.FontName = settings.font;
    end

    % Leave "plot edit" mode
    plotedit('off');

    % Added a box with a zoomed in verion of the figure
    try
        dim = [zoomBox.xLimit(1), zoomBox.yLimit(1), ...
            zoomBox.xLimit(2) - zoomBox.xLimit(1), zoomBox.yLimit(2) - zoomBox.yLimit(1)]; % Limits of the zoomed figure
        rectPosNorm = data2norm(ax, dim); % Convert the rectangle position to normalized figure coordinates
        rectangle('Position', dim); % Rectangle around the zoom region
        annotation('line', [rectPosNorm(1), zoomBox.boxPos(1)], ...
            [rectPosNorm(2), zoomBox.boxPos(2) + zoomBox.boxPos(4)], 'LineWidth', ax.Children(1).LineWidth);
        annotation('line', [rectPosNorm(1) + rectPosNorm(3), zoomBox.boxPos(1) + zoomBox.boxPos(3)], ...
            [rectPosNorm(2), zoomBox.boxPos(2) + zoomBox.boxPos(4)], 'LineWidth', ax.Children(1).LineWidth);
        ax2 = axes('Position', zoomBox.boxPos); % Create a new axes
        % Copy children from ax to ax2
        for i = 1:length(ax.Children)
            % Copy each child to ax2
            copyobj(ax.Children(i), ax2);
        end
        xlim(zoomBox.xLimit);
        ylim(zoomBox.yLimit);
        box on;
        set(ax2,'XTickLabel',[]);
        set(ax2,'YTickLabel',[]);
    end

    % Safe figure with original exponent
    fileName = erase(fileName, '.pdf');
    for pathIndex = 1 : length(figurePathArray)
        path = figurePathArray(pathIndex);
        savefig(figure, strcat(path, fileName));
    end

    % Replaces the exponents in a figure by annotations
    for i = 1:length(axArray)
        ax = axArray(i);
        exponentFnc(figure, ax, settings, exponentValue(:,i));
    end

    % Prevents undesired cropping of the figure by exportgraphics
    if cropping == false
        annotation('rectangle',[0 0 1 1],'Color','w');
    end

    movegui(figure,'center');
    
    for pathIndex = 1 : length(figurePathArray)
        path = figurePathArray(pathIndex);
        % Export as eps file
        exportgraphics(gcf, strcat(path, strcat(fileName, '.eps')), 'BackgroundColor', 'none', ...
            'ContentType', 'vector', 'Resolution', 300);
        % Export as pdf file
        exportgraphics(gcf, strcat(path, strcat(fileName, '.pdf')), 'BackgroundColor', 'none', ...
            'ContentType', 'vector', 'Resolution', 300);
    end
end

% Helper function to convert data units to normalized units
function normPos = data2norm(ax, pos)
    % Get the axes position in normalized units
    axPos = get(ax, 'Position');
    
    % Get the axes limits
    xLim = get(ax, 'XLim');
    yLim = get(ax, 'YLim');
    
    % Calculate the normalized position
    normX = (pos(1) - xLim(1)) / (xLim(2) - xLim(1)) * axPos(3) + axPos(1);
    normY = (pos(2) - yLim(1)) / (yLim(2) - yLim(1)) * axPos(4) + axPos(2);
    normW = pos(3) / (xLim(2) - xLim(1)) * axPos(3);
    normH = pos(4) / (yLim(2) - yLim(1)) * axPos(4);
    
    normPos = [normX, normY, normW, normH];
end
